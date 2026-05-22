#!/usr/bin/env bash
set -euo pipefail

# Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
# (negative-only-filter doctrine: hooks block only destructive, security-critical, or
# session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
# owned by the lane trio — Skill(governance-modification) + Skill(self-verification) +
# Skill(review-verification) named lenses — and downstream reviewer/validator gates).
# settings.json matcher was removed in the same governance patch; this file-level
# no-op handles already-started agents or local hook harness state after the wiring change.
# File preserved for traceability and potential future narrowing to a negative-only filter.
exit 0

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
	  const collectPaths = (value) => {
	    if (!value || typeof value !== "object") return [];
	    const paths = [];
	    for (const key of ["file_path", "path"]) {
	      if (typeof value[key] === "string" && value[key].trim()) paths.push(value[key].trim());
	    }
	    for (const key of ["edits", "files"]) {
	      if (!Array.isArray(value[key])) continue;
	      for (const entry of value[key]) {
	        if (typeof entry === "string" && entry.trim()) paths.push(entry.trim());
	        else if (entry && typeof entry === "object") {
	          for (const nestedKey of ["file_path", "path"]) {
	            if (typeof entry[nestedKey] === "string" && entry[nestedKey].trim()) paths.push(entry[nestedKey].trim());
	          }
	        }
	      }
	    }
	    return [...new Set(paths)];
	  };
		  const toolInput = input.tool_input || {};
		  const fields = [
		    String(input.tool_name || ""),
		    String(input.session_id || ""),
		    String(input.agent_id || ""),
		    String(input.agent_type || ""),
		    String(toolInput.command || ""),
		    String(toolInput.skill || ""),
		    String(toolInput.task_id || toolInput.taskId || toolInput.id || ""),
		    collectPaths(toolInput).join("\n")
		  ];
	  process.stdout.write(fields.join("\n"));
	} catch {
	  process.stdout.write("\n\n\n\n\n\n");
	}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
SESSION_ID="${FIELDS[1]:-}"
AGENT_ID="${FIELDS[2]:-}"
AGENT_TYPE="${FIELDS[3]:-}"
COMMAND="${FIELDS[4]:-}"
SKILL_NAME_RAW="${FIELDS[5]:-}"
TASK_ID="${FIELDS[6]:-}"
TARGET_PATHS="$(printf '%s\n' "${FIELDS[@]:7}")"
SESSION_ID="$(recover_session_id "$SESSION_ID")"
SKILL_NAME_NORM="$(printf '%s' "$SKILL_NAME_RAW" | tr '[:upper:]' '[:lower:]')"
WP_MARKER="$LOG_DIR/.wp-loaded-${SESSION_ID}"
RESULT_VERIFICATION_MARKER="$LOG_DIR/.sv-result-loaded-${SESSION_ID}"
RESULT_VERIFICATION_CONVERGED_MARKER="$LOG_DIR/.sv-converged-${SESSION_ID}"
POST_WP_ACTION_MARKER="$LOG_DIR/.post-wp-action-${SESSION_ID}"
TASK_EXECUTION_MARKER="$LOG_DIR/.task-execution-loaded-${SESSION_ID}"
# session-boot marker: active runtime requires monitoring before fresh dispatch.
SB_LOADED_MARKER="$LOG_DIR/.sb-loaded-${SESSION_ID}"

deny_tool_use() {
  local reason="${1:?reason required}"
  local surface_key=""
  surface_key="${TASK_ID:-}"
  if [[ -z "$surface_key" ]]; then
    surface_key="$(printf '%s' "$TARGET_PATHS" | sed -n '1p')"
  fi
  reason="$(augment_precheck_block_reason_on_repeat "$SESSION_ID" "$TOOL_NAME" "${surface_key:-generic}" "$reason")"
  hook_emit_pretool_deny "$reason" "Task start blocked."
}

mark_post_wp_action_after_planning() {
  [[ -f "$WP_MARKER" ]] || return 0
  [[ "$TOOL_NAME" == "Skill" ]] && return 0
  date -u '+%Y-%m-%dT%H:%M:%SZ' > "$POST_WP_ACTION_MARKER"
}

self_growth_gate_applies_to_tool() {
  local tool_name="${1:-}"
  case "$tool_name" in
    Agent|TaskCreate|SendMessage)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

self_growth_required_for_session() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 1
  if declare -F self_growth_required >/dev/null 2>&1; then
    self_growth_required "$session_id"
    return
  fi
  identity_present_in_file "$SELF_GROWTH_PENDING_FILE" "$session_id"
}

completion_grade_sendmessage_missing_result_verification() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  if ! INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText } = require(process.env.HOOK_JSON_HELPERS);
const TASK_START_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase().replace(/\s+/g, "");
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary, TASK_START_TEXT_KEYS)
    .concat(flattenText(toolInput.message, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.content, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.description, TASK_START_TEXT_KEYS))
    .join("\n");
  const stateSignal = text.trim().replace(/\s+/g, " ");
  if (/^completion(?: task [A-Za-z0-9._:-]+)?$/i.test(stateSignal)) process.exit(0);
  const messageClass = field(text, "MESSAGE-CLASS");
  process.exit(messageClass === "completion" ? 0 : 1);
} catch {
  process.exit(1);
}
NODE
  then
    return 1
  fi
  [[ -f "$RESULT_VERIFICATION_MARKER" ]] && return 1
  return 0
}

sendmessage_is_first_receipt_outcome_to_lead() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local message_class=""
  local target_name=""
  local ack_payload_ok=""

  parsed="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
