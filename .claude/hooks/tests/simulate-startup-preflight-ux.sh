#!/usr/bin/env bash
set -euo pipefail

HOOK_ROOT="${HOOK_ROOT:-/mnt/d/Agent_team/.claude/hooks}"
TMP_ROOT="${STARTUP_PREFLIGHT_SIM_ROOT:-$(mktemp -d /tmp/startup-preflight-sim-XXXXXX)}"
KEEP_ROOT="${STARTUP_PREFLIGHT_SIM_KEEP_ROOT:-0}"

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

assert_not_contains() {
  local haystack="${1-}"
  local needle="${2-}"
  local label="${3:?label required}"

  if [[ "$haystack" == *"$needle"* ]]; then
    fail "$label" "unexpected substring: $needle"$'\n'"actual: $haystack"
  else
    pass "$label"
  fi
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

setup_env() {
  local scenario="${1:?scenario required}"

  export HOME="$TMP_ROOT/$scenario/home"
  export LOG_DIR="$HOME/.claude/logs"
  export CLAUDE_ROOT="$TMP_ROOT/$scenario/repo/.claude"
  export PROCEDURE_STATE_DIR="$CLAUDE_ROOT/state"
  export PROCEDURE_STATE_FILE="$PROCEDURE_STATE_DIR/procedure-state.json"
  export PROCEDURE_STATE_LOCK="$LOG_DIR/.procedure-state.lock"
  export PROJECT_CONTINUITY_FILE="$CLAUDE_ROOT/session-state.md"
  export GLOBAL_CONTINUITY_FILE="$HOME/.claude/session-state.md"
  export HOOK_DIR="$HOOK_ROOT"
  export HOOK_HEALTH_SELF_CHECK_MODE=off
  export RUNTIME_AUTOREAP_ENABLED=0
  export SESSION_BOOT_MARKER_FILE="$LOG_DIR/.session-boot-marker"
  export BOOT_SEQUENCE_COMPLETE_FILE="$LOG_DIR/.boot-sequence-complete"

  mkdir -p "$HOME/.claude" "$LOG_DIR" "$PROCEDURE_STATE_DIR" "$CLAUDE_ROOT"
  : > "$CLAUDE_ROOT/settings.json"

  # shellcheck source=/dev/null
  source "$HOOK_ROOT/hook-config.sh"
}

json_escape() {
  VALUE="${1-}" node <<'NODE'
const value = String(process.env.VALUE || "");
process.stdout.write(JSON.stringify(value));
NODE
}

write_file() {
  local path="${1:?path required}"
  local body="${2-}"
  mkdir -p "$(dirname "$path")"
  printf '%s' "$body" > "$path"
}

touch_stale() {
  local path="${1:?path required}"
  touch -d '2 hours ago' "$path"
}

session_start_input() {
  local session_id="${1:?session id required}"
  local encoded
  encoded="$(json_escape "$session_id")"
  printf '{"session_id":%s}\n' "$encoded"
}

prompt_input() {
  local session_id="${1:?session id required}"
  local prompt="${2:?prompt required}"
  local session_json prompt_json
  session_json="$(json_escape "$session_id")"
  prompt_json="$(json_escape "$prompt")"
  printf '{"session_id":%s,"prompt":%s}\n' "$session_json" "$prompt_json"
}

skill_input() {
  local session_id="${1:?session id required}"
  local skill_name="${2:?skill required}"
  local session_json skill_json
  session_json="$(json_escape "$session_id")"
  skill_json="$(json_escape "$skill_name")"
  printf '{"tool_name":"Skill","session_id":%s,"tool_input":{"skill":%s}}\n' "$session_json" "$skill_json"
}

teamcreate_input() {
  local session_id="${1:?session id required}"
  local team_name="${2:?team name required}"
  local session_json team_json
  session_json="$(json_escape "$session_id")"
  team_json="$(json_escape "$team_name")"
  printf '{"tool_name":"TeamCreate","session_id":%s,"tool_input":{"team_name":%s}}\n' "$session_json" "$team_json"
}

teamcreate_post_input() {
  local session_id="${1:?session id required}"
  local team_name="${2:?team name required}"
  local session_json team_json
  session_json="$(json_escape "$session_id")"
  team_json="$(json_escape "$team_name")"
  printf '{"tool_name":"TeamCreate","session_id":%s,"tool_input":{"team_name":%s},"tool_response":{"success":true}}\n' "$session_json" "$team_json"
}

teamdelete_input() {
  local session_id="${1:?session id required}"
  local team_name="${2:?team name required}"
  local session_json team_json
  session_json="$(json_escape "$session_id")"
  team_json="$(json_escape "$team_name")"
  printf '{"tool_name":"TeamDelete","session_id":%s,"tool_input":{"team_name":%s}}\n' "$session_json" "$team_json"
}

crondelete_input() {
  local session_id="${1:?session id required}"
  local cron_id="${2:?cron id required}"
  local session_json cron_json
  session_json="$(json_escape "$session_id")"
  cron_json="$(json_escape "$cron_id")"
  printf '{"tool_name":"CronDelete","session_id":%s,"tool_input":{"id":%s}}\n' "$session_json" "$cron_json"
}

bash_input() {
  local session_id="${1:?session id required}"
  local command="${2:?command required}"
  local session_json command_json
  session_json="$(json_escape "$session_id")"
  command_json="$(json_escape "$command")"
  printf '{"tool_name":"Bash","session_id":%s,"tool_input":{"command":%s}}\n' "$session_json" "$command_json"
}

agent_input() {
  local session_id="${1:?session id required}"
  local team_name="${2:?team name required}"
  local worker_name="${3:?worker required}"
  local description="${4:-Phase work}"
  local session_json team_json worker_json desc_json
  session_json="$(json_escape "$session_id")"
  team_json="$(json_escape "$team_name")"
  worker_json="$(json_escape "$worker_name")"
  desc_json="$(json_escape "$description")"
  printf '{"tool_name":"Agent","session_id":%s,"tool_input":{"team_name":%s,"name":%s,"description":%s}}\n' "$session_json" "$team_json" "$worker_json" "$desc_json"
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
  local hook_name="${1:?hook required}"
  local payload="${2:?payload required}"
  local output=""
  output="$(printf '%s' "$payload" | bash "$HOOK_ROOT/$hook_name" || true)"
  extract_reason "$output"
}

mark_lead_planning() {
  local session_id="${1:?session required}"
  mark_lead_planning_required "$session_id"
}

post_skill() {
  local session_id="${1:?session required}"
  local skill_name="${2:?skill required}"
  printf '%s' "$(skill_input "$session_id" "$skill_name")" | bash "$HOOK_ROOT/sv-tracker.sh" >/dev/null
}

post_teamcreate_success() {
  local session_id="${1:?session required}"
  local team_name="${2:?team name required}"
  printf '%s' "$(teamcreate_post_input "$session_id" "$team_name")" | bash "$HOOK_ROOT/track-runtime-lifecycle.sh" >/dev/null
}

print_header() {
  local label="${1:?label required}"
  printf '\n=== %s ===\n' "$label"
}

print_header "startup-clean"
setup_env "startup-clean"
clean_output="$(session_start_input "startup-clean" | bash "$HOOK_ROOT/session-start.sh")"
assert_contains "$clean_output" "Lead session | root:" "startup-clean lead banner"
assert_contains "$clean_output" "Team runtime snapshot: no live team runtime detected." "startup-clean concise snapshot"
assert_not_contains "$clean_output" "Persisted team state channel" "startup-clean no persisted team summary"

print_header "startup-stale-carryover"
setup_env "startup-stale-carryover"
write_file "$PROJECT_CONTINUITY_FILE" $'# Session State\nstale\n'
write_file "$GLOBAL_CONTINUITY_FILE" $'# Session State\nother stale\n'
touch_stale "$PROJECT_CONTINUITY_FILE"
touch_stale "$GLOBAL_CONTINUITY_FILE"
write_file "$PROCEDURE_STATE_FILE" '{
  "workspaceRoot": "/tmp/sim",
  "sessionId": "old-session",
  "bootSessionId": "old-session",
  "startupState": "ready",
  "projectContinuityState": "stale",
  "globalContinuityState": "stale",
  "continuityMirrorStatus": "diverged",
  "teamRuntimeState": "active",
  "teamExistenceEvidence": "worker-report:status",
  "teamDispatchState": "claimed",
  "teamDispatchEvidence": "worker-activity",
  "lastClaimedWorker": "tester"
}
'
mkdir -p "$HOME/.claude/teams/old-team"
write_file "$HOME/.claude/teams/old-team/config.json" '{"members":[{"name":"tester","tmuxPaneId":"%999"}]}'
stale_output="$(session_start_input "startup-stale-carryover" | bash "$HOOK_ROOT/session-start.sh")"
assert_contains "$stale_output" "Lead session | root:" "startup-stale lead banner"
assert_contains "$stale_output" "Team runtime snapshot: carry-over config residue only; no live worker panes detected." "startup-stale concise residue warning"
assert_not_contains "$stale_output" "Observed team config files:" "startup-stale no file inventory"
assert_not_contains "$stale_output" "Persisted team state channel" "startup-stale suppress stale persisted state"

