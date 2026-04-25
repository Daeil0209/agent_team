#!/usr/bin/env bash
# Ghost teammate recovery and cleanup.
# Priority: RESTORE ghosts > KILL truly dead panes > CLEAN stale config.
#
# Ghost = tmux pane alive + running shell (not claude) + config entry exists
# Recovery: restart claude process in the same pane using config data.
# Fallback: if recovery data is missing, kill the pane and clean config.
set -euo pipefail

if ! command -v tmux &>/dev/null || [ -z "${TMUX:-}" ]; then
  exit 0
fi

SESSION="$(tmux display-message -p '#S' 2>/dev/null || echo "")"
[ -z "$SESSION" ] && exit 0

MAIN_PANE="$(tmux list-panes -t "$SESSION" -F '#{pane_index} #{pane_id}' 2>/dev/null | awk '$1 == "0" {print $2}')"

CLAUDE_BIN="$(which claude 2>/dev/null || echo "")"
[ -z "$CLAUDE_BIN" ] && exit 0

# Find the current tmux socket name for send-keys
TMUX_SOCKET=""
if [[ "${TMUX:-}" == *","* ]]; then
  TMUX_SOCKET_PATH="$(printf '%s' "$TMUX" | cut -d',' -f1)"
  TMUX_SOCKET="$(basename "$(dirname "$TMUX_SOCKET_PATH")" 2>/dev/null || echo "")"
  # Socket name is the -L argument, extract from path
  # tmux socket path: /tmp/tmux-{UID}/{socket_name}
  TMUX_SOCKET="$(basename "$TMUX_SOCKET_PATH" 2>/dev/null || echo "")"
fi

# Find team config and extract recovery data
RECOVERY_DATA=""
for CONFIG_FILE in "$HOME/.claude/teams"/*/config.json; do
  [ -f "$CONFIG_FILE" ] || continue
  RECOVERY_DATA="$(CONFIG_FILE="$CONFIG_FILE" node <<'NODE'
try {
  const fs = require("fs");
  const config = JSON.parse(fs.readFileSync(process.env.CONFIG_FILE, "utf8"));
  if (!config.members) process.exit(0);
  const teamName = config.name || "";
  const parentSessionId = config.leadSessionId || "";
  // Output: one line per non-lead member with pane
  // Format: paneId|agentId|name|agentType|model|color|cwd
  for (const m of config.members) {
    if (m.name === "team-lead" || m.agentType === "team-lead") continue;
    if (!m.tmuxPaneId) continue;
    const fields = [
      m.tmuxPaneId,
      m.agentId || "",
      m.name || "",
      m.agentType || "",
      m.model || "sonnet",
      m.color || "white",
      m.cwd || process.cwd(),
      teamName,
      parentSessionId
    ];
    console.log(fields.join("|"));
  }
} catch {}
NODE
  )"
  break  # Only process first team config
done

# Process each pane
tmux list-panes -t "$SESSION" -F '#{pane_id} #{pane_pid} #{pane_dead} #{pane_current_command}' 2>/dev/null | while read -r PANE_ID PANE_PID PANE_DEAD PANE_CMD; do
  [ "$PANE_ID" = "$MAIN_PANE" ] && continue

  IS_DEAD="false"
  IS_GHOST="false"

  # Check if truly dead
  if [ "$PANE_DEAD" = "1" ] || ! kill -0 "$PANE_PID" 2>/dev/null; then
    IS_DEAD="true"
  fi

  # Check if ghost (shell running, no claude child)
  if [ "$IS_DEAD" = "false" ]; then
    case "$PANE_CMD" in
      bash|sh|zsh|fish|dash|tcsh|csh)
        # Confirm no claude child process
        if ! pgrep -P "$PANE_PID" --list-full 2>/dev/null | grep -q "claude"; then
          IS_GHOST="true"
        fi
        ;;
    esac
  fi

  if [ "$IS_GHOST" = "true" ] && [ -n "$RECOVERY_DATA" ]; then
    # Try to restore ghost
    MEMBER_LINE="$(echo "$RECOVERY_DATA" | grep "^${PANE_ID}|" | head -1)"
    if [ -n "$MEMBER_LINE" ]; then
      IFS='|' read -r _pane AGENT_ID NAME AGENT_TYPE MODEL COLOR CWD TEAM_NAME PARENT_SID <<< "$MEMBER_LINE"
      
      if [ -n "$NAME" ] && [ -n "$TEAM_NAME" ] && [ -n "$PARENT_SID" ]; then
        # Build restore command
        RESTORE_CMD="cd ${CWD} && exec ${CLAUDE_BIN}"
        RESTORE_CMD="${RESTORE_CMD} --agent-id ${AGENT_ID}"
        RESTORE_CMD="${RESTORE_CMD} --agent-name ${NAME}"
        RESTORE_CMD="${RESTORE_CMD} --team-name ${TEAM_NAME}"
        RESTORE_CMD="${RESTORE_CMD} --agent-color ${COLOR}"
        RESTORE_CMD="${RESTORE_CMD} --parent-session-id ${PARENT_SID}"
        RESTORE_CMD="${RESTORE_CMD} --agent-type ${AGENT_TYPE}"
        RESTORE_CMD="${RESTORE_CMD} --dangerously-skip-permissions"
        RESTORE_CMD="${RESTORE_CMD} --model ${MODEL}"

        # Send command to ghost pane
        tmux send-keys -t "$PANE_ID" C-c 2>/dev/null || true
        sleep 0.1
        tmux send-keys -t "$PANE_ID" "$RESTORE_CMD" Enter 2>/dev/null || true
        continue  # Skip kill — restored
      fi
    fi
  fi

  # Fallback: kill dead or unrestorable ghost panes
  if [ "$IS_DEAD" = "true" ] || [ "$IS_GHOST" = "true" ]; then
    tmux kill-pane -t "$PANE_ID" 2>/dev/null || true
  fi
done

# Clean stale members from config (only for truly dead panes, not restored ghosts)
for CONFIG_FILE in "$HOME/.claude/teams"/*/config.json; do
  [ -f "$CONFIG_FILE" ] || continue
  SURVIVING_PANES="$(tmux list-panes -t "$SESSION" -F '#{pane_id}' 2>/dev/null || true)"
  SURVIVING_PANES="$SURVIVING_PANES" CONFIG_FILE="$CONFIG_FILE" node <<'NODE'
try {
  const fs = require("fs");
  const configPath = process.env.CONFIG_FILE;
  const survivingPanes = new Set(
    (process.env.SURVIVING_PANES || "").split("\n").map(s => s.trim()).filter(Boolean)
  );
  const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
  if (!Array.isArray(config.members)) process.exit(0);
  const before = config.members.length;
  config.members = config.members.filter(m => {
    if (m.agentType === "team-lead" || m.name === "team-lead") return true;
    if (!m.tmuxPaneId) return true;
    if (survivingPanes.has(m.tmuxPaneId)) return true;
    return false;
  });
  if (config.members.length < before) {
    fs.writeFileSync(configPath, JSON.stringify(config, null, 2) + "\n");
  }
} catch {}
NODE
done

exit 0
