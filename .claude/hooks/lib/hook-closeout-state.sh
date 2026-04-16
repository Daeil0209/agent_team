#!/usr/bin/env bash
# Closeout lifecycle state machine — split from hook-runtime-state.sh
# Sourced via hook-config.sh, do not execute directly.

CLOSEOUT_AUDIT_LOG="${CLOSEOUT_AUDIT_LOG:-$HOME/.claude/logs/closeout-audit.log}"

closeout_intent_is_active() {
  local expected_session_id="${1-}"
  local active_value=""

  active_value="$(get_closeout_state_field active "$expected_session_id")"
  [[ "$active_value" == "true" ]]
}

session_has_only_operational_activity() {
  local session_id="${1-}"

  [[ -n "$session_id" ]] || return 1
  [[ -f "$ACTIVITY_LEDGER" ]] || return 1

  awk -F' \\| ' -v sid="$session_id" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    function allowed_bash(tool, command) {
      if (tool !~ /^Bash:/) {
        return 0
      }

      command = tool
      sub(/^Bash:/, "", command)

      if (command ~ /[>|;&]/ || command ~ /(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)/) {
        return 0
      }
      if (command ~ /(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push|pull)([[:space:]]|$)/) {
        return 0
      }
      if (command ~ /(^|[[:space:]])sed[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]])perl[[:space:]]+-i([[:space:]]|$)/) {
        return 0
      }

      return command ~ /^(pwd|echo[[:space:]]+\$HOME|find[[:space:]]|sort[[:space:]]|rg[[:space:]]|grep[[:space:]]|ls([[:space:]]|$)|cat[[:space:]]|head[[:space:]]|tail[[:space:]]|wc[[:space:]]|nl[[:space:]]|sed[[:space:]]+-n[[:space:]]|bash[[:space:]]+-n[[:space:]]|git[[:space:]]+status([[:space:]]|$)|git[[:space:]]+diff[[:space:]]+--(stat|name-only|name-status)([[:space:]]|$)|git[[:space:]]+log[[:space:]]|git[[:space:]]+show[[:space:]])/
    }
    function allowed(tool) {
      if (tool ~ /^Bash:/) {
        return allowed_bash(tool)
      }
      return tool == "Read" \
        || tool == "ToolSearch" \
        || tool == "Grep" \
        || tool == "Glob" \
        || tool == "TeamCreate" \
        || tool == "CronCreate" \
        || tool == "CronDelete" \
        || tool == "TeamDelete"
    }
    {
      current_session = trim($2)
      if (current_session != sid) {
        next
      }

      tool = trim($5)
      seen = 1

      if (tool == "" || !allowed(tool)) {
        blocked = 1
        exit
      }
    }
    END {
      exit (seen && !blocked) ? 0 : 1
    }
  ' "$ACTIVITY_LEDGER"
}

closeout_continuity_file_path() {
  effective_continuity_file_path
}

current_closeout_continuity_state() {
  local state_file=""

  state_file="$(closeout_continuity_file_path)"
  continuity_file_state "$state_file"
}

closeout_validation_owner_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field validationOwnerState "$expected_session_id" "unknown"
}

closeout_acceptance_evidence_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field acceptanceEvidenceState "$expected_session_id" "unknown"
}

closeout_supervisor_review_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field supervisorReviewState "$expected_session_id" "not-needed"
}

closeout_not_needed_reason() {
  local expected_session_id="${1-}"
  get_closeout_state_field closeoutNotNeededReason "$expected_session_id" ""
}

closeout_not_needed_reason_allowed() {
  case "${1-}" in
    operational-only|no-acceptance-surface) return 0 ;;
    *) return 1 ;;
  esac
}

closeout_continuity_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field continuityState "$expected_session_id" "$(current_closeout_continuity_state)"
}

closeout_hold_reason() {
  local expected_session_id="${1-}"
  get_closeout_state_field holdReason "$expected_session_id" ""
}

# Corroborating continuity evidence only: scan session-state.md for validator
# PASS hints. This supports hold diagnostics but does not authorize teardown.
detect_validator_pass_in_session_state() {
  local session_state_file=""
  session_state_file="$(closeout_continuity_file_path)"
  [[ -f "$session_state_file" ]] || return 1
  # Look for validator PASS pattern in session state handoff blocks
  grep -qiE '(VERDICT|ACCEPTANCE|VALIDATION)[[:space:]]*:[[:space:]]*(PASS|passed)' "$session_state_file" 2>/dev/null
}

