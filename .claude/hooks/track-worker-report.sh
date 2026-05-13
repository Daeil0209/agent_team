#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"

INPUT="$(cat)"

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
const REPORT_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes"];

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const taskId = String(input.task_id || input.taskId || toolInput.task_id || toolInput.taskId || "").trim();
  const taskSubject = String(input.task_subject || input.taskSubject || toolInput.task_subject || toolInput.taskSubject || "").trim();
  const messageText = joinUniqueText(
    flattenText(toolInput.summary, REPORT_TEXT_KEYS)
      .concat(flattenText(toolInput.message || toolInput.content, REPORT_TEXT_KEYS))
      .concat(flattenText(toolInput.description, REPORT_TEXT_KEYS))
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

[[ "$TOOL_NAME" == "SendMessage" ]] || exit 0
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

SENDER_NAME="$(resolve_runtime_sender_name "$SESSION_ID" "$AGENT_ID" "$AGENT_NAME" "$AGENT_TYPE" "$TEAMMATE_NAME" 2>/dev/null || true)"
SENDER_IS_WORKER="false"
if runtime_sender_session_is_worker "$SESSION_ID"; then
  SENDER_IS_WORKER="true"
fi

if [[ "$TOP_TYPE" == "shutdown_response" || "$NESTED_TYPE" == "shutdown_response" ]]; then
  if [[ "$SENDER_IS_WORKER" == "true" && -n "$SENDER_NAME" ]]; then
    clear_worker_idle_notice "$SENDER_NAME"
    remove_worker_everywhere "$SENDER_NAME"
    schedule_current_pane_shutdown
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
        clear_worker_idle_pending "$TARGET_NAME"
        clear_worker_idle_notice "$TARGET_NAME"
        clear_worker_standby "$TARGET_NAME"
        mark_team_dispatch_pending "$SESSION_ID" "$TARGET_NAME" "sendmessage-${MESSAGE_CLASS}"
        mark_worker_dispatch_ack_required "$TARGET_NAME"
      fi
      exit 0
      ;;
    lifecycle-control)
      LIFECYCLE_DECISION="$(dispatch_field_raw_value "$DESCRIPTION" "LIFECYCLE-DECISION" 2>/dev/null || true)"
      LIFECYCLE_DECISION="$(printf '%s' "$LIFECYCLE_DECISION" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
      if [[ "$LIFECYCLE_DECISION" == "standby" && -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
        mark_worker_standby "$TARGET_NAME"
        clear_worker_idle_pending "$TARGET_NAME"
        clear_worker_idle_notice "$TARGET_NAME"
      fi
      exit 0
      ;;
  esac
fi

if [[ -z "$SENDER_NAME" ]] && runtime_sender_session_is_worker "$SESSION_ID"; then
  SENDER_NAME="session:${SESSION_ID}"
  printf '[%s] TRACK-WORKER-REPORT WARN: unresolved agent sender identity; using session fallback (session: %s)\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
fi

if [[ -z "$SENDER_NAME" || "$SENDER_NAME" == "team-lead" ]]; then
  if runtime_sender_session_is_worker "$SESSION_ID"; then
    printf '[%s] TRACK-WORKER-REPORT WARN: skipped report append because sender identity remained unresolved (session: %s)\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
  fi
  exit 0
fi

case "$MESSAGE_CLASS" in
  handoff) ;;
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
  printf '[%s] TRACK-WORKER-REPORT WARN: duplicate or stale dispatch-ack from %s without pending ack requirement; treating as receipt-only anomaly, not new work.\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "$SENDER_NAME" >> "$VIOLATION_LOG"
fi

if [[ "$DUPLICATE_DISPATCH_ACK" != "true" ]]; then
  record_team_runtime_state "$SESSION_ID" "active" "worker-report:${MESSAGE_CLASS}"

  if [[ "$CURRENT_DISPATCH_STATE" == "pending" ]] \
    && { [[ "$CURRENT_PENDING_WORKER" == "$SENDER_NAME" ]] || [[ "$CURRENT_DISPATCH_WORKER" == "$SENDER_NAME" ]]; }; then
    mark_team_dispatch_claimed "$SESSION_ID" "$SENDER_NAME" "worker-report:${MESSAGE_CLASS}"
  elif [[ "$MESSAGE_CLASS" == "dispatch-ack" && "$ACK_WAS_REQUIRED" == "true" ]]; then
    mark_team_dispatch_claimed "$SESSION_ID" "$SENDER_NAME" "worker-report:${MESSAGE_CLASS}"
  fi

  if [[ "$MESSAGE_CLASS" == "dispatch-ack" ]]; then
    clear_worker_dispatch_ack_required "$SENDER_NAME"
    clear_worker_standby "$SENDER_NAME"
    clear_worker_idle_pending "$SENDER_NAME"
  fi
fi

TASK_ID_FIELD_PRESENT="false"
TASK_ID_FROM_MESSAGE="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-ID" 2>/dev/null || true)"
if [[ -n "$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')" ]]; then
  TASK_ID_FIELD_PRESENT="true"
  TASK_ID="$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')"
