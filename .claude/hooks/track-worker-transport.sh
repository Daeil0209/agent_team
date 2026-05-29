#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"

INPUT="$(cat)"

_track_update_worker_idle_notice_locked() {
  local worker_name="${1:?agent name required}"
  local target_file="$WORKER_IDLE_NOTICE_FILE"
  local temp_file=""

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"
  awk -F'|' -v worker="$worker_name" '
    $1 != worker { print $0 }
  ' "$target_file" > "$temp_file"
  atomic_replace_file "$temp_file" "$target_file"
}

clear_worker_idle_notice() {
  local worker_name="${1-}"
  [[ -n "$worker_name" ]] || return 0
  with_lock_file "$WORKER_IDLE_NOTICE_LOCK" _track_update_worker_idle_notice_locked "$worker_name"
}

PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { encode, flattenText, joinUniqueText } = require(process.env.HOOK_JSON_HELPERS);
const TRANSPORT_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes"];

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const taskId = String(input.task_id || input.taskId || toolInput.task_id || toolInput.taskId || "").trim();
  const taskSubject = String(input.task_subject || input.taskSubject || toolInput.task_subject || toolInput.taskSubject || "").trim();
  const messageText = joinUniqueText(
    flattenText(toolInput.summary, TRANSPORT_TEXT_KEYS)
      .concat(flattenText(toolInput.message, TRANSPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.content, TRANSPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.body, TRANSPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.note, TRANSPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.notes, TRANSPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.description, TRANSPORT_TEXT_KEYS))
  );
  const fields = [
    toolName,
    String(input.session_id || ""),
    String(input.agent_id || ""),
    String(input.agent_name || input.agentName || ""),
    String(input.agent_type || ""),
    String(input.teammate_name || input.teammateName || toolInput.teammate_name || toolInput.teammateName || ""),
    String(input.team_name || input.teamName || toolInput.team_name || toolInput.teamName || ""),
    taskId,
    taskSubject,
    messageText,
    Object.prototype.hasOwnProperty.call(toolResponse, "success") ? String(toolResponse.success) : "",
    Object.prototype.hasOwnProperty.call(toolResponse, "is_error") ? String(toolResponse.is_error) : "",
    Object.prototype.hasOwnProperty.call(toolResponse, "error") ? String(toolResponse.error || "") : ""
  ];
  process.stdout.write(fields.map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TOOL_NAME="$(hook_decode_base64_field "${FIELDS[0]:-}")"
SESSION_ID="$(hook_decode_base64_field "${FIELDS[1]:-}")"
AGENT_ID="$(hook_decode_base64_field "${FIELDS[2]:-}")"
AGENT_NAME="$(hook_decode_base64_field "${FIELDS[3]:-}")"
AGENT_TYPE="$(hook_decode_base64_field "${FIELDS[4]:-}")"
TEAMMATE_NAME="$(hook_decode_base64_field "${FIELDS[5]:-}")"
TEAM_NAME="$(hook_decode_base64_field "${FIELDS[6]:-}")"
TASK_ID="$(hook_decode_base64_field "${FIELDS[7]:-}")"
TASK_SUBJECT="$(hook_decode_base64_field "${FIELDS[8]:-}")"
DESCRIPTION="$(hook_decode_base64_field "${FIELDS[9]:-}")"
SUCCESS_VALUE="$(printf '%s' "$(hook_decode_base64_field "${FIELDS[10]:-}")" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "$(hook_decode_base64_field "${FIELDS[11]:-}")" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="$(hook_decode_base64_field "${FIELDS[12]:-}")"

tool_response_succeeded || exit 0

CONTROL_PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { encode, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const nested = toolInput.message && typeof toolInput.message === "object" ? toolInput.message : {};
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  );
  const topType = String(toolInput.type || "").trim().toLowerCase();
  const nestedType = String(nested.type || "").trim().toLowerCase();
  process.stdout.write([targetName, topType, nestedType].map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"
mapfile -t CONTROL_FIELDS <<<"$CONTROL_PARSED"
TARGET_NAME="$(normalize_lane_id "$(hook_decode_base64_field "${CONTROL_FIELDS[0]:-}")")"
TOP_TYPE="$(hook_decode_base64_field "${CONTROL_FIELDS[1]:-}")"
NESTED_TYPE="$(hook_decode_base64_field "${CONTROL_FIELDS[2]:-}")"

MESSAGE_CLASS="$(dispatch_field_raw_value "$DESCRIPTION" "message-class" 2>/dev/null || true)"
MESSAGE_CLASS="$(printf '%s' "$MESSAGE_CLASS" | tr '[:upper:]' '[:lower:]')"

STATE_SIGNAL_PARSED="$(DESCRIPTION_TEXT="$DESCRIPTION" node <<'NODE'
const rawText = String(process.env.DESCRIPTION_TEXT || "");
const lines = rawText
  .split(/\r?\n/)
  .map((line) => line.trim().replace(/\s+/g, " "))
  .filter(Boolean);
const text = rawText.trim().replace(/\s+/g, " ");
let klass = "";
let taskId = "";
let signals = [];
for (const line of lines.length ? lines : [text]) {
  let match = line.match(/^ack(?: task ([A-Za-z0-9._:-]+))?$/i);
  if (match) {
    signals.push(["dispatch-ack", match[1] || ""]);
    continue;
  }
  match = line.match(/^completion(?: task ([A-Za-z0-9._:-]+))?$/i);
  if (match) signals.push(["completion", match[1] || ""]);
}
if (signals.length === 1) {
  klass = signals[0][0];
  taskId = signals[0][1];
}
process.stdout.write(`${klass}\n${taskId}`);
NODE
)"
mapfile -t STATE_SIGNAL_FIELDS <<<"$STATE_SIGNAL_PARSED"
STATE_SIGNAL_CLASS="${STATE_SIGNAL_FIELDS[0]:-}"
STATE_SIGNAL_TASK_ID="${STATE_SIGNAL_FIELDS[1]:-}"
if [[ -z "$MESSAGE_CLASS" && -n "$STATE_SIGNAL_CLASS" ]]; then
  MESSAGE_CLASS="$STATE_SIGNAL_CLASS"
fi
if [[ -n "$STATE_SIGNAL_TASK_ID" && -z "$(printf '%s' "$TASK_ID" | tr -d '[:space:]')" ]]; then
  TASK_ID="$STATE_SIGNAL_TASK_ID"
fi

SENDER_NAME="$(resolve_runtime_sender_name "$SESSION_ID" "$AGENT_ID" "$AGENT_NAME" "$AGENT_TYPE" "$TEAMMATE_NAME" 2>/dev/null || true)"
SENDER_IS_WORKER="false"
if runtime_sender_session_is_worker "$SESSION_ID"; then
  SENDER_IS_WORKER="true"
fi


recent_dispatch_ack_observed_for_worker() {
  local worker_name="${1-}"
  local window_seconds="${2:-120}"

  [[ -n "$worker_name" && -f "$WORKER_TRANSPORT_LEDGER" ]] || return 1

  WORKER_NAME="$worker_name" WORKER_TRANSPORT_LEDGER="$WORKER_TRANSPORT_LEDGER" WINDOW_SECONDS="$window_seconds" node <<'NODE'
const fs = require('fs');
const worker = String(process.env.WORKER_NAME || '').trim().toLowerCase();
const ledger = process.env.WORKER_TRANSPORT_LEDGER || '';
const windowSeconds = Number(process.env.WINDOW_SECONDS || 120);
if (!worker || !ledger || !fs.existsSync(ledger)) process.exit(1);
const cutoff = Date.now() - Math.max(1, windowSeconds) * 1000;
const lines = fs.readFileSync(ledger, 'utf8').trim().split(/\r?\n/).filter(Boolean).reverse();
for (const line of lines) {
  let row;
  try { row = JSON.parse(line); } catch { continue; }
  const ts = Date.parse(String(row.timestamp || ''));
  if (Number.isFinite(ts) && ts < cutoff) break;
  const sender = String(row.senderName || '').trim().toLowerCase();
  const klass = String(row.messageClass || '').trim().toLowerCase();
  if (sender === worker && klass === 'dispatch-ack') process.exit(0);
}
process.exit(1);
NODE
}

_update_worker_retained_carrier_locked() {
  local worker_name="${1:?worker name required}"
  local task_id="${2-}"
  local retained_path="${3-}"
  local write_scope="${4-}"
  local target_file="$WORKER_RETAINED_CARRIER_MAP"
  local temp_file=""

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"
  awk -F'|' -v worker="$worker_name" -v task="$task_id" '
    !($1 == worker && $2 == task) { print $0 }
  ' "$target_file" > "$temp_file"
  printf '%s|%s|%s|%s\n' "$worker_name" "$task_id" "$retained_path" "$write_scope" >> "$temp_file"
  atomic_replace_file "$temp_file" "$target_file"
}

remember_worker_retained_carrier() {
  local worker_name="${1-}"
  local task_id="${2-}"
  local retained_path="${3-}"
  local write_scope="${4-}"

  worker_name="$(normalize_lane_id "$worker_name")"
  task_id="$(printf '%s' "$task_id" | tr -d '[:space:]')"
  retained_path="$(printf '%s' "$retained_path" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  write_scope="$(printf '%s' "$write_scope" | tr '\n|' ', ' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  [[ -n "$worker_name" ]] || return 0
  [[ -n "$retained_path" || -n "$write_scope" ]] || return 0

  with_lock_file "$WORKER_RETAINED_CARRIER_MAP_LOCK" _update_worker_retained_carrier_locked "$worker_name" "$task_id" "$retained_path" "$write_scope"
}

[[ "$TOOL_NAME" == "SendMessage" ]] || exit 0

lookup_worker_retained_carrier() {
  local worker_name="${1-}"
  local task_id="${2-}"

  worker_name="$(normalize_lane_id "$worker_name")"
  task_id="$(printf '%s' "$task_id" | tr -d '[:space:]')"
  [[ -n "$worker_name" && -f "$WORKER_RETAINED_CARRIER_MAP" ]] || return 0

  awk -F'|' -v worker="$worker_name" -v task="$task_id" '
    $1 == worker && $2 == task { value = $3 }
    END { if (value != "") print value }
  ' "$WORKER_RETAINED_CARRIER_MAP"
}



if [[ "$TOP_TYPE" == "shutdown_response" || "$NESTED_TYPE" == "shutdown_response" ]]; then
  if [[ "$SENDER_IS_WORKER" == "true" && -n "$SENDER_NAME" ]]; then
    clear_worker_idle_notice "$SENDER_NAME"
    remove_worker_everywhere "$SENDER_NAME"
  fi
  exit 0
fi

if [[ "$TOP_TYPE" == "shutdown_request" || "$NESTED_TYPE" == "shutdown_request" ]]; then
  if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
    clear_worker_idle_pending "$TARGET_NAME"
    clear_worker_idle_notice "$TARGET_NAME"
  fi
  exit 0
fi

if [[ "$SENDER_IS_WORKER" != "true" ]]; then
  case "$MESSAGE_CLASS" in
    assignment|reuse|reroute)
      if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
        ASSIGNMENT_TASK_ID="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-ID" 2>/dev/null || true)"
        ASSIGNMENT_RETAINED_OUTPUT_PATH="$(dispatch_field_raw_value "$DESCRIPTION" "RETAINED-OUTPUT-PATH" 2>/dev/null || true)"
        ASSIGNMENT_WRITE_SCOPE="$(dispatch_field_raw_value "$DESCRIPTION" "WRITE-SCOPE" 2>/dev/null || true)"
        remember_worker_retained_carrier "$TARGET_NAME" "$ASSIGNMENT_TASK_ID" "$ASSIGNMENT_RETAINED_OUTPUT_PATH" "$ASSIGNMENT_WRITE_SCOPE"
        clear_worker_idle_pending "$TARGET_NAME"
        clear_worker_idle_notice "$TARGET_NAME"
        clear_worker_standby "$TARGET_NAME"
        mark_team_dispatch_pending "$SESSION_ID" "$TARGET_NAME" "sendmessage-${MESSAGE_CLASS}"
        mark_worker_dispatch_ack_required "$TARGET_NAME"
        if recent_dispatch_ack_observed_for_worker "$TARGET_NAME" 120; then
          clear_worker_dispatch_ack_required "$TARGET_NAME"
          mark_team_dispatch_claimed "$SESSION_ID" "$TARGET_NAME" "worker-transport:dispatch-ack"
        fi
      fi
      exit 0
      ;;
  esac
