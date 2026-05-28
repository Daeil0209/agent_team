#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# PostToolUse hook for Skill tool.
# Tracks phase/stage-end self-verification sequence markers per session and
# clears the self-growth entry markers when the self-growth-sequence skill is explicitly loaded.
# Loading proves sequence entry only; route/patch closure remains governed by
# the self-growth procedure and downstream verification, not this hook.
# session-boot load marks lead-local boot procedure entry only. Boot-infra
# completion is recorded later when runtime setup succeeds or task planning
# begins; host-authorized runtime entry still belongs to TeamCreate and runtime-entry
# enforcement.
# lead self-verification convergence marker = self-verification load observed after work-planning and at least one post-planning action.
# worker self-verification convergence marker = lane-local self-verification load observed in the worker session; planning basis belongs to the received packet.
# Markers prove required sequence shape only; PASS-1/PASS-2 convergence remains procedural work.
# wp marker = work-planning loaded (new task clears both self-verification convergence markers)

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node -e "
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
const input = parseInput();
const toolInput = input.tool_input || {};
const skill = String(toolInput.skill || toolInput.name || input.skill || input.name || '');
const sid = String(input.session_id || 'unknown');
process.stdout.write(skill + '\n' + sid);
" 2>/dev/null || printf '\nunknown')"
mapfile -t FIELDS <<<"$PARSED"
SKILL_NAME="${FIELDS[0]:-}"
RAW_SESSION_ID="${FIELDS[1]:-unknown}"
SESSION_ID="$(recover_session_id "$RAW_SESSION_ID")"
WORKER_NAME=""

skill_marker_name() {
  local raw="${1-}"
  [[ -n "$raw" ]] || return 1
  raw="$(printf '%s' "$raw" | tr '[:upper:]' '[:lower:]')"
  raw="$(printf '%s' "$raw" | sed -E 's#\\#/#g; s#^.*/skills/([^/]+)/skill\.md$#\1#; s#^.*/skills/([^/]+)/?$#\1#; s#^skill:##; s#^@##; s#[^a-z0-9._-]+#-#g; s#^-+##; s#-+$##')"
  [[ -n "$raw" ]] || return 1
  printf '%s' "$raw"
}

WP_MARKER="$LOG_DIR/.wp-loaded-${SESSION_ID}"
RESULT_VERIFICATION_MARKER="$LOG_DIR/.sv-result-loaded-${SESSION_ID}"
POST_WP_ACTION_MARKER="$LOG_DIR/.post-wp-action-${SESSION_ID}"
TASK_EXECUTION_MARKER="$LOG_DIR/.task-execution-loaded-${SESSION_ID}"
# Session-scoped planning-plus-self-verification convergence marker survives per-turn resets.
# Produced work-product convergence remains procedural.
RESULT_VERIFICATION_CONVERGED_MARKER="$LOG_DIR/.sv-converged-${SESSION_ID}"
# Session-scoped session-boot marker; consumed by dispatch gates when active
# runtime requires monitoring before fresh consequential dispatch.
SB_LOADED_MARKER="$LOG_DIR/.sb-loaded-${SESSION_ID}"

if runtime_sender_session_is_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
fi

# Display-suppression flag: when a targeted skill is loaded, this hook emits a
# PostToolUse JSON response asking the harness to hide the SKILL.md body from
# the user-visible transcript. The model still receives the tool result; only
# the screen rendering is suppressed. Scope is narrow on purpose.
SUPPRESS_DISPLAY=0
SKILL_MARKER_NAME="$(skill_marker_name "$SKILL_NAME" 2>/dev/null || true)"

if [[ -n "$SKILL_MARKER_NAME" ]]; then
  date -u '+%Y-%m-%dT%H:%M:%SZ' > "$LOG_DIR/.skill-loaded-${SESSION_ID}-${SKILL_MARKER_NAME}"
  SUPPRESS_DISPLAY=1
fi

case "$SKILL_NAME" in
	  *session-boot*)
	    if ! runtime_sender_session_is_worker "$SESSION_ID"; then
	      mark_procedure_startup_ready "$SESSION_ID"
      # Idempotent active-runtime monitoring marker.
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$SB_LOADED_MARKER"
      # Re-anchor the boot session marker to the confirmed lead session.
      # An agent's session-start may have overwritten SESSION_BOOT_MARKER_FILE
      # between the lead's session-start and the session-boot skill load,
      # causing recover_session_id to resolve the wrong identity in subsequent
      # hook invocations. Writing the raw event session here restores the
      # correct lead session identity in the marker file.
	      if [[ -n "$RAW_SESSION_ID" && "$RAW_SESSION_ID" != "unknown" ]]; then
	        printf '%s' "$RAW_SESSION_ID" > "$SESSION_BOOT_MARKER_FILE"
	      fi
	    fi
	    SUPPRESS_DISPLAY=1
	    ;;
  *self-growth-sequence*)
    # Entry was observed. Do not treat this as proof that hardening is complete.
    self_growth_clear_state "$SESSION_ID"
    ;;
  *session-closeout*)
    if ! runtime_sender_session_is_worker "$SESSION_ID"; then
      clear_lead_planning_required "$SESSION_ID"
      set_closeout_intent "session-closeout-skill-loaded" "session-closeout-skill" "teardown_readiness" "$SESSION_ID"
    fi
    SUPPRESS_DISPLAY=1
    ;;
  *self-verification*)
    if [[ -n "$WORKER_NAME" ]]; then
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$RESULT_VERIFICATION_MARKER"
    elif [[ -f "$WP_MARKER" && -f "$POST_WP_ACTION_MARKER" ]]; then
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$RESULT_VERIFICATION_MARKER"
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$RESULT_VERIFICATION_CONVERGED_MARKER"
      clear_lead_planning_required "$SESSION_ID"
    fi
    SUPPRESS_DISPLAY=1
    ;;
  *task-execution*)
    date -u '+%Y-%m-%dT%H:%M:%SZ' > "$TASK_EXECUTION_MARKER"
    SUPPRESS_DISPLAY=1
    ;;
  *work-planning*)
    date -u '+%Y-%m-%dT%H:%M:%SZ' > "$WP_MARKER"
    clear_lead_planning_required "$SESSION_ID"
    # New task started; clear self-verification convergence markers to require fresh stage-end verification.
    rm -f "$RESULT_VERIFICATION_MARKER"
    rm -f "$RESULT_VERIFICATION_CONVERGED_MARKER"
    rm -f "$POST_WP_ACTION_MARKER"
    rm -f "$TASK_EXECUTION_MARKER"
    if [[ -z "$WORKER_NAME" ]]; then
      if [[ "$(get_procedure_state_field "startupState" "")" == "ready" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
        printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
      fi
    fi
    SUPPRESS_DISPLAY=1
    ;;
esac

if [[ "$SUPPRESS_DISPLAY" == "1" ]]; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PostToolUse"},"suppressOutput":true}'
fi

exit 0
