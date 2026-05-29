#!/usr/bin/env bash
set -euo pipefail

# Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
# (negative-only-filter doctrine: hooks block only destructive, security-critical, or
# session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
# owned by the exact failing owner path named in work-runtime-boundary-law, and
# downstream reviewer/validator independent gates remain intact).
# settings.json TaskCompleted matcher was removed; this file-level no-op handles
# already-started agents or local hook harness state that still attempts to fire the hook. File preserved for
# traceability and potential future narrowing to a negative-only filter.
exit 0

source "$(dirname "$0")/hook-config-core.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" WORKER_TRANSPORT_LEDGER="$WORKER_TRANSPORT_LEDGER" LOG_DIR="$LOG_DIR" SESSION_AGENT_MAP="$SESSION_AGENT_MAP" PENDING_AGENTS_FILE="$PENDING_AGENTS_FILE" PENDING_AGENT_MODES_FILE="$PENDING_AGENT_MODES_FILE" node <<'NODE'
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
    return { sessionId: "", wpTimestamp: "", resultVerificationPresent: false };
  }
  const wpMarker = path.join(logDir, `.wp-loaded-${resolvedSessionId}`);
  const resultVerificationMarker = path.join(logDir, `.sv-result-loaded-${resolvedSessionId}`);
  return {
    sessionId: resolvedSessionId,
    wpTimestamp: readIfExists(wpMarker),
    resultVerificationPresent: fs.existsSync(resultVerificationMarker)
  };
};

