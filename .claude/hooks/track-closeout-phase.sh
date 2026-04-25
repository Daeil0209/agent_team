#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const nestedMessage = toolInput.message || {};
  const topType = String(toolInput.type || "");
  const nestedType = String(nestedMessage.type || "");
  const sessionId = String(input.session_id || "");
  const targetId = String(
    toolInput.id ||
    toolInput.job_id ||
    toolInput.jobId ||
    toolInput.cron_id ||
    toolInput.cronId ||
    ""
  );
  const successValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "success")
    ? String(toolResponse.success)
    : "";
  const isErrorValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "is_error")
    ? String(toolResponse.is_error)
    : "";
  const errorValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "error")
    ? String(toolResponse.error || "")
    : "";
  process.stdout.write(`${toolName}\n${topType}\n${nestedType}\n${sessionId}\n${targetId}\n${successValue}\n${isErrorValue}\n${errorValue}\n`);
} catch {
  process.stdout.write("\n\n\n\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
TOP_TYPE="$(printf '%s' "${FIELDS[1]:-}" | tr '[:upper:]' '[:lower:]')"
MESSAGE_TYPE="$(printf '%s' "${FIELDS[2]:-}" | tr '[:upper:]' '[:lower:]')"
SESSION_ID="${FIELDS[3]:-}"
TARGET_ID="${FIELDS[4]:-}"
SUCCESS_VALUE="$(printf '%s' "${FIELDS[5]:-}" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "${FIELDS[6]:-}" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="${FIELDS[7]:-}"
CURRENT_HEALTH_JOB_ID=""

tool_response_succeeded() {
  if [[ "$SUCCESS_VALUE" == "false" || "$IS_ERROR_VALUE" == "true" ]]; then
    return 1
  fi

  if [[ -n "$ERROR_VALUE" && "$ERROR_VALUE" != "null" && "$ERROR_VALUE" != "undefined" ]]; then
    return 1
  fi

  return 0
}

if [[ -f "$HEALTH_CRON_JOB_FILE" ]]; then
  CURRENT_HEALTH_JOB_ID="$(tr -d '\n' < "$HEALTH_CRON_JOB_FILE" 2>/dev/null || true)"
fi

if ! closeout_intent_is_active "$SESSION_ID"; then
  exit 0
fi

if ! tool_response_succeeded; then
  exit 0
fi

case "$TOOL_NAME" in
  SendMessage)
    if [[ "$TOP_TYPE" == "shutdown_request" || "$MESSAGE_TYPE" == "shutdown_request" ]]; then
      advance_closeout_phase "shutdown_requested" "$SESSION_ID"
    fi
    ;;
  CronDelete)
    if [[ -n "$CURRENT_HEALTH_JOB_ID" ]]; then
      if [[ -z "$TARGET_ID" || "$TARGET_ID" == "$CURRENT_HEALTH_JOB_ID" ]]; then
        advance_closeout_phase "cron_removed" "$SESSION_ID"
      fi
    fi
    ;;
  TeamDelete)
    advance_closeout_phase "runtime_removed" "$SESSION_ID"
    ;;
esac

exit 0