print_header "boot-teamcreate"
setup_env "boot-teamcreate"
lead_session="lead-boot-turn"
team_name="boot-team"
session_start_input "$lead_session" | bash "$HOOK_ROOT/session-start.sh" >/dev/null
boot_teamcreate_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
boot_teamcreate_runtime_reason="$(run_pre_hook_reason "runtime-entry-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
assert_equals "$boot_teamcreate_taskstart_reason" "ALLOW" "boot teamcreate still allowed during boot window"
assert_equals "$boot_teamcreate_runtime_reason" "ALLOW" "boot runtime-entry still allows teamcreate"

print_header "boot-bash-distinction"
setup_env "boot-bash-distinction"
lead_session="lead-boot-bash"
session_start_input "$lead_session" | bash "$HOOK_ROOT/session-start.sh" >/dev/null
boot_pwd_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(bash_input "$lead_session" "pwd")")"
assert_equals "$boot_pwd_reason" "ALLOW" "boot pwd probe allowed"
mark_lead_planning "$lead_session"
bootstrap_ls_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(bash_input "$lead_session" "ls")")"
assert_equals "$bootstrap_ls_reason" "ALLOW" "bootstrap read-only bash remains hook-owned and allowed"

print_header "fresh-turn-pivot"
setup_env "fresh-turn-pivot"
lead_session="lead-fresh-turn"
team_name="sim-team"
mark_lead_planning "$lead_session"