fi

if [[ -z "$SENDER_NAME" ]] && runtime_sender_session_is_worker "$SESSION_ID"; then
  SENDER_NAME="session:${SESSION_ID}"
  printf '[%s] TRACK-WORKER-TRANSPORT WARN: unresolved agent sender identity; using session fallback (session: %s)\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
fi

if [[ -z "$SENDER_NAME" || "$SENDER_NAME" == "team-lead" ]]; then
  if runtime_sender_session_is_worker "$SESSION_ID"; then
    printf '[%s] TRACK-WORKER-TRANSPORT WARN: skipped transport append because sender identity remained unresolved (session: %s)\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
  fi
  exit 0
fi

case "$MESSAGE_CLASS" in
  completion) ;;
  hold\|blocker|status|scope-pressure|dispatch-ack) ;;
  *) exit 0 ;;
esac

CURRENT_DISPATCH_STATE="$(get_procedure_state_field "teamDispatchState" "")"
CURRENT_PENDING_WORKER="$(get_procedure_state_field "lastPendingWorker" "")"
CURRENT_DISPATCH_WORKER="$(get_procedure_state_field "lastDispatchWorker" "")"
ACK_WAS_REQUIRED="false"
if worker_dispatch_ack_required "$SENDER_NAME"; then
  ACK_WAS_REQUIRED="true"
