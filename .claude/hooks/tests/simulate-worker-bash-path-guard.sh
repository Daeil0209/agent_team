#!/usr/bin/env bash
set -euo pipefail

HOOK_ROOT="${HOOK_ROOT:-/mnt/d/Agent_team/.claude/hooks}"
TMP_ROOT="${WORKER_BASH_PATH_SIM_ROOT:-$(mktemp -d /tmp/worker-bash-path-sim-XXXXXX)}"
KEEP_ROOT="${WORKER_BASH_PATH_SIM_KEEP_ROOT:-0}"

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

pass() {
  local label="${1:?label required}"
  PASSES=$((PASSES + 1))
  printf 'PASS %s\n' "$label"
}

fail() {
  local label="${1:?label required}"
  local detail="${2:-}"
  FAILURES=$((FAILURES + 1))
  printf 'FAIL %s\n' "$label"
  [[ -n "$detail" ]] && printf '  %s\n' "$detail"
}

assert_equals() {
  local actual="${1-}"
  local expected="${2-}"
  local label="${3:?label required}"

  if [[ "$actual" == "$expected" ]]; then
    pass "$label"
  else
    fail "$label" "expected: $expected"$'\n'"actual: $actual"
  fi
}

assert_contains() {
  local haystack="${1-}"
  local needle="${2-}"
  local label="${3:?label required}"

  if [[ "$haystack" == *"$needle"* ]]; then
    pass "$label"
  else
    fail "$label" "expected substring: $needle"$'\n'"actual: $haystack"
  fi
}

json_escape() {
  VALUE="${1-}" node <<'NODE'
const value = String(process.env.VALUE || "");
process.stdout.write(JSON.stringify(value));
NODE
}

setup_env() {
  local scenario="${1:?scenario required}"

  export HOME="$TMP_ROOT/$scenario/home"
  export LOG_DIR="$HOME/.claude/logs"
  export CLAUDE_ROOT="$TMP_ROOT/$scenario/repo/.claude"
  export CLAUDE_PROJECT_DIR="$TMP_ROOT/$scenario/workspace"
  export HOOK_DIR="$HOOK_ROOT"
  export HOOK_HEALTH_SELF_CHECK_MODE=off

  mkdir -p "$HOME/.claude" "$LOG_DIR" "$CLAUDE_ROOT" "$CLAUDE_PROJECT_DIR/build" "$CLAUDE_PROJECT_DIR/src"
  : > "$CLAUDE_ROOT/settings.json"
  printf 'worker-1 developer\n' > "$LOG_DIR/.session-agent-map"
  printf 'source\n' > "$CLAUDE_PROJECT_DIR/src/source.txt"

  # shellcheck source=/dev/null
  source "$HOOK_ROOT/hook-config.sh"
}

bash_input() {
  local session_id="${1:?session id required}"
  local command="${2:?command required}"
  local session_json command_json
  session_json="$(json_escape "$session_id")"
  command_json="$(json_escape "$command")"
  printf '{"tool_name":"Bash","session_id":%s,"tool_input":{"command":%s}}\n' "$session_json" "$command_json"
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

run_pre_hook_reason() {
  local payload="${1:?payload required}"
  local output=""
  output="$(printf '%s' "$payload" | bash "$HOOK_ROOT/compliance-supervisor.sh" || true)"
  extract_reason "$output"
}

print_header() {
  local label="${1:?label required}"
  printf '\n=== %s ===\n' "$label"
}

print_header "doc-alignment"
assert_contains "$(rg -n -F 'assignment-grade `SendMessage`' /mnt/d/Agent_team/.claude/agents/team-lead.md)" "assignment-grade \`SendMessage\`" "team-lead p1 wording aligned"
assert_contains "$(rg -n -F 'destination rationale' /mnt/d/Agent_team/.claude/skills/task-execution/reference.md /mnt/d/Agent_team/.claude/skills/task-execution/SKILL.md)" "destination rationale" "meaning-migration wording aligned"

print_header "worker-path-guard"
setup_env "worker-path-guard"
worker_session="worker-1"

if runtime_sender_session_is_worker "$worker_session"; then
  pass "worker session recognized by runtime registry"
else
  fail "worker session recognized by runtime registry" "expected worker-1 to resolve as a worker session"
fi

assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "mkdir -p build/output")")" "ALLOW" "worker mkdir inside workspace allowed"
assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "touch build/output/file.txt")")" "ALLOW" "worker touch inside workspace allowed"
assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "cp src/source.txt build/output/copied.txt")")" "ALLOW" "worker cp destination inside workspace allowed"
assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "chmod +x build/output/copied.txt")")" "ALLOW" "worker chmod inside workspace allowed"
assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "npm test")")" "ALLOW" "worker non-fs implementation command still allowed"
assert_equals "$(run_pre_hook_reason "$(bash_input "$worker_session" "mkdir -p build/tmp && touch build/tmp/a.txt")")" "ALLOW" "worker compound safe path command allowed"

mkdir_outside_reason="$(run_pre_hook_reason "$(bash_input "$worker_session" "mkdir -p /tmp/outside-worker-path-guard")")"
touch_outside_reason="$(run_pre_hook_reason "$(bash_input "$worker_session" "touch ../outside.txt")")"
cp_outside_reason="$(run_pre_hook_reason "$(bash_input "$worker_session" "cp src/source.txt /tmp/outside-copied.txt")")"
chmod_outside_reason="$(run_pre_hook_reason "$(bash_input "$worker_session" "chmod +x /tmp/outside-copied.txt")")"
compound_outside_reason="$(run_pre_hook_reason "$(bash_input "$worker_session" "mkdir -p build/tmp && touch /tmp/outside-a.txt")")"

assert_contains "$mkdir_outside_reason" "Worker implementation shell paths must stay within the workspace root." "worker mkdir outside workspace blocked"
assert_contains "$touch_outside_reason" "Worker implementation shell paths must stay within the workspace root." "worker touch outside workspace blocked"
assert_contains "$cp_outside_reason" "Worker implementation shell paths must stay within the workspace root." "worker cp outside workspace blocked"
assert_contains "$chmod_outside_reason" "Worker implementation shell paths must stay within the workspace root." "worker chmod outside workspace blocked"
assert_contains "$compound_outside_reason" "Worker implementation shell paths must stay within the workspace root." "worker compound outside workspace blocked"

printf '\nASSERTIONS_PASSED %d\n' "$PASSES"
if [[ "$FAILURES" != "0" ]]; then
  printf 'ASSERTIONS_FAILED %d\n' "$FAILURES"
  exit 1
fi