const TASK_START_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
function field(text, name) {
  if (String(name || "").toLowerCase() === "message-class") {
    const classRe = /(?:^|\n|\|)\s*-?\s*MESSAGE-CLASS\s*:\s*(hold\|blocker|[A-Za-z0-9_-]+)/i;
    const classMatch = text.match(classRe);
    return String(classMatch ? classMatch[1] : "").trim().toLowerCase();
  }
  const re = new RegExp(`(?:^|\\n|\\|)\\s*-?\\s*${name}\\s*:\\s*([^\\n\\r|]+)`, "i");
  const match = text.match(re);
  return String(match ? match[1] : "").trim().toLowerCase();
}
function governedPayloadText(toolInput) {
  const candidates = [
    flattenText(toolInput.summary, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.message, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.content, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.description, TASK_START_TEXT_KEYS).join("\n"),
  ].map((chunk) => String(chunk || "").trim()).filter(Boolean);
  return candidates.find((chunk) => /(?:^|\n|\|)\s*-?\s*MESSAGE-CLASS\s*:/i.test(chunk)) || candidates.join("\n");
}
function stateSignalSourceCount(toolInput, signalRe) {
  const chunks = [
    flattenText(toolInput.summary, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.title, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.message, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.content, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.description, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.body, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.note, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.notes, TASK_START_TEXT_KEYS).join("\n"),
  ].map((chunk) => String(chunk || "").trim().replace(/\s+/g, " ")).filter(Boolean);
  return chunks.filter((chunk) => signalRe.test(chunk)).length;
}
function singleStateSignal(toolInput, signalRe) {
  const chunks = [
    flattenText(toolInput.summary, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.title, TASK_START_TEXT_KEYS).join("\n"),
  ].map((chunk) => String(chunk || "").trim().replace(/\s+/g, " ")).filter(Boolean);
  const signals = chunks.filter((chunk) => signalRe.test(chunk));
  return signals.length === 1 ? signals[0] : "";
}
function bodySlotHasVisibleText(toolInput) {
  const chunks = [
    flattenText(toolInput.message, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.content, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.body, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.description, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.note, TASK_START_TEXT_KEYS).join("\n"),
    flattenText(toolInput.notes, TASK_START_TEXT_KEYS).join("\n"),
  ].map((chunk) => String(chunk || "").trim()).filter(Boolean);
  return chunks.length > 0;
}
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = governedPayloadText(toolInput);
  const messageClass = field(text, "MESSAGE-CLASS");
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  ).toLowerCase();
  const rawText = text.trim();
  const hasLineBreak = /\r?\n/.test(rawText);
  const ackSignalRe = /^ack(?: task [A-Za-z0-9._:-]+)?$/i;
  const ackSignal = singleStateSignal(toolInput, ackSignalRe);
  const duplicateStateSignal = stateSignalSourceCount(toolInput, ackSignalRe) > 1;
  let ackPayloadOk = !duplicateStateSignal && Boolean(ackSignal) && !bodySlotHasVisibleText(toolInput) && (!hasLineBreak || ackSignalRe.test(rawText));
  let effectiveClass = messageClass;
  if (ackPayloadOk) {
    effectiveClass = "dispatch-ack";
  }
  process.stdout.write(`${effectiveClass}\n${targetName}\n${ackPayloadOk ? "yes" : "no"}\n`);
} catch {
  process.stdout.write("\n\nno\n");
}
NODE
)"
  mapfile -t _receipt_fields <<<"$parsed"
  message_class="${_receipt_fields[0]:-}"
  target_name="${_receipt_fields[1]:-}"
  ack_payload_ok="${_receipt_fields[2]:-no}"

  case "$target_name" in
    ""|team-lead|lead|supervisor) ;;
    *) return 1 ;;
  esac

  case "$message_class" in
    dispatch-ack)
      [[ "$ack_payload_ok" == "yes" ]]
      return
      ;;
    scope-pressure|hold\|blocker)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

sendmessage_malformed_visible_state_signal_to_lead() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { firstNonEmptyString, flattenText } = require(process.env.HOOK_JSON_HELPERS);
const KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
function normalize(value) {
  return String(value || "").trim().replace(/\s+/g, " ");
}
function slotText(toolInput, key) {
  if (!Object.prototype.hasOwnProperty.call(toolInput, key)) return "";
  return normalize(flattenText(toolInput[key], KEYS).join("\n"));
}
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const targetName = normalize(firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  )).toLowerCase();
  if (!["", "team-lead", "lead", "supervisor"].includes(targetName)) process.exit(1);

  const allSlots = ["summary", "title", "message", "content", "description", "body", "note", "notes"]
    .map((key) => slotText(toolInput, key))
    .filter(Boolean);
  const headerSlots = ["summary", "title"]
    .map((key) => slotText(toolInput, key))
    .filter(Boolean);
  const bodySlots = ["message", "content", "body"]
    .concat(["description", "note", "notes"])
    .map((key) => slotText(toolInput, key))
    .filter(Boolean);
  const stateRe = /^(ack|completion)(?: task [A-Za-z0-9._:-]+)?$/i;
  const stateSignalSlots = allSlots.filter((slot) => stateRe.test(slot));
  const headerStateSignalSlots = headerSlots.filter((slot) => stateRe.test(slot));
  const bodyStateSignalSlots = bodySlots.filter((slot) => stateRe.test(slot));
  if (stateSignalSlots.length > 1) process.exit(0);
  if (stateSignalSlots.length === 1 && (headerStateSignalSlots.length !== 1 || bodySlots.length > 0 || bodyStateSignalSlots.length > 0)) process.exit(0);
  if (allSlots.some((slot) => /(?:^|\n|\|)\s*-?\s*MESSAGE-CLASS\s*:\s*(dispatch-ack|completion)\b/i.test(slot))) process.exit(0);
  process.exit(1);
} catch {
  process.exit(1);
}
NODE
}


lead_sendmessage_is_worker_cleanup_control() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local top_type=""
  local nested_type=""

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const nestedMessage = toolInput.message || {};
  const fields = [
    String(toolInput.type || "").trim().toLowerCase(),
    String(nestedMessage.type || "").trim().toLowerCase()
  ];
  process.stdout.write(fields.join("\n"));
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
  mapfile -t _lifecycle_fields <<<"$parsed"
  top_type="${_lifecycle_fields[0]:-}"
  nested_type="${_lifecycle_fields[1]:-}"

  case "$top_type:$nested_type" in
    shutdown_request:*|*:shutdown_request) return 0 ;;
  esac

  return 1
}

lead_sendmessage_is_bounded_iteration_continuation() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local message_class=""
  local continuation_class=""
  local iteration_owner_lane=""
  local target_name=""
  local has_required_skills=""
  local has_task_id=""
  local task_tracking_context=""

  parsed="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
