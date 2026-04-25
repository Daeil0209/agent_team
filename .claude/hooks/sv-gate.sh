#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# PreToolUse hook for SendMessage, Agent, TaskCreate, TaskUpdate, TeamDelete, and CronDelete.
# Enforces two-phase Mandatory Worker Execution Cycle:
# Plan -> post-planning self-verification -> Execute -> result verification -> Report
#
# Agent/TaskCreate (team-lead): blocks fan-out if post-planning self-verification load was not observed
# SendMessage (workers): blocks handoff if result-verification self-verification load was not observed

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
try {
  const input = JSON.parse(process.env.INPUT_JSON || '{}');
  const sid = String(input.session_id || 'unknown');
  const agentId = String(input.agent_id || '');
  const toolName = String(input.tool_name || '');
  const collectPaths = (value) => {
    if (!value || typeof value !== 'object') return [];
    const paths = [];
    for (const key of ['file_path', 'path']) {
      if (typeof value[key] === 'string' && value[key].trim()) paths.push(value[key].trim());
    }
    for (const key of ['edits', 'files']) {
      if (!Array.isArray(value[key])) continue;
      for (const entry of value[key]) {
        if (typeof entry === 'string' && entry.trim()) paths.push(entry.trim());
        else if (entry && typeof entry === 'object') {
          for (const nestedKey of ['file_path', 'path']) {
            if (typeof entry[nestedKey] === 'string' && entry[nestedKey].trim()) paths.push(entry[nestedKey].trim());
          }
        }
      }
    }
    return [...new Set(paths)];
  };
  const flattenText = (value) => {
    if (value == null) return [];
    if (typeof value === 'string') return value ? [value] : [];
    if (typeof value === 'number' || typeof value === 'boolean') return [String(value)];
    if (Array.isArray(value)) return value.flatMap(flattenText);
    if (typeof value === 'object') {
      const preferredKeys = ['text', 'message', 'content', 'summary', 'body', 'value', 'description', 'title', 'note', 'notes'];
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
      .map((chunk) => String(chunk || '').trim())
      .filter(Boolean)
      .filter((chunk) => {
        if (seen.has(chunk)) return false;
        seen.add(chunk);
        return true;
      })
      .join('\n');
  };
  const toolInput = input.tool_input || {};
  const messageText = joinUniqueText(
    flattenText(toolInput.summary)
      .concat(flattenText(toolInput.message || toolInput.content))
      .concat(flattenText(toolInput.description))
  );
  const targetPaths = collectPaths(toolInput).join('\n');
  const teammateName = String(
    input.teammate_name ||
    input.teammateName ||
    toolInput.to ||
    toolInput.recipient ||
    toolInput.recipient_name ||
    toolInput.recipientName ||
    toolInput.target_name ||
    toolInput.targetName ||
    toolInput.teammate_name ||
    toolInput.teammateName ||
    ''
  );
  process.stdout.write([sid, agentId, toolName, messageText, targetPaths, teammateName].map(encode).join('\n'));
} catch {
  process.stdout.write('\n\n\n\n\n\n');
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

SESSION_ID="$(decode_field "${FIELDS[0]:-}")"
AGENT_ID="$(decode_field "${FIELDS[1]:-}")"
TOOL_NAME="$(decode_field "${FIELDS[2]:-}")"
MESSAGE_TEXT="$(decode_field "${FIELDS[3]:-}")"
TARGET_PATHS="$(decode_field "${FIELDS[4]:-}")"
TEAMMATE_NAME="$(decode_field "${FIELDS[5]:-}")"
WORKER_NAME=""
SESSION_ID="$(recover_session_id "$SESSION_ID")"

WP_MARKER="$LOG_DIR/.wp-loaded-${SESSION_ID}"
SV_PLAN_MARKER="$LOG_DIR/.sv-plan-loaded-${SESSION_ID}"
SV_RESULT_MARKER="$LOG_DIR/.sv-result-loaded-${SESSION_ID}"

emit_deny() {
  local reason="${1:?reason required}"
  local surface_key=""
  surface_key="${TASK_ID:-}"
  if [[ -z "$surface_key" ]]; then
    surface_key="${WORKER_NAME:-${TOOL_NAME:-generic}}"
  fi
  DENY_REASON="$(augment_precheck_block_reason_on_repeat "$SESSION_ID" "$TOOL_NAME" "${surface_key:-generic}" "$reason")" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Dispatch preflight blocked."
  }
}));
NODE
}