closeout_teardown_governance_ready() {
  local expected_session_id="${1-}"
  local validation_state=""
  local evidence_state=""
  local not_needed_reason=""
  local pass_hint="no-validator-pass"

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"
  not_needed_reason="$(closeout_not_needed_reason "$expected_session_id")"

  if [[ "$validation_state" == "not-needed" || "$evidence_state" == "not-needed" ]]; then
    if ! closeout_not_needed_reason_allowed "$not_needed_reason"; then
      if detect_validator_pass_in_session_state; then
        pass_hint="validator-pass-present-use-evidence-present"
      fi
      printf '%s | BLOCK | closeout-cross-verify | not-needed without allowed reason | validation=%s | evidence=%s | reason=%s | hint=%s | session=%s\n' \
        "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$validation_state" "$evidence_state" "${not_needed_reason:-missing}" "$pass_hint" "${expected_session_id:-unknown}" \
        >> "${CLOSEOUT_AUDIT_LOG:-$HOME/.claude/logs/closeout-audit.log}" 2>/dev/null || true
      return 1
    fi
  fi

  [[ "$validation_state" == "assigned" || "$validation_state" == "not-needed" ]] \
    && [[ "$evidence_state" == "present" || "$evidence_state" == "not-needed" ]]
}

closeout_unresolved_governance_present() {
  local expected_session_id="${1-}"
  local validation_state=""
  local evidence_state=""
  local supervisor_state=""
  local not_needed_reason=""

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"
  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"
  not_needed_reason="$(closeout_not_needed_reason "$expected_session_id")"

  if [[ "$validation_state" == "not-needed" || "$evidence_state" == "not-needed" ]]; then
    if ! closeout_not_needed_reason_allowed "$not_needed_reason"; then
      return 0
    fi
  fi

  [[ "$validation_state" == "missing" || "$validation_state" == "unknown" ]] \
    || [[ "$evidence_state" == "missing" || "$evidence_state" == "unknown" ]] \
    || [[ "$supervisor_state" == "required" || "$supervisor_state" == "missing" || "$supervisor_state" == "unknown" ]]
}

closeout_governance_complete() {
  local expected_session_id="${1-}"
  local supervisor_state=""
  local continuity_state=""

  closeout_clean_pre_sessionend_ready "$expected_session_id" || return 1

  continuity_state="$(closeout_continuity_state "$expected_session_id")"
  [[ "$continuity_state" == "current" || "$continuity_state" == "captured-clean" || "$continuity_state" == "captured-with-warnings" ]]
}

closeout_clean_pre_sessionend_ready() {
  local expected_session_id="${1-}"
  local supervisor_state=""

  current_runtime_workers_drained || return 1
  [[ ! -s "$HEALTH_CRON_JOB_FILE" ]] || return 1
  [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] || return 1
  closeout_teardown_governance_ready "$expected_session_id" || return 1

  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"
  [[ "$supervisor_state" == "completed" || "$supervisor_state" == "not-needed" ]] || return 1
}

closeout_hold_pre_stop_ready() {
  local expected_session_id="${1-}"
  local hold_reason=""

  current_runtime_workers_drained || return 1
  [[ ! -s "$HEALTH_CRON_JOB_FILE" ]] || return 1
  [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] || return 1
  closeout_unresolved_governance_present "$expected_session_id" || return 1

  hold_reason="$(closeout_hold_reason "$expected_session_id")"
  [[ -n "$hold_reason" ]]
}

closeout_cleanup_eligibility() {
  local expected_session_id="${1-}"
  local continuity_state=""

  continuity_state="$(closeout_continuity_state "$expected_session_id")"

  if closeout_governance_complete "$expected_session_id" && [[ "$continuity_state" == "captured-clean" || "$continuity_state" == "captured-with-warnings" ]]; then
    printf 'ready'
    return 0
  fi

  if closeout_hold_pre_stop_ready "$expected_session_id" && [[ "$continuity_state" == "captured-with-warnings" ]]; then
    printf 'ready'
    return 0
  fi

  printf 'blocked'
}