const TASK_START_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase();
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary, TASK_START_TEXT_KEYS)
    .concat(flattenText(toolInput.message, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.content, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.description, TASK_START_TEXT_KEYS))
    .join("\n");
  const hasRequiredSkills = /(?:^|\n)\s*required-skills\s*:/i.test(text) ? "true" : "false";
  const hasTaskId = /(?:^|\n)\s*task-id\s*:/i.test(text) ? "true" : "false";
  const taskTrackingContext = /(task[ -]?tracking|taskcreate|task-created|assigned[ -]?id|task-id\s+(required|active))/i.test(text) ? "true" : "false";
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  ).toLowerCase();
  process.stdout.write([
    field(text, "message-class"),
    field(text, "continuation-class"),
    field(text, "iteration-owner-lane"),
    targetName,
    hasRequiredSkills,
    hasTaskId,
    taskTrackingContext
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n");
}
NODE
)"
  mapfile -t _continuation_fields <<<"$parsed"
  message_class="${_continuation_fields[0]:-}"
  continuation_class="${_continuation_fields[1]:-}"
  iteration_owner_lane="${_continuation_fields[2]:-}"
  target_name="$(normalize_lane_id "${_continuation_fields[3]:-}")"
  has_required_skills="${_continuation_fields[4]:-false}"
  has_task_id="${_continuation_fields[5]:-false}"
  task_tracking_context="${_continuation_fields[6]:-false}"

  case "$message_class" in
    reuse|reroute) ;;
    *) return 1 ;;
  esac

  [[ "$continuation_class" == "bounded-iteration" ]] || return 1
  [[ "$has_required_skills" == "true" ]] || return 1
  if [[ "$task_tracking_context" == "true" && "$has_task_id" != "true" ]]; then
    return 0
  fi

  case "$iteration_owner_lane" in
    developer|reviewer|tester|validator) ;;
    *) return 1 ;;
  esac

  [[ -n "$target_name" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 1 ;;
  esac
  [[ "$target_name" == "$iteration_owner_lane" ]] || return 1

  if target_is_already_active_worker "$target_name"; then
    return 0
  fi

  worker_is_standby "$target_name"
}

latest_worker_transport_class_for_gate() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" WORKER_TRANSPORT_LEDGER="$WORKER_TRANSPORT_LEDGER" node <<'NODE' 2>/dev/null || true
const fs = require("fs");

const ledgerPath = process.env.WORKER_TRANSPORT_LEDGER || "";
const workerName = String(process.env.WORKER_NAME || "").trim().toLowerCase();
if (!ledgerPath || !workerName || !fs.existsSync(ledgerPath)) process.exit(0);

let latest = null;
for (const line of fs.readFileSync(ledgerPath, "utf8").split(/\r?\n/)) {
  if (!line) continue;
  let parsed;
  try {
    parsed = JSON.parse(line);
  } catch {
    continue;
  }
  if (!parsed || typeof parsed !== "object") continue;
  const senderName = String(parsed.senderName || "").trim().toLowerCase();
  if (senderName !== workerName) continue;
  const timestamp = String(parsed.timestamp || "");
  if (!latest || timestamp >= String(latest.timestamp || "")) latest = parsed;
}

if (latest) {
  process.stdout.write(`${String(latest.messageClass || "").toLowerCase()}\n${String(latest.timestamp || "")}\n${String(latest.taskId || "")}\n`);
}
NODE
}

worker_sendmessage_reopens_closed_task() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1
  runtime_sender_session_is_worker "$SESSION_ID" || return 1

  local worker_name=""
  local latest=""
  local latest_class=""
  local latest_task_id=""
  local parsed=""
  local target_name=""
  local message_class=""
  local outgoing_task_id=""
  local top_type=""
  local nested_type=""

  worker_name="$(worker_name_for_session_id "$SESSION_ID")"
  worker_name="$(normalize_lane_id "$worker_name")"
  [[ -n "$worker_name" ]] || return 1
  worker_is_standby "$worker_name" || return 1

  latest="$(latest_worker_transport_class_for_gate "$worker_name")"
  mapfile -t _closed_transport_fields <<<"$latest"
  latest_class="${_closed_transport_fields[0]:-}"
  latest_task_id="$(printf '%s' "${_closed_transport_fields[2]:-}" | tr -d '[:space:]')"
  case "$latest_class" in
    completion) ;;
    *) return 1 ;;
  esac
  [[ -n "$latest_task_id" ]] || return 1

  parsed="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
const KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
function field(text, name) {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n|\\|)\\s*-?\\s*${escaped}\\s*:\\s*([^\\n\\r|]+)`, "i"));
  return String(match ? match[1] : "").trim();
}
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const nested = toolInput.message && typeof toolInput.message === "object" ? toolInput.message : {};
  const text = flattenText(toolInput.summary, KEYS)
    .concat(flattenText(toolInput.message, KEYS))
    .concat(flattenText(toolInput.content, KEYS))
    .concat(flattenText(toolInput.description, KEYS))
    .join("\n")
    .trim();
  const state = text.replace(/\s+/g, " ");
  let klass = field(text, "MESSAGE-CLASS").toLowerCase().replace(/\s+/g, "");
  let task = field(text, "TASK-ID").replace(/\s+/g, "");
  let match = state.match(/^ack(?: task ([A-Za-z0-9._:-]+))?$/i);
  if (!klass && match) {
    klass = "dispatch-ack";
    task = task || match[1] || "";
  }
  match = state.match(/^completion(?: task ([A-Za-z0-9._:-]+))?$/i);
  if (!klass && match) {
    klass = "completion";
    task = task || match[1] || "";
  }
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  ).toLowerCase();
  process.stdout.write([
    targetName,
    klass,
    task,
    String(toolInput.type || "").trim().toLowerCase(),
    String(nested.type || "").trim().toLowerCase()
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n");
}
NODE
)"
  mapfile -t _closed_send_fields <<<"$parsed"
  target_name="$(normalize_lane_id "${_closed_send_fields[0]:-}")"
  message_class="${_closed_send_fields[1]:-}"
  outgoing_task_id="$(printf '%s' "${_closed_send_fields[2]:-}" | tr -d '[:space:]')"
  top_type="${_closed_send_fields[3]:-}"
  nested_type="${_closed_send_fields[4]:-}"

  case "$top_type:$nested_type" in
    shutdown_response:*|*:shutdown_response) return 1 ;;
  esac
  case "$target_name" in
    ""|team-lead|lead|supervisor) ;;
    *) return 1 ;;
  esac
  [[ "$outgoing_task_id" == "$latest_task_id" ]] || return 1
  [[ -n "$message_class" ]] || return 1
  return 0
}

lead_sendmessage_replays_completed_worker_task() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1
  runtime_sender_session_is_worker "$SESSION_ID" && return 1

  local parsed=""
  local target_name=""
  local message_class=""
  local outgoing_task_id=""
  local latest=""
  local latest_class=""
  local latest_task_id=""

  parsed="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
const KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
function field(text, name) {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n|\\|)\\s*-?\\s*${escaped}\\s*:\\s*([^\\n\\r|]+)`, "i"));
  return String(match ? match[1] : "").trim();
}
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary, KEYS)
    .concat(flattenText(toolInput.message, KEYS))
    .concat(flattenText(toolInput.content, KEYS))
    .concat(flattenText(toolInput.description, KEYS))
    .join("\n");
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  ).toLowerCase();
  process.stdout.write([
    targetName,
    field(text, "MESSAGE-CLASS").toLowerCase().replace(/\s+/g, ""),
    field(text, "TASK-ID").replace(/\s+/g, "")
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"
  mapfile -t _lead_replay_fields <<<"$parsed"
  target_name="$(normalize_lane_id "${_lead_replay_fields[0]:-}")"
  message_class="${_lead_replay_fields[1]:-}"
  outgoing_task_id="$(printf '%s' "${_lead_replay_fields[2]:-}" | tr -d '[:space:]')"

  [[ -n "$target_name" && -n "$outgoing_task_id" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 1 ;;
  esac
  case "$message_class" in
    assignment|reuse|reroute) ;;
    *) return 1 ;;
  esac
  worker_is_standby "$target_name" || return 1

  latest="$(latest_worker_transport_class_for_gate "$target_name")"
  mapfile -t _lead_latest_fields <<<"$latest"
  latest_class="${_lead_latest_fields[0]:-}"
  latest_task_id="$(printf '%s' "${_lead_latest_fields[2]:-}" | tr -d '[:space:]')"
  case "$latest_class" in
    completion) ;;
    *) return 1 ;;
  esac
  [[ "$latest_task_id" == "$outgoing_task_id" ]]
}