fi
DUPLICATE_DISPATCH_ACK="false"
if [[ "$MESSAGE_CLASS" == "dispatch-ack" ]] \
  && [[ "$ACK_WAS_REQUIRED" != "true" ]] \
  && [[ "$CURRENT_DISPATCH_STATE" != "pending" ]]; then
  DUPLICATE_DISPATCH_ACK="true"
  printf '[%s] TRACK-WORKER-TRANSPORT WARN: duplicate or stale dispatch-ack from %s without pending ack requirement; treating as receipt-only anomaly, not new work.\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "$SENDER_NAME" >> "$VIOLATION_LOG"
fi

if [[ "$DUPLICATE_DISPATCH_ACK" != "true" ]]; then
  record_team_runtime_state "$SESSION_ID" "active" "worker-transport:${MESSAGE_CLASS}"

  if [[ "$CURRENT_DISPATCH_STATE" == "pending" ]] \
    && { [[ "$CURRENT_PENDING_WORKER" == "$SENDER_NAME" ]] || [[ "$CURRENT_DISPATCH_WORKER" == "$SENDER_NAME" ]]; }; then
    mark_team_dispatch_claimed "$SESSION_ID" "$SENDER_NAME" "worker-transport:${MESSAGE_CLASS}"
  elif [[ "$MESSAGE_CLASS" == "dispatch-ack" && "$ACK_WAS_REQUIRED" == "true" ]]; then
    mark_team_dispatch_claimed "$SESSION_ID" "$SENDER_NAME" "worker-transport:${MESSAGE_CLASS}"
  fi

  if [[ "$MESSAGE_CLASS" == "dispatch-ack" ]] || { [[ "$ACK_WAS_REQUIRED" == "true" ]] && { [[ "$MESSAGE_CLASS" == "scope-pressure" ]] || [[ "$MESSAGE_CLASS" == "hold|blocker" ]]; }; }; then
    clear_worker_dispatch_ack_required "$SENDER_NAME"
    clear_worker_standby "$SENDER_NAME"
    clear_worker_idle_pending "$SENDER_NAME"
  fi