const markerStateScore = (state) => {
  if (!state) return 0;
  let score = 0;
  if (state.wpTimestamp) score += 1;
  if (state.resultVerificationPresent) score += 4;
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
  const workerSessionIdLookup = new Set(identityRows.map((row) => trimText(row && row.sessionId)).filter(Boolean));
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
  let transportRejectionReason = "";
  const ledgerPath = process.env.WORKER_TRANSPORT_LEDGER || "";
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
      if (!["completion", "hold|blocker", "hold", "blocker"].includes(messageClass)) continue;

      const parsedSessionId = trimText(parsed.sessionId || "");
      const parsedSenderName = trimText(parsed.senderName || "");
      const parsedTeamName = trimText(parsed.teamName || "");
      const parsedTaskId = trimText(parsed.taskId || "");
      const sameSession = parsedSessionId && candidateSessionIdLookup.has(parsedSessionId);
      const sameTeammate = parsedSenderName && candidateSenderNameLookup.has(normalize(parsedSenderName));
      const sameTeam = !teamName || !parsedTeamName || parsedTeamName === teamName;
      // When teammateName is absent (TaskCompleted event provides only session_id+task_id),
      // accept entries that exactly match the task_id — the session/sender filter cannot
      // resolve an agent identity and would otherwise skip all agent transport ledger entries.
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
  // Add taskIdAnchorMatch sessionId so evidenceState uses actual agent markers.
  // Avoid lead-session fallback for transport-before-planning checks.
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
    { sessionId: sessionId, wpTimestamp: "", resultVerificationPresent: false };
  const evidenceSender = normalize((latest && latest.senderName) || teammateName);
  const evidenceIsWorker = Boolean(
    (evidenceState.sessionId && workerSessionIdLookup.has(evidenceState.sessionId)) ||
    (evidenceSender && evidenceSender !== "team-lead")
  );

  if (
    latest &&
    evidenceState.wpTimestamp &&
    trimText(latest.timestamp || "") &&
    trimText(latest.timestamp || "") < evidenceState.wpTimestamp
  ) {
    latest = null;
    latestExactTask = null;
    latestFallback = null;
    transportRejectionReason = "transport-before-planning";
  }

  const fields = latest && latest.fields && typeof latest.fields === "object" ? latest.fields : {};
  const fieldValues = latest && latest.fieldValues && typeof latest.fieldValues === "object" ? latest.fieldValues : {};
  const missingFields = [];
  const requiredFieldMap = [
    ["outputSurface", "OUTPUT-SURFACE"],
    ["targetIntentBasis", "TARGET-INTENT-BASIS"],
    ["evidenceBasis", "EVIDENCE-BASIS"],
    ["openSurfaces", "OPEN-SURFACES"],
    ["frozenContractStatus", "FROZEN-CONTRACT-STATUS"],
    ["laneNextCandidate", "LANE-NEXT-CANDIDATE"],
    ["planningBasis", "PLANNING-BASIS-CONSUMPTION"],
    ["resourceCleanup", "RESOURCE-CLEANUP"],
    ["convergencePass", "CONVERGENCE-PASS"],
    ["laneLocalResultVerification", "LANE-LOCAL-RESULT-VERIFICATION"]
  ];
  for (const [key, label] of requiredFieldMap) {
    if (!fields[key]) missingFields.push(label);
  }
  const hasSubstantiveValue = value => {
    const normalized = normalize(value);
    return Boolean(normalized) && normalized !== "not-applicable";
  };
  const latestAgentType = normalize(latest ? latest.agentType : "");
  const claimsUserSurfaceProof =
    hasSubstantiveValue(fieldValues.userRunPath) ||
    hasSubstantiveValue(fieldValues.proofSurfaceMatch) ||
    hasSubstantiveValue(fieldValues.runPathStatus) ||
    hasSubstantiveValue(fieldValues.coreWorkflowStatus) ||
    hasSubstantiveValue(fieldValues.interactionCoverageStatus) ||
    hasSubstantiveValue(fieldValues.burdenStatus) ||
    hasSubstantiveValue(fieldValues.acceptanceReconciliation);
  if (claimsUserSurfaceProof) {
    const proofFieldMap = [
      ["userSurfaceProofMethod", "USER-SURFACE-PROOF-METHOD"],
      ["toolPathUsed", "TOOL-PATH-USED"],
      ["toolExecutionEvidence", "TOOL-EXECUTION-EVIDENCE"]
    ];
    for (const [key, label] of proofFieldMap) {
      if (!fields[key]) missingFields.push(label);
    }
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
    resultVerificationPresent: Boolean(evidenceState.resultVerificationPresent),
    exactTaskTransportPresent: Boolean(latestExactTask),
    explicitTaskIdFieldPresent: latest ? Boolean(latest.taskIdFieldPresent) : false,
    latestAgentType: latest ? String(latest.agentType || "") : "",
    latestMessageClass: latest ? String(latest.messageClass || "") : "",
    latestTimestamp: latest ? String(latest.timestamp || "") : "",
    openSurfacesValue: String(fieldValues.openSurfaces || ""),
    frozenContractStatusValue: String(fieldValues.frozenContractStatus || ""),
    userRunPathValue: String(fieldValues.userRunPath || ""),
    burdenContractValue: String(fieldValues.burdenContract || ""),
    proofSurfaceMatchValue: String(fieldValues.proofSurfaceMatch || ""),
    runPathStatusValue: String(fieldValues.runPathStatus || ""),
    coreWorkflowStatusValue: String(fieldValues.coreWorkflowStatus || ""),
    interactionCoverageStatusValue: String(fieldValues.interactionCoverageStatus || ""),
    burdenStatusValue: String(fieldValues.burdenStatus || ""),
    acceptanceReconciliationValue: String(fieldValues.acceptanceReconciliation || ""),
    planningBasisValue: String(fieldValues.planningBasis || ""),
    resourceCleanupValue: String(fieldValues.resourceCleanup || ""),
    userSurfaceProofMethodValue: String(fieldValues.userSurfaceProofMethod || ""),
    toolPathUsedValue: String(fieldValues.toolPathUsed || ""),
    toolExecutionEvidenceValue: String(fieldValues.toolExecutionEvidence || ""),
    convergencePassValue: String(fieldValues.convergencePass || ""),
    missingFields,
    identitySummary,
    transportRejectionReason,
    evidenceIsWorker
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
    resultVerificationPresent: false,
    exactTaskTransportPresent: false,
    explicitTaskIdFieldPresent: false,
    latestAgentType: "",
    latestMessageClass: "",
    latestTimestamp: "",
    openSurfacesValue: "",
    frozenContractStatusValue: "",
    userRunPathValue: "",
    burdenContractValue: "",
    proofSurfaceMatchValue: "",
    runPathStatusValue: "",
    coreWorkflowStatusValue: "",
    interactionCoverageStatusValue: "",
    burdenStatusValue: "",
    acceptanceReconciliationValue: "",
    planningBasisValue: "",
    resourceCleanupValue: "",
    userSurfaceProofMethodValue: "",
    toolPathUsedValue: "",
    toolExecutionEvidenceValue: "",
    convergencePassValue: "",
    missingFields: [],
    identitySummary: "",
    transportRejectionReason: "",
    evidenceIsWorker: false,
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
  parsed.resultVerificationPresent ? "true" : "false",
  parsed.exactTaskTransportPresent ? "true" : "false",
  parsed.explicitTaskIdFieldPresent ? "true" : "false",
  parsed.latestAgentType || "",
  parsed.latestMessageClass || "",
  parsed.openSurfacesValue || "",
  parsed.frozenContractStatusValue || "",
  parsed.userRunPathValue || "",
  parsed.burdenContractValue || "",
  parsed.proofSurfaceMatchValue || "",
  parsed.runPathStatusValue || "",
  parsed.coreWorkflowStatusValue || "",
  parsed.interactionCoverageStatusValue || "",
  parsed.burdenStatusValue || "",
  parsed.acceptanceReconciliationValue || "",
  parsed.planningBasisValue || "",
  parsed.resourceCleanupValue || "",
  parsed.userSurfaceProofMethodValue || "",
  parsed.toolPathUsedValue || "",
  parsed.toolExecutionEvidenceValue || "",
  parsed.convergencePassValue || "",
  Array.isArray(parsed.missingFields) ? parsed.missingFields.join(", ") : "",
  parsed.identitySummary || "",
  parsed.transportRejectionReason || "",
  parsed.evidenceIsWorker ? "true" : "false"
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
RESULT_VERIFICATION_PRESENT="${TASK_COMPLETED_FIELDS[6]-false}"
EXACT_TASK_TRANSPORT_PRESENT="${TASK_COMPLETED_FIELDS[7]-false}"
EXPLICIT_TASK_ID_FIELD_PRESENT="${TASK_COMPLETED_FIELDS[8]-false}"
LATEST_AGENT_TYPE="$(printf '%s' "${TASK_COMPLETED_FIELDS[9]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
LATEST_CLASS="${TASK_COMPLETED_FIELDS[10]-}"
OPEN_SURFACES_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[11]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
OPEN_SURFACES_NORM="$(printf '%s' "$OPEN_SURFACES_VALUE" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
FROZEN_CONTRACT_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[12]-}" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
USER_RUN_PATH_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[13]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
USER_RUN_PATH_NORM="$(printf '%s' "$USER_RUN_PATH_VALUE" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
BURDEN_CONTRACT_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[14]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PROOF_SURFACE_MATCH_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[15]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
RUN_PATH_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[16]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
CORE_WORKFLOW_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[17]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
INTERACTION_COVERAGE_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[18]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
BURDEN_STATUS_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[19]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
ACCEPTANCE_RECONCILIATION_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[20]-}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
PLANNING_BASIS_VALUE="${TASK_COMPLETED_FIELDS[21]-}"
RESOURCE_CLEANUP_VALUE="${TASK_COMPLETED_FIELDS[22]-}"
RESOURCE_CLEANUP_NORM="$(printf '%s' "$RESOURCE_CLEANUP_VALUE" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
USER_SURFACE_PROOF_METHOD_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[23]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
TOOL_PATH_USED_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[24]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
TOOL_EXECUTION_EVIDENCE_VALUE="$(printf '%s' "${TASK_COMPLETED_FIELDS[25]-}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
TOOL_STATEFUL_EVIDENCE_NORM="$(printf '%s\n%s' "$TOOL_PATH_USED_VALUE" "$TOOL_EXECUTION_EVIDENCE_VALUE" | tr '[:upper:]' '[:lower:]')"
CONVERGENCE_PASS_VALUE="${TASK_COMPLETED_FIELDS[26]-}"
MISSING_FIELDS="${TASK_COMPLETED_FIELDS[27]-}"
IDENTITY_SUMMARY="${TASK_COMPLETED_FIELDS[28]-}"
TRANSPORT_REJECTION_REASON="${TASK_COMPLETED_FIELDS[29]-}"
EVIDENCE_IS_WORKER="${TASK_COMPLETED_FIELDS[30]-false}"

FAILURES=()
WARNINGS=()

missing_field_present() {
  local field_name="${1:?field required}"
  [[ ", ${MISSING_FIELDS}, " == *", ${field_name}, "* ]]
}

if [[ -z "$SESSION_ID" && -z "$TEAMMATE_NAME" ]]; then
  FAILURES+=("Identity resolution failed. Cannot verify completion requirements.")
fi

if [[ -z "$WP_TIMESTAMP" && "$EVIDENCE_IS_WORKER" != "true" ]]; then
  FAILURES+=("No observed work-planning load for session ${EVIDENCE_SESSION_ID:-unknown}. Load work-planning via Skill first.")
fi

if [[ "$RESULT_VERIFICATION_PRESENT" != "true" ]]; then
  FAILURES+=("No observed self-verification sequence marker for session ${EVIDENCE_SESSION_ID:-unknown}. Load Skill(self-verification), run PASS-1 coverage and PASS-2 review-verification on the produced completion surface set, then retry completion.")
fi

if [[ -z "$LATEST_CLASS" ]]; then
  if [[ "$TRANSPORT_REJECTION_REASON" == "transport-before-planning" ]]; then
    FAILURES+=("Latest completion-grade transport predates planning evidence (${IDENTITY_SUMMARY}). Send fresh completion-grade transport after verification.")
  else
    FAILURES+=("No completion-grade transport matched agent identity (${IDENTITY_SUMMARY}). Send completion-grade Communication Plane transport to team-lead via SendMessage.")
  fi
fi

case "$LATEST_CLASS" in
  hold\|blocker)
    FAILURES+=("Latest transport is ${LATEST_CLASS}. Task must remain open until governing lane resolves it.")
    ;;
  hold)
    FAILURES+=("Latest transport uses legacy MESSAGE-CLASS '${LATEST_CLASS}'. Exact MESSAGE-CLASS: hold|blocker is required; task remains open until corrected.")
    ;;
  blocker)
    FAILURES+=("Latest transport uses legacy MESSAGE-CLASS '${LATEST_CLASS}'. Exact MESSAGE-CLASS: hold|blocker is required; task remains open until corrected.")
    ;;
  completion) ;;
  "") ;;
  *)
    FAILURES+=("Latest transport is '${LATEST_CLASS}', not a completion-grade transport.")
    ;;
