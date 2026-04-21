#!/usr/bin/env bash
set -euo pipefail

HOOK_ROOT="${HOOK_ROOT:-/mnt/d/Agent_team/.claude/hooks}"
TMP_ROOT="${DISPATCH_PROOF_SIM_ROOT:-$(mktemp -d /tmp/dispatch-proof-sim-XXXXXX)}"
KEEP_ROOT="${DISPATCH_PROOF_SIM_KEEP_ROOT:-0}"

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

make_agent_input() {
  local lane="${1:?lane required}"
  local prompt_text="${2:?prompt required}"
  local summary_text="${3:-Phase 4 proof contract simulation}"
  local session_id="${4:-dispatch-proof-sim}"

  TARGET_LANE="$lane" PROMPT_TEXT="$prompt_text" SUMMARY_TEXT="$summary_text" SESSION_ID="$session_id" node <<'NODE'
process.stdout.write(JSON.stringify({
  tool_name: "Agent",
  session_id: process.env.SESSION_ID || "dispatch-proof-sim",
  tool_input: {
    description: process.env.SUMMARY_TEXT || "proof contract simulation",
    subagent_type: process.env.TARGET_LANE || "",
    name: process.env.TARGET_LANE || "",
    team_name: "rnd-budget-webapp",
    run_in_background: true,
    prompt: process.env.PROMPT_TEXT || ""
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

print_case_header() {
  local name="${1:?name required}"
  printf '\n=== %s ===\n' "$name"
}

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

field_probe() {
  local prompt_text="${1:?prompt required}"
  local field_name="${2:?field required}"
  dispatch_field_raw_value "$prompt_text" "$field_name" || true
}

run_case() {
  local name="${1:?name required}"
  local lane="${2:?lane required}"
  local prompt_text="${3:?prompt required}"
  local field_a="${4:?field_a required}"
  local field_b="${5:?field_b required}"
  local field_c="${6:?field_c required}"
  local expected_lint="${7:?expected lint required}"
  local expected_gate="${8:?expected gate required}"
  local expected_detail="${9:?expected detail required}"
  local parsed_a=""
  local parsed_b=""
  local parsed_c=""
  local lint_output=""
  local gate_output=""
  local gate_reason=""
  local session_id=""

  setup_env "$name"
  session_id="${name}"

  parsed_a="$(field_probe "$prompt_text" "$field_a")"
  parsed_b="$(field_probe "$prompt_text" "$field_b")"
  parsed_c="$(field_probe "$prompt_text" "$field_c")"

  print_case_header "$name"
  printf 'parsed.%s=%s\n' "$field_a" "${parsed_a:-<empty>}"
  printf 'parsed.%s=%s\n' "$field_b" "${parsed_b:-<empty>}"
  printf 'parsed.%s=%s\n' "$field_c" "${parsed_c:-<empty>}"

  lint_output="$(printf '%s' "$prompt_text" | bash "$HOOK_ROOT/dispatch-packet-lint.sh" --lane "$lane" --summary "dispatch lint simulation" || true)"
  printf 'lint=%s\n' "$lint_output"

  gate_output="$(make_agent_input "$lane" "$prompt_text" "$name" "$session_id" | bash "$HOOK_ROOT/dispatch-proof-gate.sh" || true)"
  gate_reason="$(extract_reason "$gate_output")"
  printf 'gate=%s\n' "$gate_reason"

  assert_contains "$lint_output" "$expected_lint" "$name lint detail"
  assert_contains "$gate_reason" "$expected_gate" "$name gate class"
  assert_contains "$gate_reason" "$expected_detail" "$name expected detail"
}

run_repeat_block_case() {
  local name="${1:?name required}"
  local lane="${2:?lane required}"
  local prompt_text="${3:?prompt required}"
  local expected_repeat="${4:?expected repeat detail required}"
  local first_gate_output=""
  local second_gate_output=""
  local first_gate_reason=""
  local second_gate_reason=""
  local session_id=""

  setup_env "$name"
  session_id="${name}"

  print_case_header "$name"

  printf '%s' "$prompt_text" | bash "$HOOK_ROOT/dispatch-packet-lint.sh" --lane "$lane" --summary "repeat blocker lint simulation" >/dev/null || true

  first_gate_output="$(make_agent_input "$lane" "$prompt_text" "$name first" "$session_id" | bash "$HOOK_ROOT/dispatch-proof-gate.sh" || true)"
  first_gate_reason="$(extract_reason "$first_gate_output")"
  second_gate_output="$(make_agent_input "$lane" "$prompt_text" "$name second" "$session_id" | bash "$HOOK_ROOT/dispatch-proof-gate.sh" || true)"
  second_gate_reason="$(extract_reason "$second_gate_output")"

  printf 'repeat.first=%s\n' "$first_gate_reason"
  printf 'repeat.second=%s\n' "$second_gate_reason"

  assert_contains "$first_gate_reason" "BLOCKED: dispatch packet incomplete." "$name first gate class"
  assert_contains "$second_gate_reason" "$expected_repeat" "$name repeat escalation"
}

PROMPT_BASE=$'MESSAGE-CLASS: assignment\nTASK-ID: #5b\nWORK-SURFACE: /mnt/d/Agent_team/rnd-budget-webapp/ + docs/04-verification/tester-report.md + artifacts/screenshots/\nCURRENT-PHASE: dev-workflow Phase 4 Analysis\nACTIVE-WORKFLOW: dev-workflow\nREQUIRED-SKILLS: work-planning(start), self-verification(plan-verify, handoff), tester\nACCEPTANCE-RISK: meaningful\nPROOF-TARGET: 웹앱 전체 기동 성공 + S1~S10 10 화면 브라우저 상호작용 검증 + SC-1~SC-6 매핑\nENV-BASIS: Linux (WSL) + Python 3.12 + Node 20+ + Playwright CLI\nSCENARIO-SCOPE: plan §5 SC-1~SC-6 + Playwright E2E 최소 시나리오 8건\nUSER-RUN-PATH: run.sh 또는 run.ps1 단일 명령 기동 → 브라우저 자동 열기 → 대시보드\nBURDEN-CONTRACT: low-touch'

PROMPT_FAIL_MISSING_SURFACE=$"$PROMPT_BASE"$'\nPROOF-EXPECTATION: direct proof via Playwright CLI for S1-S10 navigation, interaction, screenshots, runtime recertification, and SC mapping'

PROMPT_FAIL_MULTILINE_EXPECTATION=$"$PROMPT_BASE"$'\nPROOF-SURFACE: browser-ui\nTOOL-REQUIREMENT: Playwright CLI + chromium + curl + pytest\nPROOF-EXPECTATION:\n - Playwright CLI 로 S1~S10 화면 네비게이션 성공\n - 각 화면 최소 1개 상호작용 동작\n - artifacts/screenshots/*.png 최소 6장'

PROMPT_PASS_ONE_SHOT=$"$PROMPT_BASE"$'\nPROOF-SURFACE: browser-ui\nPROOF-EXPECTATION: direct proof via Playwright CLI for S1-S10 navigation and interaction, screenshots, runtime/API recertification, and SC-1~SC-6 mapping\nTOOL-REQUIREMENT: Playwright CLI + chromium + curl + pytest\nDETAILS:\n- Playwright CLI 로 S1~S10 화면 네비게이션\n- 각 화면 최소 1개 상호작용\n- artifacts/screenshots/*.png 최소 6장'

VALIDATOR_PROMPT_BASE=$'MESSAGE-CLASS: assignment\nTASK-ID: #5c\nWORK-SURFACE: /mnt/d/Agent_team/rnd-budget-webapp/ + docs/04-verification/validator-report.md + artifacts/screenshots/\nCURRENT-PHASE: dev-workflow Phase 4 Final\nACTIVE-WORKFLOW: dev-workflow\nREQUIRED-SKILLS: work-planning(start), self-verification(plan-verify, handoff), validator\nVALIDATION-TARGET: 사용자 전달 웹앱의 launch-path, interaction coverage, visual/user-readiness 수용 판단\nEXPECTATION-SOURCES: design.md §5 + reviewer findings + tester report + requested delivery contract\nREVIEW-STATE: ready\nTEST-STATE: ready\nVALIDATION-SURFACE: browser-ui\nTOOL-REQUIREMENT: Playwright MCP visual inspection + reviewer/tester evidence reconciliation\nUSER-RUN-PATH: run.sh 또는 run.ps1 단일 명령 기동 → 브라우저 자동 열기 → 대시보드\nBURDEN-CONTRACT: low-touch'

PROMPT_VALIDATOR_FAIL_MULTILINE_DECISION=$"$VALIDATOR_PROMPT_BASE"$'\nDECISION-SURFACE:\n - launch path hands-off 성공\n - dashboard first view 시각적 이상 없음\n - 핵심 상호작용 coverage와 user-readiness 정합'

PROMPT_VALIDATOR_PASS_ONE_SHOT=$"$VALIDATOR_PROMPT_BASE"$'\nDECISION-SURFACE: pass or hold based on hands-off launch path, first-view integrity, interaction coverage, and user-readiness reconciliation\nDETAILS:\n- launch path hands-off 성공\n- dashboard first view 시각적 이상 없음\n- 핵심 상호작용 coverage와 user-readiness 정합'

run_case \
  "fail-01-missing-proof-surface" \
  "tester" \
  "$PROMPT_FAIL_MISSING_SURFACE" \
  "PROOF-SURFACE" \
  "PROOF-EXPECTATION" \
  "TOOL-REQUIREMENT" \
  "PROOF-SURFACE" \
  "BLOCKED: dispatch packet incomplete." \
  "PROOF-SURFACE"

run_case \
  "fail-02-multiline-proof-expectation" \
  "tester" \
  "$PROMPT_FAIL_MULTILINE_EXPECTATION" \
  "PROOF-SURFACE" \
  "PROOF-EXPECTATION" \
  "TOOL-REQUIREMENT" \
  "same-line KEY: value" \
  "BLOCKED: dispatch packet incomplete." \
  "PROOF-EXPECTATION"

run_case \
  "pass-03-one-shot-parser-friendly-packet" \
  "tester" \
  "$PROMPT_PASS_ONE_SHOT" \
  "PROOF-SURFACE" \
  "PROOF-EXPECTATION" \
  "TOOL-REQUIREMENT" \
  "PASS: tester packet clears dispatch-proof-gate." \
  "ALLOW" \
  "ALLOW"

run_case \
  "fail-04-validator-multiline-decision-surface" \
  "validator" \
  "$PROMPT_VALIDATOR_FAIL_MULTILINE_DECISION" \
  "VALIDATION-SURFACE" \
  "DECISION-SURFACE" \
  "TOOL-REQUIREMENT" \
  "same-line KEY: value" \
  "BLOCKED: dispatch packet incomplete." \
  "DECISION-SURFACE"

run_case \
  "pass-05-validator-one-shot-parser-friendly-packet" \
  "validator" \
  "$PROMPT_VALIDATOR_PASS_ONE_SHOT" \
  "VALIDATION-SURFACE" \
  "DECISION-SURFACE" \
  "TOOL-REQUIREMENT" \
  "PASS: validator packet clears dispatch-proof-gate." \
  "ALLOW" \
  "ALLOW"

run_repeat_block_case \
  "fail-06-repeat-blocker-escalation" \
  "tester" \
  "$PROMPT_FAIL_MULTILINE_EXPECTATION" \
  "Repeated blocker on the same operating surface. Stop retries and HOLD until the listed preflight step is completed."

printf '\nSUMMARY passes=%d failures=%d\n' "$PASSES" "$FAILURES"

if (( FAILURES > 0 )); then
  exit 1
fi
