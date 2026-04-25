#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" LOG_DIR="$LOG_DIR" SESSION_AGENT_MAP="$SESSION_AGENT_MAP" PENDING_AGENTS_FILE="$PENDING_AGENTS_FILE" PENDING_AGENT_MODES_FILE="$PENDING_AGENT_MODES_FILE" node <<'NODE'
const fs = require("fs");
const path = require("path");

const readTextIfExists = (filePath) => {
  try {
    return fs.readFileSync(filePath, "utf8");
  } catch {
    return "";
  }
};

const readIfExists = (filePath) => readTextIfExists(filePath).trim();
const trimText = (value) => String(value || "").trim();
const normalize = (value) => trimText(value).toLowerCase();

const addTrimmed = (targetSet, value) => {
  const trimmed = trimText(value);
  if (trimmed) targetSet.add(trimmed);
};

const parseSessionMapRows = (filePath) => {
  const rows = [];
  const content = readTextIfExists(filePath);
  if (!content) return rows;
  for (const line of content.split(/\r?\n/)) {
    const trimmed = trimText(line);
    if (!trimmed) continue;
    const [sessionId = "", name = ""] = trimmed.split(/\s+/, 2);
    if (!sessionId || !name) continue;
    rows.push({ sessionId: trimText(sessionId), name: trimText(name) });
  }
  return rows;
};

const parseClaimedPendingRows = (filePath, statusIndex) => {
  const rows = [];
  const content = readTextIfExists(filePath);
  if (!content) return rows;
  for (const line of content.split(/\r?\n/)) {
    const trimmed = trimText(line);
    if (!trimmed) continue;
    const parts = trimmed.split(/\s*\|\s*/);
    const name = trimText(parts[1] || "");
    const status = trimText(parts[statusIndex] || "");
    if (!name || !status.startsWith("CLAIMED:")) continue;
    const sessionId = trimText(status.slice("CLAIMED:".length));
    if (!sessionId) continue;
    rows.push({ sessionId, name });
  }
  return rows;
};

const markerStateForSession = (sessionId, logDir) => {
  const resolvedSessionId = trimText(sessionId);
  if (!resolvedSessionId) {
    return { sessionId: "", wpTimestamp: "", svPlanPresent: false, svResultPresent: false };
  }
  const wpMarker = path.join(logDir, `.wp-loaded-${resolvedSessionId}`);
  const svPlanMarker = path.join(logDir, `.sv-plan-loaded-${resolvedSessionId}`);
  const svResultMarker = path.join(logDir, `.sv-result-loaded-${resolvedSessionId}`);
  return {
    sessionId: resolvedSessionId,
    wpTimestamp: readIfExists(wpMarker),
    svPlanPresent: fs.existsSync(svPlanMarker),
    svResultPresent: fs.existsSync(svResultMarker)
  };
};

