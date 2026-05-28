#!/usr/bin/env bash
# TeammateIdle lifecycle sync. SendMessage state belongs to track-worker-transport.sh.
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"
INPUT="$(cat)"

# Detect event type. This hook is wired for TeammateIdle only.
EVENT_TYPE="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
const input = parseInput();
process.stdout.write(Object.prototype.hasOwnProperty.call(input, "tool_name") ? "unsupported" : "teammate-idle");
NODE
)"

latest_worker_transport_class() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" WORKER_TRANSPORT_LEDGER="$WORKER_TRANSPORT_LEDGER" node <<'NODE' 2>/dev/null || true
const fs = require("fs");

const ledgerPath = process.env.WORKER_TRANSPORT_LEDGER || "";
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
    printf 'working-transport-missing'
    return 0
  }

  if worker_dispatch_ack_required "$worker_name"; then
    printf 'dispatch-pending-no-ack'
    return 0
  fi

  parsed="$(latest_worker_transport_class "$worker_name")"
  mapfile -t _turn_end_transport_fields <<<"$parsed"
  last_message_class="${_turn_end_transport_fields[0]:-}"
  last_message_timestamp="${_turn_end_transport_fields[1]:-}"
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
    completion)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$worker_name" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-transport-missing'
        return 0
      fi
      printf 'standby'
      ;;
    hold\|blocker|hold|blocker)
      printf 'working-blocked'
      ;;
    scope-pressure)
      printf 'scope-pressure-resolution'
      ;;
    *)
      printf 'working-transport-missing'
      ;;
  esac
}

_update_worker_idle_notice_locked() {
  local action="${1:?action required}"
  local worker_name="${2:?agent name required}"
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

  teammate-idle)
    # Quality gate mirror.
    PARSED_IDLE="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
const input = parseInput();
const teammate = input.teammate_name || input.teammateName || "unknown";
const idleReason = input.idle_reason || input.idleReason || "unknown";
const completedTask = input.completed_task_id || input.completedTaskId || "none";
const completedStatus = input.completed_status || input.completedStatus || "none";
process.stdout.write(`${teammate}\n${idleReason}\n${completedTask}\n${completedStatus}\n`);
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
      if [[ "$TURN_END_CLASSIFICATION" == "standby" ]]; then
        mark_worker_standby "$TEAMMATE"
        clear_worker_idle_pending "$TEAMMATE"
      else
        clear_worker_idle_pending "$TEAMMATE"
      fi
    fi

    if ! mark_worker_idle_notice_if_changed "$TEAMMATE" "$IDLE_NOTICE_REASON" "$COMPLETED_TASK" "$COMPLETED_STATUS"; then
      exit 0
    fi

    TEAMMATE_VAR="$TEAMMATE" IDLE_REASON_VAR="$IDLE_REASON" COMPLETED_STATUS_VAR="$COMPLETED_STATUS" TURN_END_CLASSIFICATION_VAR="$TURN_END_CLASSIFICATION" node <<'NODE'
const teammate = process.env.TEAMMATE_VAR || "unknown";
const reason = process.env.IDLE_REASON_VAR || "unknown";
const status = process.env.COMPLETED_STATUS_VAR || "none";
const classification = process.env.TURN_END_CLASSIFICATION_VAR || "working-transport-missing";
let ctx;
switch (classification) {
  case "standby":
    ctx = `Agent completed: ${teammate} sent completion transport (${reason}, ${status}). Treat the agent as STANDBY for lifecycle availability only; retained-carrier synthesis or verification is required before relying on quality claims.`;
    break;
  case "working-permission-pending":
    ctx = `Agent still working: ${teammate} has a host-presented tool permission request. Next: resolve the existing host request if already displayed; do not ask the user otherwise, status-probe, or reclassify the agent as not working.`;
    break;
  case "dispatch-pending-no-ack":
    ctx = `Dispatch still pending: ${teammate} has no dispatch-ack yet after current dispatch check. Next: send one same-assignment receipt follow-up; do not wait silently or status-probe the unstarted target as the primary action.`;
    break;
  case "working-blocked":
    ctx = `Agent still working: ${teammate} reported a blocker before this turn-ended signal. Next: resolve the blocker or request the smallest needed partial result.`;
    break;
  case "scope-pressure-resolution":
    ctx = `Agent needs scope resolution: ${teammate} raised scope-pressure. Evidence surface: structured objection. Next: classify packet-correction, route-replan, or parallel-continue and resolve through the smallest lawful owner.`;
    break;
  default:
    ctx = `Agent still working: ${teammate}'s turn ended without completion transport. Next: do not treat this as non-working; request partial results only if it blocks current lead work.`;
}
// Intentional silent stdout: the Claude Code TeammateIdle hookSpecificOutput schema
// is not documented in .claude/reference/environment-official-claude-code-source-cache.md, and the
// prior shape ({hookSpecificOutput:{hookEventName:"TeammateIdle",additionalContext:ctx},
// suppressOutput:true}) was rejected by the harness with "Hook JSON output validation
// failed — (root): Invalid input" on every idle event. Context-injection via stdout is
// abandoned until a verified schema lands; file/state side effects above remain the
// hook's effective output. The `ctx` variable is still constructed so future schema
// verification can re-enable the write only if the verified schema preserves
// silent-by-default reporting and does not ask the user unless a host request
// already exists.
void ctx;
NODE

    exit 0
    ;;

  *)
    exit 0
    ;;

esac
