#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# PreToolUse warning hook for user-surface Playwright proof tools.
# Self-verification remains doctrine-owned at phase/stage-end reporting gates.

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { encode } = require(process.env.HOOK_JSON_HELPERS);
try {
  const input = JSON.parse(process.env.INPUT_JSON || '{}');
  const sid = String(input.session_id || 'unknown');
  const toolName = String(input.tool_name || '');
  process.stdout.write([sid, toolName].map(encode).join('\n'));
} catch {
  process.stdout.write('\n\n');
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"

SESSION_ID="$(hook_decode_base64_field "${FIELDS[0]:-}")"
TOOL_NAME="$(hook_decode_base64_field "${FIELDS[1]:-}")"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

WP_MARKER="$LOG_DIR/.wp-loaded-${SESSION_ID}"

case "$TOOL_NAME" in
  mcp__playwright__browser_*)
    if [[ ! -f "$WP_MARKER" ]]; then
      printf '[%s] SV-GATE WARN: Playwright user-surface tool before observed work-planning (session: %s)\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "${SESSION_ID:0:20}" >> "$VIOLATION_LOG"
      exit 0
    fi
    ;;
esac

exit 0
