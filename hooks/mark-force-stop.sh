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
  _pane_id="$(node -e "
    try {
      const c = JSON.parse(require('fs').readFileSync('${_cfg}', 'utf8'));
      const m = (c.members || []).find(m => m.name === '${WORKER_NAME}');
      if (m && m.tmuxPaneId) process.stdout.write(m.tmuxPaneId);
    } catch(e) {}
  " 2>/dev/null || true)"
  if [[ -n "$_pane_id" ]]; then
    tmux_cmd kill-pane -t "$_pane_id" 2>/dev/null || true
    break
  fi
done

# 2. Remove from SESSION_AGENT_MAP
if [[ -f "$SESSION_AGENT_MAP" ]]; then
  _tmp="$(awk -v name="$WORKER_NAME" '{
    w = $2; gsub(/^[[:space:]]+|[[:space:]]+$/, "", w)
    if (w != name) print
  }' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  if [[ -n "$_tmp" ]]; then
    printf '%s\n' "$_tmp" > "$SESSION_AGENT_MAP"
  else
    : > "$SESSION_AGENT_MAP"
  fi
fi

# 3. Remove from STANDBY_FILE
if [[ -f "$STANDBY_FILE" ]]; then
  _tmp="$(grep -v "^${WORKER_NAME}$" "$STANDBY_FILE" 2>/dev/null || true)"
  if [[ -n "$_tmp" ]]; then printf '%s\n' "$_tmp" > "$STANDBY_FILE"; else : > "$STANDBY_FILE"; fi
fi

# 5. Remove from team config.json
remove_member_from_config "$WORKER_NAME" 2>/dev/null || true

# 5a. Remove worker inbox file to trigger Claude Code inotify re-sync
for _team_dir in "$HOME/.claude/teams"/*/; do
  [[ -d "$_team_dir" ]] || continue
  _inbox="$_team_dir/inboxes/${WORKER_NAME}.json"
  if [[ -f "$_inbox" ]]; then
    rm -f "$_inbox"
  fi
done

# 6. Add to KILL_LIST for audit trail
mkdir -p "$(dirname "$KILL_LIST")"
printf '%s|%s|FORCE-STOPPED\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$WORKER_NAME" >> "$KILL_LIST"

echo "FORCE-STOPPED: $WORKER_NAME"
