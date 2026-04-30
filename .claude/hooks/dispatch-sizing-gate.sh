#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["description", "summary", "prompt", "task", "assignment", "message", "content", "instructions", "goal", "brief", "context", "request", "note", "notes"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) return preferred;
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const joinUniqueText = (chunks) => {
  const seen = new Set();
  return chunks
    .map((chunk) => String(chunk || "").trim())
    .filter(Boolean)
    .filter((chunk) => {
      if (seen.has(chunk)) return false;
      seen.add(chunk);
      return true;
    })
    .join("\n");
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
	    const fields = [
	    String(input.tool_name || ""),
	    joinUniqueText(flattenText(toolInput)),
	    firstNonEmptyString(
	      toolInput.name,
	      toolInput.subagent_type,
	      toolInput.subagentType,
	      toolInput.agent_type,
	      toolInput.agentType,
	      toolInput.agent_name,
	      toolInput.agentName,
	      toolInput.role,
	      toolInput.lane,
	      toolInput.worker_name,
	      toolInput.workerName,
	      toolInput.teammate_name,
      toolInput.teammateName,
      toolInput.target_name,
      toolInput.targetName
    ),
    String(input.session_id || "")
  ];
  process.stdout.write(fields.map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TOOL_NAME="$(hook_decode_base64_field "${FIELDS[0]:-}")"
DESCRIPTION="$(hook_decode_base64_field "${FIELDS[1]:-}")"
AGENT_NAME="$(hook_decode_base64_field "${FIELDS[2]:-}")"
SESSION_ID="$(hook_decode_base64_field "${FIELDS[3]:-}")"

emit_deny() {
  local reason="${1:?reason required}"
  local surface_key=""
  surface_key="${DISPATCH_WORK_SURFACE:-${TARGET_NAME:-${TARGET_LANE:-generic}}}"
  reason="$(augment_precheck_block_reason_on_repeat "$SESSION_ID" "$TOOL_NAME" "${surface_key:-generic}" "$reason")"
  hook_emit_pretool_deny "$reason" "Dispatch sizing guard blocked the assignment."
}

emit_dispatch_warning() {
  local detail="${1:?detail required}"
  printf '[%s] DISPATCH-SIZING WARN: %s | target=%s | lane=%s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$detail" \
    "${TARGET_NAME:-unknown}" \
    "${TARGET_LANE:-unknown}" >> "$VIOLATION_LOG"
}

dispatch_sizing_block() {
  local detail="${1:?detail required}"
  local next_step="${2:?next step required}"
  printf 'BLOCKED: dispatch preflight incomplete. Detail: %s. Next: %s.' "$detail" "$next_step"
}

phase3_dispatch_scope_tags() {
  local scope_blob="${1-}"
  local normalized=""
  local tags=()

  normalized="$(printf '%s' "$scope_blob" | tr '[:upper:]' '[:lower:]')"

  if printf '%s' "$normalized" | grep -qE '(^|[^a-z])frontend/|frontend/\*\*'; then
    tags+=("frontend")
  fi
  if printf '%s' "$normalized" | grep -qE 'backend/\*\*|backend/modules/|/modules/\*\*|feature-modules'; then
    tags+=("feature-modules")
  fi
  if printf '%s' "$normalized" | grep -qE 'backend/\*\*|backend/core/|/core/\*\*|shared core|alembic|run\.ps1|run\.sh'; then
    tags+=("shared-core")
  fi

  if [[ "${#tags[@]}" -eq 0 ]]; then
    return 0
  fi

  printf '%s\n' "${tags[@]}" | awk '!seen[$0]++'
}

phase3_parallel_basis_declared() {
  local split_basis_norm="${1-}"
  local parallel_groups_norm="${2-}"

  printf '%s\n%s\n' "$split_basis_norm" "$parallel_groups_norm" | grep -qiE 'parallel|병렬|split|batch|lane'
}

phase3_has_concrete_serial_blocker() {
  local blockers_norm="${1-}"

  [[ -n "$blockers_norm" && "$blockers_norm" != "none" ]]
}

phase3_parallel_developer_requires_concrete_name() {
  local active_workflow_norm="${1-}"
  local current_phase_norm="${2-}"
  local target_lane="${3-}"
  local target_name="${4-}"
  local split_basis_norm="${5-}"
  local parallel_groups_norm="${6-}"
  local dispatch_blockers_norm="${7-}"

  [[ "$active_workflow_norm" == "dev-workflow" ]] || return 1
  [[ "$current_phase_norm" == *"phase 3"* ]] || return 1
  [[ "$current_phase_norm" == *"implementation"* ]] || return 1
  [[ "$target_lane" == "developer" ]] || return 1
  [[ "$target_name" == "developer" ]] || return 1
  phase3_parallel_basis_declared "$split_basis_norm" "$parallel_groups_norm" || return 1
  phase3_has_concrete_serial_blocker "$dispatch_blockers_norm" && return 1
  return 0
}

idle_pending_recovery_step() {
  local worker_summary="${1-}"
  local primary_worker=""

  primary_worker="$(printf '%s' "$worker_summary" | awk -F',' '{print $1}' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$primary_worker" && "$worker_summary" != *","* ]]; then
    printf "treat '%s' as standby from its completion report and read its REQUESTED-LIFECYCLE: reuse it with assignment-grade SendMessage after WP+SV when reuse is requested or justified, or clean it up with shutdown_request during explicit teardown -> retry dispatch" \
      "$primary_worker"
    return 0
  fi

  if [[ -n "$worker_summary" ]]; then
    printf "treat completed agent(s) (%s) as standby and consult REQUESTED-LIFECYCLE: reuse the fitting agent when reuse is requested or justified, or clean up unneeded agents with shutdown_request during explicit teardown -> retry dispatch" \
      "$worker_summary"
    return 0
  fi

  printf 'reuse the fitting standby agent, or clean up unneeded agents with shutdown_request during explicit teardown -> retry dispatch'
}

