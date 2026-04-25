#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

# EMERGENCY FALLBACK ONLY.
# Normal shutdown: team-lead sends SendMessage(shutdown_request) first.
# Use this script only when the worker is unresponsive to shutdown_request.
# Direct use skips Claude Code's internal agent registry cleanup,
# leaving ghost entries in the UI.

WORKER_NAME="${1:-}"
if [[ -z "$WORKER_NAME" ]]; then
  echo "Usage: mark-force-stop.sh <worker-name>" >&2
  exit 1
fi

# 1. Try to kill tmux pane
for _cfg in "$HOME/.claude/teams"/*/config.json; do
  [[ -f "$_cfg" ]] || continue
  _pane_id="$(CONFIG_FILE="$_cfg" WORKER_NAME="$WORKER_NAME" node -e "
    try {
      const c = JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE, 'utf8'));
      const m = (c.members || []).find(m => m.name === process.env.WORKER_NAME);
      if (m && m.tmuxPaneId) process.stdout.write(m.tmuxPaneId);
    } catch(e) {}
  " 2>/dev/null || true)"
  if [[ -n "$_pane_id" ]]; then
    tmux_cmd kill-pane -t "$_pane_id" 2>/dev/null || true
    break
  fi
done

# 2. Remove worker from all registries
remove_worker_everywhere "$WORKER_NAME" 2>/dev/null || true

# 3. Add to KILL_LIST for audit trail
mkdir -p "$(dirname "$KILL_LIST")"
printf '%s|%s|FORCE-STOP\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$WORKER_NAME" >> "$KILL_LIST"

echo "FORCE-STOP: $WORKER_NAME"
