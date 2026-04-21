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

decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
DESCRIPTION="$(decode_field "${FIELDS[1]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[2]:-}")"
SESSION_ID="$(decode_field "${FIELDS[3]:-}")"

emit_deny() {
  local reason="${1:?reason required}"
  local surface_key=""
  surface_key="${DISPATCH_WORK_SURFACE:-${TARGET_NAME:-${TARGET_LANE:-generic}}}"
  DENY_REASON="$(augment_precheck_block_reason_on_repeat "$SESSION_ID" "$TOOL_NAME" "${surface_key:-generic}" "$reason")" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Dispatch sizing guard blocked the assignment."
  }
}));
NODE
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

dispatch_target_block() {
  local detail="${1:?detail required}"
  local next_step="${2:?next step required}"
  printf 'BLOCKED: dispatch target invalid. Detail: %s. Next: %s.' "$detail" "$next_step"
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

worker_requested_lifecycle_for_idle_guard() {
  local worker_name="${1-}"
  local normalized_worker=""

  [[ -n "$worker_name" && -f "$WORKER_REPORT_LEDGER" ]] || return 0
  normalized_worker="$(printf '%s' "$worker_name" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "$normalized_worker" ]] || return 0

  WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" TARGET_WORKER="$normalized_worker" node <<'NODE'
const fs = require("fs");

const ledgerPath = process.env.WORKER_REPORT_LEDGER || "";
const targetWorker = String(process.env.TARGET_WORKER || "").trim().toLowerCase();

if (!ledgerPath || !targetWorker || !fs.existsSync(ledgerPath)) {
  process.stdout.write("");
  process.exit(0);
}

let latest = null;
for (const line of fs.readFileSync(ledgerPath, "utf8").split(/\r?\n/)) {
  if (!line.trim()) continue;
  let parsed;
  try {
    parsed = JSON.parse(line);
  } catch {
    continue;
  }
  if (!parsed || typeof parsed !== "object") continue;
  const senderName = String(parsed.senderName || "").trim().toLowerCase();
  if (senderName !== targetWorker) continue;
  const messageClass = String(parsed.messageClass || "").trim().toLowerCase();
  if (!["handoff", "completion", "hold"].includes(messageClass)) continue;
  const timestamp = String(parsed.timestamp || "");
  if (!latest || timestamp >= String(latest.timestamp || "")) {
    latest = parsed;
  }
}

process.stdout.write(String((latest && latest.requestedLifecycle) || "").trim().toLowerCase());
NODE
}

idle_pending_recovery_step() {
  local worker_summary="${1-}"
  local requested_lifecycle=""
  local primary_worker=""

  primary_worker="$(printf '%s' "$worker_summary" | awk -F',' '{print $1}' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$primary_worker" && "$worker_summary" != *","* ]]; then
    requested_lifecycle="$(worker_requested_lifecycle_for_idle_guard "$primary_worker")"
  fi

  if [[ -n "$primary_worker" && "$worker_summary" != *","* && -n "$requested_lifecycle" ]]; then
    printf "send lifecycle SendMessage for '%s' with LIFECYCLE-DECISION: %s -> retry dispatch" \
      "$primary_worker" "$requested_lifecycle"
    return 0
  fi

  if [[ -n "$worker_summary" ]]; then
    printf "send lifecycle SendMessage(s) for undecided worker(s) (%s) with explicit reuse|standby|shutdown|hold-for-validation -> retry dispatch" \
      "$worker_summary"
    return 0
  fi

  printf 'send lifecycle SendMessage with explicit reuse|standby|shutdown|hold-for-validation -> retry dispatch'
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
  local requested_lifecycle=""

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
    requested_lifecycle="$(worker_requested_lifecycle_for_idle_guard "$worker")"
    [[ -n "$requested_lifecycle" ]] || return 1
  done

  return 0
}

sharded_researcher_follow_on_can_proceed() {
  local worker_summary="${1-}"
  local target_lane="${2-}"
  local target_worker="${3-}"
  local target_shard_boundary="${4-}"
  local worker=""
  local requested_lifecycle=""
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

    requested_lifecycle="$(worker_requested_lifecycle_for_idle_guard "$worker")"
    [[ -n "$requested_lifecycle" ]] || return 1

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
RESEARCH_MODE_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "RESEARCH-MODE" 2>/dev/null || true)")"
DISPATCH_WORK_SURFACE="$(dispatch_field_raw_value "$DESCRIPTION" "WORK-SURFACE" 2>/dev/null | tr -d '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' || true)"
TARGET_SHARD_BOUNDARY="$(dispatch_field_raw_value "$DESCRIPTION" "SHARD-BOUNDARY" 2>/dev/null | tr -d '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' || true)"
CURRENT_PHASE_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "CURRENT-PHASE" 2>/dev/null || true)")"
ACTIVE_WORKFLOW_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "ACTIVE-WORKFLOW" 2>/dev/null || true)")"
PARALLEL_GROUPS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "PARALLEL-GROUPS" 2>/dev/null || true)")"
SPLIT_BASIS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "SPLIT-BASIS" 2>/dev/null || true)")"
DISPATCH_BLOCKERS_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "DISPATCH-BLOCKERS" 2>/dev/null || true)")"
WRITE_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "WRITE-SCOPE" 2>/dev/null || true)"

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
    emit_deny "$(dispatch_sizing_block "Phase 3 implementation packet spans multiple independently ownable lanes (${_phase3_scope_summary}) while dispatch basis already declares a parallel split" "split into lane-bounded developer packets, or record the exact blocker keeping those lanes serial in DISPATCH-BLOCKERS")"
    exit 0
  fi
fi

