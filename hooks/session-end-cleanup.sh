#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"
SESSION_ID="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(String(input.session_id || ""));
} catch {
  process.stdout.write("");
}
NODE
)"

if ! session_end_owns_runtime_state "$SESSION_ID"; then
  cleanup_worker_session_records "$SESSION_ID"
  exit 0
fi

if ! closeout_intent_is_active "$SESSION_ID"; then
  cleanup_session_files
  cleanup_project_auto_memory
  exit 0
fi

refresh_closeout_state_sensors "$SESSION_ID"

CLEANUP_ELIGIBILITY="$(closeout_cleanup_eligibility "$SESSION_ID")"
CLOSEOUT_DISPOSITION="$(get_closeout_state_field closeoutDisposition "$SESSION_ID" "none")"

if [[ "$CLEANUP_ELIGIBILITY" != "ready" ]]; then
  if [[ -n "$SESSION_ID" && -f "$CLOSEOUT_STATE_FILE" ]]; then
    printf '[%s] closeout cleanup preserved: cleanupEligibility=%s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$CLEANUP_ELIGIBILITY" >> "$VIOLATION_LOG"
  fi
  exit 0
fi

if [[ "$CLOSEOUT_DISPOSITION" == "hold" ]]; then
  update_closeout_state_fields "$SESSION_ID" phase "cleanup_committed"
  clear_closeout_intent "closeout-hold-carry-forward" "$SESSION_ID"
  cleanup_runtime_transients
  cleanup_project_auto_memory
  exit 0
fi

update_closeout_state_fields "$SESSION_ID" phase "cleanup_committed"
clear_closeout_intent "closeout-clean-completed" "$SESSION_ID"
cleanup_runtime_transients
cleanup_governance_residue
cleanup_project_auto_memory
