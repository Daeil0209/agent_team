#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = input.tool_name || "";
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};

  const lookup = (obj, keys) => {
    for (const key of keys) {
      if (obj && obj[key] !== undefined && obj[key] !== null && String(obj[key]) !== "") {
        return String(obj[key]);
      }
    }
    return "";
  };

  const responseId = lookup(toolResponse, ["job_id", "jobId", "id", "cron_id", "cronId"]);
  const inputId = lookup(toolInput, ["job_id", "jobId", "id", "cron_id", "cronId"]);
  const commandLike = String(toolInput.prompt || toolInput.command || toolInput.description || "");
  const sessionId = String(input.session_id || "");
  const successValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "success")
    ? String(toolResponse.success)
    : "";
  const isErrorValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "is_error")
    ? String(toolResponse.is_error)
    : "";
  const errorValue = toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "error")
    ? String(toolResponse.error || "")
    : "";
  process.stdout.write(`${toolName}\n${commandLike}\n${responseId}\n${inputId}\n${sessionId}\n${successValue}\n${isErrorValue}\n${errorValue}\n`);
} catch {
  process.stdout.write("\n\n\n\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
COMMAND_LIKE="${FIELDS[1]:-}"
RESPONSE_ID="${FIELDS[2]:-}"
INPUT_ID="${FIELDS[3]:-}"
SESSION_ID="${FIELDS[4]:-}"
SUCCESS_VALUE="$(printf '%s' "${FIELDS[5]:-}" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "${FIELDS[6]:-}" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="${FIELDS[7]:-}"
TIMESTAMP="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

tool_response_succeeded() {
  if [[ "$SUCCESS_VALUE" == "false" || "$IS_ERROR_VALUE" == "true" ]]; then
    return 1
  fi

  if [[ -n "$ERROR_VALUE" && "$ERROR_VALUE" != "null" && "$ERROR_VALUE" != "undefined" ]]; then
    return 1
  fi

  return 0
}

is_health_check_cron() {
  local raw="${1-}"
  local normalized=""

  [[ -n "$raw" ]] || return 1
  normalized="$(printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//')"

  if [[ "$normalized" == *"health-check.sh"* ]]; then
    return 0
  fi

  if printf '%s' "$normalized" | grep -Eq '^health[- ]check:'; then
    return 0
  fi

  return 1
}

mark_runtime_active() {
  printf '%s | explicit-team-runtime-active\n' "$TIMESTAMP" > "$TEAM_RUNTIME_ACTIVE_FILE"
}

clear_runtime_active() {
  : > "$TEAM_RUNTIME_ACTIVE_FILE"
}

mark_boot_complete() {
  printf '%s | boot-complete\n' "$TIMESTAMP" > "$BOOT_SEQUENCE_COMPLETE_FILE"
}

clear_boot_complete() {
  : > "$BOOT_SEQUENCE_COMPLETE_FILE"
}

record_health_cron() {
  local job_id="$1"
  [[ -n "$job_id" ]] || return 0
  printf '%s\n' "$job_id" > "$HEALTH_CRON_JOB_FILE"
  if [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]]; then
    mark_boot_complete
  fi
}

clear_health_cron() {
  : > "$HEALTH_CRON_JOB_FILE"
  if [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]]; then
    clear_boot_complete
  fi
}

# TeamCreate "Already leading" is not a runtime failure — the team IS active.
# Re-affirm runtime state even when TeamCreate returns an already-exists error.
if [[ "$TOOL_NAME" == "TeamCreate" ]] && ! tool_response_succeeded; then
  if [[ "$ERROR_VALUE" == *"Already leading"* ]]; then
    if [[ -n "$SESSION_ID" ]]; then
      record_runtime_session_id "$SESSION_ID"
    fi
    mark_runtime_active
    mark_boot_complete
  fi
  exit 0
fi

if ! tool_response_succeeded; then
  exit 0
fi

case "$TOOL_NAME" in
  TeamCreate)
    if [[ -n "$SESSION_ID" ]]; then
      record_runtime_session_id "$SESSION_ID"
    fi
    mark_runtime_active
    mark_boot_complete
    ;;
  TeamDelete)
    clear_runtime_active
    clear_boot_complete
    clear_runtime_session_id
    clear_health_cron_rotation_intent "team-runtime-removed" "$SESSION_ID"
    ;;
  CronCreate)
    if is_health_check_cron "$COMMAND_LIKE"; then
      record_health_cron "$RESPONSE_ID"
      if [[ -n "$SESSION_ID" ]] && health_cron_rotation_is_active "$SESSION_ID"; then
        advance_health_cron_rotation_phase "replacement_created" "$SESSION_ID" "" "$RESPONSE_ID"
        clear_health_cron_rotation_intent "health-cron-rotation-complete" "$SESSION_ID"
      fi
    fi
    ;;
  CronDelete)
    CURRENT_JOB_ID="$(current_health_cron_job_id)"
    if [[ -n "$CURRENT_JOB_ID" ]]; then
      if [[ -z "$INPUT_ID" || "$INPUT_ID" == "$CURRENT_JOB_ID" ]]; then
        if [[ -n "$SESSION_ID" ]] && health_cron_rotation_is_active "$SESSION_ID" "$CURRENT_JOB_ID"; then
          advance_health_cron_rotation_phase "target_deleted" "$SESSION_ID" "$CURRENT_JOB_ID"
        fi
        clear_health_cron
      fi
    fi
    ;;
esac

exit 0