# Sharded researcher dispatches are intentionally parallel instances, each identified by a
# unique SHARD-ID. Duplicate-prevention and idle-backlog checks do not apply to them;
# sharded-field validation (SHARD-ID, SHARD-BOUNDARY, MERGE-OWNER) runs in the case block below.
# B-5: Also treat as sharded when SHARD-ID or SHARD-BOUNDARY is present even if
# RESEARCH-MODE is not explicitly "sharded" (the case block will validate required fields).
_is_sharded_researcher=false
SHARDED_TARGET_NAME=""
if [[ "$TARGET_LANE" == "researcher" ]]; then
  if [[ "$RESEARCH_MODE_NORM" == "sharded" ]] || dispatch_field_present "$DESCRIPTION" "SHARD-ID" || dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY"; then
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
    emit_deny "$(dispatch_sizing_block "sharded researcher worker '${SHARDED_TARGET_NAME}' already exists" "choose a unique SHARD-ID for parallel work, or reuse '${SHARDED_TARGET_NAME}' with assignment-grade SendMessage after WP+SV")"
    exit 0
  fi

  if worker_is_standby "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher worker '${SHARDED_TARGET_NAME}' is already on standby" "reuse '${SHARDED_TARGET_NAME}' with assignment-grade SendMessage after WP+SV, or choose a unique SHARD-ID for a genuinely distinct shard")"
    exit 0
  fi

  if worker_is_idle_pending "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher worker '${SHARDED_TARGET_NAME}' has completion-grade output awaiting lifecycle decision" "$(idle_pending_recovery_step "$SHARDED_TARGET_NAME")")"
    exit 0
  fi
fi

if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "unknown" ]]; then
  if [[ "$_is_sharded_researcher" != "true" ]] && target_is_already_active_worker "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "live worker '${TARGET_NAME}' already exists" "reuse with assignment-grade SendMessage after WP+SV, or decide shutdown/standby/hold before replacement spawn. For parallel researcher work, retry as RESEARCH-MODE: sharded with SHARD-ID, SHARD-BOUNDARY, and MERGE-OWNER")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_standby "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "standby worker '${TARGET_NAME}' already exists" "reuse '${TARGET_NAME}' with assignment-grade SendMessage after WP+SV instead of replacement spawn")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_idle_pending "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "worker '${TARGET_NAME}' has completion-grade output awaiting lifecycle decision" "$(idle_pending_recovery_step "$TARGET_NAME")")"
    exit 0
  fi
fi

# Lifecycle-control SendMessages (MESSAGE-CLASS: control + LIFECYCLE-DECISION) are
# exempt from lifecycle-backlog enforcement via sv-gate.sh. No equivalent Agent-dispatch
# exemption is needed here: lifecycle decisions use SendMessage, not Agent, so
# MESSAGE-CLASS: control cannot appear in a real Agent dispatch payload.

# Lifecycle-backlog enforcement is scoped to the current dispatch's work-surface:
# completed workers on a different known surface are excluded, while workers with
# unknown surfaces remain blocking because non-overlap cannot be proven truthfully.
IDLE_PENDING_COUNT="$(idle_pending_worker_count_for_surface "$DISPATCH_WORK_SURFACE")"
if [[ "$IDLE_PENDING_COUNT" =~ ^[0-9]+$ ]] && (( IDLE_PENDING_COUNT >= 1 )); then
  IDLE_PENDING_SUMMARY="$(idle_pending_worker_summary_for_surface "$DISPATCH_WORK_SURFACE")"
  if [[ -z "$DISPATCH_WORK_SURFACE" ]]; then
    emit_deny "$(dispatch_sizing_block "dispatch packet omits WORK-SURFACE while completed-worker lifecycle backlog exists (${IDLE_PENDING_SUMMARY:-unknown})" "add explicit WORK-SURFACE, or $(idle_pending_recovery_step "$IDLE_PENDING_SUMMARY")")"
    exit 0
  fi

  if acceptance_follow_on_can_proceed "$IDLE_PENDING_SUMMARY" "$TARGET_LANE"; then
    emit_dispatch_warning "allowing '${TARGET_LANE}' acceptance follow-on on work-surface '${DISPATCH_WORK_SURFACE}' despite completed-worker lifecycle backlog (${IDLE_PENDING_SUMMARY}). Upstream completion-grade handoff exists; lead still owes an explicit lifecycle SendMessage."
    exit 0
  fi

  if sharded_researcher_follow_on_can_proceed "$IDLE_PENDING_SUMMARY" "$TARGET_LANE" "$SHARDED_TARGET_NAME" "$TARGET_SHARD_BOUNDARY"; then
    emit_dispatch_warning "allowing sharded researcher fan-out on work-surface '${DISPATCH_WORK_SURFACE}' despite shard lifecycle backlog (${IDLE_PENDING_SUMMARY}). Distinct SHARD-BOUNDARY values and completion-grade handoff are present; lead still owes an explicit lifecycle SendMessage."
    exit 0
  fi

  emit_deny "$(dispatch_sizing_block "completed worker(s) awaiting lifecycle decision already exist on work-surface '${DISPATCH_WORK_SURFACE}' (${IDLE_PENDING_SUMMARY:-unknown})" "$(idle_pending_recovery_step "$IDLE_PENDING_SUMMARY")")"
  exit 0
fi

case "$TARGET_LANE" in
  researcher)
    if [[ "$RESEARCH_MODE_NORM" == "sharded" ]] || dispatch_field_present "$DESCRIPTION" "SHARD-ID" || dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY"; then
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

# Record the dispatched worker's work-surface so future lifecycle-backlog checks can scope to
# the correct surface. Workers dispatched without a WORK-SURFACE field get no surface file
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
