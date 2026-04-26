#!/usr/bin/env bash
set -euo pipefail

HOOK_ROOT="${HOOK_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
TARGET_LANE=""
SUMMARY_TEXT="dispatch packet lint"
KEEP_ROOT="${DISPATCH_PACKET_LINT_KEEP_ROOT:-0}"
TMP_ROOT="${DISPATCH_PACKET_LINT_ROOT:-$(mktemp -d /tmp/dispatch-packet-lint-XXXXXX)}"

usage() {
  printf 'Usage: %s --lane tester|validator [--summary "short description"] < packet.txt\n' "${0##*/}" >&2
}

cleanup() {
  if [[ "$KEEP_ROOT" == "1" ]]; then
    printf 'LINT_ROOT %s\n' "$TMP_ROOT"
    return 0
  fi

  rm -rf "$TMP_ROOT"
}
trap cleanup EXIT

while [[ $# -gt 0 ]]; do
  case "$1" in
    --lane)
      TARGET_LANE="${2-}"
      shift 2
      ;;
    --summary)
      SUMMARY_TEXT="${2-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 2
      ;;
  esac
done

TARGET_LANE="$(printf '%s' "$TARGET_LANE" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
case "$TARGET_LANE" in
  tester|validator)
    ;;
  *)
    usage
    exit 2
    ;;
esac

PACKET_TEXT="$(cat)"
[[ -n "$PACKET_TEXT" ]] || {
  printf 'FAIL: empty packet.\n' >&2
  exit 1
}

export HOME="$TMP_ROOT/home"
export LOG_DIR="$TMP_ROOT/logs"
export PROCEDURE_STATE_DIR="$TMP_ROOT/state"
export PROCEDURE_STATE_FILE="$PROCEDURE_STATE_DIR/procedure-state.json"
export PROCEDURE_STATE_LOCK="$LOG_DIR/.procedure-state.lock"
export PROJECT_CONTINUITY_FILE="$TMP_ROOT/session-state.md"
export HOOK_DIR="$HOOK_ROOT"
export HOOK_HEALTH_SELF_CHECK_MODE=off

mkdir -p "$HOME" "$LOG_DIR" "$PROCEDURE_STATE_DIR"

HOOK_OUTPUT="$(PACKET_TEXT="$PACKET_TEXT" TARGET_LANE="$TARGET_LANE" SUMMARY_TEXT="$SUMMARY_TEXT" node <<'NODE' | bash "$HOOK_ROOT/dispatch-proof-gate.sh" || true
process.stdout.write(JSON.stringify({
  tool_name: "Agent",
  session_id: "dispatch-packet-lint",
  tool_input: {
    description: process.env.SUMMARY_TEXT || "dispatch packet lint",
    subagent_type: process.env.TARGET_LANE || "",
    name: process.env.TARGET_LANE || "",
    run_in_background: true,
    prompt: process.env.PACKET_TEXT || ""
  }
}));
NODE
)"

HOOK_REASON="$(HOOK_OUTPUT="$HOOK_OUTPUT" node <<'NODE'
try {
  const parsed = JSON.parse(process.env.HOOK_OUTPUT || "{}");
  const reason = parsed?.hookSpecificOutput?.permissionDecisionReason || "";
  process.stdout.write(reason || "ALLOW");
} catch {
  process.stdout.write("UNPARSEABLE");
}
NODE
)"

if [[ "$HOOK_REASON" == "ALLOW" ]]; then
  printf 'PASS: %s packet clears dispatch-proof-gate.\n' "$TARGET_LANE"
  exit 0
fi

printf 'FAIL: %s packet blocked.\n' "$TARGET_LANE"
printf '%s\n' "$HOOK_REASON"
exit 1
