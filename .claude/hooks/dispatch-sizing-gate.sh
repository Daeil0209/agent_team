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
  DENY_REASON="$reason" node <<'NODE'
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

idle_pending_summary_allows_phase_progress() {
  local summary="${1-}"
  local target_lane="${2-}"
  local worker=""

  [[ -n "$summary" && -n "$target_lane" ]] || return 1
  [[ "$target_lane" != "researcher" ]] || return 1

  IFS=',' read -r -a _idle_workers <<< "$summary"
  [[ "${#_idle_workers[@]}" -ge 1 ]] || return 1

  for worker in "${_idle_workers[@]}"; do
    worker="$(printf '%s' "$worker" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    [[ -n "$worker" ]] || return 1
    [[ "$worker" == researcher-* ]] || return 1
  done

  return 0
}

worker_surface_for_idle_guard() {
  local worker_name="${1-}"
  local worker_key=""
  local surface_file=""

  [[ -n "$worker_name" ]] || return 0
  worker_key="$(printf '%s' "$worker_name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g')"
  surface_file="$LOG_DIR/.worker-surface-${worker_key}"
  [[ -f "$surface_file" ]] || return 0
  sed -n '1p' "$surface_file" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
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

filter_idle_pending_summary_for_validation_follow_on() {
  local summary="${1-}"
  local target_lane="${2-}"
  local dispatch_surface="${3-}"
  local worker=""
  local worker_surface=""
  local worker_lane=""
  local -a remaining_workers=()

  [[ -n "$summary" ]] || return 0
  case "$target_lane" in
    reviewer|tester|validator) ;;
    *)
      printf '%s' "$summary"
      return 0
      ;;
  esac
  [[ -n "$dispatch_surface" ]] || {
    printf '%s' "$summary"
    return 0
  }

  IFS=',' read -r -a _idle_workers <<< "$summary"
  for worker in "${_idle_workers[@]}"; do
    worker="$(printf '%s' "$worker" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    [[ -n "$worker" ]] || continue
    worker_surface="$(worker_surface_for_idle_guard "$worker")"
    worker_lane="$(resolve_agent_id "$worker")"
    if [[ -n "$worker_surface" && "$worker_surface" == "$dispatch_surface" ]]; then
      case "$worker_lane" in
        developer|researcher)
          continue
          ;;
      esac
      if [[ "$target_lane" == "reviewer" || "$target_lane" == "tester" || "$target_lane" == "validator" ]]; then
        continue
      fi
    fi
    remaining_workers+=("$worker")
  done

  if [[ "${#remaining_workers[@]}" -eq 0 ]]; then
    printf ''
    return 0
  fi

  local joined=""
  printf -v joined '%s,' "${remaining_workers[@]}"
  printf '%s' "${joined%,}"
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
    emit_deny "$(dispatch_sizing_block "sharded researcher worker '${SHARDED_TARGET_NAME}' is on standby" "reuse preserved shard context with SendMessage, or choose a unique SHARD-ID for a separate parallel shard")"
    exit 0
  fi

  if worker_is_idle_pending "$SHARDED_TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "sharded researcher worker '${SHARDED_TARGET_NAME}' is idle without lifecycle decision" "decide reuse/standby/shutdown/hold-for-validation for that shard before respawning the same SHARD-ID")"
    exit 0
  fi
fi

if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "unknown" ]]; then
  if [[ "$_is_sharded_researcher" != "true" ]] && target_is_already_active_worker "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "live worker '${TARGET_NAME}' already exists" "reuse with assignment-grade SendMessage after WP+SV, or decide shutdown/standby/hold before replacement spawn. For parallel researcher work, retry as RESEARCH-MODE: sharded with SHARD-ID, SHARD-BOUNDARY, and MERGE-OWNER")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_standby "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "standby worker '${TARGET_NAME}' already exists" "reuse preserved context with SendMessage, or make an explicit lifecycle decision before replacement spawn. For parallel researcher work, retry as RESEARCH-MODE: sharded with SHARD-ID, SHARD-BOUNDARY, and MERGE-OWNER")"
    exit 0
  fi

  if [[ "$_is_sharded_researcher" != "true" ]] && worker_is_idle_pending "$TARGET_NAME"; then
    emit_deny "$(dispatch_sizing_block "worker '${TARGET_NAME}' is idle without lifecycle decision" "decide reuse/standby/shutdown/hold-for-validation before duplicate spawn. For parallel researcher work, retry as RESEARCH-MODE: sharded with SHARD-ID, SHARD-BOUNDARY, and MERGE-OWNER")"
    exit 0
  fi