worker_shard_boundary_for_idle_guard() {
  local worker_name="${1-}"
  local worker_key=""
  local boundary_file=""

  [[ -n "$worker_name" ]] || return 0
  worker_key="$(printf '%s' "$worker_name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g')"
  boundary_file="$LOG_DIR/.worker-shard-boundary-${worker_key}"
  [[ -f "$boundary_file" ]] || return 0
  sed -n '1p' "$boundary_file" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

acceptance_follow_on_can_proceed() {
  local worker_summary="${1-}"
  local target_lane="${2-}"
  local worker=""
  case "$target_lane" in
    reviewer|tester|validator) ;;
    *)
      return 1
      ;;
  esac

  [[ -n "$worker_summary" ]] || return 1
  IFS=',' read -r -a _idle_workers <<< "$worker_summary"
  [[ "${#_idle_workers[@]}" -ge 1 ]] || return 1

  for worker in "${_idle_workers[@]}"; do
    worker="$(printf '%s' "$worker" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    [[ -n "$worker" ]] || return 1
  done

  return 0
}

sharded_researcher_follow_on_can_proceed() {
  local worker_summary="${1-}"
  local target_lane="${2-}"
  local target_worker="${3-}"
  local target_shard_boundary="${4-}"
  local worker=""
  local worker_shard_boundary=""
  local normalized_target_boundary=""
  local normalized_worker_boundary=""

  [[ "$target_lane" == "researcher" ]] || return 1
  [[ -n "$target_worker" && "$target_worker" == researcher-* ]] || return 1
  [[ -n "$worker_summary" && -n "$target_shard_boundary" ]] || return 1

  normalized_target_boundary="$(normalize_surface_id "$target_shard_boundary")"
  [[ -n "$normalized_target_boundary" ]] || return 1

  IFS=',' read -r -a _idle_workers <<< "$worker_summary"
  [[ "${#_idle_workers[@]}" -ge 1 ]] || return 1

  for worker in "${_idle_workers[@]}"; do
    worker="$(printf '%s' "$worker" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    [[ -n "$worker" && "$worker" == researcher-* ]] || return 1
    [[ "$worker" != "$target_worker" ]] || return 1

    worker_shard_boundary="$(worker_shard_boundary_for_idle_guard "$worker")"
    [[ -n "$worker_shard_boundary" ]] || return 1

    normalized_worker_boundary="$(normalize_surface_id "$worker_shard_boundary")"
    [[ -n "$normalized_worker_boundary" && "$normalized_worker_boundary" != "$normalized_target_boundary" ]] || return 1
  done

  return 0
}