sv_bootstrap_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(skill_input "$lead_session" "self-verification")")"
assert_equals "$sv_bootstrap_reason" "ALLOW" "pivot self-verification allowed during audit bootstrap"
post_skill "$lead_session" "self-verification"

teamcreate_before_taskexec_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
assert_contains "$teamcreate_before_taskexec_reason" "BLOCKED: fresh-turn preflight sequence incomplete." "pivot teamcreate blocked before work-planning"

task_execution_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(skill_input "$lead_session" "task-execution")")"
assert_equals "$task_execution_reason" "ALLOW" "pivot task-execution allowed during bootstrap"
post_skill "$lead_session" "task-execution"

teamcreate_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
assert_contains "$teamcreate_taskstart_reason" "BLOCKED: fresh-turn preflight sequence incomplete." "pivot teamcreate still blocked after task-execution bootstrap"

post_skill "$lead_session" "work-planning"

teamcreate_after_wp_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
teamcreate_after_wp_runtime_reason="$(run_pre_hook_reason "runtime-entry-gate.sh" "$(teamcreate_input "$lead_session" "$team_name")")"
assert_equals "$teamcreate_after_wp_taskstart_reason" "ALLOW" "pivot teamcreate allowed after work-planning"
assert_equals "$teamcreate_after_wp_runtime_reason" "ALLOW" "pivot runtime-entry allows teamcreate after work-planning"
post_teamcreate_success "$lead_session" "$team_name"

