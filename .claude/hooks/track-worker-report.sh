#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes"];
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

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const taskId = String(input.task_id || input.taskId || toolInput.task_id || toolInput.taskId || "").trim();
  const taskSubject = String(input.task_subject || input.taskSubject || toolInput.task_subject || toolInput.taskSubject || "").trim();
  const messageText = joinUniqueText(
    flattenText(toolInput.summary)
      .concat(flattenText(toolInput.message || toolInput.content))
      .concat(flattenText(toolInput.description))
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

decode_field() {
  local encoded="${1-}"
  if [[ -z "$encoded" ]]; then
    printf ''
    return 0
  fi
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
SESSION_ID="$(decode_field "${FIELDS[1]:-}")"
AGENT_ID="$(decode_field "${FIELDS[2]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[3]:-}")"
AGENT_TYPE="$(decode_field "${FIELDS[4]:-}")"
TEAMMATE_NAME="$(decode_field "${FIELDS[5]:-}")"
TEAM_NAME="$(decode_field "${FIELDS[6]:-}")"
TASK_ID="$(decode_field "${FIELDS[7]:-}")"
TASK_SUBJECT="$(decode_field "${FIELDS[8]:-}")"
DESCRIPTION="$(decode_field "${FIELDS[9]:-}")"
SUCCESS_VALUE="$(printf '%s' "$(decode_field "${FIELDS[10]:-}")" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "$(decode_field "${FIELDS[11]:-}")" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="$(decode_field "${FIELDS[12]:-}")"

[[ "$TOOL_NAME" == "SendMessage" ]] || exit 0
tool_response_succeeded || exit 0

SENDER_NAME="$(resolve_runtime_sender_name "$SESSION_ID" "$AGENT_ID" "$AGENT_NAME" "$AGENT_TYPE" "$TEAMMATE_NAME" 2>/dev/null || true)"

if [[ -z "$SENDER_NAME" ]] && runtime_sender_session_is_worker "$SESSION_ID"; then
  SENDER_NAME="session:${SESSION_ID}"
  printf '[%s] TRACK-WORKER-REPORT WARN: unresolved worker sender identity; using session fallback (session: %s)\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
fi

if [[ -z "$SENDER_NAME" || "$SENDER_NAME" == "team-lead" ]]; then
  if runtime_sender_session_is_worker "$SESSION_ID"; then
    printf '[%s] TRACK-WORKER-REPORT WARN: skipped report append because sender identity remained unresolved (session: %s)\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
  fi
  exit 0
fi

MESSAGE_CLASS="$(dispatch_field_raw_value "$DESCRIPTION" "message-class" 2>/dev/null || true)"
MESSAGE_CLASS="$(printf '%s' "$MESSAGE_CLASS" | tr '[:upper:]' '[:lower:]')"

case "$MESSAGE_CLASS" in
  handoff|completion|hold|status|blocker|scope-pressure|dispatch-ack) ;;
  *) exit 0 ;;
esac

REQUESTED_LIFECYCLE="$(dispatch_field_raw_value "$DESCRIPTION" "REQUESTED-LIFECYCLE" 2>/dev/null || true)"
REQUESTED_LIFECYCLE="$(printf '%s' "$REQUESTED_LIFECYCLE" | tr '[:upper:]' '[:lower:]')"

TASK_ID_FIELD_PRESENT="false"
TASK_ID_FROM_MESSAGE="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-ID" 2>/dev/null || true)"
if [[ -n "$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')" ]]; then
  TASK_ID_FIELD_PRESENT="true"
  TASK_ID="$(printf '%s' "$TASK_ID_FROM_MESSAGE" | tr -d '[:space:]')"
else
  TASK_ID="$(printf '%s' "$TASK_ID" | tr -d '[:space:]')"
fi

if [[ -z "$TASK_SUBJECT" ]]; then
  TASK_SUBJECT="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-SUBJECT" 2>/dev/null || true)"
fi

field_value() {
  local field_name="${1:?field required}"
  dispatch_field_raw_value "$DESCRIPTION" "$field_name" 2>/dev/null || true
}

has_field() {
  local field_name="${1:?field required}"
  [[ -n "$(printf '%s' "$(field_value "$field_name")" | tr -d '[:space:]')" ]]
}

