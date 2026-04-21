#!/usr/bin/env bash
set -euo pipefail

HOOK_ROOT="${HOOK_ROOT:-/mnt/d/Agent_team/.claude/hooks}"
TMP_ROOT="${SENDMESSAGE_GATE_SIM_ROOT:-$(mktemp -d /tmp/sendmessage-gate-sim-XXXXXX)}"
KEEP_ROOT="${SENDMESSAGE_GATE_SIM_KEEP_ROOT:-0}"

PASSES=0
FAILURES=0

cleanup() {
  if [[ "$KEEP_ROOT" == "1" || "$FAILURES" != "0" ]]; then
    printf 'SIM_ROOT %s\n' "$TMP_ROOT"
    return 0
  fi

  rm -rf "$TMP_ROOT"
}
trap cleanup EXIT

assert_contains() {
  local haystack="${1-}"
  local needle="${2-}"
  local context="${3:?context required}"

  if [[ "$haystack" == *"$needle"* ]]; then
    PASSES=$((PASSES + 1))
    printf 'PASS %s\n' "$context"
    return 0
  fi

  FAILURES=$((FAILURES + 1))
  printf 'FAIL %s\n' "$context"
  printf '  expected substring: %s\n' "$needle"
  printf '  actual: %s\n' "$haystack"
  return 1
}

print_case_header() {
  local name="${1:?name required}"
  printf '\n=== %s ===\n' "$name"
}

setup_env() {
  local scenario="${1:?scenario required}"

  export HOME="$TMP_ROOT/$scenario/home"
  export LOG_DIR="$TMP_ROOT/$scenario/logs"
  export PROCEDURE_STATE_DIR="$TMP_ROOT/$scenario/state"
  export PROCEDURE_STATE_FILE="$PROCEDURE_STATE_DIR/procedure-state.json"
  export PROCEDURE_STATE_LOCK="$LOG_DIR/.procedure-state.lock"
  export PROJECT_CONTINUITY_FILE="$TMP_ROOT/$scenario/session-state.md"
  export HOOK_DIR="$HOOK_ROOT"
  export HOOK_HEALTH_SELF_CHECK_MODE=off

  mkdir -p "$HOME" "$LOG_DIR" "$PROCEDURE_STATE_DIR"

  # shellcheck source=/dev/null
  source "$HOOK_ROOT/hook-config.sh"
  ensure_name_registry
}

seed_live_worker() {
  local worker_name="${1:?worker required}"
  local worker_session="${2:-worker-session}"

  printf '%s %s\n' "$worker_session" "$worker_name" > "$SESSION_AGENT_MAP"
}

seed_claimed_worker_state() {
  local lead_session="${1:?lead session required}"
  local worker_name="${2:?worker required}"
  local dispatch_at="${3:-$(date -u '+%Y-%m-%dT%H:%M:%SZ')}"

  update_procedure_state_fields \
    "$lead_session" \
    lastClaimedWorker "$worker_name" \
    lastDispatchWorker "$worker_name" \
    lastDispatchAt "$dispatch_at" \
    teamDispatchState "claimed"
}

append_worker_report() {
  local worker_name="${1:?worker required}"
  local message_class="${2:?message class required}"
  local timestamp="${3:-$(date -u '+%Y-%m-%dT%H:%M:%SZ')}"

  WORKER_NAME="$worker_name" MESSAGE_CLASS="$message_class" TIMESTAMP="$timestamp" WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" node <<'NODE'
const fs = require("fs");
const line = {
  timestamp: process.env.TIMESTAMP || "",
  sessionId: "worker-session",
  senderName: process.env.WORKER_NAME || "",
  teamName: "sim-team",
  agentType: process.env.WORKER_NAME || "",
  taskId: "",
  taskIdFieldPresent: false,
  taskSubject: "",
  messageClass: process.env.MESSAGE_CLASS || "",
  requestedLifecycle: "",
  fields: {}
};
fs.mkdirSync(require("path").dirname(process.env.WORKER_REPORT_LEDGER || ""), { recursive: true });
fs.appendFileSync(process.env.WORKER_REPORT_LEDGER || "", `${JSON.stringify(line)}\n`);
NODE
}

append_permission_request() {
  local worker_name="${1:?worker required}"
  local timestamp="${2:-$(date -u '+%Y-%m-%dT%H:%M:%SZ')}"
  local inbox_path="$HOME/.claude/teams/sim-team/inboxes/team-lead.json"

  mkdir -p "$(dirname "$inbox_path")"
  WORKER_NAME="$worker_name" TIMESTAMP="$timestamp" INBOX_PATH="$inbox_path" node <<'NODE'
const fs = require("fs");
const path = process.env.INBOX_PATH || "";
let rows = [];
try {
  rows = JSON.parse(fs.readFileSync(path, "utf8"));
  if (!Array.isArray(rows)) rows = [];
} catch {
  rows = [];
}
rows.push({
  from: process.env.WORKER_NAME || "",
  timestamp: process.env.TIMESTAMP || "",
  text: JSON.stringify({ type: "permission_request" })
});
fs.writeFileSync(path, JSON.stringify(rows, null, 2));
NODE
}