esac

if [[ -n "$TASK_ID" && "$EXPLICIT_TASK_ID_FIELD_PRESENT" != "true" ]]; then
  FAILURES+=("Completion-grade transport envelope must carry TASK-ID field when task tracking is active.")
fi

if [[ -n "$TASK_ID" && "$EXACT_TASK_TRANSPORT_PRESENT" != "true" ]]; then
  FAILURES+=("Completion-grade transport envelope must carry matching TASK-ID: ${TASK_ID}.")
fi

if [[ -n "$MISSING_FIELDS" ]]; then
  for field_name in OUTPUT-SURFACE TARGET-INTENT-BASIS EVIDENCE-BASIS OPEN-SURFACES FROZEN-CONTRACT-STATUS LANE-NEXT-CANDIDATE PLANNING-BASIS-CONSUMPTION RESOURCE-CLEANUP CONVERGENCE-PASS LANE-LOCAL-RESULT-VERIFICATION USER-SURFACE-PROOF-METHOD TOOL-PATH-USED TOOL-EXECUTION-EVIDENCE; do
    if missing_field_present "$field_name"; then
      FAILURES+=("Missing completion-carrier safety field: ${field_name}.")
    fi
  done
fi

if [[ -z "$(printf '%s' "$PLANNING_BASIS_VALUE" | tr -d '[:space:]')" || "$(printf '%s' "$PLANNING_BASIS_VALUE" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')" == "loaded" ]]; then
  FAILURES+=("Completion carrier must provide PLANNING-BASIS-CONSUMPTION with loaded basis, applied planning rule, and decision impact, or blocked/not-applicable basis.")