worker_taskupdate_completes_latest_completion() {
  [[ "$TOOL_NAME" == "TaskUpdate" ]] || return 1
  runtime_sender_session_is_worker "$SESSION_ID" || return 1

  local worker_name=""
  local latest=""
  local latest_class=""
  local latest_task_id=""
  local parsed=""
  local update_task_id=""
  local update_status=""

  worker_name="$(worker_name_for_session_id "$SESSION_ID")"
  worker_name="$(normalize_lane_id "$worker_name")"
  [[ -n "$worker_name" ]] || return 1

  latest="$(latest_worker_transport_class_for_gate "$worker_name")"
  mapfile -t _taskupdate_latest_fields <<<"$latest"
  latest_class="${_taskupdate_latest_fields[0]:-}"
  latest_task_id="$(printf '%s' "${_taskupdate_latest_fields[2]:-}" | tr -d '[:space:]')"
  case "$latest_class" in
    completion) ;;
    *) return 1 ;;
  esac
  [[ -n "$latest_task_id" ]] || return 1

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  process.stdout.write([
    String(toolInput.task_id || toolInput.taskId || toolInput.id || "").trim(),
    String(toolInput.status || toolInput.state || "").trim().toLowerCase()
  ].join("\n"));
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
  mapfile -t _taskupdate_fields <<<"$parsed"
  update_task_id="$(printf '%s' "${_taskupdate_fields[0]:-}" | tr -d '[:space:]')"
  update_status="${_taskupdate_fields[1]:-}"

  [[ "$update_task_id" == "$latest_task_id" ]] || return 1
  [[ "$update_status" == "completed" ]]
}

taskupdate_is_completion_closure_payload() {
  [[ "$TOOL_NAME" == "TaskUpdate" ]] || return 1

  local parsed=""
  local update_status=""
  local mutation_marker=""

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const status = String(toolInput.status || toolInput.state || "").trim().toLowerCase();
  const mutationKeys = [
    "owner", "assignee", "assigned_to", "assignedTo",
    "subject", "description", "activeForm", "metadata",
    "blocks", "blockedBy", "addBlocks", "addBlockedBy"
  ];
  const hasMutation = mutationKeys.some((key) => {
    const value = toolInput[key];
    if (Array.isArray(value)) return value.length > 0;
    if (value && typeof value === "object") return Object.keys(value).length > 0;
    return String(value || "").trim();
  });
  process.stdout.write([status, hasMutation ? "mutation" : ""].join("\n"));
} catch {
  process.stdout.write("\nmutation");
}
NODE
)"
  mapfile -t _taskupdate_closure_fields <<<"$parsed"
  update_status="${_taskupdate_closure_fields[0]:-}"
  mutation_marker="${_taskupdate_closure_fields[1]:-}"

  [[ "$update_status" == "completed" ]] || return 1
  [[ -z "$mutation_marker" ]]
}

latest_worker_permission_request_timestamp_for_gate() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" HOME_DIR="$HOME" node <<'NODE' 2>/dev/null || true
const fs = require("fs");
const path = require("path");

const normalize = (value) => String(value || "").trim().toLowerCase();
const workerName = normalize(process.env.WORKER_NAME);
const runtimeHomeRoot = String(process.env.RUNTIME_HOME_ROOT || path.dirname(process.env.LOG_DIR || "")).trim();
const teamsRoot = path.join(runtimeHomeRoot, "teams");
if (!workerName || !fs.existsSync(teamsRoot)) process.exit(0);

let latest = "";
for (const entry of fs.readdirSync(teamsRoot, { withFileTypes: true })) {
  if (!entry.isDirectory()) continue;
  const inboxPath = path.join(teamsRoot, entry.name, "inboxes", "team-lead.json");
  if (!fs.existsSync(inboxPath)) continue;

  let rows;
  try {
    rows = JSON.parse(fs.readFileSync(inboxPath, "utf8"));
  } catch {
    continue;
  }
  if (!Array.isArray(rows)) continue;

  for (const row of rows) {
    if (!row || typeof row !== "object") continue;
    if (normalize(row.from) !== workerName) continue;

    let payload;
    try {
      payload = JSON.parse(String(row.text || ""));
    } catch {
      continue;
    }
    if (!payload || typeof payload !== "object") continue;
    if (payload.type !== "permission_request") continue;

    const timestamp = String(row.timestamp || "");
    if (timestamp && timestamp >= latest) latest = timestamp;
  }
}

if (latest) process.stdout.write(latest);
NODE
}

