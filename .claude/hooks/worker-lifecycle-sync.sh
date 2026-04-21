#!/usr/bin/env bash
# Consolidated worker lifecycle sync -- merges sync-worker-lifecycle-state.sh,
# cleanup-terminated-panes.sh, and teammate-quality-gate.sh.
# EVENT TYPES (both routed here via settings.json hooks):
#   PostToolUse(SendMessage): worker state sync + planning marker management + pane cleanup
#   TeammateIdle:            quality gate mirror + turn-ended lifecycle decisions + pane cleanup
# BRANCHING: EVENT_TYPE detected at runtime (tool_name field presence, lines 13-21).
#   post-tool-use path: handles assignment/reuse/reroute markers, handoff state, standby/shutdown lifecycle
#   teammate-idle path: records turn-ended lifecycle backlog, mirrors quality gate decisions, triggers pane cleanup
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"
INPUT="$(cat)"

# Detect event type: PostToolUse has tool_name field; TeammateIdle does not.
EVENT_TYPE="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(Object.prototype.hasOwnProperty.call(input, "tool_name") ? "post-tool-use" : "teammate-idle");
} catch {
  process.stdout.write("unknown");
}
NODE
)"

# ---------------------------------------------------------------------------
# Helper: schedule deferred self-pane shutdown (used after shutdown_response)
# ---------------------------------------------------------------------------
schedule_current_pane_shutdown() {
  local tmux_ref="${TMUX:-}"
  local pane_id="${TMUX_PANE:-}"
  local socket_path=""

  [[ -n "$tmux_ref" && -n "$pane_id" ]] || return 0
  command -v tmux >/dev/null 2>&1 || return 0

  socket_path="$(printf '%s' "$tmux_ref" | cut -d',' -f1)"
  [[ -n "$socket_path" ]] || return 0

  (
    sleep 1
    tmux -S "$socket_path" kill-pane -t "$pane_id" >/dev/null 2>&1 || true
  ) >/dev/null 2>&1 &
}

latest_worker_report_class() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" node <<'NODE' 2>/dev/null || true
const fs = require("fs");

const ledgerPath = process.env.WORKER_REPORT_LEDGER || "";
const workerName = String(process.env.WORKER_NAME || "").trim().toLowerCase();
if (!ledgerPath || !workerName || !fs.existsSync(ledgerPath)) process.exit(0);

let latest = null;
for (const line of fs.readFileSync(ledgerPath, "utf8").split(/\r?\n/)) {
  if (!line) continue;
  let parsed;
  try {
    parsed = JSON.parse(line);
  } catch {
    continue;
  }
  if (!parsed || typeof parsed !== "object") continue;
  const senderName = String(parsed.senderName || "").trim().toLowerCase();
  if (senderName !== workerName) continue;
  const timestamp = String(parsed.timestamp || "");
  if (!latest || timestamp >= String(latest.timestamp || "")) latest = parsed;
}

if (latest) {
  process.stdout.write(`${String(latest.messageClass || "").toLowerCase()}\n${String(latest.timestamp || "")}\n`);
}
NODE
}

latest_worker_permission_request_timestamp() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" HOME_DIR="$HOME" node <<'NODE' 2>/dev/null || true
const fs = require("fs");
const path = require("path");

const normalize = (value) => String(value || "").trim().toLowerCase();
const workerName = normalize(process.env.WORKER_NAME);
const teamsRoot = path.join(process.env.HOME_DIR || "", ".claude", "teams");
if (!workerName || !fs.existsSync(teamsRoot)) process.exit(0);

let latest = "";
for (const entry of fs.readdirSync(teamsRoot, { withFileTypes: true })) {
  if (!entry.isDirectory()) continue;
  const inboxPath = path.join(teamsRoot, entry.name, "inboxes", "team-lead.json");
  if (!fs.existsSync(inboxPath)) continue;

  let rows;
  try {
    rows = JSON.parse(fs.readFileSync(inboxPath, "utf8"));
  } catch {
    continue;
  }
  if (!Array.isArray(rows)) continue;

  for (const row of rows) {
    if (!row || typeof row !== "object") continue;
    if (normalize(row.from) !== workerName) continue;

    let payload;
    try {
      payload = JSON.parse(String(row.text || ""));
    } catch {
      continue;
    }
    if (!payload || typeof payload !== "object") continue;
    if (payload.type !== "permission_request") continue;

    const payloadAgent = normalize(payload.agent_id || payload.agentId || payload.from);
    if (payloadAgent && payloadAgent !== workerName) continue;

    const timestamp = String(row.timestamp || payload.timestamp || "");
    if (timestamp && (!latest || timestamp >= latest)) latest = timestamp;
  }
}

