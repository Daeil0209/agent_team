#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const filePath = toolInput.file_path || toolInput.path || "";
  const agentId = input.agent_id || "";
  process.stdout.write(`${filePath}\n${agentId}\n`);
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
FILE_PATH="${FIELDS[0]:-}"
AGENT_ID="${FIELDS[1]:-}"

if [[ -n "$AGENT_ID" || -z "$FILE_PATH" ]]; then
  exit 0
fi

TARGET_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || printf '%s' "$FILE_PATH")"
REPO_ROOT="$(resolve_project_root)"
EXPECTED_STATE_FILE="$(realpath -m "$REPO_ROOT/.claude/session-state.md" 2>/dev/null || printf '%s' "$REPO_ROOT/.claude/session-state.md")"

if [[ "$TARGET_PATH" == */.claude/session-state.md ]] && [[ "$TARGET_PATH" != "$EXPECTED_STATE_FILE" ]]; then
  printf '[%s] MAIN-CONTINUITY-ANCHOR BLOCKED: %s (expected %s)\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "${TARGET_PATH:0:200}" \
    "${EXPECTED_STATE_FILE:0:200}" >> "$VIOLATION_LOG"
  cat <<EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Continuity reads must stay anchored to the active project root. Use $EXPECTED_STATE_FILE and do not guess repo paths from team names, team directories, or prior sessions."}}
EOF
  exit 0
fi

exit 0
