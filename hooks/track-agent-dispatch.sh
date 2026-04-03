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
    const preferredKeys = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes"];
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
const collectAgentDispatchText = (toolInput) => joinUniqueText([
  ...flattenText(toolInput.description),
  ...flattenText(toolInput.summary),
  ...flattenText(toolInput.prompt),
  ...flattenText(toolInput.task),
  ...flattenText(toolInput.assignment),
  ...flattenText(toolInput.message),
  ...flattenText(toolInput.content),
  ...flattenText(toolInput.instructions),
  ...flattenText(toolInput.goal),
  ...flattenText(toolInput.brief),
  ...flattenText(toolInput.context),
  ...flattenText(toolInput.request),
  ...flattenText(toolInput.note),
  ...flattenText(toolInput.notes),
]);

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
  const fields = [
    toolName,
    collectAgentDispatchText(toolInput),
    firstNonEmptyString(
      toolInput.name,
      toolInput.agent_name,
      toolInput.agentName,
      toolInput.subagent_type,
      toolInput.subagentType,
      toolInput.role,
      toolInput.lane,
      toolInput.worker_name,
      toolInput.workerName,
      toolInput.teammate_name,
      toolInput.teammateName,
      toolInput.target_name,
      toolInput.targetName
    ),
    String(toolInput.mode || ""),
    String(input.session_id || ""),
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
  process.stdout.write("\n\n\n\n\n\n\n\n");
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
DESCRIPTION="$(decode_field "${FIELDS[1]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[2]:-}")"
MODE="$(decode_field "${FIELDS[3]:-}")"
SESSION_ID="$(decode_field "${FIELDS[4]:-}")"
SUCCESS_VALUE="$(printf '%s' "$(decode_field "${FIELDS[5]:-}")" | tr '[:upper:]' '[:lower:]')"
IS_ERROR_VALUE="$(printf '%s' "$(decode_field "${FIELDS[6]:-}")" | tr '[:upper:]' '[:lower:]')"
ERROR_VALUE="$(decode_field "${FIELDS[7]:-}")"
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

[[ "$TOOL_NAME" == "Agent" ]] || exit 0
tool_response_succeeded || exit 0

if [[ -z "$AGENT_NAME" ]]; then
  AGENT_NAME="$(resolve_requested_dispatch_name "" "$DESCRIPTION")"
fi

[[ -n "$AGENT_NAME" && "$AGENT_NAME" != "unknown" ]] || exit 0

clear_worker_standby "$AGENT_NAME"
record_pending_agent_dispatch "$TIMESTAMP" "$AGENT_NAME" "${MODE:-default}"

if [[ ! -s "$HEALTH_CRON_FLAG" ]]; then
  printf '1\n' > "$HEALTH_CRON_FLAG"
  printf '[%s] HEALTH-CRON: first agent dispatched\n' "$(date '+%Y-%m-%d %H:%M:%S')" >> "$VIOLATION_LOG"
fi

exit 0