lead_sendmessage_monitoring_target_state() {
  local worker_name="${1-}"
  local normalized_worker=""
  local parsed=""
  local last_message_class=""
  local last_message_timestamp=""
  local permission_request_timestamp=""
  local dispatch_worker=""
  local dispatch_at=""
  local claimed_worker=""

  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || {
    printf 'unknown'
    return 0
  }

  if worker_is_standby "$normalized_worker"; then
    printf 'standby'
    return 0
  fi

  if worker_dispatch_ack_required "$normalized_worker"; then
    printf 'pending-ack'
    return 0
  fi

  parsed="$(latest_worker_transport_class_for_gate "$normalized_worker")"
  mapfile -t _probe_transport_fields <<<"$parsed"
  last_message_class="${_probe_transport_fields[0]:-}"
  last_message_timestamp="${_probe_transport_fields[1]:-}"
  permission_request_timestamp="$(latest_worker_permission_request_timestamp_for_gate "$normalized_worker")"
  dispatch_worker="$(normalize_lane_id "$(get_procedure_state_field "lastDispatchWorker" "")")"
  dispatch_at="$(get_procedure_state_field "lastDispatchAt" "")"
  claimed_worker="$(normalize_lane_id "$(get_procedure_state_field "lastClaimedWorker" "")")"

  if [[ -n "$permission_request_timestamp" ]] \
    && { [[ -z "$dispatch_worker" || "$dispatch_worker" == "$normalized_worker" ]]; } \
    && { [[ -z "$dispatch_at" || "$permission_request_timestamp" == "$dispatch_at" || "$permission_request_timestamp" > "$dispatch_at" ]]; } \
    && { [[ -z "$last_message_timestamp" || "$permission_request_timestamp" == "$last_message_timestamp" || "$permission_request_timestamp" > "$last_message_timestamp" ]]; }; then
    printf 'permission-pending'
    return 0
  fi

  case "$last_message_class" in
    dispatch-ack|status)
      printf 'working'
      return 0
      ;;
    scope-pressure)
      printf 'scope-pressure-resolution'
      return 0
      ;;
    blocker)
      printf 'blocked'
      return 0
      ;;
    completion)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$normalized_worker" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-transport-missing'
        return 0
      fi
      printf 'completed'
      return 0
      ;;
    hold\|blocker|hold)
      printf 'blocked'
      return 0
      ;;
  esac

  if [[ "$claimed_worker" == "$normalized_worker" ]]; then
    printf 'working'
    return 0
  fi

  printf 'unknown'
}

lead_sendmessage_is_monitoring_probe() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local message_class=""
  local target_name=""
  local has_required_skills=""
  local target_state=""

  parsed="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { flattenText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
const TASK_START_TEXT_KEYS = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes", "type"];
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase();
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary, TASK_START_TEXT_KEYS)
    .concat(flattenText(toolInput.message, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.content, TASK_START_TEXT_KEYS))
    .concat(flattenText(toolInput.description, TASK_START_TEXT_KEYS))
    .join("\n");
  const hasRequiredSkills = /(?:^|\n)\s*required-skills\s*:/i.test(text) ? "true" : "false";
  const targetName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.recipient_name,
    toolInput.recipientName,
    toolInput.name,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.teammate_name,
    toolInput.teammateName
  ).toLowerCase();
  process.stdout.write([
    field(text, "message-class"),
    targetName,
    hasRequiredSkills
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"
  mapfile -t _monitor_fields <<<"$parsed"
  message_class="${_monitor_fields[0]:-}"
  target_name="$(normalize_lane_id "${_monitor_fields[1]:-}")"
  has_required_skills="${_monitor_fields[2]:-false}"

  [[ -n "$target_name" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 1 ;;
  esac
  [[ "$has_required_skills" != "true" ]] || return 1

  case "$message_class" in
    ""|status) ;;
    completion)
      return 1
      ;;
    assignment|reuse|reroute|dispatch-ack|hold|scope-pressure|blocker|control)
      return 1
      ;;
    *)
      return 1
      ;;
  esac

  target_is_already_active_worker "$target_name" || return 1
  target_state="$(lead_sendmessage_monitoring_target_state "$target_name")"
  case "$target_state" in
    working|working-transport-missing|blocked|scope-pressure-resolution)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

runtime_teardown_intent_block_reason() {
  local tool_name="${1:-tool}"

  printf 'BLOCKED: runtime teardown intent incomplete. Detail: %s is not a routine status or dispatch action. Next: answer status from authoritative read-only surfaces, or if teardown is explicitly requested, enter session-closeout/teardown readiness and retry.' "$tool_name"
}

strip_bash_read_only_null_redirections() {
  local command_text="${1-}"
  printf '%s' "$command_text" | sed -E '
    s@(^|[[:space:]])&>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])[0-9]*>>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])[0-9]*>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])2>&1([[:space:];|&)]|$)@ @g;
  '
}

split_bootstrap_bash_segments() {
  local cmd="${1-}"

  COMMAND_TEXT="$cmd" node <<'NODE'
const command = String(process.env.COMMAND_TEXT || "");
function splitShellSegments(input) {
  const parts = [];
  let buf = "";
  let i = 0;
  let quote = null;
  while (i < input.length) {
    const c = input[i];
    if (quote) {
      buf += c;
      if (c === quote) {
        quote = null;
      } else if (c === "\\" && quote === "\"" && i + 1 < input.length) {
        buf += input[++i];
      }
      i++;
      continue;
    }
    if (c === "'" || c === "\"") { quote = c; buf += c; i++; continue; }
    if (c === "\\" && i + 1 < input.length) { buf += c + input[++i]; i++; continue; }
    if (c === ";")                                    { parts.push(buf); buf = ""; i++; continue; }
    if (c === "&" && input[i + 1] === "&")            { parts.push(buf); buf = ""; i += 2; continue; }
    if (c === "|" && input[i + 1] === "|")            { parts.push(buf); buf = ""; i += 2; continue; }
    if (c === "|")                                    { parts.push(buf); buf = ""; i++; continue; }
    buf += c;
    i++;
  }
  if (buf.trim()) parts.push(buf);
  return parts.map((s) => s.trim()).filter(Boolean);
}
for (const part of splitShellSegments(command)) {
  console.log(part);
}
NODE
}