fi

case "$FROZEN_CONTRACT_STATUS_VALUE" in
  matched|partial|drifted|blocked|not-assessable|not-applicable:*) ;;
  *)
    FAILURES+=("FROZEN-CONTRACT-STATUS must be matched|partial|drifted|blocked|not-assessable|not-applicable:<basis>.")
    ;;
esac

case "$OPEN_SURFACES_NORM" in
  ""|none|"[]"|"no open surfaces"|not-applicable:*)
    ;;
  *deferred*:*|*deferred*basis*|*out-of-scope*:*|*out-of-scope*basis*)
    ;;
  *)
    FAILURES+=("OPEN-SURFACES contains unresolved material work without explicit deferred/out-of-scope basis.")
    ;;
esac

case "$FROZEN_CONTRACT_STATUS_VALUE" in
  matched|not-applicable:*) ;;
  *)
    FAILURES+=("FROZEN-CONTRACT-STATUS is not closure-ready for TaskCompleted.")
    ;;
esac

case "$RESOURCE_CLEANUP_NORM" in
  complete*)
    if [[ "$RESOURCE_CLEANUP_NORM" == "complete" ]]; then
      FAILURES+=("RESOURCE-CLEANUP: complete must enumerate closed stateful resources and post-cleanup probe evidence.")
    fi
    case "$RESOURCE_CLEANUP_NORM" in
      *closed*|*released*|*probe*|*pid*|*port*|*browser*|*server*|*process*|*resource*) ;;
      *)
        FAILURES+=("RESOURCE-CLEANUP: complete must name the cleaned resource or release probe.")
        ;;
    esac
    ;;
  not-applicable*)
    case "$TOOL_STATEFUL_EVIDENCE_NORM" in
      *playwright*|*browser*|*server*|*localhost*|*127.0.0.1*|*pid*|*port*|*launch*)
        FAILURES+=("RESOURCE-CLEANUP: not-applicable is invalid when tool evidence shows browser/server/launch/process work.")
        ;;
    esac
    ;;
  *)
    FAILURES+=("Completion carrier must provide RESOURCE-CLEANUP: complete|not-applicable, with cleanup detail when stateful resources were opened.")
    ;;
