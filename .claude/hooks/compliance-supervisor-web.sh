#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const sessionId = String(input.session_id || "");
  const agentId = String(input.agent_id || "");
  const agentType = String(input.agent_type || "");
  process.stdout.write(`${toolName}\n${sessionId}\n${agentId}\n${agentType}\n`);
} catch {
  process.stdout.write("\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
SESSION_ID="${FIELDS[1]:-}"
AGENT_ID="${FIELDS[2]:-}"
AGENT_TYPE="${FIELDS[3]:-}"

[[ "$TOOL_NAME" == "WebSearch" || "$TOOL_NAME" == "WebFetch" ]] || exit 0

resolve_sender_role() {
  local sender_role=""

  if [[ -z "$AGENT_ID" ]]; then
    printf 'team-lead'
    return 0
  fi

  sender_role="$AGENT_TYPE"
  if [[ -z "$sender_role" ]] && [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MAP" ]]; then
    sender_role="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  fi
  if [[ -z "$sender_role" ]]; then
    sender_role="$(resolve_agent_id "$AGENT_ID")"
  fi

  printf '%s' "${sender_role:-unknown}"
}

emit_deny() {
  local reason="${1:?reason required}"
  DENY_REASON="$reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Web research is blocked."
  }
}));
NODE
}

SENDER_ROLE="$(resolve_sender_role)"

case "$SENDER_ROLE" in
  researcher)
    exit 0
    ;;
  team-lead|supervisor)
    emit_deny "Main session must not perform direct web research. Delegate external evidence gathering to researcher so the evidence packet, contradiction work, and cross-check status stay explicit."
    exit 0
    ;;
  developer|reviewer|tester|validator|int-op|unknown|unknown-agent)
    emit_deny "This lane must not perform direct web research. Route external evidence gathering through researcher so the evidence packet, contradiction work, and cross-check status stay explicit."
    exit 0
    ;;
  *)
    emit_deny "Direct web research is reserved for the researcher lane unless doctrine defines a narrower exception path."
    exit 0
    ;;
esac
