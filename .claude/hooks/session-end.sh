#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

# --- Shared input parsing ---
INPUT="$(cat)"
SESSION_END_INPUT="$INPUT"
SESSION_END_TIMESTAMP_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
SESSION_ID="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
process.stdout.write(String(parseInput().session_id || ""));
NODE
)"
if [[ -z "$SESSION_ID" || "$SESSION_ID" == "unknown" ]]; then
  cleanup_worker_session_records "$SESSION_ID"
  exit 0
fi
SESSION_ID="$(recover_session_id "$SESSION_ID")"

if ! session_end_owns_runtime_state "$SESSION_ID"; then
  cleanup_worker_session_records "$SESSION_ID"
  exit 0
fi

# --- Session End Capture ---
REPO_ROOT="$(resolve_project_root)"

ensure_procedure_state_surfaces
mkdir -p "$(dirname "$SESSION_END_LOG")"

printf '%s %s\n' "$SESSION_END_TIMESTAMP_UTC" "$SESSION_END_INPUT" >> "$SESSION_END_LOG"

if [ -f "$VIOLATION_LOG" ]; then
  line_count="$(wc -l < "$VIOLATION_LOG" 2>/dev/null || echo 0)"
  if [ "$line_count" -gt 500 ]; then
    tail -500 "$VIOLATION_LOG" > "${VIOLATION_LOG}.tmp"
    mv "${VIOLATION_LOG}.tmp" "$VIOLATION_LOG"
  fi
fi

WARNINGS=""
HOLD_REASON=""
GOVERNANCE_BLOCKERS=""
CURRENT_DISPOSITION=""
UNCOMMITTED="$(git -C "$REPO_ROOT" status --porcelain 2>/dev/null | head -5 || true)"
if [ -n "$UNCOMMITTED" ]; then
  WARNINGS="${WARNINGS}Session residual-state: Uncommitted changes detected at session end\n"
fi

if [ -s "${TEAM_RUNTIME_ACTIVE_FILE:-}" ]; then
  WARNINGS="${WARNINGS}Session residual-state: explicit team runtime still marked active at session end\n"
fi

if [ -s "${HEALTH_CRON_JOB_FILE:-}" ]; then
  HEALTH_JOB_ID="$(tr -d '\n' < "$HEALTH_CRON_JOB_FILE" 2>/dev/null || true)"
  if [ -n "$HEALTH_JOB_ID" ]; then
    WARNINGS="${WARNINGS}Session residual-state: recurring health-check cron still registered at session end (${HEALTH_JOB_ID})\n"
  else
    WARNINGS="${WARNINGS}Session residual-state: recurring health-check cron marker still present at session end\n"
  fi
fi

if [[ -f "$CLOSEOUT_STATE_FILE" ]]; then
  refresh_closeout_state_sensors "$SESSION_ID"
  HOLD_REASON="$(closeout_hold_reason "$SESSION_ID")"
  GOVERNANCE_BLOCKERS="$(closeout_governance_blockers "$SESSION_ID" || true)"
  CURRENT_DISPOSITION="$(get_closeout_state_field closeoutDisposition "$SESSION_ID" "none")"

  if [[ "$CURRENT_DISPOSITION" == "hold" || -n "$HOLD_REASON" || -n "$GOVERNANCE_BLOCKERS" ]]; then
    WARNINGS="${WARNINGS}Session residual-state: closeout completed in truthful hold mode\n"
    if [[ -n "$HOLD_REASON" ]]; then
      WARNINGS="${WARNINGS}Session residual-state: closeout hold reason preserved (${HOLD_REASON})\n"
    fi
    if [[ -n "$GOVERNANCE_BLOCKERS" ]]; then
      WARNINGS="${WARNINGS}Session residual-state: unresolved closeout governance preserved (${GOVERNANCE_BLOCKERS})\n"
    fi
  fi
fi

if [ -n "$WARNINGS" ]; then
  printf "[%s] AUTO-COMPLETION CHECK:\n%b" "$(date '+%Y-%m-%d %H:%M:%S')" "$WARNINGS" >> "$VIOLATION_LOG"
fi

if [[ -f "$CLOSEOUT_STATE_FILE" ]]; then
  update_closeout_state_fields "$SESSION_ID" continuityState "not-required" phase "runtime_truth_recorded"
fi

refresh_procedure_state_sensors "$SESSION_ID"
update_procedure_state_fields \
  "$SESSION_ID" \
  startupState "closed" \
  lastSessionEndTimestamp "$SESSION_END_TIMESTAMP_UTC"

# --- Session End Cleanup ---
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