agent_after_wp_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(agent_input "$lead_session" "$team_name" "tester" "Phase work")")"
agent_after_wp_svgate_reason="$(run_pre_hook_reason "sv-gate.sh" "$(agent_input "$lead_session" "$team_name" "tester" "Phase work")")"
assert_equals "$agent_after_wp_taskstart_reason" "ALLOW" "pivot agent passes task-start after work-planning"
assert_contains "$agent_after_wp_svgate_reason" "BLOCKED: verification preflight incomplete." "pivot agent still blocked by sv-gate before self-verification"

post_skill "$lead_session" "self-verification"

agent_after_wp_runtime_reason="$(run_pre_hook_reason "runtime-entry-gate.sh" "$(agent_input "$lead_session" "$team_name" "tester" "Phase work")")"
agent_after_wpsv_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(agent_input "$lead_session" "$team_name" "tester" "Phase work")")"
agent_after_wpsv_svgate_reason="$(run_pre_hook_reason "sv-gate.sh" "$(agent_input "$lead_session" "$team_name" "tester" "Phase work")")"
assert_equals "$agent_after_wpsv_taskstart_reason" "ALLOW" "pivot agent passes task-start after wp-sv"
assert_equals "$agent_after_wpsv_svgate_reason" "ALLOW" "pivot agent passes sv-gate after wp-sv"
assert_equals "$agent_after_wp_runtime_reason" "ALLOW" "pivot agent passes runtime-entry after teamcreate"

print_header "teardown-without-intent"
setup_env "teardown-without-intent"
lead_session="lead-no-closeout"
session_start_input "$lead_session" | bash "$HOOK_ROOT/session-start.sh" >/dev/null
write_file "$BOOT_SEQUENCE_COMPLETE_FILE" "boot-complete"
mark_lead_planning "$lead_session"
teardown_without_intent_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamdelete_input "$lead_session" "sim-team")")"
assert_contains "$teardown_without_intent_reason" "BLOCKED: runtime teardown intent incomplete." "teardown blocked without explicit closeout intent"

print_header "closeout-owner-alignment"
setup_env "closeout-owner-alignment"
lead_session="lead-closeout"
session_start_input "$lead_session" | bash "$HOOK_ROOT/session-start.sh" >/dev/null
write_file "$BOOT_SEQUENCE_COMPLETE_FILE" "boot-complete"
post_skill "$lead_session" "work-planning"
closeout_prompt_output="$(printf '%s' "$(prompt_input "$lead_session" "세션 종료해")" | bash "$HOOK_ROOT/user-prompt-gate.sh")"
assert_contains "$closeout_prompt_output" "CTX: closeout-active." "closeout prompt sets closeout intent"
closeout_teamdelete_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(teamdelete_input "$lead_session" "sim-team")")"
closeout_teamdelete_svgate_reason="$(run_pre_hook_reason "sv-gate.sh" "$(teamdelete_input "$lead_session" "sim-team")")"
closeout_crondelete_taskstart_reason="$(run_pre_hook_reason "task-start-gate.sh" "$(crondelete_input "$lead_session" "cron-1")")"
closeout_crondelete_svgate_reason="$(run_pre_hook_reason "sv-gate.sh" "$(crondelete_input "$lead_session" "cron-1")")"
assert_equals "$closeout_teamdelete_taskstart_reason" "ALLOW" "closeout teamdelete bypasses generic fresh-turn gate"
assert_equals "$closeout_teamdelete_svgate_reason" "ALLOW" "closeout teamdelete bypasses routine sv-gate"
assert_equals "$closeout_crondelete_taskstart_reason" "ALLOW" "closeout crondelete bypasses generic fresh-turn gate"
assert_equals "$closeout_crondelete_svgate_reason" "ALLOW" "closeout crondelete bypasses routine sv-gate"

printf '\nASSERTIONS_PASSED %d\n' "$PASSES"
if [[ "$FAILURES" != "0" ]]; then
  printf 'ASSERTIONS_FAILED %d\n' "$FAILURES"
  exit 1
fi