[[ "$TOOL_NAME" == "Agent" ]] || exit 0

TARGET_NAME="$(resolve_requested_dispatch_name "$AGENT_NAME" "$DESCRIPTION")"
if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "unknown" ]] && ! dispatch_target_is_dispatchable_agent "$TARGET_NAME"; then
  TARGET_NAME=""
fi
TARGET_LANE="$(resolve_agent_id "$TARGET_NAME")"
if [[ "$TARGET_LANE" == "unknown" ]]; then
  # Avoid calling resolve_requested_dispatch_name with an empty first argument.
  # Only attempt description-based lane fallback when AGENT_NAME is non-empty.
  if [[ -n "$AGENT_NAME" ]]; then
    TARGET_LANE="$(resolve_requested_dispatch_name "$AGENT_NAME" "$DESCRIPTION")"
  fi
  # If TARGET_LANE is still unknown after fallback, the case block below skips
  # lane-specific validation (no case arm matches); global checks above still applied.
fi

NORMALIZED_DESC="$(normalize_dispatch_text "$DESCRIPTION")"
DISPATCH_WORK_SURFACE="$(dispatch_field_raw_value "$DESCRIPTION" "WORK-SURFACE" 2>/dev/null | tr -d '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' || true)"
TARGET_SHARD_BOUNDARY="$(dispatch_field_raw_value "$DESCRIPTION" "SHARD-BOUNDARY" 2>/dev/null | tr -d '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' || true)"
CURRENT_PHASE_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "CURRENT-PHASE" 2>/dev/null || true)")"
ACTIVE_WORKFLOW_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "ACTIVE-WORKFLOW" 2>/dev/null || true)")"
PARALLEL_GROUPS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "PARALLEL-GROUPS" 2>/dev/null || true)")"
SPLIT_BASIS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "SPLIT-BASIS" 2>/dev/null || true)")"
DISPATCH_BLOCKERS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "DISPATCH-BLOCKERS" 2>/dev/null || true)")"
WRITE_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "WRITE-SCOPE" 2>/dev/null || true)"

if phase3_parallel_developer_requires_concrete_name \
  "$ACTIVE_WORKFLOW_NORM" \
  "$CURRENT_PHASE_NORM" \
  "$TARGET_LANE" \
  "$TARGET_NAME" \
  "$SPLIT_BASIS_NORM" \
  "$PARALLEL_GROUPS_NORM" \
  "$DISPATCH_BLOCKERS_NORM"; then
  emit_dispatch_warning "Phase 3 parallel developer dispatch uses bare agent name 'developer' while same-capability parallel work benefits from concrete identities. Prefer a concrete developer name from AGENT-MAP or reuse the matching existing developer with assignment-grade SendMessage after WP+SV."
fi