sv_plan_block() {
  local tool_name="${1:-tool}"
  local next_step="${2:-retry after work-planning}"
  printf 'BLOCKED: planning preflight incomplete. Detail: %s missing current-task work-planning. Next: %s.' "$tool_name" "$next_step"
}

sv_verify_block() {
  local tool_name="${1:-tool}"
  local next_step="${2:-retry after self-verification}"
  printf 'BLOCKED: verification preflight incomplete. Detail: %s missing post-planning self-verification. Next: %s.' "$tool_name" "$next_step"
}

lead_bounded_iteration_continuation() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local target_name=""
  local message_class=""
  local continuation_class=""
  local iteration_owner_lane=""

  target_name="$(normalize_lane_id "$TEAMMATE_NAME")"
  [[ -n "$target_name" ]] || return 1

  message_class="$(dispatch_field_raw_value "$MESSAGE_TEXT" "MESSAGE-CLASS" 2>/dev/null || true)"
  message_class="$(printf '%s' "$message_class" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
  continuation_class="$(dispatch_field_raw_value "$MESSAGE_TEXT" "CONTINUATION-CLASS" 2>/dev/null || true)"
  continuation_class="$(printf '%s' "$continuation_class" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
  iteration_owner_lane="$(dispatch_field_raw_value "$MESSAGE_TEXT" "ITERATION-OWNER-LANE" 2>/dev/null || true)"
  iteration_owner_lane="$(printf '%s' "$iteration_owner_lane" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"

  case "$message_class" in
    reuse|reroute) ;;
    *) return 1 ;;
  esac

  [[ "$continuation_class" == "bounded-iteration" ]] || return 1
  dispatch_field_present "$MESSAGE_TEXT" "REQUIRED-SKILLS" || return 1

  case "$iteration_owner_lane" in
    developer|reviewer|tester|validator) ;;
    *) return 1 ;;
  esac

  if target_is_already_active_worker "$target_name"; then
    return 0
  fi

  worker_is_standby "$target_name"
}

if session_id_is_known_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
fi