bootstrap_bash_segment_is_read_only() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1

  # Strip quoted regions for shell-level deny checks; inspect inline scripts separately below.
  local stripped
  stripped="$(printf '%s' "$subcmd" | sed -E "s/'[^']*'/ /g; s/\"[^\"]*\"/ /g")"

  # Binary-locator queries are read-only; later mutation/redirect guards still apply.
  local is_binary_locator=0
  if printf '%s' "$stripped" | grep -Eq '^[[:space:]]*(which|whereis|type|command[[:space:]]+-[vV])([[:space:]]|$)'; then
    is_binary_locator=1
  fi

  # Inline node/python may be read-only only when the script body is inspectably inert.
  local is_inline_readonly_interpreter=0
  if printf '%s' "$stripped" | grep -Eq '^[[:space:]]*(node|nodejs|python([0-9]+([.][0-9]+)?)?)([[:space:]]+(-e|-c|<<))'; then
    # Inspect raw $subcmd; inline script bodies live inside quotes.
    if ! printf '%s' "$subcmd" | grep -Eq '(fs\.(write|mkdir|rm|rmdir|unlink|append|copyFile|rename|chmod|chown|symlink|truncate|utimes)|child_process|spawn[[:space:]]*\(|exec[[:space:]]*\(|execSync|spawnSync|require[[:space:]]*\([[:space:]]*['\''\"](child_process|http|https|net|dgram|dns|tls|cluster|worker_threads|repl|fs/promises)['\''\"]|import[[:space:]]*\([[:space:]]*['\''\"](child_process|http|https|net|dgram|dns|tls|cluster|worker_threads|repl|fs|fs/promises)['\''\"]|process\.binding[[:space:]]*\(|os\.(open|writeFile|system|popen|remove|unlink|rmdir|mkdir|chmod|chown)|process\.(exit|kill|abort|chdir)|eval[[:space:]]*\(|new[[:space:]]+Function|subprocess|shutil\.(move|copy|rmtree|chmod|chown)|urllib|requests\.|socket\.|http\.client|__import__[[:space:]]*\([[:space:]]*['\''\"](subprocess|os|socket|urllib|requests|http)|open[[:space:]]*\([^)]*['\''\"](w|a|x|wb|ab|xb|w\+|a\+|r\+))'; then
      is_inline_readonly_interpreter=1
    fi
  fi

  # DENY dangerous interpreters/network fetchers except locator/read-only inline forms.
  if [[ "$is_binary_locator" -eq 0 ]] && [[ "$is_inline_readonly_interpreter" -eq 0 ]] && printf '%s' "$stripped" | grep -Eiq '(^|[[:space:]])(node|nodejs|python([0-9]+([.][0-9]+)?)?|npm|pnpm|yarn|uv|pip|pip3|cargo|make|curl|wget)([[:space:]]|$)'; then
    return 1
  fi
  # DENY: file-mutating commands
  if printf '%s' "$stripped" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])(sed|perl)[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push|pull|add|stash)([[:space:]]|$)|(^|[[:space:]])find([[:space:]]|$).*([[:space:]]-delete([[:space:]]|$)|[[:space:]]-exec(dir)?([[:space:]]|$))'; then
    return 1
  fi
  # DENY: write redirect to file (`>file`, `>>file`, `2>file`, `&>file`).
  # Allow `>&` fd duplication (e.g. `2>&1`) since it does not write to filesystem.
  if printf '%s' "$stripped" | grep -qE '>[^&]|>>'; then
    return 1
  fi
  # DENY command substitution whose first word is dangerous.
  if printf '%s' "$stripped" | grep -Eiq '[$][(][[:space:]]*(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee|node|nodejs|npm|pnpm|yarn|uv|pip|pip3|cargo|go|make|curl|wget)([[:space:]]|$|\))|[$][(][[:space:]]*(sed|perl)[[:space:]]+-i([[:space:]]|$|\))'; then
    return 1
  fi
  # Same first-word rule for backtick substitution.
  if printf '%s' "$stripped" | grep -Eiq '`[[:space:]]*(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee|node|nodejs|npm|pnpm|yarn|uv|pip|pip3|cargo|go|make|curl|wget)([[:space:]]|$|`)|`[[:space:]]*(sed|perl)[[:space:]]+-i([[:space:]]|$|`)'; then
    return 1
  fi

  # Default ALLOW: anything not matching deny patterns is read-only by design.
  return 0
}

bash_command_is_read_only_context() {
  local command_text="${1-}"
  local sanitized=""
  local subcmd=""
  local saw_segment="0"

  [[ -n "$command_text" ]] || return 1

  sanitized="$(printf '%s' "$command_text" | sed '/^[[:space:]]*#/d')"
  sanitized="$(strip_bash_read_only_null_redirections "$sanitized")"
  [[ -n "$(printf '%s' "$sanitized" | tr -d '[:space:]')" ]] || return 1

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    saw_segment="1"
    if ! bootstrap_bash_segment_is_read_only "$subcmd"; then
      return 1
    fi
  done < <(split_bootstrap_bash_segments "$sanitized")

  [[ "$saw_segment" == "1" ]]
}

# Routine git carve-out: allow non-destructive workflow commands; destructive
# flags/subcommands remain gated.
git_segment_is_safe_workflow() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1

  local stripped
  stripped="$(printf '%s' "$subcmd" | sed -E "s/'[^']*'/ /g; s/\"[^\"]*\"/ /g")"

  printf '%s' "$stripped" | grep -Eq '^[[:space:]]*git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+' || return 1

  if printf '%s' "$stripped" | grep -Eq '(^|[[:space:]])(--force|--force-with-lease|-f|--no-verify|--no-gpg-sign|--interactive|--hard|--mixed|--soft|--amend)([[:space:]]|=|$)'; then
    return 1
  fi

  if printf '%s' "$stripped" | grep -Eq '(^|[[:space:]])-i([[:space:]]|$)'; then
    return 1
  fi

  if printf '%s' "$stripped" | grep -Eq '(^|[[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+(add|commit|push|pull|fetch)([[:space:]]|$)'; then
    return 0
  fi

  return 1
}

bash_command_is_safe_git_workflow() {
  local command_text="${1-}"
  local sanitized=""
  local subcmd=""
  local saw_safe_git="0"

  [[ -n "$command_text" ]] || return 1

  sanitized="$(printf '%s' "$command_text" | sed '/^[[:space:]]*#/d')"
  sanitized="$(strip_bash_read_only_null_redirections "$sanitized")"
  [[ -n "$(printf '%s' "$sanitized" | tr -d '[:space:]')" ]] || return 1

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    if git_segment_is_safe_workflow "$subcmd"; then
      saw_safe_git="1"
      continue
    fi
    if bootstrap_bash_segment_is_read_only "$subcmd"; then
      continue
    fi
    return 1
  done < <(split_bootstrap_bash_segments "$sanitized")

  [[ "$saw_safe_git" == "1" ]]
}

boot_infra_tool_allowed() {
  local tool_name="${1:-}"
  local command="${2:-}"
  local skill_name="${3:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|TeamCreate|TeamDelete|WebFetch|WebSearch)
      return 0
      ;;
    Skill)
      if [[ "$skill_name" == *session-boot* ]]; then
        return 0
      fi
      return 1
      ;;
    Bash)
      if [[ "$command" =~ ^[[:space:]]*(pwd|echo[[:space:]]+\$HOME)[[:space:]]*$ ]]; then
        return 0
      fi
      return 1
      ;;
    *)
      return 1
      ;;
  esac
}

lead_planning_bootstrap_tool_allowed() {
  local tool_name="${1:-}"
  local command="${2:-}"
  local skill_name="${3:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch)
      return 0
      ;;
    Bash)
      if bash_command_is_read_only_context "$command"; then
        return 0
      fi
      return 1
      ;;
    Skill)
      if [[ "$skill_name" == *work-planning* || "$skill_name" == *self-verification* ]]; then
        return 0
      fi
      return 1
      ;;
    *)
      return 1
      ;;
  esac
}