if [[ "$ACTIVE_WORKFLOW_NORM" == "dev-workflow" ]] \
  && [[ "$CURRENT_PHASE_NORM" == *"phase 3"* ]] \
  && [[ "$CURRENT_PHASE_NORM" == *"implementation"* ]] \
  && [[ "$TARGET_LANE" == "developer" ]] \
  && phase3_parallel_basis_declared "$SPLIT_BASIS_NORM" "$PARALLEL_GROUPS_NORM" \
  && ! phase3_has_concrete_serial_blocker "$DISPATCH_BLOCKERS_NORM"; then
  mapfile -t _phase3_scope_tags < <(phase3_dispatch_scope_tags "$WRITE_SCOPE_RAW")
  if [[ "${#_phase3_scope_tags[@]}" -ge 2 ]]; then
    _phase3_scope_summary="$(printf '%s, ' "${_phase3_scope_tags[@]}")"
    _phase3_scope_summary="${_phase3_scope_summary%, }"
    emit_dispatch_warning "Phase 3 implementation packet spans multiple independently ownable lanes (${_phase3_scope_summary}) while dispatch basis already declares a parallel split. Prefer lane-bounded developer packets, or record the exact blocker keeping those lanes serial in DISPATCH-BLOCKERS."
  fi
fi

# Sharded researcher dispatches are intentionally parallel runtime instances.
# The hook recognizes them only by explicit shard identity fields because packet
# mode wording is doctrine context, not a hook-owned behavior controller.
_is_sharded_researcher=false
SHARDED_TARGET_NAME=""
if [[ "$TARGET_LANE" == "researcher" ]]; then
  if dispatch_field_present "$DESCRIPTION" "SHARD-ID" || dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY"; then
    _is_sharded_researcher=true
    SHARD_ID_FOR_TARGET="$(dispatch_field_raw_value "$DESCRIPTION" "SHARD-ID" 2>/dev/null || true)"
    SHARD_ID_FOR_TARGET="$(printf '%s' "$SHARD_ID_FOR_TARGET" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9_-]+/-/g; s/^-+//; s/-+$//')"
    if [[ -n "$SHARD_ID_FOR_TARGET" ]]; then
      SHARDED_TARGET_NAME="researcher-${SHARD_ID_FOR_TARGET}"
    fi
  fi
fi

if [[ "$_is_sharded_researcher" == "true" && -n "$SHARDED_TARGET_NAME" ]]; then
  if target_is_already_active_worker "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher agent '${SHARDED_TARGET_NAME}' already exists" "choose a unique SHARD-ID for parallel work, or reuse '${SHARDED_TARGET_NAME}' with assignment-grade SendMessage after WP+SV")"
    exit 0
  fi

  if worker_is_standby "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher agent '${SHARDED_TARGET_NAME}' is already on standby" "reuse '${SHARDED_TARGET_NAME}' with assignment-grade SendMessage after WP+SV, or choose a unique SHARD-ID for a genuinely distinct shard")"
    exit 0
  fi

  if worker_is_idle_pending "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher agent '${SHARDED_TARGET_NAME}' has completion-grade output that should already classify as standby" "$(idle_pending_recovery_step "$SHARDED_TARGET_NAME")")"
    exit 0
  fi
fi

if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "unknown" ]]; then
  if [[ "$_is_sharded_researcher" != "true" ]] && target_is_already_active_worker "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "live agent '${TARGET_NAME}' already exists" "reuse with assignment-grade SendMessage after WP+SV, or decide shutdown/standby/hold before replacement spawn. For parallel same-capability work, choose a concrete unique agent name from AGENT-MAP instead of repeating a bare lane label. For parallel researcher work, provide shard identity fields (SHARD-ID, SHARD-BOUNDARY, MERGE-OWNER) or another concrete unique agent name.")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_standby "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "standby agent '${TARGET_NAME}' already exists" "reuse '${TARGET_NAME}' with assignment-grade SendMessage after WP+SV instead of replacement spawn")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_idle_pending "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "agent '${TARGET_NAME}' has completion-grade output that should already classify as standby" "$(idle_pending_recovery_step "$TARGET_NAME")")"
    exit 0
  fi
fi

