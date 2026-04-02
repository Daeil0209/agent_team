#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# Boot already complete → silent exit (cost: ~5ms)
[[ ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]] || exit 0

# Worker session → not our concern
is_worker_session && exit 0

# SessionStart hook hasn't run yet (no boot marker) → not ready to enforce
[[ -s "$SESSION_BOOT_MARKER_FILE" ]] || exit 0

# Boot not complete → inject enforcement reminder
cat <<'JSON'
{
  "suppressOutput": true,
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "BOOT SEQUENCE NOT YET COMPLETE. In ONE turn, execute in parallel: (1) Read session-state.md, (2) ToolSearch select:TeamCreate, (3) check team existence. Next turn: TeamCreate if needed + respond to the user's message. Do NOT output boot status — just answer the user after boot."
  }
}
JSON