lead_preplanning_reference_allowed() {
  [[ "$TOOL_NAME" == "Read" ]] || return 1

  case "$TARGET_PATHS" in
    *"/.claude/CLAUDE.md"*|*".claude/CLAUDE.md"*|CLAUDE.md)
      return 0
      ;;
    *"/.claude/agents/team-lead.md"*|*".claude/agents/team-lead.md"*|*"agents/team-lead.md"*)
      return 0
      ;;
    *"/.claude/reference/reporting-prohibition-law.md"*|*".claude/reference/reporting-prohibition-law.md"*)
      return 0
      ;;
    *"/.claude/skills/agent-team-lead/references/pre-action-gate.md"*|*".claude/skills/agent-team-lead/references/pre-action-gate.md"*|*"skills/agent-team-lead/references/pre-action-gate.md"*)
      return 0
      ;;
    *"/.claude/skills/agent-team-lead/references/owner-trigger-order.md"*|*".claude/skills/agent-team-lead/references/owner-trigger-order.md"*|*"skills/agent-team-lead/references/owner-trigger-order.md"*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

lead_required_planning_owner_allowed() {
  local tool_name="${1:-}"
  local skill_name="${2:-}"

  case "$tool_name" in
    Read)
      if lead_preplanning_reference_allowed; then
        return 0
      fi
      return 1
      ;;
    Skill)
      if [[ "$skill_name" == *agent-team-lead* ]] && lead_session_start_ready; then
        return 0
      fi
      if [[ "$skill_name" == *session-boot* ]]; then
        return 0
      fi
      if [[ "$skill_name" == *work-planning* ]] && lead_session_start_ready; then
        return 0
      fi
      return 1
      ;;
    *)
      return 1
      ;;
  esac
}

lead_session_start_ready() {
  [[ -f "$SB_LOADED_MARKER" ]] && return 0
  [[ -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]] && return 0
  [[ "$(get_procedure_state_field "startupState" "")" == "ready" ]]
}

lead_required_planning_block_reason() {
  if lead_session_start_ready; then
    printf 'BLOCKED: work-planning required before consequential discovery or dispatch. Next: Skill(work-planning).'
    return 0
  fi

  printf 'BLOCKED: session-start readiness unresolved. Next: Skill(session-boot).'
}

lead_dispatch_requires_task_execution() {
  local tool_name="${1:-}"

  case "$tool_name" in
    TeamCreate|TaskCreate|Agent|SendMessage)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

agent_missing_team_scope_fields() {
  [[ "$TOOL_NAME" == "Agent" ]] || return 1

  local parsed=""
  local team_name=""
  local member_name=""

  parsed="$(INPUT_JSON="$INPUT" node -e "
    try {
      const input = JSON.parse(process.env.INPUT_JSON || '{}');
      const ti = input.tool_input || {};
      process.stdout.write(String(ti.team_name || '').trim() + '\n' + String(ti.name || '').trim());
    } catch { process.stdout.write('\n'); }
  " 2>/dev/null || printf '\n')"
  team_name="$(printf '%s' "$parsed" | sed -n '1p')"
  member_name="$(printf '%s' "$parsed" | sed -n '2p')"

  [[ -z "$team_name" || -z "$member_name" ]]
}

lead_runtime_prep_allowed_before_dispatch_gate() {
  local tool_name="${1:-}"

  case "$tool_name" in
    TeamCreate)
      [[ -f "$WP_MARKER" ]]
      return
      ;;
    *)
      return 1
      ;;
  esac
}

if [[ -z "$TOOL_NAME" || -z "$SESSION_ID" ]]; then
  exit 0
fi

if sendmessage_malformed_visible_state_signal_to_lead; then
  deny_tool_use "BLOCKED: malformed visible state signal. Put ack/completion only in the SendMessage header/preview; message/body slots must be blank or whitespace-only. Keep detail in task state or retained carriers."
  exit 0
fi

mark_post_wp_action_after_planning

if ! runtime_sender_session_is_worker "$SESSION_ID"; then
  if lead_planning_required "$SESSION_ID" && [[ ! -f "$WP_MARKER" ]]; then
    if lead_required_planning_owner_allowed "$TOOL_NAME" "$SKILL_NAME_NORM"; then
      exit 0
    fi
    deny_tool_use "$(lead_required_planning_block_reason)"
    exit 0
  fi
  if [[ -f "$WP_MARKER" && ! -f "$TASK_EXECUTION_MARKER" ]] && lead_dispatch_requires_task_execution "$TOOL_NAME"; then
    deny_tool_use "BLOCKED: task-execution required before team runtime dispatch or assignment messaging. Next: Skill(task-execution)."
    exit 0
  fi
  if [[ -f "$WP_MARKER" && -f "$TASK_EXECUTION_MARKER" && "$TOOL_NAME" == "Agent" ]] && agent_missing_team_scope_fields; then
    deny_tool_use "BLOCKED: team-scoped Agent required before dispatch attempt. Detail: planned team-agent dispatch must include BOTH top-level team_name and name; standalone Agent is fallback evidence only, not a valid planned dispatch. Next: use TeamCreate when no team exists, otherwise retry Agent with team_name and concrete member name."
    exit 0
  fi
fi

# TaskUpdate shape enforcement (completion-closure only) removed per operator
# directive 2026-05-19 and `.claude/reference/environment-configuration-core-law.md` `[HOOK-LAST]` negative-only-filter philosophy.
# TaskUpdate doctrine ("completion-closure only" per task-execution/references/
# message-classes.md ### Assignment Delivery Contract and CLAUDE.md ## 8. Environment Configuration Philosophy) stays in effect for
# lane self-restraint via the trio quality contract (Skill(governance-modification) +
# self-verification + review-verification named lenses); a hook positive-filtering
# generic Claude Code TaskUpdate patterns was bottlenecking lanes without
# preventing any destructive action (setting in_progress/owner/etc. on a task row
# is non-doctrine but not harmful). The helper `taskupdate_is_completion_closure_payload`
# stays defined for any future negative-filter use (e.g., blocking destructive
# field-clobbering on closed tasks) but is no longer invoked here.

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]] && ! session_id_is_known_worker "$SESSION_ID"; then
  if boot_infra_tool_allowed "$TOOL_NAME" "$COMMAND" "$SKILL_NAME_NORM"; then
    exit 0
  fi
fi

