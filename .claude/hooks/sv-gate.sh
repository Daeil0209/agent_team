#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# PreToolUse hook for SendMessage, Agent, and TaskCreate.
# Enforces two-phase Mandatory Worker Execution Cycle:
# Plan -> Verify Plan (Phase 1) -> Execute -> Verify Results (Phase 2) -> Report
#
# Agent/TaskCreate (team-lead): blocks fan-out if Phase 1 self-verification load was not observed
# SendMessage (workers): blocks handoff if Phase 2 self-verification load was not observed

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
  const teammateName = String(input.teammate_name || input.teammateName || toolInput.teammate_name || toolInput.teammateName || '');
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
  DENY_REASON="$reason" node <<'NODE'
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
  printf 'BLOCKED: verification preflight incomplete. Detail: %s missing Phase 1 self-verification. Next: %s.' "$tool_name" "$next_step"
}

lead_follow_on_verification_sendmessage_allowed() {
  local message_class="${1-}"
  local message_text="${2-}"
  local teammate_name="${3-}"
  local target_name=""
  local target_lane=""

  case "$message_class" in
    assignment|reuse|reroute) ;;
    *) return 1 ;;
  esac

  target_name="$(resolve_requested_dispatch_name "$teammate_name" "$message_text")"
  target_lane="$(resolve_agent_id "$target_name")"
  case "$target_lane" in
    reviewer|tester|validator) ;;
    *) return 1 ;;
  esac
  return 0
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
      # Lifecycle-control exemption per team-lead.md IR-2 §10:
      # MESSAGE-CLASS: control + LIFECYCLE-DECISION bypass WP+SV requirements.
      if [[ "$LEAD_MESSAGE_CLASS" == "control" ]] && dispatch_field_present "$MESSAGE_TEXT" "LIFECYCLE-DECISION"; then
        exit 0
      fi
      # Minimal-guide exception: follow-on verification assignment to an existing
      # reviewer/tester/validator worker should not be serialized behind fresh-turn
      # planning ceremony.
      if lead_follow_on_verification_sendmessage_allowed "$LEAD_MESSAGE_CLASS" "$MESSAGE_TEXT" "$TEAMMATE_NAME"; then
        exit 0
      fi
      if dispatch_field_present "$MESSAGE_TEXT" "REQUIRED-SKILLS" || [[ "$LEAD_MESSAGE_CLASS" == "assignment" || "$LEAD_MESSAGE_CLASS" == "reuse" || "$LEAD_MESSAGE_CLASS" == "reroute" ]]; then
        if [[ ! -f "$WP_MARKER" ]]; then
          printf '[%s] SV-GATE BLOCKED: lead assignment-grade SendMessage without work-planning (session: %s)\n' \
            "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
          emit_deny "$(sv_plan_block "assignment-grade SendMessage" "Skill(work-planning) -> Skill(self-verification) -> lifecycle/reuse check -> retry SendMessage")"
          exit 0
        fi
        if [[ ! -f "$SV_PLAN_MARKER" ]]; then
          printf '[%s] SV-GATE BLOCKED: lead assignment-grade SendMessage without Phase 1 SV (session: %s)\n' \
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
      printf '[%s] SV-GATE BLOCKED: worker completion-grade SendMessage without Phase 1 self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "completion-grade SendMessage" "Skill(self-verification) -> continue work -> retry SendMessage")"
      exit 0
    fi
    # Phase 2 gate: workers must load self-verification and verify results before handoff.
    # PLATFORM NOTE: a PreToolUse deny here prevents PostToolUse (track-worker-report.sh)
    # from firing, leaving a ledger gap — but the platform still delivers the message.
    # Changed to WARN-ONLY: allow the message through so track-worker-report.sh writes the
    # ledger entry. Enforcement is deferred to task-completed-gate.sh, which checks the
    # sv-result marker independently before accepting task completion.
    if [[ ! -f "$SV_RESULT_MARKER" ]]; then
      printf '[%s] SV-GATE WARN: worker SendMessage without Phase 2 self-verification load (session: %s) -- deferring enforcement to task-completed-gate\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
    fi
    ;;
  Agent|TaskCreate)
    # Team-lead gate: only enforce for non-worker sessions.
    if runtime_sender_session_is_worker "$SESSION_ID"; then
      exit 0
    fi
    if lead_planning_required "$SESSION_ID"; then
      printf '[%s] SV-GATE BLOCKED: team-lead %s before fresh work-planning (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_plan_block "$TOOL_NAME" "Skill(work-planning) -> Skill(self-verification) -> lifecycle/reuse check -> retry dispatch")"
      exit 0
    fi
    if [[ ! -f "$WP_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: team-lead %s without observed work-planning (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_plan_block "$TOOL_NAME" "Skill(work-planning) -> Skill(self-verification) -> lifecycle/reuse check -> retry dispatch")"
      exit 0
    fi
    # Phase 1 gate: team-lead must load self-verification and verify the plan before dispatching.
    if [[ ! -f "$SV_PLAN_MARKER" ]]; then
      printf '[%s] SV-GATE BLOCKED: team-lead %s without Phase 1 self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "$TOOL_NAME" "Skill(self-verification) -> lifecycle/reuse check -> retry dispatch")"
      exit 0
    fi
    ;;
  Edit|MultiEdit|Write|TaskUpdate|TeamDelete|CronDelete)
    # Team-lead gate: block file/state mutation when task is in progress but plan is not yet verified.
    # TaskUpdate, TeamDelete, CronDelete are included per Identity Lock (team-lead.md IR-2 §10).
    if runtime_sender_session_is_worker "$SESSION_ID"; then
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
      printf '[%s] SV-GATE BLOCKED: team-lead %s without Phase 1 self-verification load (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$TOOL_NAME" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      emit_deny "$(sv_verify_block "file modification" "Skill(self-verification) -> retry file modification")"
      exit 0
    fi
    ;;
  Bash)
    # A-10: Gate mutable Bash operations targeting .claude/ governance surfaces.
    # Only enforces when team-lead has WP loaded but SV Phase 1 not yet done.
    if runtime_sender_session_is_worker "$SESSION_ID"; then
      exit 0
    fi
    if [[ ! -f "$WP_MARKER" ]]; then
      exit 0
    fi
    if [[ ! -f "$SV_PLAN_MARKER" ]]; then
      BASH_CMD_RAW="$(INPUT_JSON="$INPUT" node -e "
try {
  const input = JSON.parse(process.env.INPUT_JSON || '{}');
  process.stdout.write(String((input.tool_input && input.tool_input.command) || ''));
} catch { process.stdout.write(''); }
" 2>/dev/null || printf '')"
      # Check if the command targets .claude/ governance surfaces with a mutable operation
      if printf '%s' "$BASH_CMD_RAW" | grep -qE '(^|[[:space:]])[^[:space:]]*\.claude/|/\.claude/'; then
        if printf '%s' "$BASH_CMD_RAW" | grep -Eiq '(^|[[:space:]])(sed[[:space:]]+-i|perl[[:space:]]+-i|tee|cp|mv|rm|mkdir|touch)([[:space:]]|$)|>>?[[:space:]]*[^&/]'; then
          printf '[%s] SV-GATE BLOCKED: team-lead Bash targeting .claude/ governance surface without Phase 1 SV (session: %s)\n' \
            "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
          emit_deny "$(sv_verify_block "Bash (governance surface write)" "Skill(self-verification) -> retry Bash command")"
          exit 0
        fi
      fi
    fi
    ;;
esac

exit 0