closeout_governance_blockers() {
  local expected_session_id="${1-}"
  local blockers=()
  local validation_state=""
  local evidence_state=""
  local supervisor_state=""
  local continuity_state=""
  local not_needed_reason=""

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"
  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"
  continuity_state="$(closeout_continuity_state "$expected_session_id")"
  not_needed_reason="$(closeout_not_needed_reason "$expected_session_id")"

  if [[ "$validation_state" == "not-needed" ]] && ! closeout_not_needed_reason_allowed "$not_needed_reason"; then
    blockers+=("validation-owner=not-needed(reason=${not_needed_reason:-missing})")
  elif [[ "$validation_state" != "assigned" && "$validation_state" != "not-needed" ]]; then
    blockers+=("validation-owner=${validation_state}")
  fi
  if [[ "$evidence_state" == "not-needed" ]] && ! closeout_not_needed_reason_allowed "$not_needed_reason"; then
    blockers+=("acceptance-evidence=not-needed(reason=${not_needed_reason:-missing})")
  elif [[ "$evidence_state" != "present" && "$evidence_state" != "not-needed" ]]; then
    blockers+=("acceptance-evidence=${evidence_state}")
  fi
  if [[ "$supervisor_state" != "completed" && "$supervisor_state" != "not-needed" ]]; then
    blockers+=("supervisor-review=${supervisor_state}")
  fi
  if [[ "$continuity_state" == "stale" || "$continuity_state" == "missing" || "$continuity_state" == "unknown" ]]; then
    blockers+=("continuity=${continuity_state}")
  fi

  if [[ ${#blockers[@]} -eq 0 ]]; then
    return 0
  fi

  printf '%s' "${blockers[0]}"
  local idx=""
  for idx in "${!blockers[@]}"; do
    if [[ "$idx" == "0" ]]; then
      continue
    fi
    printf ', %s' "${blockers[$idx]}"
  done
}

get_closeout_state_field() {
  local field="${1:?field required}"
  local expected_session_id="${2-}"
  local default_value="${3-}"
  local resolved_session_id=""

  resolved_session_id="$(resolve_closeout_session_id "$expected_session_id")"
  [[ -n "$resolved_session_id" ]] || {
    printf '%s' "$default_value"
    return 0
  }

  FIELD="$field" EXPECTED_SESSION_ID="$resolved_session_id" DEFAULT_VALUE="$default_value" CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" node <<'NODE'
const fs = require("fs");

try {
  const raw = fs.readFileSync(process.env.CLOSEOUT_STATE_FILE || "", "utf8").trim();
  if (!raw) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const state = JSON.parse(raw);
  const expectedSessionId = process.env.EXPECTED_SESSION_ID || "";
  const stateSessionId = String(state.sessionId || "");
  if (expectedSessionId && (!stateSessionId || stateSessionId !== expectedSessionId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const field = process.env.FIELD || "";
  const value = state[field];
  if (value === undefined || value === null || value === "") {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
  } else {
    process.stdout.write(String(value));
  }
} catch {
  process.stdout.write(process.env.DEFAULT_VALUE || "");
}
NODE
}

update_closeout_state_fields() {
  local session_id="${1-}"
  local update_lines=""

  shift || true
  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  [[ -n "$session_id" ]] || return 0

  while [[ $# -gt 1 ]]; do
    update_lines+="${1}=${2}"$'\n'
    shift 2
  done

  with_lock_file "$CLOSEOUT_STATE_LOCK" _update_closeout_state_fields_impl "$session_id" "$update_lines"
}

_update_closeout_state_fields_impl() {
  local session_id="${1-}"
  local update_lines="${2-}"
  local workers_drained_value="false"
  local health_cron_removed_value="true"
  local runtime_removed_value="true"
  local continuity_state_value=""

  current_runtime_workers_drained && workers_drained_value="true"
  [[ -s "$HEALTH_CRON_JOB_FILE" ]] && health_cron_removed_value="false"
  [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] && runtime_removed_value="false"
  continuity_state_value="$(current_closeout_continuity_state)"

  SESSION_ID="$session_id" \
  UPDATE_LINES="$update_lines" \
  WORKERS_DRAINED_VALUE="$workers_drained_value" \
  HEALTH_CRON_REMOVED_VALUE="$health_cron_removed_value" \
  RUNTIME_REMOVED_VALUE="$runtime_removed_value" \
  CONTINUITY_STATE_VALUE="$continuity_state_value" \
  CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");

const path = process.env.CLOSEOUT_STATE_FILE || "";
const sessionId = process.env.SESSION_ID || "";
const updateLines = String(process.env.UPDATE_LINES || "")
  .split(/\n/)
  .filter(Boolean);

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) previous = JSON.parse(raw);
} catch {}

const updates = {};
for (const line of updateLines) {
  const idx = line.indexOf("=");
  if (idx <= 0) continue;
  updates[line.slice(0, idx)] = line.slice(idx + 1);
}

const workersDrained = process.env.WORKERS_DRAINED_VALUE === "true";
const healthCronRemoved = process.env.HEALTH_CRON_REMOVED_VALUE === "true";
const runtimeRemoved = process.env.RUNTIME_REMOVED_VALUE === "true";
const sensedContinuityState = process.env.CONTINUITY_STATE_VALUE || "unknown";
const previousContinuityState = previous.continuityState || "";
const stickyContinuityState = ["captured-clean", "captured-with-warnings"].includes(previousContinuityState)
  ? previousContinuityState
  : "";
const continuityState = updates.continuityState || stickyContinuityState || sensedContinuityState || "unknown";
const validationOwnerState = updates.validationOwnerState || previous.validationOwnerState || "unknown";
const acceptanceEvidenceState = updates.acceptanceEvidenceState || previous.acceptanceEvidenceState || "unknown";
const supervisorReviewState = updates.supervisorReviewState || previous.supervisorReviewState || "not-needed";
const closeoutNotNeededReason = updates.closeoutNotNeededReason !== undefined
  ? updates.closeoutNotNeededReason
  : (previous.closeoutNotNeededReason || "");
const holdReason = updates.holdReason !== undefined ? updates.holdReason : (previous.holdReason || "");
const closeoutDisposition = updates.closeoutDisposition || previous.closeoutDisposition || (previous.active === true ? "blocked" : "none");

const allowedNotNeededReasons = new Set(["operational-only", "no-acceptance-surface"]);
const notNeededIsJustified = allowedNotNeededReasons.has(closeoutNotNeededReason);
const validationReady = validationOwnerState === "assigned" ||
  (validationOwnerState === "not-needed" && notNeededIsJustified);
const evidenceReady = acceptanceEvidenceState === "present" ||
  (acceptanceEvidenceState === "not-needed" && notNeededIsJustified);
const unjustifiedNotNeeded =
  ([validationOwnerState, acceptanceEvidenceState].includes("not-needed") && !notNeededIsJustified);

const teardownGovernanceReady =
  validationReady &&
  evidenceReady;

const governanceComplete =
  workersDrained &&
  healthCronRemoved &&
  runtimeRemoved &&
  teardownGovernanceReady &&
  ["completed", "not-needed"].includes(supervisorReviewState) &&
  ["current", "captured-clean", "captured-with-warnings"].includes(continuityState);

const unresolvedGovernance =
  unjustifiedNotNeeded ||
  ["missing", "unknown"].includes(validationOwnerState) ||
  ["missing", "unknown"].includes(acceptanceEvidenceState) ||
  ["required", "missing", "unknown"].includes(supervisorReviewState);

const holdPreStopReady =
  workersDrained &&
  healthCronRemoved &&
  runtimeRemoved &&
  unresolvedGovernance &&
  Boolean(holdReason);

const cleanupEligibility =
  (governanceComplete && ["captured-clean", "captured-with-warnings"].includes(continuityState))
    || (holdPreStopReady && continuityState === "captured-with-warnings")
    ? "ready"
    : "blocked";

const next = {
  ...previous,
  sessionId: previous.sessionId || sessionId,
  workersDrained,
  healthCronRemoved,
  runtimeRemoved,
  validationOwnerState,
  acceptanceEvidenceState,
  supervisorReviewState,
  closeoutNotNeededReason,
  continuityState,
  holdReason,
  closeoutDisposition,
  cleanupEligibility,
  ...updates
};

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}

refresh_closeout_state_sensors() {
  local session_id="${1-}"

  session_id="$(resolve_closeout_session_id "$session_id")"
  [[ -n "$session_id" ]] || return 0
  [[ -f "$CLOSEOUT_STATE_FILE" ]] || return 0

  update_closeout_state_fields "$session_id"
}

set_closeout_intent() {
  local reason="${1-}"
  local source="${2:-manual-helper}"
  local phase="${3:-intent_marked}"
  local session_id="${4:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  _write_closeout_state "true" "$session_id" "$source" "${reason:-explicit-closeout-intent}" "$phase"
  if session_has_only_operational_activity "$session_id"; then
    mark_closeout_governance_packet "not-needed" "not-needed" "not-used" "$session_id" "operational-only"
  fi
  update_closeout_state_fields "$session_id"
}

clear_closeout_intent() {
  local reason="${1:-closeout-cleared}"
  local session_id="${2:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  _write_closeout_state "false" "$session_id" "clear-helper" "$reason" "inactive"
  update_closeout_state_fields "$session_id"
}

mark_closeout_governance_packet() {
  local validation_state="${1:-unknown}"
  local acceptance_state="${2:-unknown}"
  local supervisor_state="${3:-not-needed}"
  local session_id="${4:-}"
  local not_needed_reason="${5:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  update_closeout_state_fields \
    "$session_id" \
    validationOwnerState "$validation_state" \
    acceptanceEvidenceState "$acceptance_state" \
    supervisorReviewState "$supervisor_state" \
    closeoutNotNeededReason "$not_needed_reason"
}

prepare_closeout_hold_state() {
  local hold_reason="${1:-governance-hold}"
  local session_id="${2:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  update_closeout_state_fields \
    "$session_id" \
    holdReason "$hold_reason" \
    closeoutDisposition "hold"
}

_write_closeout_state() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"

  with_lock_file "$CLOSEOUT_STATE_LOCK" _write_closeout_state_impl "$active" "$session_id" "$source" "$reason" "$phase"
}

_write_closeout_state_impl() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local event_ts=""

  event_ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  mkdir -p "$(dirname "$CLOSEOUT_STATE_FILE")"

  STATE_ACTIVE="$active" \
  STATE_SESSION_ID="$session_id" \
  STATE_SOURCE="$source" \
  STATE_REASON="$reason" \
  STATE_PHASE="$phase" \
  EVENT_TS="$event_ts" \
  CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");
const path = process.env.CLOSEOUT_STATE_FILE || "";
const now = process.env.EVENT_TS || new Date().toISOString();
const active = process.env.STATE_ACTIVE === "true";

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) {
    previous = JSON.parse(raw);
  }
} catch {}

const sessionId = process.env.STATE_SESSION_ID || previous.sessionId || "";
const source = process.env.STATE_SOURCE || previous.source || (active ? "manual-helper" : "");
const reason = process.env.STATE_REASON || previous.reason || "";
const phase = process.env.STATE_PHASE || (active ? previous.phase || "intent_marked" : "inactive");
const previousSessionId = previous.sessionId || "";
const startsNewIntent = active && (!previous.active || (sessionId && previousSessionId && sessionId !== previousSessionId));
const preserveUnlessNewIntent = (field, fallback = undefined) =>
  startsNewIntent ? fallback : previous[field];

const next = active
  ? {
      active: true,
      sessionId,
      source,
      reason: reason || "explicit-closeout-intent",
      phase,
      requestedAt: startsNewIntent ? now : previous.active ? previous.requestedAt || now : now,
      updatedAt: now,
      clearedAt: "",
      workersDrained: preserveUnlessNewIntent("workersDrained"),
      healthCronRemoved: preserveUnlessNewIntent("healthCronRemoved"),
      runtimeRemoved: preserveUnlessNewIntent("runtimeRemoved"),
      validationOwnerState: preserveUnlessNewIntent("validationOwnerState"),
      acceptanceEvidenceState: preserveUnlessNewIntent("acceptanceEvidenceState"),
      supervisorReviewState: preserveUnlessNewIntent("supervisorReviewState"),
      closeoutNotNeededReason: preserveUnlessNewIntent("closeoutNotNeededReason", "") || "",
      continuityState: preserveUnlessNewIntent("continuityState"),
      holdReason: preserveUnlessNewIntent("holdReason", "") || "",
      closeoutDisposition: startsNewIntent ? "blocked" : previous.closeoutDisposition || "blocked",
      cleanupEligibility: startsNewIntent ? "blocked" : previous.cleanupEligibility || "blocked"
    }
  : {
      active: false,
      sessionId,
      source,
      reason,
      phase: "inactive",
      requestedAt: "",
      updatedAt: now,
      clearedAt: now,
      workersDrained: previous.workersDrained,
      healthCronRemoved: previous.healthCronRemoved,
      runtimeRemoved: previous.runtimeRemoved,
      validationOwnerState: previous.validationOwnerState,
      acceptanceEvidenceState: previous.acceptanceEvidenceState,
      supervisorReviewState: previous.supervisorReviewState,
      closeoutNotNeededReason: previous.closeoutNotNeededReason || "",
      continuityState: previous.continuityState,
      holdReason: previous.holdReason || "",
      closeoutDisposition: previous.closeoutDisposition || "none",
      cleanupEligibility: previous.cleanupEligibility || "blocked",
      lastActiveSessionId: previous.sessionId || sessionId || "",
      lastActiveSource: previous.source || "",
      lastActiveReason: previous.reason || "",
      lastActivePhase: previous.phase || "",
      lastActiveRequestedAt: previous.requestedAt || ""
    };

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}