if (latest) process.stdout.write(latest);
NODE
}

worker_turn_end_classification() {
  local worker_name="${1-}"
  local last_message_class=""
  local last_message_timestamp=""
  local permission_request_timestamp=""
  local parsed=""
  local dispatch_worker=""
  local dispatch_at=""

  [[ -n "$worker_name" ]] || {
    printf 'working-report-missing'
    return 0
  }

  if worker_dispatch_ack_required "$worker_name"; then
    printf 'dispatch-pending-no-ack'
    return 0
  fi

  parsed="$(latest_worker_report_class "$worker_name")"
  mapfile -t _turn_end_report_fields <<<"$parsed"
  last_message_class="${_turn_end_report_fields[0]:-}"
  last_message_timestamp="${_turn_end_report_fields[1]:-}"
  dispatch_worker="$(get_procedure_state_field "lastDispatchWorker" "")"
  dispatch_at="$(get_procedure_state_field "lastDispatchAt" "")"
  permission_request_timestamp="$(latest_worker_permission_request_timestamp "$worker_name")"

  if [[ -n "$permission_request_timestamp" ]] \
    && { [[ -z "$dispatch_worker" || "$dispatch_worker" == "$worker_name" ]]; } \
    && { [[ -z "$dispatch_at" || "$permission_request_timestamp" == "$dispatch_at" || "$permission_request_timestamp" > "$dispatch_at" ]]; } \
    && { [[ -z "$last_message_timestamp" || "$permission_request_timestamp" == "$last_message_timestamp" || "$permission_request_timestamp" > "$last_message_timestamp" ]]; }; then
    printf 'working-permission-pending'
    return 0
  fi

  case "$last_message_class" in
    handoff|completion|hold)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$worker_name" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-report-missing'
        return 0
      fi
      printf 'not-working-awaiting-lifecycle'
      ;;
    blocker)
      printf 'working-blocked'
      ;;
    *)
      printf 'working-report-missing'
      ;;
  esac
}

# ---------------------------------------------------------------------------
# Helper: clean stale pane entries from team config (lock-safe)
# ---------------------------------------------------------------------------
_cleanup_terminated_panes_config_impl() {
  local config_file="${1:?config file required}"
  local surviving_panes="${2-}"
  CONFIG_FILE="$config_file" SURVIVING_PANES="$surviving_panes" node <<'NODE'
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
}