# Standby-overlap enforcement is scoped to the current dispatch's work-surface:
# standby agents on a different known surface are excluded, while agents with
# unknown surfaces remain blocking because non-overlap cannot be proven truthfully.
STANDBY_COUNT="$(standby_worker_count_for_surface "$DISPATCH_WORK_SURFACE")"
if [[ "$STANDBY_COUNT" =~ ^[0-9]+$ ]] && (( STANDBY_COUNT >= 1 )); then
  STANDBY_SUMMARY="$(standby_worker_summary_for_surface "$DISPATCH_WORK_SURFACE")"
  if [[ -z "$DISPATCH_WORK_SURFACE" ]]; then
    emit_deny "$(dispatch_sizing_block "dispatch packet omits WORK-SURFACE while standby overlap exists (${STANDBY_SUMMARY:-unknown})" "add explicit WORK-SURFACE, or $(idle_pending_recovery_step "$STANDBY_SUMMARY")")"
    exit 0
  fi

  if acceptance_follow_on_can_proceed "$STANDBY_SUMMARY" "$TARGET_LANE"; then
    emit_dispatch_warning "allowing '${TARGET_LANE}' acceptance follow-on on work-surface '${DISPATCH_WORK_SURFACE}' despite standby overlap (${STANDBY_SUMMARY}). Upstream completion-grade handoff exists; keep ownership explicit."
    exit 0
  fi

  if sharded_researcher_follow_on_can_proceed "$STANDBY_SUMMARY" "$TARGET_LANE" "$SHARDED_TARGET_NAME" "$TARGET_SHARD_BOUNDARY"; then
    emit_dispatch_warning "allowing sharded researcher fan-out on work-surface '${DISPATCH_WORK_SURFACE}' despite standby overlap (${STANDBY_SUMMARY}). Distinct SHARD-BOUNDARY values and completion-grade handoff are present; keep ownership explicit."
    exit 0
  fi

  emit_deny "$(dispatch_sizing_block "standby agent(s) already exist on work-surface '${DISPATCH_WORK_SURFACE}' (${STANDBY_SUMMARY:-unknown})" "$(idle_pending_recovery_step "$STANDBY_SUMMARY")")"
  exit 0
fi

case "$TARGET_LANE" in
  researcher)
    if dispatch_field_present "$DESCRIPTION" "SHARD-ID" || dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY"; then
      if ! dispatch_field_present "$DESCRIPTION" "SHARD-ID"; then
        emit_deny "Sharded researcher dispatch requires SHARD-ID. Parallel shard work cannot stay legible without an explicit shard identity."
        exit 0
      fi
      if ! dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY"; then
        emit_deny "Sharded researcher dispatch requires SHARD-BOUNDARY. Parallel shard work must state the exact non-overlapping boundary."
        exit 0
      fi
      if ! dispatch_field_present "$DESCRIPTION" "MERGE-OWNER"; then
        emit_deny "Sharded researcher dispatch requires MERGE-OWNER before full fan-out. Merge responsibility cannot remain implicit."
        exit 0
      fi
    fi
    ;;

esac

# Record the dispatched agent's work-surface so future lifecycle-backlog checks can scope to
# the correct surface. Agents dispatched without a WORK-SURFACE field get no surface file
# and are treated as global-scope (safe fallback) in future lifecycle-backlog checks.
if [[ -n "$DISPATCH_WORK_SURFACE" ]]; then
  if [[ "$_is_sharded_researcher" == "true" && -n "$SHARDED_TARGET_NAME" ]]; then
    _dispatch_target="$SHARDED_TARGET_NAME"
  elif [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "unknown" ]]; then
    _dispatch_target="$TARGET_NAME"
  else
    _dispatch_target=""
  fi
  if [[ -n "$_dispatch_target" ]]; then
    _dispatch_surface_key="$(printf '%s' "$_dispatch_target" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g')"
    mkdir -p "$LOG_DIR"
    printf '%s\n' "$DISPATCH_WORK_SURFACE" > "$LOG_DIR/.worker-surface-${_dispatch_surface_key}"
    if [[ "$_is_sharded_researcher" == "true" && -n "$TARGET_SHARD_BOUNDARY" ]]; then
      printf '%s\n' "$TARGET_SHARD_BOUNDARY" > "$LOG_DIR/.worker-shard-boundary-${_dispatch_surface_key}"
    fi
  fi
fi

exit 0
