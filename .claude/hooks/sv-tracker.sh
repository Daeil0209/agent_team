#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# PostToolUse hook for Skill tool.
# Tracks two-phase self-verification per session and clears the self-growth
# entry markers when the self-growth-sequence skill is explicitly loaded.
# Loading proves sequence entry only; route/patch closure remains governed by
# the self-growth procedure and downstream verification, not this hook.
# session-boot load marks lead-local boot procedure entry only. Boot-infra
# completion is recorded later when runtime setup succeeds or task planning
# begins; runtime authorization still belongs to TeamCreate and runtime-entry
# enforcement.
# Phase 1 marker (sv-plan) = self-verification load observed after work-planning
# Phase 2 marker (sv-result) = later self-verification load observed before handoff
# Markers prove skill-load entry only; Critical Challenge remains procedural work.
# wp marker = work-planning loaded (new task, clears both sv phase markers)

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node -e "
try {
  const input = JSON.parse(process.env.INPUT_JSON || '{}');
  const skill = String((input.tool_input || {}).skill || '');
  const sid = String(input.session_id || 'unknown');
  process.stdout.write(skill + '\n' + sid);
} catch { process.stdout.write('\nunknown'); }
" 2>/dev/null || printf '\nunknown')"
mapfile -t FIELDS <<<"$PARSED"
SKILL_NAME="${FIELDS[0]:-}"
RAW_SESSION_ID="${FIELDS[1]:-unknown}"
SESSION_ID="$(recover_session_id "$RAW_SESSION_ID")"
WORKER_NAME=""

WP_MARKER="$LOG_DIR/.wp-loaded-${SESSION_ID}"
SV_PLAN_MARKER="$LOG_DIR/.sv-plan-loaded-${SESSION_ID}"
SV_RESULT_MARKER="$LOG_DIR/.sv-result-loaded-${SESSION_ID}"

if runtime_sender_session_is_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
fi

# Display-suppression flag: when a targeted skill is loaded, this hook emits a
# PostToolUse JSON response asking the harness to hide the SKILL.md body from
# the user-visible transcript. The model still receives the tool result; only
# the screen rendering is suppressed. Scope is narrow on purpose.
SUPPRESS_DISPLAY=0

case "$SKILL_NAME" in
  *session-boot*)
    if ! runtime_sender_session_is_worker "$SESSION_ID"; then
      mark_procedure_startup_ready "$SESSION_ID"
      # Re-anchor the boot session marker to the confirmed lead session.
      # A worker's session-start may have overwritten SESSION_BOOT_MARKER_FILE
      # between the lead's session-start and the session-boot skill load,
      # causing recover_session_id to resolve the wrong identity in subsequent
      # hook invocations. Writing the raw event session here restores the
      # correct lead session identity in the marker file.
      if [[ -n "$RAW_SESSION_ID" && "$RAW_SESSION_ID" != "unknown" ]]; then
        printf '%s' "$RAW_SESSION_ID" > "$SESSION_BOOT_MARKER_FILE"
      fi
    fi
    ;;
  *self-growth-sequence*)
    # Entry was observed. Do not treat this as proof that hardening is complete.
    self_growth_clear_state "$SESSION_ID"
    ;;
  *self-verification*)
    if [[ -f "$WP_MARKER" ]] && [[ ! -f "$SV_PLAN_MARKER" ]]; then
      # First SV after WP = Phase 1 load marker.
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$SV_PLAN_MARKER"
      if [[ -z "$WORKER_NAME" ]]; then
        clear_lead_planning_required "$SESSION_ID"
      fi
    elif [[ -f "$WP_MARKER" ]]; then
      # Subsequent SV = Phase 2 load marker.
      date -u '+%Y-%m-%dT%H:%M:%SZ' > "$SV_RESULT_MARKER"
    fi
    SUPPRESS_DISPLAY=1
    ;;
  *work-planning*)
    date -u '+%Y-%m-%dT%H:%M:%SZ' > "$WP_MARKER"
    # New task started — clear both SV phase markers to require fresh verification
    rm -f "$SV_PLAN_MARKER" "$SV_RESULT_MARKER"
    if [[ -n "$WORKER_NAME" ]]; then
      clear_worker_planning_required "$WORKER_NAME"
    else
      if [[ "$(get_procedure_state_field "startupState" "")" == "ready" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
        printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
      fi
    fi
    SUPPRESS_DISPLAY=1
    ;;
esac

if [[ "$SUPPRESS_DISPLAY" == "1" ]]; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PostToolUse","suppressOutput":true}}'
fi

exit 0