if runtime_sender_session_is_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
  if [[ -n "$WORKER_NAME" ]] && worker_dispatch_ack_required "$WORKER_NAME"; then
    if sendmessage_is_first_receipt_outcome_to_lead; then
      clear_worker_dispatch_ack_required "$WORKER_NAME"
      exit 0
    fi
    if reconcile_worker_dispatch_ack_from_transcript "$SESSION_ID" "$WORKER_NAME"; then
      exit 0
    fi
    if [[ "$TOOL_NAME" == "SendMessage" ]]; then
      deny_tool_use "BLOCKED: worker receipt is pending. First upward outcome must be one host-visible header/preview state signal: 'ack task <id>' when task tracking is active, otherwise 'ack'. Message/body slots must be blank or whitespace-only. Keep MESSAGE-CLASS, WORK-SURFACE, ACK-STATUS, paths, and packet detail in internal carriers. Use scope-pressure or hold|blocker only when receipt cannot be accepted safely."
      exit 0
    fi
    if worker_dispatch_ack_gate_active_for_session "$SESSION_ID" "$WORKER_NAME"; then
      deny_tool_use "BLOCKED: worker receipt is pending. Send one host-visible header/preview 'ack task <id>' or 'ack' to team-lead before Skill, Read, Bash, discovery, proof, or lane work; message/body slots must be blank or whitespace-only; use scope-pressure or hold|blocker only when receipt cannot be accepted safely."
      exit 0
    fi
    deny_tool_use "BLOCKED: worker receipt is pending. Send one host-visible header/preview 'ack task <id>' or 'ack' to team-lead before first lane work; message/body slots must be blank or whitespace-only; use scope-pressure or hold|blocker only when receipt cannot be accepted safely."
    exit 0
  fi
  if worker_sendmessage_reopens_closed_task; then
    deny_tool_use "BLOCKED: closed task already completed. Same-task replay after completion must stay silent; team-lead consumes the retained carrier or sends distinct new assignment/reuse/reroute work."
    exit 0
  fi
  if [[ "$TOOL_NAME" == "TaskUpdate" ]]; then
    if worker_taskupdate_completes_latest_completion; then
      exit 0
    fi
    deny_tool_use "BLOCKED: worker TaskUpdate is limited to immediate status=completed closure for the same TASK-ID after a valid completion signal."
    exit 0
  fi
  if completion_grade_sendmessage_missing_result_verification; then
    exit 0
  fi
  exit 0
fi

if ! runtime_sender_session_is_worker "$SESSION_ID"; then
  if lead_sendmessage_is_worker_cleanup_control; then
    exit 0
  fi
  if lead_sendmessage_replays_completed_worker_task; then
    deny_tool_use "BLOCKED: completed task replay. The target worker already completed this TASK-ID and is STANDBY; consume the retained carrier or send distinct new assignment/reuse/reroute work with a new task basis."
    exit 0
  fi
  if lead_sendmessage_is_monitoring_probe; then
    exit 0
  fi
  if [[ "$TOOL_NAME" == "Bash" ]] && bash_command_is_safe_git_workflow "$COMMAND"; then
    exit 0
  fi
  if procedure_state_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS"; then
    exit 0
  fi
  if self_growth_required_for_session "$SESSION_ID" && self_growth_gate_applies_to_tool "$TOOL_NAME"; then
    exit 0
  fi
  if lead_planning_bootstrap_tool_allowed "$TOOL_NAME" "$COMMAND" "$SKILL_NAME_NORM"; then
    exit 0
  fi
  if lead_planning_required "$SESSION_ID"; then
    if [[ "$TOOL_NAME" == "mcp__codex__codex" && ! -f "$WP_MARKER" ]]; then
      exit 0
    fi
    if lead_runtime_prep_allowed_before_dispatch_gate "$TOOL_NAME"; then
      exit 0
    fi
    if lead_sendmessage_is_bounded_iteration_continuation; then
      exit 0
    fi
    case "$TOOL_NAME" in
      Agent|TaskCreate|SendMessage)
        # Hard guard: active team runtime requires addressable team-member Agent dispatch.
        if [[ "$TOOL_NAME" == "Agent" ]] \
            && [[ "$(get_procedure_state_field "teamRuntimeState" "")" == "active" ]]; then
          AGENT_PARAMS="$(INPUT_JSON="$INPUT" node -e "
            try {
              const input = JSON.parse(process.env.INPUT_JSON || '{}');
              const ti = input.tool_input || {};
              const tn = (ti.team_name || '').trim();
              const nm = (ti.name || '').trim();
              process.stdout.write(tn + '\n' + nm);
            } catch { process.stdout.write('\n'); }
          " 2>/dev/null || printf '\n')"
          AGENT_TEAM_NAME="$(printf '%s' "$AGENT_PARAMS" | sed -n '1p')"
          AGENT_NAME="$(printf '%s' "$AGENT_PARAMS" | sed -n '2p')"
          if [[ -z "$AGENT_TEAM_NAME" || -z "$AGENT_NAME" ]]; then
            deny_tool_use "BLOCKED: team-agent-only mandate per Skill(task-execution) Step 2 Dispatch law. Detail: Agent dispatch on active team runtime (procedure-state.json teamRuntimeState=active) must include BOTH team_name AND name parameters so the spawned agent joins the team runtime as a member addressable via SendMessage by lane name. Standalone subagent shape or unaddressable shape bypasses team continuity, lifecycle visibility, reuse, and inter-agent coordination."
            exit 0
          fi
        fi
        # Once WP is observed, dispatch-specific validation moves to its owner.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        ;;
      Skill)
        # Once WP is observed, skill sequencing belongs to the active owner.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        # Hook-last carve-out: specialist skill consults may continue after prior self-verification convergence.
        if [[ -f "$RESULT_VERIFICATION_CONVERGED_MARKER" ]]; then
          exit 0
        fi
        ;;
      TaskUpdate|TaskStop)
        # Task-state mutation remains consequential; exact-id validation is downstream.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        ;;
      Edit|MultiEdit|Write|NotebookEdit)
        # Hook-last carve-out: bounded file-edit continuation may proceed after prior self-verification convergence.
        if [[ -f "$RESULT_VERIFICATION_CONVERGED_MARKER" ]]; then
          exit 0
        fi
        ;;
      TeamDelete)
        if [[ -n "$SESSION_ID" ]] && closeout_intent_is_active "$SESSION_ID"; then
          exit 0
        fi
        deny_tool_use "$(runtime_teardown_intent_block_reason "$TOOL_NAME")"
        exit 0
        ;;
      CronDelete)
        deny_tool_use "$(runtime_teardown_intent_block_reason "$TOOL_NAME")"
        exit 0
        ;;
    esac
    exit 0
  fi
fi

exit 0