make_sendmessage_input() {
  local session_id="${1:?session id required}"
  local target_name="${2:?target required}"
  local message_text="${3:?message required}"

  SESSION_ID="$session_id" TARGET_NAME="$target_name" MESSAGE_TEXT="$message_text" node <<'NODE'
process.stdout.write(JSON.stringify({
  tool_name: "SendMessage",
  session_id: process.env.SESSION_ID || "",
  tool_input: {
    to: process.env.TARGET_NAME || "",
    message: process.env.MESSAGE_TEXT || ""
  }
}));
NODE
}

extract_reason() {
  local hook_output="${1-}"

  if [[ -z "$hook_output" ]]; then
    printf 'ALLOW'
    return 0
  fi

  HOOK_OUTPUT="$hook_output" node <<'NODE'
try {
  const parsed = JSON.parse(process.env.HOOK_OUTPUT || "{}");
  const reason = parsed?.hookSpecificOutput?.permissionDecisionReason || "";
  process.stdout.write(reason || "ALLOW");
} catch {
  process.stdout.write("UNPARSEABLE");
}
NODE
}

run_case() {
  local name="${1:?name required}"
  local expected="${2:?expected required}"
  local detail="${3:?detail required}"
  shift 3
  local setup_commands=("$@")
  local lead_session="lead-${name}"
  local output=""
  local reason=""

  setup_env "$name"
  seed_live_worker tester
  mark_lead_planning_required "$lead_session"

  for cmd in "${setup_commands[@]}"; do
    LEAD_SESSION="$lead_session" eval "$cmd"
  done

  print_case_header "$name"
  output="$(make_sendmessage_input "$lead_session" tester "$MESSAGE_TEXT" | bash "$HOOK_ROOT/task-start-gate.sh" || true)"
  reason="$(extract_reason "$output")"
  printf 'gate=%s\n' "$reason"
  assert_contains "$reason" "$expected" "$name gate class"
  assert_contains "$reason" "$detail" "$name gate detail"
}

MESSAGE_TEXT="Current step and next evidence?"
run_case \
  "pass-01-working-freeform-status-probe" \
  "ALLOW" \
  "ALLOW" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T01:00:00Z'" \
  "append_worker_report tester dispatch-ack '2026-04-21T01:00:05Z'"

MESSAGE_TEXT=$'MESSAGE-CLASS: status\nCurrent step and next evidence?'
run_case \
  "pass-02-working-structured-status-probe" \
  "ALLOW" \
  "ALLOW" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T01:10:00Z'" \
  "append_worker_report tester status '2026-04-21T01:10:05Z'"

MESSAGE_TEXT="Send the smallest partial result and current blocker."
run_case \
  "pass-03-blocked-worker-partial-result" \
  "ALLOW" \
  "ALLOW" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T01:20:00Z'" \
  "append_worker_report tester blocker '2026-04-21T01:20:05Z'"

MESSAGE_TEXT="Current step and next evidence?"
run_case \
  "block-04-pending-ack-status-probe" \
  "BLOCKED: fresh-turn preflight sequence incomplete." \
  "SendMessage cannot run before observed" \
  "mark_worker_dispatch_ack_required tester '2026-04-21T01:30:00Z'"

MESSAGE_TEXT="Current step and next evidence?"
run_case \
  "block-05-permission-pending-status-probe" \
  "BLOCKED: fresh-turn preflight sequence incomplete." \
  "SendMessage cannot run before observed" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T01:40:00Z'" \
  "append_worker_report tester status '2026-04-21T01:40:05Z'" \
  "append_permission_request tester '2026-04-21T01:40:10Z'"

MESSAGE_TEXT="Current step and next evidence?"
run_case \
  "block-06-standby-status-probe" \
  "BLOCKED: fresh-turn preflight sequence incomplete." \
  "SendMessage cannot run before observed" \
  "printf 'tester\n' > \"$STANDBY_FILE\""

MESSAGE_TEXT=$'MESSAGE-CLASS: assignment\nREQUIRED-SKILLS: work-planning, self-verification\nWORK-SURFACE: docs/\nCURRENT-PHASE: analysis\nContinue the assigned work.'
run_case \
  "block-07-assignment-grade-sendmessage" \
  "BLOCKED: fresh-turn preflight sequence incomplete." \
  "SendMessage cannot run before observed" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T01:50:00Z'" \
  "append_worker_report tester status '2026-04-21T01:50:05Z'"

MESSAGE_TEXT=$'MESSAGE-CLASS: control\nLIFECYCLE-DECISION: standby\nDECISION-BASIS: waiting for next phase'
run_case \
  "pass-08-lifecycle-control" \
  "ALLOW" \
  "ALLOW"

MESSAGE_TEXT="Current step and next evidence?"
run_case \
  "block-09-completed-worker-status-probe" \
  "BLOCKED: fresh-turn preflight sequence incomplete." \
  "SendMessage cannot run before observed" \
  "seed_claimed_worker_state \"\$LEAD_SESSION\" tester '2026-04-21T02:00:00Z'" \
  "append_worker_report tester completion '2026-04-21T02:00:10Z'"

printf '\nSUMMARY passes=%d failures=%d\n' "$PASSES" "$FAILURES"

if (( FAILURES > 0 )); then
  exit 1
fi