OUTPUT_SURFACE_VALUE="$(field_value "OUTPUT-SURFACE")"
EVIDENCE_BASIS_VALUE="$(field_value "EVIDENCE-BASIS")"
OPEN_SURFACES_VALUE="$(field_value "OPEN-SURFACES")"
NEXT_LANE_VALUE="$(field_value "RECOMMENDED-NEXT-LANE")"
USER_RUN_PATH_VALUE="$(field_value "USER-RUN-PATH")"
BURDEN_CONTRACT_VALUE="$(printf '%s' "$(field_value "BURDEN-CONTRACT")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PROOF_SURFACE_MATCH_VALUE="$(printf '%s' "$(field_value "PROOF-SURFACE-MATCH")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RUN_PATH_STATUS_VALUE="$(printf '%s' "$(field_value "RUN-PATH-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
CORE_WORKFLOW_STATUS_VALUE="$(printf '%s' "$(field_value "CORE-WORKFLOW-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
INTERACTION_COVERAGE_STATUS_VALUE="$(printf '%s' "$(field_value "INTERACTION-COVERAGE-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
BURDEN_STATUS_VALUE="$(printf '%s' "$(field_value "BURDEN-STATUS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
ACCEPTANCE_RECONCILIATION_VALUE="$(printf '%s' "$(field_value "ACCEPTANCE-RECONCILIATION")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PLANNING_BASIS_VALUE="$(printf '%s' "$(field_value "PLANNING-BASIS")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
SV_PLAN_VERIFY_VALUE="$(printf '%s' "$(field_value "SV-PLAN-VERIFY")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
SELF_VERIFICATION_VALUE="$(printf '%s' "$(field_value "SELF-VERIFICATION")" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
CONVERGENCE_PASS_VALUE="$(printf '%s' "$(field_value "CONVERGENCE-PASS")" | tr -d '[:space:]')"

OUTPUT_SURFACE="false"
EVIDENCE_BASIS="false"
OPEN_SURFACES="false"
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
SV_PLAN_VERIFY="false"
SELF_VERIFICATION="false"
CONVERGENCE_PASS="false"

[[ -n "$(printf '%s' "$OUTPUT_SURFACE_VALUE" | tr -d '[:space:]')" ]] && OUTPUT_SURFACE="true"
[[ -n "$(printf '%s' "$EVIDENCE_BASIS_VALUE" | tr -d '[:space:]')" ]] && EVIDENCE_BASIS="true"
[[ -n "$(printf '%s' "$OPEN_SURFACES_VALUE" | tr -d '[:space:]')" ]] && OPEN_SURFACES="true"
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
[[ -n "$SV_PLAN_VERIFY_VALUE" ]] && SV_PLAN_VERIFY="true"
[[ -n "$SELF_VERIFICATION_VALUE" ]] && SELF_VERIFICATION="true"
[[ -n "$CONVERGENCE_PASS_VALUE" ]] && CONVERGENCE_PASS="true"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

LEDGER_LINE="$(REPORT_TIMESTAMP="$TIMESTAMP" REPORT_SESSION_ID="$SESSION_ID" REPORT_SENDER_NAME="$SENDER_NAME" REPORT_TEAM_NAME="$TEAM_NAME" REPORT_AGENT_TYPE="$AGENT_TYPE" REPORT_TASK_ID="$TASK_ID" REPORT_TASK_ID_FIELD_PRESENT="$TASK_ID_FIELD_PRESENT" REPORT_TASK_SUBJECT="$TASK_SUBJECT" REPORT_MESSAGE_CLASS="$MESSAGE_CLASS" REPORT_REQUESTED_LIFECYCLE="$REQUESTED_LIFECYCLE" REPORT_OUTPUT_SURFACE="$OUTPUT_SURFACE" REPORT_EVIDENCE_BASIS="$EVIDENCE_BASIS" REPORT_OPEN_SURFACES="$OPEN_SURFACES" REPORT_NEXT_LANE="$NEXT_LANE" REPORT_USER_RUN_PATH="$USER_RUN_PATH" REPORT_BURDEN_CONTRACT="$BURDEN_CONTRACT" REPORT_PROOF_SURFACE_MATCH="$PROOF_SURFACE_MATCH" REPORT_RUN_PATH_STATUS="$RUN_PATH_STATUS" REPORT_CORE_WORKFLOW_STATUS="$CORE_WORKFLOW_STATUS" REPORT_INTERACTION_COVERAGE_STATUS="$INTERACTION_COVERAGE_STATUS" REPORT_BURDEN_STATUS="$BURDEN_STATUS" REPORT_ACCEPTANCE_RECONCILIATION="$ACCEPTANCE_RECONCILIATION" REPORT_PLANNING_BASIS="$PLANNING_BASIS" REPORT_SV_PLAN_VERIFY="$SV_PLAN_VERIFY" REPORT_SELF_VERIFICATION="$SELF_VERIFICATION" REPORT_CONVERGENCE_PASS="$CONVERGENCE_PASS" REPORT_USER_RUN_PATH_VALUE="$USER_RUN_PATH_VALUE" REPORT_BURDEN_CONTRACT_VALUE="$BURDEN_CONTRACT_VALUE" REPORT_PROOF_SURFACE_MATCH_VALUE="$PROOF_SURFACE_MATCH_VALUE" REPORT_RUN_PATH_STATUS_VALUE="$RUN_PATH_STATUS_VALUE" REPORT_CORE_WORKFLOW_STATUS_VALUE="$CORE_WORKFLOW_STATUS_VALUE" REPORT_INTERACTION_COVERAGE_STATUS_VALUE="$INTERACTION_COVERAGE_STATUS_VALUE" REPORT_BURDEN_STATUS_VALUE="$BURDEN_STATUS_VALUE" REPORT_ACCEPTANCE_RECONCILIATION_VALUE="$ACCEPTANCE_RECONCILIATION_VALUE" REPORT_PLANNING_BASIS_VALUE="$PLANNING_BASIS_VALUE" REPORT_SV_PLAN_VERIFY_VALUE="$SV_PLAN_VERIFY_VALUE" REPORT_SELF_VERIFICATION_VALUE="$SELF_VERIFICATION_VALUE" REPORT_CONVERGENCE_PASS_VALUE="$CONVERGENCE_PASS_VALUE" node <<'NODE'
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
    evidenceBasis: process.env.REPORT_EVIDENCE_BASIS === "true",
    openSurfaces: process.env.REPORT_OPEN_SURFACES === "true",
    recommendedNextLane: process.env.REPORT_NEXT_LANE === "true",
    userRunPath: process.env.REPORT_USER_RUN_PATH === "true",
    burdenContract: process.env.REPORT_BURDEN_CONTRACT === "true",
    proofSurfaceMatch: process.env.REPORT_PROOF_SURFACE_MATCH === "true",
    runPathStatus: process.env.REPORT_RUN_PATH_STATUS === "true",
    coreWorkflowStatus: process.env.REPORT_CORE_WORKFLOW_STATUS === "true",
    interactionCoverageStatus: process.env.REPORT_INTERACTION_COVERAGE_STATUS === "true",
    burdenStatus: process.env.REPORT_BURDEN_STATUS === "true",
    acceptanceReconciliation: process.env.REPORT_ACCEPTANCE_RECONCILIATION === "true",
    planningBasis: process.env.REPORT_PLANNING_BASIS === "true",
    svPlanVerify: process.env.REPORT_SV_PLAN_VERIFY === "true",
    selfVerification: process.env.REPORT_SELF_VERIFICATION === "true",
    convergencePass: process.env.REPORT_CONVERGENCE_PASS === "true"
  },
  fieldValues: {
    userRunPath: process.env.REPORT_USER_RUN_PATH_VALUE || "",
    burdenContract: process.env.REPORT_BURDEN_CONTRACT_VALUE || "",
    proofSurfaceMatch: process.env.REPORT_PROOF_SURFACE_MATCH_VALUE || "",
    runPathStatus: process.env.REPORT_RUN_PATH_STATUS_VALUE || "",
    coreWorkflowStatus: process.env.REPORT_CORE_WORKFLOW_STATUS_VALUE || "",
    interactionCoverageStatus: process.env.REPORT_INTERACTION_COVERAGE_STATUS_VALUE || "",
    burdenStatus: process.env.REPORT_BURDEN_STATUS_VALUE || "",
    acceptanceReconciliation: process.env.REPORT_ACCEPTANCE_RECONCILIATION_VALUE || "",
    planningBasis: process.env.REPORT_PLANNING_BASIS_VALUE || "",
    svPlanVerify: process.env.REPORT_SV_PLAN_VERIFY_VALUE || "",
    selfVerification: process.env.REPORT_SELF_VERIFICATION_VALUE || "",
    convergencePass: process.env.REPORT_CONVERGENCE_PASS_VALUE || ""
  }
};
process.stdout.write(JSON.stringify(line));
NODE
)"

append_line_locked "$WORKER_REPORT_LEDGER_LOCK" "$WORKER_REPORT_LEDGER" "$LEDGER_LINE"

exit 0