case "$TOOL_NAME" in
  SendMessage)
    # Worker gate: enforce Phase 1+2 for worker completion-grade reports.
    if ! runtime_sender_session_is_worker "$SESSION_ID"; then
      # V-01 fix: lead assignment-grade SendMessage must also satisfy WP + SV Phase 1.
      LEAD_MESSAGE_CLASS="$(dispatch_field_raw_value "$MESSAGE_TEXT" "MESSAGE-CLASS" 2>/dev/null || true)"
      LEAD_MESSAGE_CLASS="$(printf '%s' "$LEAD_MESSAGE_CLASS" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
      if lead_bounded_iteration_continuation; then
        exit 0
      fi
      # Cleanup-only exemption per team-lead.md RPA-8 SV Consume Rule:
      # shutdown_request bypasses WP+SV requirements because it is teardown/control, not new work.
      if printf '%s' "$MESSAGE_TEXT" | grep -qiE 'shutdown_request'; then
        exit 0
      fi
      if dispatch_field_present "$MESSAGE_TEXT" "REQUIRED-SKILLS" || [[ "$LEAD_MESSAGE_CLASS" == "assignment" || "$LEAD_MESSAGE_CLASS" == "reuse" || "$LEAD_MESSAGE_CLASS" == "reroute" ]]; then
        # Missing-WP/fresh-turn dispatch is owned by task-start-gate. Avoid
        # emitting a second hard block for the same defect; this gate owns
        # Phase-1 SV after work-planning is observed.
        [[ -f "$WP_MARKER" ]] || exit 0
        if [[ ! -f "$SV_PLAN_MARKER" ]]; then
          printf '[%s] SV-GATE BLOCKED: lead assignment-grade SendMessage without post-planning SV (session: %s)\n' \
            "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
          emit_deny "$(sv_verify_block "assignment-grade SendMessage" "Skill(self-verification) -> lifecycle/reuse check -> retry SendMessage")"
          exit 0
        fi
      fi
      exit 0
    fi
    MESSAGE_CLASS="$(dispatch_field_raw_value "$MESSAGE_TEXT" "message-class" 2>/dev/null || true)"
    MESSAGE_CLASS="$(printf '%s' "$MESSAGE_CLASS" | tr '[:upper:]' '[:lower:]')"
    case "$MESSAGE_CLASS" in
      handoff|completion) ;;
      *) exit 0 ;;
    esac
    if [[ -n "$WORKER_NAME" ]] && worker_planning_required "$WORKER_NAME"; then
      printf '[%s] SV-GATE BLOCKED: worker completion-grade SendMessage before fresh work-planning (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_plan_block "completion-grade SendMessage" "Skill(work-planning) -> continue work -> retry SendMessage")"
      exit 0
    fi
    if [[ ! -f "$WP_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: worker completion-grade SendMessage without observed work-planning (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_plan_block "completion-grade SendMessage" "Skill(work-planning) -> continue work -> retry SendMessage")"
      exit 0
    fi
    if [[ ! -f "$SV_PLAN_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: worker completion-grade SendMessage without post-planning self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "completion-grade SendMessage" "Skill(self-verification) -> continue work -> retry SendMessage")"
      exit 0
    fi
    # Result-verification gate: workers must load self-verification and verify results before handoff.
    # PLATFORM NOTE: a PreToolUse deny here prevents PostToolUse (track-worker-report.sh)
    # from firing, leaving a ledger gap — but the platform still delivers the message.
    # Changed to WARN-ONLY: allow the message through so track-worker-report.sh writes the
    # ledger entry. Enforcement is deferred to task-completed-gate.sh, which checks the
    # sv-result marker independently before accepting task completion.
    if [[ ! -f "$SV_RESULT_MARKER" ]]; then
      printf '[%s] SV-GATE WARN: worker SendMessage without result-verification self-verification load (session: %s) -- deferring enforcement to task-completed-gate\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
    fi
    ;;
  Agent|TaskCreate)
    # Team-lead gate: only enforce for non-worker sessions.
    if runtime_sender_session_is_worker "$SESSION_ID"; then
      exit 0
    fi
    # Missing-WP/fresh-turn dispatch is owned by task-start-gate. This avoids
    # duplicate block messages while preserving the same hard stop.
    [[ -f "$WP_MARKER" ]] || exit 0
    # Post-planning gate: team-lead must load self-verification and verify the plan before dispatching.
    if [[ ! -f "$SV_PLAN_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: team-lead %s without post-planning self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "$TOOL_NAME" "Skill(self-verification) -> lifecycle/reuse check -> retry dispatch")"
      exit 0
    fi
    ;;
  TaskUpdate|TeamDelete|CronDelete)
    # This branch enforces post-planning SV for runtime/state mutation tools only.
    # File edits are not hard-blocked by this branch: their fresh-turn planning
    # lock is enforced by task-start-gate, while SV remains a doctrine/procedure
    # obligation under team-lead.md RPA-8 SV Consume Rule.
    if runtime_sender_session_is_worker "$SESSION_ID"; then
      exit 0
    fi
    if [[ "$TOOL_NAME" == "TeamDelete" || "$TOOL_NAME" == "CronDelete" ]] && [[ -n "$SESSION_ID" ]] && closeout_intent_is_active "$SESSION_ID"; then
      exit 0
    fi
    if procedure_state_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS" || project_continuity_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS"; then
      exit 0
    fi
    # Only enforce when a task is in progress (WP loaded) but plan not yet verified (no SV Phase 1).
    if [[ ! -f "$WP_MARKER" ]]; then
      exit 0
    fi
    if [[ ! -f "$SV_PLAN_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: team-lead %s without post-planning self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "$TOOL_NAME" "Skill(self-verification) -> retry $TOOL_NAME")"
      exit 0
    fi
    ;;
esac

exit 0