fi

description_field_value() {
  local field_name="${1:?field required}"
  dispatch_field_raw_value "$DESCRIPTION" "$field_name" 2>/dev/null || true
}

read_retained_carrier() {
  local raw_path="${1-}"
  local project_root=""

  [[ -n "$(printf '%s' "$raw_path" | tr -d '[:space:]')" ]] || return 0
  project_root="$(resolve_project_root)"

  RAW_RETAINED_OUTPUT_PATH="$raw_path" PROJECT_ROOT="$project_root" node <<'NODE'
const fs = require('fs');
const path = require('path');

try {
  const raw = String(process.env.RAW_RETAINED_OUTPUT_PATH || '').trim();
  if (!raw) process.exit(0);

  const projectRoot = fs.realpathSync(String(process.env.PROJECT_ROOT || process.cwd()));
  const candidate = path.resolve(projectRoot, raw);
  const real = fs.realpathSync(candidate);
  const relative = path.relative(projectRoot, real);

  if (!relative || relative.startsWith('..') || path.isAbsolute(relative)) process.exit(0);
  if (relative === '.claude' || relative.startsWith('.claude/')) process.exit(0);
  if (relative === '.runtime' || relative.startsWith('.runtime/')) process.exit(0);
  if (relative !== 'claude_doc' && !relative.startsWith('claude_doc/')) process.exit(0);

  process.stdout.write(fs.readFileSync(real, 'utf8'));
} catch {
  process.exit(0);
}
NODE
}

RETAINED_OUTPUT_PATH_VALUE="$(description_field_value "RETAINED-OUTPUT-PATH")"
if [[ -z "$(printf '%s' "$RETAINED_OUTPUT_PATH_VALUE" | tr -d '[:space:]')" ]]; then
  RETAINED_OUTPUT_PATH_VALUE="$(lookup_worker_retained_carrier "$SENDER_NAME" "$TASK_ID")"
fi
RETAINED_CARRIER_TEXT=""
case "$MESSAGE_CLASS" in
  completion)
    RETAINED_CARRIER_TEXT="$(read_retained_carrier "$RETAINED_OUTPUT_PATH_VALUE" || true)"
    ;;
esac

field_value() {
  local field_name="${1:?field required}"
  local carrier_value=""

  if [[ -n "$RETAINED_CARRIER_TEXT" ]]; then
    carrier_value="$(dispatch_field_raw_value "$RETAINED_CARRIER_TEXT" "$field_name" 2>/dev/null || true)"
    if [[ -n "$(printf '%s' "$carrier_value" | tr -d '[:space:]')" ]]; then
      printf '%s' "$carrier_value"
      return 0
    fi
  fi

  description_field_value "$field_name"
}

TASK_ID_FIELD_PRESENT="false"
TASK_ID_FROM_MESSAGE="$(field_value "TASK-ID")"
if [[ -n "$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')" ]]; then
  TASK_ID_FIELD_PRESENT="true"
  TASK_ID="$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')"
elif [[ -n "$STATE_SIGNAL_TASK_ID" ]]; then
  TASK_ID_FIELD_PRESENT="true"
  TASK_ID="$(printf '%s' "$STATE_SIGNAL_TASK_ID" | tr -d '[:space:]')"
else
  TASK_ID="$(printf '%s' "$TASK_ID" | tr -d '[:space:]')"
fi

case "$MESSAGE_CLASS" in
  completion)
    clear_worker_idle_pending "$SENDER_NAME"
    clear_worker_idle_notice "$SENDER_NAME"
    mark_worker_standby "$SENDER_NAME"
    ;;
  hold\|blocker)
    clear_worker_idle_pending "$SENDER_NAME"
    ;;
esac

if [[ -z "$TASK_SUBJECT" ]]; then
  TASK_SUBJECT="$(field_value "TASK-SUBJECT")"
fi