const markerStateScore = (state) => {
  if (!state) return 0;
  let score = 0;
  if (state.wpTimestamp) score += 1;
  if (state.svPlanPresent) score += 2;
  if (state.svResultPresent) score += 4;
  return score;
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const sessionId = trimText(input.session_id || "");
  const teammateName = trimText(input.teammate_name || "");
  const teamName = trimText(input.team_name || "");
  const taskId = trimText(input.task_id || "");
  const taskSubject = trimText(input.task_subject || "");

  const logDir = process.env.LOG_DIR || "";
  const sessionMapRows = parseSessionMapRows(process.env.SESSION_AGENT_MAP || "");
  const pendingAgentRows = parseClaimedPendingRows(process.env.PENDING_AGENTS_FILE || "", 2);
  const pendingModeRows = parseClaimedPendingRows(process.env.PENDING_AGENT_MODES_FILE || "", 3);
  const identityRows = sessionMapRows.concat(pendingAgentRows, pendingModeRows);
  const candidateSessionIdsSet = new Set();
  const candidateSenderNamesSet = new Set();

  addTrimmed(candidateSessionIdsSet, sessionId);
  addTrimmed(candidateSenderNamesSet, teammateName);

  for (const row of identityRows) {
    const rowSessionId = trimText(row && row.sessionId);
    const rowName = trimText(row && row.name);
    if (!rowSessionId || !rowName) continue;
    if (sessionId && rowSessionId === sessionId) {
      addTrimmed(candidateSenderNamesSet, rowName);
    }
    if (teammateName && normalize(rowName) === normalize(teammateName)) {
      addTrimmed(candidateSessionIdsSet, rowSessionId);
    }
  }

  const candidateSessionIds = Array.from(candidateSessionIdsSet);
  const candidateSenderNames = Array.from(candidateSenderNamesSet);
  const candidateSessionIdLookup = new Set(candidateSessionIds);
  const candidateSenderNameLookup = new Set(candidateSenderNames.map(normalize).filter(Boolean));

  let latest = null;
  let latestExactTask = null;
  let latestFallback = null;
  let reportRejectionReason = "";
  const ledgerPath = process.env.WORKER_REPORT_LEDGER || "";
  if (ledgerPath && fs.existsSync(ledgerPath)) {
    const lines = fs.readFileSync(ledgerPath, "utf8").split(/\r?\n/).filter(Boolean);
    for (const line of lines) {
      let parsed;
      try {
        parsed = JSON.parse(line);
      } catch {
        continue;
      }
      if (!parsed || typeof parsed !== "object") continue;
      const messageClass = String(parsed.messageClass || "").toLowerCase();
      if (!["handoff", "completion", "hold"].includes(messageClass)) continue;

      const parsedSessionId = trimText(parsed.sessionId || "");
      const parsedSenderName = trimText(parsed.senderName || "");
      const parsedTeamName = trimText(parsed.teamName || "");
      const parsedTaskId = trimText(parsed.taskId || "");
      const sameSession = parsedSessionId && candidateSessionIdLookup.has(parsedSessionId);
      const sameTeammate = parsedSenderName && candidateSenderNameLookup.has(normalize(parsedSenderName));
      const sameTeam = !teamName || !parsedTeamName || parsedTeamName === teamName;
      // When teammateName is absent (TaskCompleted event provides only session_id+task_id),
      // accept entries that exactly match the task_id — the session/sender filter cannot
      // resolve a worker identity and would otherwise skip all worker ledger entries.
      // When teammateName IS provided the stricter session+sender guard still applies.
      const taskIdAnchorMatch = !teammateName && taskId && parsedTaskId === taskId;
      if (!sameSession && !(sameTeammate && sameTeam) && !taskIdAnchorMatch) continue;

      const timestamp = String(parsed.timestamp || "");
      const matchesExplicitTask = taskId && parsedTaskId && parsedTaskId === taskId;
      const hasConflictingExplicitTask = taskId && parsedTaskId && parsedTaskId !== taskId;

      if (matchesExplicitTask) {
        if (!latestExactTask || timestamp >= String(latestExactTask.timestamp || "")) {
          latestExactTask = parsed;
        }
        continue;
      }

      if (hasConflictingExplicitTask) {
        continue;
      }

      if (!latestFallback || timestamp >= String(latestFallback.timestamp || "")) {
        latestFallback = parsed;
      }
    }
  }

  latest = latestExactTask || latestFallback;
  // When teammateName is absent and the entry was found via taskIdAnchorMatch,
  // the matched entry's sessionId is the worker's session — it is not in
  // candidateSessionIds (which only contains the lead's session from the event).
  // Include it here so evidenceState resolves to the actual worker session markers
  // rather than falling back to the lead's session and rejecting the report as
  // "report-before-planning" due to the lead's WP timestamp post-dating the report.
  const taskIdAnchorSession = (!teammateName && latestExactTask)
    ? trimText(latestExactTask.sessionId || "")
    : "";
  const markerSessionIds = candidateSessionIds.slice();
  if (taskIdAnchorSession && !candidateSessionIdLookup.has(taskIdAnchorSession)) {
    markerSessionIds.push(taskIdAnchorSession);
  }
  const markerStates = (markerSessionIds.length ? markerSessionIds : [sessionId])
    .map((candidateSessionId) => markerStateForSession(candidateSessionId, logDir));
  const preferredEvidenceSessionId = trimText((latest && latest.sessionId) || sessionId);
  const sortedMarkerStates = markerStates
    .slice()
    .sort((left, right) => {
      const scoreDelta = markerStateScore(right) - markerStateScore(left);
      if (scoreDelta !== 0) return scoreDelta;
      const tsLeft = trimText(left && left.wpTimestamp);
      const tsRight = trimText(right && right.wpTimestamp);
      if (tsLeft === tsRight) return 0;
      return tsRight.localeCompare(tsLeft);
    });
  const evidenceState =
    markerStates.find((state) => state.sessionId && state.sessionId === preferredEvidenceSessionId) ||
    sortedMarkerStates[0] ||
    { sessionId: sessionId, wpTimestamp: "", svPlanPresent: false, svResultPresent: false };

  if (
    latest &&
    evidenceState.wpTimestamp &&
    trimText(latest.timestamp || "") &&
    trimText(latest.timestamp || "") < evidenceState.wpTimestamp
  ) {
    latest = null;
    latestExactTask = null;
    latestFallback = null;
    reportRejectionReason = "report-before-planning";
  }

  const fields = latest && latest.fields && typeof latest.fields === "object" ? latest.fields : {};
  const fieldValues = latest && latest.fieldValues && typeof latest.fieldValues === "object" ? latest.fieldValues : {};
  const missingFields = [];
  const requiredFieldMap = [
    ["outputSurface", "OUTPUT-SURFACE"],
    ["evidenceBasis", "EVIDENCE-BASIS"],
    ["openSurfaces", "OPEN-SURFACES"],
    ["recommendedNextLane", "RECOMMENDED-NEXT-LANE"],
    ["planningBasis", "PLANNING-BASIS"],
    ["svPlanVerify", "SV-PLAN-VERIFY"],
    ["selfVerification", "SELF-VERIFICATION"],
    ["convergencePass", "CONVERGENCE-PASS"]
  ];
  for (const [key, label] of requiredFieldMap) {
    if (!fields[key]) missingFields.push(label);
  }
  if (!latest || !String(latest.requestedLifecycle || "").trim()) {
    missingFields.push("REQUESTED-LIFECYCLE");
  }
  const identitySummary = `sessions=${candidateSessionIds.join(",") || "none"}; senders=${candidateSenderNames.join(",") || "none"}; evidence=${trimText(evidenceState.sessionId || "") || "none"}`;

  const result = {
    sessionId,
    teammateName,
    teamName,
    taskId,
    taskSubject,
    evidenceSessionId: trimText(evidenceState.sessionId || ""),
    wpTimestamp: trimText(evidenceState.wpTimestamp || ""),
    svPlanPresent: Boolean(evidenceState.svPlanPresent),
    svResultPresent: Boolean(evidenceState.svResultPresent),
    exactTaskReportPresent: Boolean(latestExactTask),
    explicitTaskIdFieldPresent: latest ? Boolean(latest.taskIdFieldPresent) : false,
    latestAgentType: latest ? String(latest.agentType || "") : "",
    latestMessageClass: latest ? String(latest.messageClass || "") : "",
    latestTimestamp: latest ? String(latest.timestamp || "") : "",
    userRunPathValue: String(fieldValues.userRunPath || ""),
    burdenContractValue: String(fieldValues.burdenContract || ""),
    proofSurfaceMatchValue: String(fieldValues.proofSurfaceMatch || ""),
    runPathStatusValue: String(fieldValues.runPathStatus || ""),
    coreWorkflowStatusValue: String(fieldValues.coreWorkflowStatus || ""),
    interactionCoverageStatusValue: String(fieldValues.interactionCoverageStatus || ""),
    burdenStatusValue: String(fieldValues.burdenStatus || ""),
    acceptanceReconciliationValue: String(fieldValues.acceptanceReconciliation || ""),
    planningBasisValue: String(fieldValues.planningBasis || ""),
    svPlanVerifyValue: String(fieldValues.svPlanVerify || ""),
    selfVerificationValue: String(fieldValues.selfVerification || ""),
    convergencePassValue: String(fieldValues.convergencePass || ""),
    missingFields,
    identitySummary,
    reportRejectionReason
  };

  process.stdout.write(JSON.stringify(result));
} catch (error) {
  process.stdout.write(JSON.stringify({
    sessionId: "",
    teammateName: "",
    teamName: "",
    taskId: "",
    taskSubject: "",
    evidenceSessionId: "",
    wpTimestamp: "",
    svPlanPresent: false,
    svResultPresent: false,
    exactTaskReportPresent: false,
    explicitTaskIdFieldPresent: false,
    latestAgentType: "",
    latestMessageClass: "",
    latestTimestamp: "",
    userRunPathValue: "",
    burdenContractValue: "",
    proofSurfaceMatchValue: "",
    runPathStatusValue: "",
    coreWorkflowStatusValue: "",
    interactionCoverageStatusValue: "",
    burdenStatusValue: "",
    acceptanceReconciliationValue: "",
    planningBasisValue: "",
    svPlanVerifyValue: "",
    selfVerificationValue: "",
    convergencePassValue: "",
    missingFields: [],
    identitySummary: "",
    reportRejectionReason: "",
    parseError: String(error && error.message || error)
  }));
}
NODE
)"

