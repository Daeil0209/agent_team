#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config-core.sh"
source "$(dirname "$0")/lib/hook-agent-dispatch.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
try {
	  const input = JSON.parse(process.env.INPUT_JSON || "{}");
	  const toolInput = input.tool_input || {};
	  const subject = String(input.task_subject || input.taskSubject || toolInput.task_subject || toolInput.taskSubject || toolInput.subject || toolInput.title || "").trim();
	  const description = String(input.task_description || input.taskDescription || toolInput.task_description || toolInput.taskDescription || toolInput.description || "").trim();
	  const teammate = String(input.teammate_name || input.teammateName || toolInput.teammate_name || toolInput.teammateName || "").trim();
	  const team = String(input.team_name || input.teamName || toolInput.team_name || toolInput.teamName || "").trim();
	  const toolName = String(input.tool_name || "");
	  process.stdout.write([subject, description, teammate, team, toolName].map(encode).join("\n"));
	} catch {
	  process.stdout.write("\n\n\n\n");
	}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TASK_SUBJECT="$(hook_decode_base64_field "${FIELDS[0]:-}")"
TASK_DESCRIPTION="$(hook_decode_base64_field "${FIELDS[1]:-}")"
TEAMMATE_NAME="$(hook_decode_base64_field "${FIELDS[2]:-}")"
TEAM_NAME="$(hook_decode_base64_field "${FIELDS[3]:-}")"
TOOL_NAME="$(hook_decode_base64_field "${FIELDS[4]:-}")"

deny_task_create() {
  local reason="${1:?reason required}"
  printf '[%s] TASK-CREATED BLOCKED: team=%s teammate=%s subject=%s reason=%s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "${TEAM_NAME:-unknown}" "${TEAMMATE_NAME:-unknown}" "${TASK_SUBJECT:-<empty>}" "$reason" >> "$VIOLATION_LOG"
  if [[ "$TOOL_NAME" == "TaskCreate" ]]; then
    hook_emit_pretool_deny "$reason" "TaskCreate blocked."
    exit 0
  fi
  printf '%s\n' "$reason" >&2
  exit 2
}

task_create_error() {
  local detail="${1:?detail required}"
  if [[ "$TOOL_NAME" == "TaskCreate" ]]; then
    printf 'BLOCKED: task-create packet incomplete. Detail: %s Next: create the task with a non-empty subject, one bounded-scope coordinate, and one completion coordinate in the description. Do not retry before Next is complete.' "$detail"
  else
    printf 'TaskCreated requires %s' "$detail"
  fi
}

[[ -n "$TASK_SUBJECT" ]] || deny_task_create "$(task_create_error "a non-empty task subject.")"
[[ -n "$TASK_DESCRIPTION" ]] || deny_task_create "$(task_create_error "a non-empty task description so the shared task list remains a reliable state surface.")"

# Minimal-guidance policy: TaskCreate should block only when the shared task row
# is effectively unusable as a state surface. Non-empty subject + description are
# sufficient for execution; bounded-scope and completion coordinates remain best
# practice but do not justify a hard block by themselves.

exit 0
