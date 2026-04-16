#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

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
decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

TASK_SUBJECT="$(decode_field "${FIELDS[0]:-}")"
TASK_DESCRIPTION="$(decode_field "${FIELDS[1]:-}")"
TEAMMATE_NAME="$(decode_field "${FIELDS[2]:-}")"
TEAM_NAME="$(decode_field "${FIELDS[3]:-}")"
TOOL_NAME="$(decode_field "${FIELDS[4]:-}")"

deny_task_create() {
  local reason="${1:?reason required}"
  printf '[%s] TASK-CREATED BLOCKED: team=%s teammate=%s subject=%s reason=%s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "${TEAM_NAME:-unknown}" "${TEAMMATE_NAME:-unknown}" "${TASK_SUBJECT:-<empty>}" "$reason" >> "$VIOLATION_LOG"
  if [[ "$TOOL_NAME" == "TaskCreate" ]]; then
    DENY_REASON="$reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "TaskCreate blocked."
  }
}));
NODE
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

has_any_dispatch_field() {
  local field_name=""
  for field_name in "$@"; do
    if dispatch_field_present "$TASK_DESCRIPTION" "$field_name" 2>/dev/null; then
      return 0
    fi
  done
  # Fallback: detect FIELD-NAME: pattern mid-line when semicolons are absent
  local lower_desc
  lower_desc="$(printf '%s' "$TASK_DESCRIPTION" | tr '[:upper:]' '[:lower:]')"
  for field_name in "$@"; do
    local lower_field
    lower_field="$(printf '%s' "$field_name" | tr '[:upper:]' '[:lower:]')"
    if printf '%s' "$lower_desc" | grep -qF "${lower_field}:" 2>/dev/null; then
      return 0
    fi
  done
  return 1
}

if ! has_any_dispatch_field "QUESTION-BOUNDARY" "CHANGE-BOUNDARY" "CHILD-BOUNDARY" "EXCLUDED-BOUNDARY" "EXCLUDED-SCOPE" "WORK-SURFACE"; then
  deny_task_create "$(task_create_error "a bounded-scope coordinate in the description. Use QUESTION-BOUNDARY, CHANGE-BOUNDARY, CHILD-BOUNDARY, EXCLUDED-BOUNDARY, EXCLUDED-SCOPE, or WORK-SURFACE.")"
fi

if ! has_any_dispatch_field "DONE-CONDITION" "OUTPUT-SURFACE" "PROOF-TARGET" "VALIDATION-TARGET" "ACCEPTANCE-SURFACE" "DECISION-SURFACE"; then
  deny_task_create "$(task_create_error "an expected completion surface in the description. Use DONE-CONDITION, OUTPUT-SURFACE, PROOF-TARGET, VALIDATION-TARGET, ACCEPTANCE-SURFACE, or DECISION-SURFACE.")"
fi

exit 0