deny_task_complete() {
  local reason="${1:?reason required}"
  printf '[%s] TASK-COMPLETED BLOCKED: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" >> "$VIOLATION_LOG"
  printf '%s\n' "$reason" >&2
  exit 1
}

mapfile -d '' -t TASK_COMPLETED_FIELDS < <(
  RESULT_JSON="$PARSED" node <<'NODE'
const parsed = JSON.parse(process.env.RESULT_JSON || "{}");
const fieldValues = [
  parsed.sessionId || "",
  parsed.teammateName || "",
  parsed.taskId || "",
  parsed.taskSubject || "",
  parsed.evidenceSessionId || "",
  parsed.wpTimestamp || "",
  parsed.svPlanPresent ? "true" : "false",
  parsed.svResultPresent ? "true" : "false",
  parsed.exactTaskReportPresent ? "true" : "false",
  parsed.explicitTaskIdFieldPresent ? "true" : "false",
  parsed.latestAgentType || "",
  parsed.latestMessageClass || "",
  parsed.userRunPathValue || "",
  parsed.burdenContractValue || "",
  parsed.proofSurfaceMatchValue || "",
  parsed.runPathStatusValue || "",
  parsed.coreWorkflowStatusValue || "",
  parsed.interactionCoverageStatusValue || "",
  parsed.burdenStatusValue || "",
  parsed.acceptanceReconciliationValue || "",
  parsed.planningBasisValue || "",
  parsed.svPlanVerifyValue || "",
  parsed.selfVerificationValue || "",
  parsed.convergencePassValue || "",
  Array.isArray(parsed.missingFields) ? parsed.missingFields.join(", ") : "",
  parsed.identitySummary || "",
  parsed.reportRejectionReason || ""
];

for (const value of fieldValues) {
  process.stdout.write(String(value) + "\0");
}
NODE
)