else
  TASK_ID="$(printf '%s' "$TASK_ID" | tr -d '[:space:]')"
fi

REQUESTED_LIFECYCLE="$(dispatch_field_raw_value "$DESCRIPTION" "REQUESTED-LIFECYCLE" 2>/dev/null || true)"
REQUESTED_LIFECYCLE="$(printf '%s' "$REQUESTED_LIFECYCLE" | tr '[:upper:]' '[:lower:]')"

case "$MESSAGE_CLASS" in
  handoff)
    clear_worker_standby "$SENDER_NAME"
    mark_worker_idle_pending "$SENDER_NAME" "standby" "${TASK_ID:-none}" "$MESSAGE_CLASS"
    ;;
  completion)
    clear_worker_standby "$SENDER_NAME"
    mark_worker_idle_pending "$SENDER_NAME" "standby" "${TASK_ID:-none}" "$MESSAGE_CLASS"
    ;;
  hold\|blocker)
    clear_worker_idle_pending "$SENDER_NAME"
    ;;
esac

if [[ -z "$TASK_SUBJECT" ]]; then
  TASK_SUBJECT="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-SUBJECT" 2>/dev/null || true)"
fi

field_value() {
  local field_name="${1:?field required}"
  dispatch_field_raw_value "$DESCRIPTION" "$field_name" 2>/dev/null || true
}

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
PLANNING_BASIS_VALUE="$(printf '%s' "$(field_value "PLANNING-BASIS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RESOURCE_CLEANUP_VALUE="$(printf '%s' "$(field_value "RESOURCE-CLEANUP")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
USER_SURFACE_PROOF_METHOD_VALUE="$(field_value "USER-SURFACE-PROOF-METHOD")"
TOOL_PATH_USED_VALUE="$(field_value "TOOL-PATH-USED")"
TOOL_EXECUTION_EVIDENCE_VALUE="$(field_value "TOOL-EXECUTION-EVIDENCE")"
CONVERGENCE_PASS_VALUE="$(printf '%s' "$(field_value "CONVERGENCE-PASS")" | tr -d '[:space:]')"
PRODUCER_SELF_REVIEW_PASS_VALUE="$(field_value "PRODUCER-SELF-REVIEW-PASS")"
LANE_LOCAL_SV_RESULT_VALUE="$(field_value "LANE-LOCAL-SV-RESULT")"

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
PRODUCER_SELF_REVIEW_PASS="false"
LANE_LOCAL_SV_RESULT="false"

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
[[ -n "$(printf '%s' "$PRODUCER_SELF_REVIEW_PASS_VALUE" | tr -d '[:space:]')" ]] && PRODUCER_SELF_REVIEW_PASS="true"
[[ -n "$(printf '%s' "$LANE_LOCAL_SV_RESULT_VALUE" | tr -d '[:space:]')" ]] && LANE_LOCAL_SV_RESULT="true"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

LEDGER_LINE="$(REPORT_TIMESTAMP="$TIMESTAMP" REPORT_SESSION_ID="$SESSION_ID" REPORT_SENDER_NAME="$SENDER_NAME" REPORT_TEAM_NAME="$TEAM_NAME" REPORT_AGENT_TYPE="$AGENT_TYPE" REPORT_TASK_ID="$TASK_ID" REPORT_TASK_ID_FIELD_PRESENT="$TASK_ID_FIELD_PRESENT" REPORT_TASK_SUBJECT="$TASK_SUBJECT" REPORT_MESSAGE_CLASS="$MESSAGE_CLASS" REPORT_REQUESTED_LIFECYCLE="$REQUESTED_LIFECYCLE" REPORT_OUTPUT_SURFACE="$OUTPUT_SURFACE" REPORT_TARGET_INTENT_BASIS="$TARGET_INTENT_BASIS" REPORT_EVIDENCE_BASIS="$EVIDENCE_BASIS" REPORT_OPEN_SURFACES="$OPEN_SURFACES" REPORT_FROZEN_CONTRACT_STATUS="$FROZEN_CONTRACT_STATUS" REPORT_NEXT_LANE="$NEXT_LANE" REPORT_USER_RUN_PATH="$USER_RUN_PATH" REPORT_BURDEN_CONTRACT="$BURDEN_CONTRACT" REPORT_PROOF_SURFACE_MATCH="$PROOF_SURFACE_MATCH" REPORT_RUN_PATH_STATUS="$RUN_PATH_STATUS" REPORT_CORE_WORKFLOW_STATUS="$CORE_WORKFLOW_STATUS" REPORT_INTERACTION_COVERAGE_STATUS="$INTERACTION_COVERAGE_STATUS" REPORT_BURDEN_STATUS="$BURDEN_STATUS" REPORT_ACCEPTANCE_RECONCILIATION="$ACCEPTANCE_RECONCILIATION" REPORT_PLANNING_BASIS="$PLANNING_BASIS" REPORT_RESOURCE_CLEANUP="$RESOURCE_CLEANUP" REPORT_USER_SURFACE_PROOF_METHOD="$USER_SURFACE_PROOF_METHOD" REPORT_TOOL_PATH_USED="$TOOL_PATH_USED" REPORT_TOOL_EXECUTION_EVIDENCE="$TOOL_EXECUTION_EVIDENCE" REPORT_CONVERGENCE_PASS="$CONVERGENCE_PASS" REPORT_PRODUCER_SELF_REVIEW_PASS="$PRODUCER_SELF_REVIEW_PASS" REPORT_LANE_LOCAL_SV_RESULT="$LANE_LOCAL_SV_RESULT" REPORT_OPEN_SURFACES_VALUE="$OPEN_SURFACES_VALUE" REPORT_FROZEN_CONTRACT_STATUS_VALUE="$FROZEN_CONTRACT_STATUS_VALUE" REPORT_USER_RUN_PATH_VALUE="$USER_RUN_PATH_VALUE" REPORT_BURDEN_CONTRACT_VALUE="$BURDEN_CONTRACT_VALUE" REPORT_PROOF_SURFACE_MATCH_VALUE="$PROOF_SURFACE_MATCH_VALUE" REPORT_RUN_PATH_STATUS_VALUE="$RUN_PATH_STATUS_VALUE" REPORT_CORE_WORKFLOW_STATUS_VALUE="$CORE_WORKFLOW_STATUS_VALUE" REPORT_INTERACTION_COVERAGE_STATUS_VALUE="$INTERACTION_COVERAGE_STATUS_VALUE" REPORT_BURDEN_STATUS_VALUE="$BURDEN_STATUS_VALUE" REPORT_ACCEPTANCE_RECONCILIATION_VALUE="$ACCEPTANCE_RECONCILIATION_VALUE" REPORT_PLANNING_BASIS_VALUE="$PLANNING_BASIS_VALUE" REPORT_RESOURCE_CLEANUP_VALUE="$RESOURCE_CLEANUP_VALUE" REPORT_USER_SURFACE_PROOF_METHOD_VALUE="$USER_SURFACE_PROOF_METHOD_VALUE" REPORT_TOOL_PATH_USED_VALUE="$TOOL_PATH_USED_VALUE" REPORT_TOOL_EXECUTION_EVIDENCE_VALUE="$TOOL_EXECUTION_EVIDENCE_VALUE" REPORT_CONVERGENCE_PASS_VALUE="$CONVERGENCE_PASS_VALUE" REPORT_PRODUCER_SELF_REVIEW_PASS_VALUE="$PRODUCER_SELF_REVIEW_PASS_VALUE" REPORT_LANE_LOCAL_SV_RESULT_VALUE="$LANE_LOCAL_SV_RESULT_VALUE" node <<'NODE'
const line = {
  timestamp: process.env.REPORT_TIMESTAMP || "",
  sessionId: process.env.REPORT_SESSION_ID || "",
  senderName: process.env.REPORT_SENDER_NAME || "",
  teamName: process.env.REPORT_TEAM_NAME || "",
  agentType: process.env.REPORT_AGENT_TYPE || "",
  taskId: process.env.REPORT_TASK_ID || "",
  taskIdFieldPresent: process.env.REPORT_TASK_ID_FIELD_PRESENT === "true",
  taskSubject: process.env.REPORT_TASK_SUBJECT || "",
  messageClass: process.env.REPORT_MESSAGE_CLASS || "",
  requestedLifecycle: process.env.REPORT_REQUESTED_LIFECYCLE || "",
  fields: {
    outputSurface: process.env.REPORT_OUTPUT_SURFACE === "true",
    targetIntentBasis: process.env.REPORT_TARGET_INTENT_BASIS === "true",
    evidenceBasis: process.env.REPORT_EVIDENCE_BASIS === "true",
    openSurfaces: process.env.REPORT_OPEN_SURFACES === "true",
    frozenContractStatus: process.env.REPORT_FROZEN_CONTRACT_STATUS === "true",
    laneNextCandidate: process.env.REPORT_NEXT_LANE === "true",
    userRunPath: process.env.REPORT_USER_RUN_PATH === "true",
    burdenContract: process.env.REPORT_BURDEN_CONTRACT === "true",
    proofSurfaceMatch: process.env.REPORT_PROOF_SURFACE_MATCH === "true",
    runPathStatus: process.env.REPORT_RUN_PATH_STATUS === "true",
    coreWorkflowStatus: process.env.REPORT_CORE_WORKFLOW_STATUS === "true",
    interactionCoverageStatus: process.env.REPORT_INTERACTION_COVERAGE_STATUS === "true",
    burdenStatus: process.env.REPORT_BURDEN_STATUS === "true",
    acceptanceReconciliation: process.env.REPORT_ACCEPTANCE_RECONCILIATION === "true",
    planningBasis: process.env.REPORT_PLANNING_BASIS === "true",
    resourceCleanup: process.env.REPORT_RESOURCE_CLEANUP === "true",
    userSurfaceProofMethod: process.env.REPORT_USER_SURFACE_PROOF_METHOD === "true",
    toolPathUsed: process.env.REPORT_TOOL_PATH_USED === "true",
    toolExecutionEvidence: process.env.REPORT_TOOL_EXECUTION_EVIDENCE === "true",
    convergencePass: process.env.REPORT_CONVERGENCE_PASS === "true",
    producerSelfReviewPass: process.env.REPORT_PRODUCER_SELF_REVIEW_PASS === "true",
    laneLocalSvResult: process.env.REPORT_LANE_LOCAL_SV_RESULT === "true"
  },
  fieldValues: {
    openSurfaces: process.env.REPORT_OPEN_SURFACES_VALUE || "",
    frozenContractStatus: process.env.REPORT_FROZEN_CONTRACT_STATUS_VALUE || "",
    userRunPath: process.env.REPORT_USER_RUN_PATH_VALUE || "",
    burdenContract: process.env.REPORT_BURDEN_CONTRACT_VALUE || "",
    proofSurfaceMatch: process.env.REPORT_PROOF_SURFACE_MATCH_VALUE || "",
    runPathStatus: process.env.REPORT_RUN_PATH_STATUS_VALUE || "",
    coreWorkflowStatus: process.env.REPORT_CORE_WORKFLOW_STATUS_VALUE || "",
    interactionCoverageStatus: process.env.REPORT_INTERACTION_COVERAGE_STATUS_VALUE || "",
    burdenStatus: process.env.REPORT_BURDEN_STATUS_VALUE || "",
    acceptanceReconciliation: process.env.REPORT_ACCEPTANCE_RECONCILIATION_VALUE || "",
    planningBasis: process.env.REPORT_PLANNING_BASIS_VALUE || "",
    resourceCleanup: process.env.REPORT_RESOURCE_CLEANUP_VALUE || "",
    userSurfaceProofMethod: process.env.REPORT_USER_SURFACE_PROOF_METHOD_VALUE || "",
    toolPathUsed: process.env.REPORT_TOOL_PATH_USED_VALUE || "",
    toolExecutionEvidence: process.env.REPORT_TOOL_EXECUTION_EVIDENCE_VALUE || "",
    convergencePass: process.env.REPORT_CONVERGENCE_PASS_VALUE || "",
    producerSelfReviewPass: process.env.REPORT_PRODUCER_SELF_REVIEW_PASS_VALUE || "",
    laneLocalSvResult: process.env.REPORT_LANE_LOCAL_SV_RESULT_VALUE || ""
  }
};
process.stdout.write(JSON.stringify(line));
NODE
)"

append_line_locked "$WORKER_REPORT_LEDGER_LOCK" "$WORKER_REPORT_LEDGER" "$LEDGER_LINE"

# ─── VALIDATOR REPORT FIELD WARNING (recovery design Phase 1.1c) ───────
# Runtime tracker records a non-blocking warning when a validator PASS-grade
# report carries obvious evidence-field mismatches. Validator remains the
# acceptance owner; this hook does not issue, deny, or revise verdict truth.
#
# Trigger conditions (ALL must hold to fire):
#   (a) AGENT_TYPE = validator
#   (b) MESSAGE_CLASS in {handoff, completion}
#   (c) DESCRIPTION contains explicit PASS verdict marker (`VERDICT: PASS`)
#   (d) Any evidence-vs-claim mismatch present:
#       - EVIDENCE-BASIS empty/missing
#       - USER-RUN-PATH empty/missing
#       - PROOF-SURFACE-MATCH not 'matched'
#       - RUN-PATH-STATUS not 'matched'
#       - BURDEN-STATUS not 'matched'
#       - ACCEPTANCE-RECONCILIATION value present but noncanonical
#
# Narrow recurrence signal only: downstream owners decide whether the report
# is acceptable, blocked, or needs correction.
if [[ "$AGENT_TYPE" == "validator" ]] && { [[ "$MESSAGE_CLASS" == "handoff" ]] || [[ "$MESSAGE_CLASS" == "completion" ]]; }; then
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
      printf '[%s] TRACK-WORKER-REPORT WARN: validator PASS report field mismatch from %s task=%s mismatches=%s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$SENDER_NAME" "${TASK_ID:-unknown}" "$WARN_MISMATCH_LIST" >> "$VIOLATION_LOG"
    fi
  fi
fi
# ─── END VALIDATOR REPORT FIELD WARNING ───────────────────────────────────

exit 0