esac

if ! [[ "$CONVERGENCE_PASS_VALUE" =~ ^[1-9][0-9]*$ ]]; then
  FAILURES+=("Completion carrier must provide CONVERGENCE-PASS as a positive integer.")
fi

if [[ "$LATEST_AGENT_TYPE" == "tester" || "$LATEST_AGENT_TYPE" == "validator" ]]; then
  if [[ -n "$BURDEN_CONTRACT_VALUE" ]]; then
    case "$BURDEN_CONTRACT_VALUE" in
      hands-off|low-touch|normal|not-applicable) ;;
      *)
        WARNINGS+=("When present, BURDEN-CONTRACT should be hands-off|low-touch|normal|not-applicable.")
        ;;
    esac
  fi

  case "$PROOF_SURFACE_MATCH_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    "")
      FAILURES+=("Tester/validator completion carrier omitted PROOF-SURFACE-MATCH.")
      ;;
    *)
      FAILURES+=("Tester/validator completion carrier used noncanonical PROOF-SURFACE-MATCH.")
      ;;
  esac

  case "$RUN_PATH_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    "")
      FAILURES+=("Tester/validator completion carrier omitted RUN-PATH-STATUS.")
      ;;
    *)
      FAILURES+=("Tester/validator completion carrier used noncanonical RUN-PATH-STATUS.")
      ;;
  esac

  case "$CORE_WORKFLOW_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    "")
      FAILURES+=("Tester/validator completion carrier omitted CORE-WORKFLOW-STATUS.")
      ;;
    *)
      FAILURES+=("Tester/validator completion carrier used noncanonical CORE-WORKFLOW-STATUS.")
      ;;
  esac

  case "$INTERACTION_COVERAGE_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    "")
      FAILURES+=("Tester/validator completion carrier omitted INTERACTION-COVERAGE-STATUS.")
      ;;
    *)
      FAILURES+=("Tester/validator completion carrier used noncanonical INTERACTION-COVERAGE-STATUS.")
      ;;
  esac

  case "$BURDEN_STATUS_VALUE" in
    matched|mismatched|blocked|missing|partial|not-applicable) ;;
    "")
      FAILURES+=("Tester/validator completion carrier omitted BURDEN-STATUS.")
      ;;
    *)
      FAILURES+=("Tester/validator completion carrier used noncanonical BURDEN-STATUS.")
      ;;
  esac

  if [[ "$LATEST_AGENT_TYPE" == "validator" ]]; then
    case "$ACCEPTANCE_RECONCILIATION_VALUE" in
      explicit|missing|not-applicable) ;;
      "")
        FAILURES+=("Validator completion carrier omitted ACCEPTANCE-RECONCILIATION.")
        ;;
      *)
        FAILURES+=("Validator completion carrier used noncanonical ACCEPTANCE-RECONCILIATION.")
        ;;
    esac
  fi

  if [[ "$RUN_PATH_STATUS_VALUE" != "not-applicable" && -z "$USER_RUN_PATH_VALUE" ]]; then
    FAILURES+=("Tester/validator executable or run-path status requires USER-RUN-PATH; use not-applicable only when run-path proof is outside the frozen surface.")
  fi
  if [[ "$BURDEN_STATUS_VALUE" != "not-applicable" && -z "$BURDEN_CONTRACT_VALUE" ]]; then
    FAILURES+=("Tester/validator burden status requires BURDEN-CONTRACT; use not-applicable only when operator burden is outside the frozen surface.")
  fi

  if [[ -n "$USER_RUN_PATH_VALUE" && "$USER_RUN_PATH_NORM" != "not-applicable" ]]; then
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
  FAILURE_MSG="TaskCompleted blocked for ${TEAMMATE_NAME:-agent} (${TASK_ID:-unknown-task}). ${#FAILURES[@]} issue(s) found:"
  for f in "${FAILURES[@]}"; do
    FAILURE_MSG+=$'\n'"  - $f"
  done
  deny_task_complete "$FAILURE_MSG"
fi

if [[ ${#WARNINGS[@]} -gt 0 ]]; then
  WARNING_MSG="TaskCompleted warning for ${TEAMMATE_NAME:-agent} (${TASK_ID:-unknown-task}). ${#WARNINGS[@]} issue(s) found:"
  for w in "${WARNINGS[@]}"; do
    WARNING_MSG+=$'\n'"  - $w"
  done
  printf '[%s] TASK-COMPLETED WARNING: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$WARNING_MSG" >> "$VIOLATION_LOG"
fi

exit 0