SESSION_ID="${TASK_COMPLETED_FIELDS[0]-}"
TEAMMATE_NAME="${TASK_COMPLETED_FIELDS[1]-}"
TASK_ID="${TASK_COMPLETED_FIELDS[2]-}"
TASK_SUBJECT="${TASK_COMPLETED_FIELDS[3]-}"
EVIDENCE_SESSION_ID="${TASK_COMPLETED_FIELDS[4]-}"
WP_TIMESTAMP="${TASK_COMPLETED_FIELDS[5]-}"
SV_PLAN_PRESENT="${TASK_COMPLETED_FIELDS[6]-false}"
SV_RESULT_PRESENT="${TASK_COMPLETED_FIELDS[7]-false}"
EXACT_TASK_REPORT_PRESENT="${TASK_COMPLETED_FIELDS[8]-false}"
EXPLICIT_TASK_ID_FIELD_PRESENT="${TASK_COMPLETED_FIELDS[9]-false}"
LATEST_AGENT_TYPE="$(printf '%s' "${TASK_COMPLETED_FIELDS[10]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
LATEST_CLASS="${TASK_COMPLETED_FIELDS[11]-}"
USER_RUN_PATH_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[12]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
BURDEN_CONTRACT_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[13]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PROOF_SURFACE_MATCH_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[14]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RUN_PATH_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[15]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
CORE_WORKFLOW_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[16]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
INTERACTION_COVERAGE_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[17]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
BURDEN_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[18]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
ACCEPTANCE_RECONCILIATION_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[19]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PLANNING_BASIS_VALUE="${TASK_COMPLETED_FIELDS[20]-}"
SV_PLAN_VERIFY_VALUE="${TASK_COMPLETED_FIELDS[21]-}"
SELF_VERIFICATION_VALUE="${TASK_COMPLETED_FIELDS[22]-}"
CONVERGENCE_PASS_VALUE="${TASK_COMPLETED_FIELDS[23]-}"
MISSING_FIELDS="${TASK_COMPLETED_FIELDS[24]-}"
IDENTITY_SUMMARY="${TASK_COMPLETED_FIELDS[25]-}"
REPORT_REJECTION_REASON="${TASK_COMPLETED_FIELDS[26]-}"

FAILURES=()

if [[ -z "$SESSION_ID" && -z "$TEAMMATE_NAME" ]]; then
  FAILURES+=("Identity resolution failed. Cannot verify completion requirements.")
fi

if [[ -z "$WP_TIMESTAMP" ]]; then
  FAILURES+=("No observed work-planning load for session ${EVIDENCE_SESSION_ID:-unknown}. Load work-planning via Skill first.")
fi

if [[ "$SV_PLAN_PRESENT" != "true" ]]; then
  FAILURES+=("No post-planning self-verification marker for session ${EVIDENCE_SESSION_ID:-unknown}. Load self-verification and challenge the plan.")
fi

if [[ "$SV_RESULT_PRESENT" != "true" ]]; then
  FAILURES+=("No Phase 2 self-verification marker for session ${EVIDENCE_SESSION_ID:-unknown}. Load self-verification, verify results.")
fi

if [[ -z "$LATEST_CLASS" ]]; then
  if [[ "$REPORT_REJECTION_REASON" == "report-before-planning" ]]; then
    FAILURES+=("Latest completion-grade report predates planning evidence (${IDENTITY_SUMMARY}). Send fresh report after verification.")
  else
    FAILURES+=("No completion-grade report matched worker identity (${IDENTITY_SUMMARY}). Send a report to team-lead via SendMessage.")
  fi
fi

case "$LATEST_CLASS" in
  hold)
    FAILURES+=("Latest report is HOLD. Task must remain open until governing lane resolves it.")
    ;;
  handoff|completion|"") ;;
  *)
    FAILURES+=("Latest report is '${LATEST_CLASS}', not a completion-grade report.")
    ;;