OUTPUT_SURFACE_VALUE="$(field_value "OUTPUT-SURFACE")"
TARGET_INTENT_BASIS_VALUE="$(field_value "TARGET-INTENT-BASIS")"
EVIDENCE_BASIS_VALUE="$(field_value "EVIDENCE-BASIS")"
OPEN_SURFACES_VALUE="$(field_value "OPEN-SURFACES")"
FROZEN_CONTRACT_STATUS_VALUE="$(printf '%s' "$(field_value "FROZEN-CONTRACT-STATUS")" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
NEXT_LANE_VALUE="$(field_value "LANE-NEXT-CANDIDATE")"
USER_RUN_PATH_VALUE="$(field_value "USER-RUN-PATH")"
BURDEN_CONTRACT_VALUE="$(printf '%s' "$(field_value "BURDEN-CONTRACT")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PROOF_SURFACE_MATCH_VALUE="$(printf '%s' "$(field_value "PROOF-SURFACE-MATCH")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RUN_PATH_STATUS_VALUE="$(printf '%s' "$(field_value "RUN-PATH-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
CORE_WORKFLOW_STATUS_VALUE="$(printf '%s' "$(field_value "CORE-WORKFLOW-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
INTERACTION_COVERAGE_STATUS_VALUE="$(printf '%s' "$(field_value "INTERACTION-COVERAGE-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
BURDEN_STATUS_VALUE="$(printf '%s' "$(field_value "BURDEN-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
ACCEPTANCE_RECONCILIATION_VALUE="$(printf '%s' "$(field_value "ACCEPTANCE-RECONCILIATION")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PLANNING_BASIS_VALUE="$(printf '%s' "$(field_value "PLANNING-BASIS-CONSUMPTION")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RESOURCE_CLEANUP_VALUE="$(printf '%s' "$(field_value "RESOURCE-CLEANUP")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
USER_SURFACE_PROOF_METHOD_VALUE="$(field_value "USER-SURFACE-PROOF-METHOD")"
TOOL_PATH_USED_VALUE="$(field_value "TOOL-PATH-USED")"
TOOL_EXECUTION_EVIDENCE_VALUE="$(field_value "TOOL-EXECUTION-EVIDENCE")"
CONVERGENCE_PASS_VALUE="$(printf '%s' "$(field_value "CONVERGENCE-PASS")" | tr -d '[:space:]')"
LANE_LOCAL_RESULT_VERIFICATION_VALUE="$(field_value "LANE-LOCAL-RESULT-VERIFICATION")"

OUTPUT_SURFACE="false"
TARGET_INTENT_BASIS="false"
EVIDENCE_BASIS="false"
OPEN_SURFACES="false"
FROZEN_CONTRACT_STATUS="false"
NEXT_LANE="false"
USER_RUN_PATH="false"
BURDEN_CONTRACT="false"
PROOF_SURFACE_MATCH="false"
RUN_PATH_STATUS="false"
CORE_WORKFLOW_STATUS="false"
INTERACTION_COVERAGE_STATUS="false"
BURDEN_STATUS="false"
ACCEPTANCE_RECONCILIATION="false"
PLANNING_BASIS="false"
RESOURCE_CLEANUP="false"
USER_SURFACE_PROOF_METHOD="false"
TOOL_PATH_USED="false"
TOOL_EXECUTION_EVIDENCE="false"
CONVERGENCE_PASS="false"
LANE_LOCAL_RESULT_VERIFICATION="false"

[[ -n "$(printf '%s' "$OUTPUT_SURFACE_VALUE" | tr -d '[:space:]')" ]] && OUTPUT_SURFACE="true"
[[ -n "$(printf '%s' "$TARGET_INTENT_BASIS_VALUE" | tr -d '[:space:]')" ]] && TARGET_INTENT_BASIS="true"
[[ -n "$(printf '%s' "$EVIDENCE_BASIS_VALUE" | tr -d '[:space:]')" ]] && EVIDENCE_BASIS="true"
[[ -n "$(printf '%s' "$OPEN_SURFACES_VALUE" | tr -d '[:space:]')" ]] && OPEN_SURFACES="true"
[[ -n "$FROZEN_CONTRACT_STATUS_VALUE" ]] && FROZEN_CONTRACT_STATUS="true"
[[ -n "$(printf '%s' "$NEXT_LANE_VALUE" | tr -d '[:space:]')" ]] && NEXT_LANE="true"
[[ -n "$(printf '%s' "$USER_RUN_PATH_VALUE" | tr -d '[:space:]')" ]] && USER_RUN_PATH="true"
[[ -n "$BURDEN_CONTRACT_VALUE" ]] && BURDEN_CONTRACT="true"
[[ -n "$PROOF_SURFACE_MATCH_VALUE" ]] && PROOF_SURFACE_MATCH="true"
[[ -n "$RUN_PATH_STATUS_VALUE" ]] && RUN_PATH_STATUS="true"
[[ -n "$CORE_WORKFLOW_STATUS_VALUE" ]] && CORE_WORKFLOW_STATUS="true"
[[ -n "$INTERACTION_COVERAGE_STATUS_VALUE" ]] && INTERACTION_COVERAGE_STATUS="true"
[[ -n "$BURDEN_STATUS_VALUE" ]] && BURDEN_STATUS="true"
[[ -n "$ACCEPTANCE_RECONCILIATION_VALUE" ]] && ACCEPTANCE_RECONCILIATION="true"
[[ -n "$PLANNING_BASIS_VALUE" ]] && PLANNING_BASIS="true"
[[ -n "$RESOURCE_CLEANUP_VALUE" ]] && RESOURCE_CLEANUP="true"
[[ -n "$(printf '%s' "$USER_SURFACE_PROOF_METHOD_VALUE" | tr -d '[:space:]')" ]] && USER_SURFACE_PROOF_METHOD="true"
[[ -n "$(printf '%s' "$TOOL_PATH_USED_VALUE" | tr -d '[:space:]')" ]] && TOOL_PATH_USED="true"
[[ -n "$(printf '%s' "$TOOL_EXECUTION_EVIDENCE_VALUE" | tr -d '[:space:]')" ]] && TOOL_EXECUTION_EVIDENCE="true"
[[ -n "$CONVERGENCE_PASS_VALUE" ]] && CONVERGENCE_PASS="true"
[[ -n "$(printf '%s' "$LANE_LOCAL_RESULT_VERIFICATION_VALUE" | tr -d '[:space:]')" ]] && LANE_LOCAL_RESULT_VERIFICATION="true"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

LEDGER_LINE="$(TRANSPORT_TIMESTAMP="$TIMESTAMP" TRANSPORT_SESSION_ID="$SESSION_ID" TRANSPORT_SENDER_NAME="$SENDER_NAME" TRANSPORT_TEAM_NAME="$TEAM_NAME" TRANSPORT_AGENT_TYPE="$AGENT_TYPE" TRANSPORT_TASK_ID="$TASK_ID" TRANSPORT_TASK_ID_FIELD_PRESENT="$TASK_ID_FIELD_PRESENT" TRANSPORT_TASK_SUBJECT="$TASK_SUBJECT" TRANSPORT_MESSAGE_CLASS="$MESSAGE_CLASS" TRANSPORT_OUTPUT_SURFACE="$OUTPUT_SURFACE" TRANSPORT_TARGET_INTENT_BASIS="$TARGET_INTENT_BASIS" TRANSPORT_EVIDENCE_BASIS="$EVIDENCE_BASIS" TRANSPORT_OPEN_SURFACES="$OPEN_SURFACES" TRANSPORT_FROZEN_CONTRACT_STATUS="$FROZEN_CONTRACT_STATUS" TRANSPORT_NEXT_LANE="$NEXT_LANE" TRANSPORT_USER_RUN_PATH="$USER_RUN_PATH" TRANSPORT_BURDEN_CONTRACT="$BURDEN_CONTRACT" TRANSPORT_PROOF_SURFACE_MATCH="$PROOF_SURFACE_MATCH" TRANSPORT_RUN_PATH_STATUS="$RUN_PATH_STATUS" TRANSPORT_CORE_WORKFLOW_STATUS="$CORE_WORKFLOW_STATUS" TRANSPORT_INTERACTION_COVERAGE_STATUS="$INTERACTION_COVERAGE_STATUS" TRANSPORT_BURDEN_STATUS="$BURDEN_STATUS" TRANSPORT_ACCEPTANCE_RECONCILIATION="$ACCEPTANCE_RECONCILIATION" TRANSPORT_PLANNING_BASIS="$PLANNING_BASIS" TRANSPORT_RESOURCE_CLEANUP="$RESOURCE_CLEANUP" TRANSPORT_USER_SURFACE_PROOF_METHOD="$USER_SURFACE_PROOF_METHOD" TRANSPORT_TOOL_PATH_USED="$TOOL_PATH_USED" TRANSPORT_TOOL_EXECUTION_EVIDENCE="$TOOL_EXECUTION_EVIDENCE" TRANSPORT_CONVERGENCE_PASS="$CONVERGENCE_PASS" TRANSPORT_LANE_LOCAL_RESULT_VERIFICATION="$LANE_LOCAL_RESULT_VERIFICATION" TRANSPORT_OPEN_SURFACES_VALUE="$OPEN_SURFACES_VALUE" TRANSPORT_FROZEN_CONTRACT_STATUS_VALUE="$FROZEN_CONTRACT_STATUS_VALUE" TRANSPORT_USER_RUN_PATH_VALUE="$USER_RUN_PATH_VALUE" TRANSPORT_BURDEN_CONTRACT_VALUE="$BURDEN_CONTRACT_VALUE" TRANSPORT_PROOF_SURFACE_MATCH_VALUE="$PROOF_SURFACE_MATCH_VALUE" TRANSPORT_RUN_PATH_STATUS_VALUE="$RUN_PATH_STATUS_VALUE" TRANSPORT_CORE_WORKFLOW_STATUS_VALUE="$CORE_WORKFLOW_STATUS_VALUE" TRANSPORT_INTERACTION_COVERAGE_STATUS_VALUE="$INTERACTION_COVERAGE_STATUS_VALUE" TRANSPORT_BURDEN_STATUS_VALUE="$BURDEN_STATUS_VALUE" TRANSPORT_ACCEPTANCE_RECONCILIATION_VALUE="$ACCEPTANCE_RECONCILIATION_VALUE" TRANSPORT_PLANNING_BASIS_VALUE="$PLANNING_BASIS_VALUE" TRANSPORT_RESOURCE_CLEANUP_VALUE="$RESOURCE_CLEANUP_VALUE" TRANSPORT_USER_SURFACE_PROOF_METHOD_VALUE="$USER_SURFACE_PROOF_METHOD_VALUE" TRANSPORT_TOOL_PATH_USED_VALUE="$TOOL_PATH_USED_VALUE" TRANSPORT_TOOL_EXECUTION_EVIDENCE_VALUE="$TOOL_EXECUTION_EVIDENCE_VALUE" TRANSPORT_CONVERGENCE_PASS_VALUE="$CONVERGENCE_PASS_VALUE" TRANSPORT_LANE_LOCAL_RESULT_VERIFICATION_VALUE="$LANE_LOCAL_RESULT_VERIFICATION_VALUE" node <<'NODE'
const line = {
  timestamp: process.env.TRANSPORT_TIMESTAMP || "",
  sessionId: process.env.TRANSPORT_SESSION_ID || "",
  senderName: process.env.TRANSPORT_SENDER_NAME || "",
  teamName: process.env.TRANSPORT_TEAM_NAME || "",
  agentType: process.env.TRANSPORT_AGENT_TYPE || "",
  taskId: process.env.TRANSPORT_TASK_ID || "",
  taskIdFieldPresent: process.env.TRANSPORT_TASK_ID_FIELD_PRESENT === "true",
  taskSubject: process.env.TRANSPORT_TASK_SUBJECT || "",
  messageClass: process.env.TRANSPORT_MESSAGE_CLASS || "",
  fields: {
    outputSurface: process.env.TRANSPORT_OUTPUT_SURFACE === "true",
    targetIntentBasis: process.env.TRANSPORT_TARGET_INTENT_BASIS === "true",
    evidenceBasis: process.env.TRANSPORT_EVIDENCE_BASIS === "true",
    openSurfaces: process.env.TRANSPORT_OPEN_SURFACES === "true",
    frozenContractStatus: process.env.TRANSPORT_FROZEN_CONTRACT_STATUS === "true",
    laneNextCandidate: process.env.TRANSPORT_NEXT_LANE === "true",
    userRunPath: process.env.TRANSPORT_USER_RUN_PATH === "true",
    burdenContract: process.env.TRANSPORT_BURDEN_CONTRACT === "true",
    proofSurfaceMatch: process.env.TRANSPORT_PROOF_SURFACE_MATCH === "true",
    runPathStatus: process.env.TRANSPORT_RUN_PATH_STATUS === "true",
    coreWorkflowStatus: process.env.TRANSPORT_CORE_WORKFLOW_STATUS === "true",
    interactionCoverageStatus: process.env.TRANSPORT_INTERACTION_COVERAGE_STATUS === "true",
    burdenStatus: process.env.TRANSPORT_BURDEN_STATUS === "true",
    acceptanceReconciliation: process.env.TRANSPORT_ACCEPTANCE_RECONCILIATION === "true",
    planningBasis: process.env.TRANSPORT_PLANNING_BASIS === "true",
    resourceCleanup: process.env.TRANSPORT_RESOURCE_CLEANUP === "true",
    userSurfaceProofMethod: process.env.TRANSPORT_USER_SURFACE_PROOF_METHOD === "true",
    toolPathUsed: process.env.TRANSPORT_TOOL_PATH_USED === "true",
    toolExecutionEvidence: process.env.TRANSPORT_TOOL_EXECUTION_EVIDENCE === "true",
    convergencePass: process.env.TRANSPORT_CONVERGENCE_PASS === "true",
    laneLocalResultVerification: process.env.TRANSPORT_LANE_LOCAL_RESULT_VERIFICATION === "true"
  },
  fieldValues: {
    openSurfaces: process.env.TRANSPORT_OPEN_SURFACES_VALUE || "",
    frozenContractStatus: process.env.TRANSPORT_FROZEN_CONTRACT_STATUS_VALUE || "",
    userRunPath: process.env.TRANSPORT_USER_RUN_PATH_VALUE || "",
    burdenContract: process.env.TRANSPORT_BURDEN_CONTRACT_VALUE || "",
    proofSurfaceMatch: process.env.TRANSPORT_PROOF_SURFACE_MATCH_VALUE || "",
    runPathStatus: process.env.TRANSPORT_RUN_PATH_STATUS_VALUE || "",
    coreWorkflowStatus: process.env.TRANSPORT_CORE_WORKFLOW_STATUS_VALUE || "",
    interactionCoverageStatus: process.env.TRANSPORT_INTERACTION_COVERAGE_STATUS_VALUE || "",
    burdenStatus: process.env.TRANSPORT_BURDEN_STATUS_VALUE || "",
    acceptanceReconciliation: process.env.TRANSPORT_ACCEPTANCE_RECONCILIATION_VALUE || "",
    planningBasis: process.env.TRANSPORT_PLANNING_BASIS_VALUE || "",
    resourceCleanup: process.env.TRANSPORT_RESOURCE_CLEANUP_VALUE || "",
    userSurfaceProofMethod: process.env.TRANSPORT_USER_SURFACE_PROOF_METHOD_VALUE || "",
    toolPathUsed: process.env.TRANSPORT_TOOL_PATH_USED_VALUE || "",
    toolExecutionEvidence: process.env.TRANSPORT_TOOL_EXECUTION_EVIDENCE_VALUE || "",
    convergencePass: process.env.TRANSPORT_CONVERGENCE_PASS_VALUE || "",
    laneLocalResultVerification: process.env.TRANSPORT_LANE_LOCAL_RESULT_VERIFICATION_VALUE || ""
  }
};
process.stdout.write(JSON.stringify(line));
NODE
)"

append_line_locked "$WORKER_TRANSPORT_LEDGER_LOCK" "$WORKER_TRANSPORT_LEDGER" "$LEDGER_LINE"

# ─── VALIDATOR TRANSPORT FIELD WARNING (recovery design Phase 1.1c) ───────
# Runtime tracker records a non-blocking warning when a validator PASS-grade
# transport carries obvious evidence-field mismatches. Validator remains the
# acceptance owner; this hook does not issue, deny, or revise verdict truth.
#
# Trigger conditions (ALL must hold to fire):
#   (a) AGENT_TYPE = validator
#   (b) MESSAGE_CLASS = completion
#   (c) DESCRIPTION contains explicit PASS verdict marker (`VERDICT: PASS`)
#   (d) Any evidence-vs-claim mismatch present:
#       - EVIDENCE-BASIS empty/missing
#       - USER-RUN-PATH empty/missing
#       - PROOF-SURFACE-MATCH not 'matched'
#       - RUN-PATH-STATUS not 'matched'
#       - BURDEN-STATUS not 'matched'
#       - ACCEPTANCE-RECONCILIATION value present but noncanonical
#
# Narrow recurrence signal only: downstream owners decide whether the transport
# is acceptable, blocked, or needs correction.
if [[ "$AGENT_TYPE" == "validator" && "$MESSAGE_CLASS" == "completion" ]]; then
  PASS_VERDICT="false"
  if printf '%s' "$DESCRIPTION" | grep -Eiq '(^|[[:space:]])VERDICT[[:space:]]*:[[:space:]]*PASS([[:space:]]|$)'; then
    PASS_VERDICT="true"
  fi

  if [[ "$PASS_VERDICT" == "true" ]]; then
    SILENT_PASS_MISMATCHES=()
    [[ "$EVIDENCE_BASIS" == "false" ]] && SILENT_PASS_MISMATCHES+=("EVIDENCE-BASIS field empty/missing")
    if [[ "$USER_RUN_PATH" == "false" ]] && printf '%s' "$DESCRIPTION" | grep -Eiq '(browser[-[:space:]]*ui|web[-[:space:]]*ui|cli|server|runtime|app|application|executable|run[-[:space:]]*path|launch|operator[ -]facing)'; then
      SILENT_PASS_MISMATCHES+=("USER-RUN-PATH field empty/missing for executable user-facing PASS claim")
    fi
    if [[ -n "$PROOF_SURFACE_MATCH_VALUE" && "$PROOF_SURFACE_MATCH_VALUE" != "matched" ]]; then
      SILENT_PASS_MISMATCHES+=("PROOF-SURFACE-MATCH=${PROOF_SURFACE_MATCH_VALUE} (not 'matched')")
    fi
    if [[ -n "$RUN_PATH_STATUS_VALUE" && "$RUN_PATH_STATUS_VALUE" != "matched" ]]; then
      SILENT_PASS_MISMATCHES+=("RUN-PATH-STATUS=${RUN_PATH_STATUS_VALUE} (not 'matched')")
    fi
    if [[ -n "$BURDEN_STATUS_VALUE" && "$BURDEN_STATUS_VALUE" != "matched" ]]; then
      SILENT_PASS_MISMATCHES+=("BURDEN-STATUS=${BURDEN_STATUS_VALUE} (not 'matched')")
    fi
    if [[ -n "$ACCEPTANCE_RECONCILIATION_VALUE" ]] \
       && [[ "$ACCEPTANCE_RECONCILIATION_VALUE" != "explicit" ]] \
       && [[ "$ACCEPTANCE_RECONCILIATION_VALUE" != "missing" ]] \
       && [[ "$ACCEPTANCE_RECONCILIATION_VALUE" != "not-applicable" ]]; then
      SILENT_PASS_MISMATCHES+=("ACCEPTANCE-RECONCILIATION=${ACCEPTANCE_RECONCILIATION_VALUE} (canonical values: explicit|missing|not-applicable)")
    fi

    if (( ${#SILENT_PASS_MISMATCHES[@]} > 0 )); then
      WARN_MISMATCH_LIST="$(printf '%s; ' "${SILENT_PASS_MISMATCHES[@]}")"
      printf '[%s] TRACK-WORKER-TRANSPORT WARN: validator PASS transport field mismatch from %s task=%s mismatches=%s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$SENDER_NAME" "${TASK_ID:-unknown}" "$WARN_MISMATCH_LIST" >> "$VIOLATION_LOG"
    fi
  fi
fi
# ─── END VALIDATOR TRANSPORT FIELD WARNING ───────────────────────────────────

exit 0
