#!/usr/bin/env bash
# Cleanup tmux panes from terminated teammate agents.
# Kills all panes except pane 0 (main session) where the process has exited.
# Safe to run repeatedly — no-ops when nothing to clean.
set -euo pipefail

# Only run if tmux is available and we're in a tmux session
if ! command -v tmux &>/dev/null || [ -z "${TMUX:-}" ]; then
  exit 0
fi

# Get the current session name
SESSION="$(tmux display-message -p '#S' 2>/dev/null || echo "")"
if [ -z "$SESSION" ]; then
  exit 0
fi

# Get main pane ID (pane index 0) to protect it
MAIN_PANE="$(tmux list-panes -t "$SESSION" -F '#{pane_index} #{pane_id}' 2>/dev/null | awk '$1 == "0" {print $2}')"

# List all panes and kill non-main panes where the process is dead
tmux list-panes -t "$SESSION" -F '#{pane_id} #{pane_pid} #{pane_dead}' 2>/dev/null | while read -r PANE_ID PANE_PID PANE_DEAD; do
  # Never kill the main pane
  if [ "$PANE_ID" = "$MAIN_PANE" ]; then
    continue
  fi
  
  # Kill pane if process is dead OR if the process no longer exists
  if [ "$PANE_DEAD" = "1" ] || ! kill -0 "$PANE_PID" 2>/dev/null; then
    tmux kill-pane -t "$PANE_ID" 2>/dev/null || true
  fi
done

exit 0