# ---------------------------------------------------------------------------
# Helper: run pane cleanup (ghost recovery + dead pane cleanup)
# ---------------------------------------------------------------------------
run_pane_cleanup() {
  if ! command -v tmux &>/dev/null || [ -z "${TMUX:-}" ]; then
    return 0
  fi

  SESSION="$(tmux_cmd display-message -p '#S' 2>/dev/null || echo "")"
  [ -z "$SESSION" ] && return 0

  MAIN_PANE="$(tmux_cmd list-panes -t "$SESSION" -F '#{pane_index} #{pane_id}' 2>/dev/null | awk '$1 == "0" {print $2}')"

  CLAUDE_BIN="$(which claude 2>/dev/null || echo "")"
  [ -z "$CLAUDE_BIN" ] && return 0

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

  # Process each pane: restore ghosts, kill dead
  tmux_cmd list-panes -t "$SESSION" -F '#{pane_id} #{pane_pid} #{pane_dead} #{pane_current_command}' 2>/dev/null | while read -r PANE_ID PANE_PID PANE_DEAD PANE_CMD; do
    [ "$PANE_ID" = "$MAIN_PANE" ] && continue

    IS_DEAD="false"
    IS_GHOST="false"

    if [ "$PANE_DEAD" = "1" ] || ! kill -0 "$PANE_PID" 2>/dev/null; then
      IS_DEAD="true"
    fi

    if [ "$IS_DEAD" = "false" ]; then
      case "$PANE_CMD" in
        bash|sh|zsh|fish|dash|tcsh|csh)
          if ! pgrep -P "$PANE_PID" --list-full 2>/dev/null | grep -q "claude"; then
            IS_GHOST="true"
          fi
          ;;
      esac
    fi

    if [ "$IS_GHOST" = "true" ] && [ -n "$RECOVERY_DATA" ]; then
      MEMBER_LINE="$(echo "$RECOVERY_DATA" | grep "^${PANE_ID}|" | head -1)"
      if [ -n "$MEMBER_LINE" ]; then
        IFS='|' read -r _pane AGENT_ID NAME AGENT_TYPE MODEL COLOR CWD TEAM_NAME PARENT_SID <<< "$MEMBER_LINE"

        if [ -n "$NAME" ] && [ -n "$TEAM_NAME" ] && [ -n "$PARENT_SID" ]; then
          RESTORE_CMD="cd \"${CWD}\" && exec \"${CLAUDE_BIN}\""
          RESTORE_CMD="${RESTORE_CMD} --agent-id \"${AGENT_ID}\""
          RESTORE_CMD="${RESTORE_CMD} --agent-name \"${NAME}\""
          RESTORE_CMD="${RESTORE_CMD} --team-name \"${TEAM_NAME}\""
          RESTORE_CMD="${RESTORE_CMD} --agent-color \"${COLOR}\""
          RESTORE_CMD="${RESTORE_CMD} --parent-session-id \"${PARENT_SID}\""
          RESTORE_CMD="${RESTORE_CMD} --agent-type \"${AGENT_TYPE}\""
          RESTORE_CMD="${RESTORE_CMD} --model \"${MODEL}\""

          tmux_cmd send-keys -t "$PANE_ID" C-c 2>/dev/null || true
          sleep 0.1
          tmux_cmd send-keys -t "$PANE_ID" "$RESTORE_CMD" Enter 2>/dev/null || true
          continue  # Skip kill -- restored
        fi
      fi
    fi

    # Fallback: kill dead or unrestorable ghost panes
    if [ "$IS_DEAD" = "true" ] || [ "$IS_GHOST" = "true" ]; then
      # Sync registry before killing pane so state files don't retain stale entries
      if [ -n "$RECOVERY_DATA" ]; then
        _CLEANUP_LINE="$(printf '%s\n' "$RECOVERY_DATA" | grep "^${PANE_ID}|" | head -1)"
        if [ -n "$_CLEANUP_LINE" ]; then
          _CLEANUP_NAME="$(printf '%s\n' "$_CLEANUP_LINE" | cut -d'|' -f3)"
          if [ -n "$_CLEANUP_NAME" ]; then
            remove_worker_everywhere "$_CLEANUP_NAME"
          fi
        fi
      fi
      tmux_cmd kill-pane -t "$PANE_ID" 2>/dev/null || true
    fi
  done

  # Clean stale members from config (only for truly dead panes, not restored ghosts)
  for CONFIG_FILE in "$HOME/.claude/teams"/*/config.json; do
    [ -f "$CONFIG_FILE" ] || continue
    SURVIVING_PANES="$(tmux_cmd list-panes -t "$SESSION" -F '#{pane_id}' 2>/dev/null || true)"
    with_lock_file "$(team_config_hook_lock_file "$CONFIG_FILE")" _cleanup_terminated_panes_config_impl "$CONFIG_FILE" "$SURVIVING_PANES"
  done
}

_update_worker_idle_notice_locked() {
  local action="${1:?action required}"
  local worker_name="${2:?worker name required}"
  local idle_reason="${3-}"
  local completed_task="${4-}"
  local completed_status="${5-}"
  local target_file="$WORKER_IDLE_NOTICE_FILE"
  local temp_file=""
  local new_state=""

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"

  case "$action" in
    clear)
      awk -F'|' -v worker="$worker_name" '
        $1 != worker { print $0 }
      ' "$target_file" > "$temp_file"
      atomic_replace_file "$temp_file" "$target_file"
      ;;
    mark)
      new_state="${idle_reason}|${completed_status}|${completed_task}"
      if awk -F'|' -v worker="$worker_name" -v state="$new_state" '
        $1 == worker {
          current = $2 "|" $3 "|" $4
          if (current == state) found = 1
        }
        END { exit(found ? 0 : 1) }
      ' "$target_file"; then
        rm -f "$temp_file"
        return 10
      fi
      awk -F'|' -v worker="$worker_name" '
        $1 != worker { print $0 }
      ' "$target_file" > "$temp_file"
      printf '%s|%s|%s|%s\n' "$worker_name" "$idle_reason" "$completed_status" "$completed_task" >> "$temp_file"
      atomic_replace_file "$temp_file" "$target_file"
      ;;
    *)
      rm -f "$temp_file"
      return 1
      ;;
  esac
}

clear_worker_idle_notice() {
  local worker_name="${1-}"
  [[ -n "$worker_name" ]] || return 0
  with_lock_file "$WORKER_IDLE_NOTICE_LOCK" _update_worker_idle_notice_locked "clear" "$worker_name"
}

mark_worker_idle_notice_if_changed() {
  local worker_name="${1-}"
  local idle_reason="${2-}"
  local completed_task="${3-}"
  local completed_status="${4-}"
  local rc=0

  [[ -n "$worker_name" ]] || return 1
  if with_lock_file "$WORKER_IDLE_NOTICE_LOCK" _update_worker_idle_notice_locked "mark" "$worker_name" "$idle_reason" "$completed_task" "$completed_status"; then
    return 0
  else
    rc=$?
  fi

  [[ "$rc" -eq 10 ]] && return 1
  return "$rc"
}

# ---------------------------------------------------------------------------
# Route by event type
# ---------------------------------------------------------------------------
case "$EVENT_TYPE" in

  post-tool-use)
    # Worker lifecycle sync -- same logic as sync-worker-lifecycle-state.sh
    PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) return preferred;
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const joinUniqueText = (chunks) => {
  const seen = new Set();
  return chunks
    .map((chunk) => String(chunk || "").trim())
    .filter(Boolean)
    .filter((chunk) => {
      if (seen.has(chunk)) return false;
      seen.add(chunk);
      return true;
    })
    .join("\n");
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const nestedMessage = toolInput.message || {};
  const description = joinUniqueText(
    flattenText(toolInput.summary).concat(flattenText(toolInput.message || toolInput.content))
  );
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName
  );
  const fields = [
    toolName,
    targetName,
    String(toolInput.type || ""),
    String(nestedMessage.type || ""),
    description,
    String(input.session_id || ""),
    String(input.agent_id || ""),
    String(input.agent_name || input.agentName || ""),
    String(input.agent_type || ""),
    String(input.teammate_name || input.teammateName || toolInput.teammate_name || toolInput.teammateName || ""),
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "success")
      ? String(toolResponse.success)
      : "",
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "is_error")
      ? String(toolResponse.is_error)
      : "",
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "error")
      ? String(toolResponse.error || "")
      : "",
  ];
  process.stdout.write(fields.map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n\n\n\n\n");
}
NODE
    )"
    mapfile -t FIELDS <<<"$PARSED"

    decode_field() {
      local encoded="${1-}"
      if [[ -z "$encoded" ]]; then
        printf ''
        return 0
      fi
      printf '%s' "$encoded" | base64 -d
    }

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
TARGET_NAME="$(decode_field "${FIELDS[1]:-}")"
TOP_TYPE="$(printf '%s' "$(decode_field "${FIELDS[2]:-}")" | tr '[:upper:]' '[:lower:]')"
MESSAGE_TYPE="$(printf '%s' "$(decode_field "${FIELDS[3]:-}")" | tr '[:upper:]' '[:lower:]')"
DESCRIPTION="$(decode_field "${FIELDS[4]:-}")"
SESSION_ID="$(decode_field "${FIELDS[5]:-}")"
AGENT_ID="$(decode_field "${FIELDS[6]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[7]:-}")"
AGENT_TYPE="$(decode_field "${FIELDS[8]:-}")"
TEAMMATE_NAME="$(decode_field "${FIELDS[9]:-}")"
SUCCESS_VALUE="$(printf '%s' "$(decode_field "${FIELDS[10]:-}")" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "$(decode_field "${FIELDS[11]:-}")" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="$(decode_field "${FIELDS[12]:-}")"

    [[ "$TOOL_NAME" == "SendMessage" ]] || { run_pane_cleanup; exit 0; }
    tool_response_succeeded || { run_pane_cleanup; exit 0; }

    SENDER_NAME="$(resolve_runtime_sender_name "$SESSION_ID" "$AGENT_ID" "$AGENT_NAME" "$AGENT_TYPE" "$TEAMMATE_NAME" 2>/dev/null || true)"

    SENDER_IS_WORKER="false"
    if runtime_sender_session_is_worker "$SESSION_ID"; then
      SENDER_IS_WORKER="true"
    fi

    if [[ "$TOP_TYPE" == "shutdown_response" || "$MESSAGE_TYPE" == "shutdown_response" ]]; then
      if [[ "$SENDER_IS_WORKER" == "true" && -n "$SENDER_NAME" ]]; then
        clear_worker_idle_notice "$SENDER_NAME"
        remove_worker_everywhere "$SENDER_NAME"
        schedule_current_pane_shutdown
      fi
      run_pane_cleanup
      exit 0
    fi

    if [[ "$TOP_TYPE" == "shutdown_request" || "$MESSAGE_TYPE" == "shutdown_request" ]]; then
      if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
        clear_worker_idle_pending "$TARGET_NAME"
        clear_worker_idle_notice "$TARGET_NAME"
      fi
      run_pane_cleanup
      exit 0
    fi

    MESSAGE_CLASS="$(dispatch_field_raw_value "$DESCRIPTION" "message-class" 2>/dev/null || true)"
    MESSAGE_CLASS="$(printf '%s' "$MESSAGE_CLASS" | tr '[:upper:]' '[:lower:]')"
    LIFECYCLE_DECISION="$(dispatch_field_raw_value "$DESCRIPTION" "lifecycle-decision" 2>/dev/null | tr '[:upper:]' '[:lower:]' || true)"

    # Resolve lifecycle decisions with minimal friction. Full structured control
    # packets are preferred, but the operational minimum is the concrete worker
    # target plus LIFECYCLE-DECISION.
    if [[ "$MESSAGE_CLASS" == "control" || -n "$LIFECYCLE_DECISION" ]]; then
      case "$LIFECYCLE_DECISION" in
        standby)           MESSAGE_CLASS="standby" ;;
        reuse)             MESSAGE_CLASS="reuse" ;;
        hold-for-validation) MESSAGE_CLASS="hold-for-validation" ;;
        shutdown)
          if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
            clear_worker_idle_pending "$TARGET_NAME"
            clear_worker_idle_notice "$TARGET_NAME"
            clear_worker_standby "$TARGET_NAME"
          fi
          run_pane_cleanup
          exit 0
          ;;
      esac
    fi

    if [[ "$SENDER_IS_WORKER" == "true" ]]; then
      run_pane_cleanup
      exit 0
    fi

    case "$MESSAGE_CLASS" in
      standby)
        if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
          clear_worker_idle_pending "$TARGET_NAME"
          clear_worker_idle_notice "$TARGET_NAME"
          mark_worker_standby "$TARGET_NAME"
        fi
        ;;
      hold-for-validation)
        if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
          clear_worker_idle_pending "$TARGET_NAME"
          clear_worker_idle_notice "$TARGET_NAME"
          clear_worker_standby "$TARGET_NAME"
        fi
        ;;
	      assignment|reuse|reroute)
	        if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
	          clear_worker_idle_pending "$TARGET_NAME"
	          clear_worker_idle_notice "$TARGET_NAME"
	          clear_worker_standby "$TARGET_NAME"
	          mark_team_dispatch_pending "$SESSION_ID" "$TARGET_NAME" "sendmessage-${MESSAGE_CLASS}"
	          mark_worker_dispatch_ack_required "$TARGET_NAME"
	          # Every new assignment/reuse/reroute starts a fresh task-level planning window.
	          # Reusing a stale WP marker would let a previous task's planning residue mask a
	          # missing plan on the current dispatch.
	          mark_worker_planning_required "$TARGET_NAME"
	        fi
	        ;;
    esac

    run_pane_cleanup
    exit 0
    ;;

  teammate-idle)
    # Quality gate mirror -- same logic as teammate-quality-gate.sh
    PARSED_IDLE="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const teammate = input.teammate_name || input.teammateName || "unknown";
  const idleReason = input.idle_reason || input.idleReason || "unknown";
  const completedTask = input.completed_task_id || input.completedTaskId || "none";
  const completedStatus = input.completed_status || input.completedStatus || "none";
  process.stdout.write(`${teammate}\n${idleReason}\n${completedTask}\n${completedStatus}\n`);
} catch {
  process.stdout.write("unknown\nunknown\nnone\nnone\n");
}
NODE
    )"
    mapfile -t IDLE_FIELDS <<<"$PARSED_IDLE"
    TEAMMATE="${IDLE_FIELDS[0]:-unknown}"
    IDLE_REASON="${IDLE_FIELDS[1]:-unknown}"
    COMPLETED_TASK="${IDLE_FIELDS[2]:-none}"
    COMPLETED_STATUS="${IDLE_FIELDS[3]:-none}"
    TURN_END_CLASSIFICATION="$(worker_turn_end_classification "$TEAMMATE")"
    IDLE_NOTICE_REASON="$TURN_END_CLASSIFICATION"

    TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    printf '%s | TEAMMATE_IDLE | %s | reason:%s | status:%s | task:%s | mode:mirror\n' \
      "$TIMESTAMP" "$TEAMMATE" "$IDLE_NOTICE_REASON" "$COMPLETED_STATUS" "$COMPLETED_TASK" >> "$ACTIVITY_LEDGER"

    if [[ -n "$TEAMMATE" && "$TEAMMATE" != "unknown" ]]; then
      # Only completion-grade turn endings belong in the lifecycle backlog file.
      if ! worker_is_standby "$TEAMMATE" && [[ "$TURN_END_CLASSIFICATION" == "not-working-awaiting-lifecycle" ]]; then
        mark_worker_idle_pending "$TEAMMATE" "$IDLE_NOTICE_REASON" "$COMPLETED_TASK" "$COMPLETED_STATUS"
      else
        clear_worker_idle_pending "$TEAMMATE"
      fi
    fi

    if ! mark_worker_idle_notice_if_changed "$TEAMMATE" "$IDLE_NOTICE_REASON" "$COMPLETED_TASK" "$COMPLETED_STATUS"; then
      run_pane_cleanup
      exit 0
    fi

    TEAMMATE_VAR="$TEAMMATE" IDLE_REASON_VAR="$IDLE_REASON" COMPLETED_STATUS_VAR="$COMPLETED_STATUS" TURN_END_CLASSIFICATION_VAR="$TURN_END_CLASSIFICATION" node <<'NODE'
const teammate = process.env.TEAMMATE_VAR || "unknown";
const reason = process.env.IDLE_REASON_VAR || "unknown";
const status = process.env.COMPLETED_STATUS_VAR || "none";
const classification = process.env.TURN_END_CLASSIFICATION_VAR || "working-report-missing";
let ctx;
switch (classification) {
  case "not-working-awaiting-lifecycle":
    ctx = `Worker not working: ${teammate} has completion-grade output (${reason}, ${status}). Next: decide reuse, standby, shutdown, or hold-for-validation before unrelated dispatch.`;
    break;
  case "working-permission-pending":
    ctx = `Worker still working: ${teammate} is awaiting user permission for a tool request. Next: resolve the permission prompt; do not status-probe or reclassify the worker as not working.`;
    break;
  case "dispatch-pending-no-ack":
    ctx = `Dispatch still pending: ${teammate} has no dispatch-ack yet. Next: apply dispatch reception thresholds; do not status-probe the unstarted target as the primary action.`;
    break;
  case "working-blocked":
    ctx = `Worker still working: ${teammate} reported a blocker before this turn-ended signal. Next: resolve the blocker or request the smallest needed partial result.`;
    break;
  default:
    ctx = `Worker still working: ${teammate}'s turn ended without completion-grade output. Next: do not treat this as non-working; request partial results only if it blocks current lead work.`;
}
process.stdout.write(JSON.stringify({ systemMessage: ctx }));
NODE

    run_pane_cleanup
    exit 0
    ;;

  *)
    run_pane_cleanup
    exit 0
    ;;

esac