fi

# Lifecycle-control SendMessages (MESSAGE-CLASS: control + LIFECYCLE-DECISION) are
# exempt from idle-pending enforcement via sv-gate.sh. No equivalent Agent-dispatch
# exemption is needed here: lifecycle decisions use SendMessage, not Agent, so
# MESSAGE-CLASS: control cannot appear in a real Agent dispatch payload.

# Sharded researcher dispatches may co-exist with an idle-pending first shard that
# completed normally. Allow the idle-pending check to be bypassed for them so
# that parallel shard fan-out is not serialized by the first shard's lifecycle decision.
# Idle-pending enforcement is scoped to the current dispatch's work-surface: workers on a
# different known surface are excluded. Workers with unknown surface are included as a safe
# fallback (never weaker than the previous global check).
if [[ "$_is_sharded_researcher" != "true" ]]; then
  IDLE_PENDING_COUNT="$(idle_pending_worker_count_for_surface "$DISPATCH_WORK_SURFACE")"
  if [[ "$IDLE_PENDING_COUNT" =~ ^[0-9]+$ ]] && (( IDLE_PENDING_COUNT >= 1 )); then
    IDLE_PENDING_SUMMARY="$(idle_pending_worker_summary_for_surface "$DISPATCH_WORK_SURFACE")"
    FILTERED_IDLE_PENDING_SUMMARY="$(filter_idle_pending_summary_for_validation_follow_on "$IDLE_PENDING_SUMMARY" "$TARGET_LANE" "$DISPATCH_WORK_SURFACE")"
    if [[ -n "$FILTERED_IDLE_PENDING_SUMMARY" ]]; then
      FILTERED_IDLE_PENDING_COUNT="$(printf '%s' "$FILTERED_IDLE_PENDING_SUMMARY" | awk -F',' '{print NF}')"
    else
      FILTERED_IDLE_PENDING_COUNT="0"
    fi
    if idle_pending_summary_allows_phase_progress "$IDLE_PENDING_SUMMARY" "$TARGET_LANE"; then
      emit_dispatch_warning "researcher shard idle backlog left undecided (${IDLE_PENDING_SUMMARY:-unknown}); allowing cross-lane phase progress for '${TARGET_LANE}'. Recommended follow-up: send lifecycle decisions to those shard workers."
    elif [[ "$FILTERED_IDLE_PENDING_COUNT" =~ ^[0-9]+$ ]] && (( FILTERED_IDLE_PENDING_COUNT == 0 )); then
      emit_dispatch_warning "allowing '${TARGET_LANE}' follow-on verification on work-surface '${DISPATCH_WORK_SURFACE:-unknown}' despite idle worker backlog (${IDLE_PENDING_SUMMARY:-unknown}). Verification follow-on should not be serialized behind lifecycle housekeeping. Lead still owes authoritative lifecycle cleanup."
    else
      emit_deny "$(dispatch_sizing_block "${FILTERED_IDLE_PENDING_COUNT:-$IDLE_PENDING_COUNT} undecided idle worker(s) on work-surface '${DISPATCH_WORK_SURFACE:-global}' (${FILTERED_IDLE_PENDING_SUMMARY:-$IDLE_PENDING_SUMMARY})" "SendMessage each listed worker with LIFECYCLE-DECISION: standby(default)|reuse|shutdown|hold-for-validation; optional DECISION-BASIS, then retry dispatch.")"
      exit 0
    fi
  fi
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

# Record the dispatched worker's work-surface so future idle-pending checks can scope to
# the correct surface. Workers dispatched without a WORK-SURFACE field get no surface file
# and are treated as global-scope (safe fallback) in future idle-pending checks.
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
  fi
fi

exit 0
