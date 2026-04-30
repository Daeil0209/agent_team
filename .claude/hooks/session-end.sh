#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

# --- Shared input parsing ---
INPUT="$(cat)"
SESSION_END_INPUT="$INPUT"
SESSION_END_TIMESTAMP_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
SESSION_ID="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(String(input.session_id || ""));
} catch {
  process.stdout.write("");
}
NODE
)"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

if ! session_end_owns_runtime_state "$SESSION_ID"; then
  cleanup_worker_session_records "$SESSION_ID"
  exit 0
fi

# --- Session End Capture ---
REPO_ROOT="$(resolve_project_root)"
STATE_DIR="$(dirname "$PROJECT_CONTINUITY_FILE")"
STATE_FILE="$PROJECT_CONTINUITY_FILE"
GLOBAL_STATE_FILE="$GLOBAL_CONTINUITY_FILE"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M')"

ensure_procedure_state_surfaces
mkdir -p "$STATE_DIR"
mkdir -p "$(dirname "$SESSION_END_LOG")"

printf '%s %s\n' "$SESSION_END_TIMESTAMP_UTC" "$SESSION_END_INPUT" >> "$SESSION_END_LOG"

render_residual_state() {
  local warnings_text="$1"
  if [ -n "$warnings_text" ]; then
    while IFS= read -r line; do
      [ -n "$line" ] || continue
      printf -- '- %s\n' "$line"
    done <<< "$(printf '%b' "$warnings_text")"
  else
    printf -- '- No automatically detected residual closeout warnings.\n'
  fi
}

render_minimal_auto_capture() {
  local timestamp="$1"
  local warnings_text="$2"

  cat <<EOF
# Session State
Last updated: $timestamp (auto-captured on session end)
Session summary: [Auto-captured — previous session ended without explicit handoff]
Continuity classification: generated startup anchor only; not authoritative runtime, task, cleanup, or acceptance state.

## Active Work
- (not captured in auto-capture mode)

## Key Decisions
- (not captured — session ended without explicit handoff)

## Pending Items
- [ ] Resume from explicit user direction or a fresh verified task request
- [ ] Reconstruct repository context only if the next task actually requires it

## Closeout Residual State
$(render_residual_state "$warnings_text")

## Next Session Recommendation
- Start from the workspace-local continuity file first
- Treat this file as a startup anchor, not as a repository summary
- Do not reconstruct branch, commit, or dirty-state context unless the next task requires repository analysis
EOF
}

rewrite_residual_state_section() {
  local target_file="$1"
  local warnings_text="$2"
  local tmp_file="${target_file}.tmp"

  awk '
    BEGIN {skip=0}
    /^## Closeout Residual State$/ {skip=1; next}
    /^## / {
      if (skip) {
        skip=0
      }
    }
    !skip {print}
  ' "$target_file" > "$tmp_file"
  mv "$tmp_file" "$target_file"

  {
    printf '\n## Closeout Residual State\n'
    render_residual_state "$warnings_text"
  } >> "$target_file"
}

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

if [ -f "$STATE_FILE" ]; then
  state_age=$(( $(date +%s) - $(stat -c %Y "$STATE_FILE" 2>/dev/null || echo 0) ))
  if [ "$state_age" -gt "$SESSION_STATE_STALE_THRESHOLD" ]; then
    WARNINGS="${WARNINGS}Session residual-state: session-state.md stale (${state_age}s old) at session end\n"
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

CAPTURED_CONTINUITY_STATE="captured-clean"
if [ -n "$WARNINGS" ]; then
  CAPTURED_CONTINUITY_STATE="captured-with-warnings"
fi

if [ -f "$STATE_FILE" ]; then
  file_age=$(( $(date +%s) - $(stat -c %Y "$STATE_FILE" 2>/dev/null || echo 0) ))
  if [ "$file_age" -lt "$SESSION_STATE_FRESH_THRESHOLD" ]; then
    if grep -q '^Session summary: \[Auto-captured' "$STATE_FILE" 2>/dev/null; then
      render_minimal_auto_capture "$TIMESTAMP" "$WARNINGS" > "$STATE_FILE"
    else
      sed -i "s/^Last updated:.*/Last updated: $TIMESTAMP (session ended)/" "$STATE_FILE" 2>/dev/null || true
      rewrite_residual_state_section "$STATE_FILE" "$WARNINGS"
    fi
  else
    render_minimal_auto_capture "$TIMESTAMP" "$WARNINGS" > "$STATE_FILE"
  fi
else
  render_minimal_auto_capture "$TIMESTAMP" "$WARNINGS" > "$STATE_FILE"
fi

mirror_project_continuity_to_global

if [[ -f "$CLOSEOUT_STATE_FILE" ]]; then
  update_closeout_state_fields "$SESSION_ID" continuityState "$CAPTURED_CONTINUITY_STATE" phase "continuity_captured"
fi

refresh_procedure_state_sensors "$SESSION_ID"
update_procedure_state_fields \
  "$SESSION_ID" \
  startupState "closed" \
  continuityWritePath "$STATE_FILE" \
  globalContinuityMirrorPath "$GLOBAL_STATE_FILE" \
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
