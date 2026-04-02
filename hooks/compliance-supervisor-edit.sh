#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const filePath = (input.tool_input && (input.tool_input.file_path || input.tool_input.path)) || "";
  const agentId = input.agent_id || "";
  const sessionId = input.session_id || "";
  const agentType = input.agent_type || "";
  process.stdout.write(`${filePath}\n${agentId}\n${sessionId}\n${agentType}\n`);
} catch {
  process.stdout.write("\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
FILE_PATH="${FIELDS[0]:-}"
AGENT_ID="${FIELDS[1]:-}"
SESSION_ID="${FIELDS[2]:-}"
AGENT_TYPE="${FIELDS[3]:-}"

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

CANONICAL_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || printf '%s' "$FILE_PATH")"
BASENAME="$(basename "$CANONICAL_PATH" 2>/dev/null || printf '%s' "$CANONICAL_PATH")"

if echo "$CANONICAL_PATH" | grep -qPi '(^|/)references/'; then
  printf '[%s] A-03 BLOCKED: Reference file write attempt: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CANONICAL_PATH:0:200}" >> "$VIOLATION_LOG"
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[A-03] Cannot overwrite user-provided reference files in ./references/."}}
EOF
  exit 0
fi

if echo "$BASENAME" | grep -qPi '(^\.env$|^\.env\.|credentials\.json$|\.pem$|\.key$|secrets?\.|api.?key)'; then
  printf '[%s] A-02 BLOCKED: Credential file write attempt: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CANONICAL_PATH:0:200}" >> "$VIOLATION_LOG"
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[A-02] Credential or secret file detected. Use secure credential management."}}
EOF
  exit 0
fi

if [[ -n "$AGENT_ID" ]]; then
  if [[ -z "$AGENT_TYPE" ]] && [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MAP" ]]; then
    AGENT_TYPE="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  fi
  AGENT_MODE=""
  if [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MODE_MAP" ]]; then
    AGENT_MODE="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MODE_MAP" 2>/dev/null || true)"
  fi
  if [[ "$AGENT_TYPE" == "developer" ]] && [[ "$AGENT_MODE" =~ ^(proposal|proposal-only|diff|diff-only)$ ]]; then
    printf '[%s] DEV-PROPOSAL BLOCKED: developer attempted edit in %s mode: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$AGENT_MODE" "${CANONICAL_PATH:0:200}" >> "$VIOLATION_LOG"
    cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Developer is running in proposal-only mode. Do not apply edits until the lead authorizes execution/apply mode."}}
EOF
    exit 0
  fi
  exit 0
fi

if echo "$CANONICAL_PATH" | grep -qP '/skills/[^/]+/SKILL\.md$'; then
  printf '[%s] S-22 NOTE: SKILL.md edit: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CANONICAL_PATH:0:200}" >> "$VIOLATION_LOG"
fi
cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Main session is operating in team-lead mode. Delegate file edits to the developer agent instead of editing directly."}}
EOF
exit 0
