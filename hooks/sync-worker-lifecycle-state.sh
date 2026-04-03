#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) return preferred;
    return Object.values(value).flatMap(flattenText);
  }
  return [];
};
const joinUniqueText = (chunks) => {
  const seen = new Set();
  return chunks
    .map((chunk) => String(chunk || "").trim())
    .filter(Boolean)
    .filter((chunk) => {
      if (seen.has(chunk)) return false;
      seen.add(chunk);
      return true;
    })
    .join("\n");
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const nestedMessage = toolInput.message || {};
  const description = joinUniqueText(
    flattenText(toolInput.summary).concat(flattenText(toolInput.message || toolInput.content))
  );
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName
  );
  const fields = [
    toolName,
    targetName,
    String(toolInput.type || ""),
    String(nestedMessage.type || ""),
    description,
    String(input.session_id || ""),
    String(input.agent_id || ""),
    String(input.agent_type || ""),
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "success")
      ? String(toolResponse.success)
      : "",
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "is_error")
      ? String(toolResponse.is_error)
      : "",
    toolResponse && Object.prototype.hasOwnProperty.call(toolResponse, "error")
      ? String(toolResponse.error || "")
      : "",
  ];
  process.stdout.write(fields.map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"

decode_field() {
  local encoded="${1-}"
  if [[ -z "$encoded" ]]; then
    printf ''
    return 0
  fi
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
TARGET_NAME="$(decode_field "${FIELDS[1]:-}")"
TOP_TYPE="$(printf '%s' "$(decode_field "${FIELDS[2]:-}")" | tr '[:upper:]' '[:lower:]')"
MESSAGE_TYPE="$(printf '%s' "$(decode_field "${FIELDS[3]:-}")" | tr '[:upper:]' '[:lower:]')"
DESCRIPTION="$(decode_field "${FIELDS[4]:-}")"
SESSION_ID="$(decode_field "${FIELDS[5]:-}")"
AGENT_ID="$(decode_field "${FIELDS[6]:-}")"
AGENT_TYPE="$(decode_field "${FIELDS[7]:-}")"
SUCCESS_VALUE="$(printf '%s' "$(decode_field "${FIELDS[8]:-}")" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "$(decode_field "${FIELDS[9]:-}")" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="$(decode_field "${FIELDS[10]:-}")"

tool_response_succeeded() {
  if [[ "$SUCCESS_VALUE" == "false" || "$IS_ERROR_VALUE" == "true" ]]; then
    return 1
  fi

  if [[ -n "$ERROR_VALUE" && "$ERROR_VALUE" != "null" && "$ERROR_VALUE" != "undefined" ]]; then
    return 1
  fi

  return 0
}

schedule_current_pane_shutdown() {
  local tmux_ref="${TMUX:-}"
  local pane_id="${TMUX_PANE:-}"
  local socket_path=""

  [[ -n "$tmux_ref" && -n "$pane_id" ]] || return 0
  command -v tmux >/dev/null 2>&1 || return 0

  socket_path="$(printf '%s' "$tmux_ref" | cut -d',' -f1)"
  [[ -n "$socket_path" ]] || return 0

  (
    sleep 1
    tmux -S "$socket_path" kill-pane -t "$pane_id" >/dev/null 2>&1 || true
  ) >/dev/null 2>&1 &
}

[[ "$TOOL_NAME" == "SendMessage" ]] || exit 0
tool_response_succeeded || exit 0

SENDER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
if [[ -z "$SENDER_NAME" && -n "$AGENT_ID" && "$AGENT_ID" != "team-lead" ]]; then
  SENDER_NAME="$AGENT_ID"
fi

SENDER_IS_WORKER="false"
if session_id_is_known_worker "$SESSION_ID"; then
  SENDER_IS_WORKER="true"
fi

MESSAGE_CLASS="$(dispatch_field_raw_value "$DESCRIPTION" "message-class" | tr '[:upper:]' '[:lower:]')"

if [[ "$TOP_TYPE" == "shutdown_response" || "$MESSAGE_TYPE" == "shutdown_response" ]]; then
  if [[ "$SENDER_IS_WORKER" == "true" && -n "$SENDER_NAME" ]]; then
    remove_worker_everywhere "$SENDER_NAME"
    schedule_current_pane_shutdown
  fi
  exit 0
fi

if [[ "$SENDER_IS_WORKER" == "true" ]]; then
  exit 0
fi

case "$MESSAGE_CLASS" in
  standby)
    if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
      mark_worker_standby "$TARGET_NAME"
    fi
    ;;
  assignment|reuse)
    if [[ -n "$TARGET_NAME" && "$TARGET_NAME" != "team-lead" ]]; then
      clear_worker_standby "$TARGET_NAME"
    fi
    ;;
esac

exit 0