esac

if [[ "$EXPLICIT_TASK_ID_FIELD_PRESENT" != "true" ]]; then
  FAILURES+=("Completion-grade report must carry TASK-ID field.")
fi

if [[ -n "$TASK_ID" && "$EXACT_TASK_REPORT_PRESENT" != "true" ]]; then
  FAILURES+=("Report must carry matching TASK-ID: ${TASK_ID}.")
fi

if [[ -n "$MISSING_FIELDS" ]]; then
  FAILURES+=("Missing required fields: ${MISSING_FIELDS}.")
fi

if [[ "$PLANNING_BASIS_VALUE" != "loaded" ]]; then
  FAILURES+=("Report must carry PLANNING-BASIS: loaded.")
fi

if [[ "$SV_PLAN_VERIFY_VALUE" != "done" ]]; then
  FAILURES+=("Report must carry SV-PLAN-VERIFY: done.")
fi

if [[ "$SELF_VERIFICATION_VALUE" != "converged" ]]; then
  FAILURES+=("Report must carry SELF-VERIFICATION: converged.")
fi

case "$CONVERGENCE_PASS_VALUE" in
  1|2|3) ;;
  *)
    FAILURES+=("Report must carry CONVERGENCE-PASS: 1|2|3.")
    ;;
esac

if [[ "$LATEST_AGENT_TYPE" == "tester" || "$LATEST_AGENT_TYPE" == "validator" ]]; then
  if [[ -z "$USER_RUN_PATH_VALUE" ]]; then
    FAILURES+=("Tester/validator report must carry USER-RUN-PATH.")
  fi

  case "$BURDEN_CONTRACT_VALUE" in
    hands-off|low-touch|normal|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry BURDEN-CONTRACT: hands-off|low-touch|normal|not-applicable.")
      ;;
  esac

  case "$PROOF_SURFACE_MATCH_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry PROOF-SURFACE-MATCH: matched|mismatched|blocked|missing|partial|not-applicable.")
      ;;
  esac

  case "$RUN_PATH_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry RUN-PATH-STATUS: matched|mismatched|blocked|missing|partial|not-applicable.")
      ;;
  esac

  case "$CORE_WORKFLOW_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry CORE-WORKFLOW-STATUS: matched|mismatched|blocked|missing|partial|not-applicable.")
      ;;
  esac

  case "$INTERACTION_COVERAGE_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry INTERACTION-COVERAGE-STATUS: matched|mismatched|blocked|missing|partial|not-applicable.")
      ;;
  esac

  case "$BURDEN_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    *)
      FAILURES+=("Tester/validator report must carry BURDEN-STATUS: matched|mismatched|blocked|missing|partial|not-applicable.")
      ;;
  esac

  if [[ "$LATEST_AGENT_TYPE" == "validator" ]]; then
    case "$ACCEPTANCE_RECONCILIATION_VALUE" in
      explicit|missing|not-applicable) ;;
      *)
        FAILURES+=("Validator report must carry ACCEPTANCE-RECONCILIATION: explicit|missing|not-applicable.")
        ;;
    esac
  fi

  if [[ -n "$USER_RUN_PATH_VALUE" && "$(printf '%s' "$USER_RUN_PATH_VALUE" | tr '[:upper:]' '[:lower:]')" != "not-applicable" ]]; then
    if [[ "$PROOF_SURFACE_MATCH_VALUE" != "matched" ]]; then
      FAILURES+=("User-run-path proof is not matched. Keep the task open until proof matches the promised delivery surface.")
    fi
    if [[ "$RUN_PATH_STATUS_VALUE" != "matched" ]]; then
      FAILURES+=("User-run-path status is not matched. Keep the task open until the promised run path is directly proven.")
    fi
    if [[ "$CORE_WORKFLOW_STATUS_VALUE" != "matched" ]]; then
      FAILURES+=("Core workflow status is not matched. Keep the task open until the promised user workflow is directly proven.")
    fi
    case "$INTERACTION_COVERAGE_STATUS_VALUE" in
      matched|not-applicable) ;;
      *)
        FAILURES+=("Interaction coverage is not matched. Keep the task open until in-scope controls are proven or explicitly not-applicable.")
        ;;
    esac
    case "$BURDEN_STATUS_VALUE" in
      matched|not-applicable) ;;
      *)
        FAILURES+=("Burden status is not matched. Keep the task open until the promised hands-off/low-touch delivery burden is met.")
        ;;
    esac
    if [[ "$LATEST_AGENT_TYPE" == "validator" && "$ACCEPTANCE_RECONCILIATION_VALUE" != "explicit" ]]; then
      FAILURES+=("Validator must explicitly reconcile delivery experience, user-readiness, and interaction coverage before completion.")
    fi
  fi
fi

if [[ ${#FAILURES[@]} -gt 0 ]]; then
  FAILURE_MSG="TaskCompleted blocked for ${TEAMMATE_NAME:-worker} (${TASK_ID:-unknown-task}). ${#FAILURES[@]} issue(s) found:"
  for f in "${FAILURES[@]}"; do
    FAILURE_MSG+=$'\n'"  - $f"
  done
  deny_task_complete "$FAILURE_MSG"
fi

exit 0
