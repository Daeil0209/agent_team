#!/usr/bin/env bash
set -euo pipefail

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
SV_PLAN_MARKER="$LOG_DIR/.sv-plan-loaded-${SESSION_ID}"
SV_CONVERGED_MARKER="$LOG_DIR/.sv-converged-${SESSION_ID}"
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

warn_tool_use() {
  local reason="${1:?reason required}"
  reason="${reason/BLOCKED: /}"
  reason="${reason/PROCEDURE WARNING: /}"
  printf '[%s] TASK-START WARN: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" >> "$VIOLATION_LOG"
  hook_emit_pretool_context "HOOK-LAST WARNING: $reason" "Hook-last procedure warning."
}

planning_preflight_block() {
  local tool_name="${1:-tool}"
  local next_step="${2:-Skill(work-planning) -> Skill(self-verification) -> retry}"
  printf 'PROCEDURE WARNING: fresh-turn preflight sequence incomplete. Detail: %s should not run before observed Skill(work-planning) -> Skill(self-verification) in this user turn. Prior analysis may narrow the plan scope, but it does not replace the fresh-turn sequence. If this turn started as answer-only and an agent handoff or blocker changed the next action, reopen an execution segment first. Next first tools: %s.' "$tool_name" "$next_step"
}

verification_preflight_block() {
  local tool_name="${1:-tool}"
  local next_step="${2:-Skill(self-verification) -> retry}"
  printf 'PROCEDURE WARNING: verification preflight incomplete. Detail: %s should not run before observed post-planning Skill(self-verification) in this user turn. Read-only inspection may continue when still justified, but mutable Bash should wait for plan verification. Next first tools: %s.' "$tool_name" "$next_step"
}

self_growth_block() {
  printf 'PROCEDURE WARNING: self-growth entry required. Detail: current session has confirmed or escalated correction debt. Next: Skill(self-growth-sequence) -> stabilize the request basis -> continue consequential work.'
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

sendmessage_is_dispatch_ack_to_lead() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local message_class=""
  local target_name=""

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
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
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
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
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary)
    .concat(flattenText(toolInput.message || toolInput.content))
    .concat(flattenText(toolInput.description))
    .join("\n");
  const match = text.match(/(?:^|\n)\s*message-class\s*:\s*([^\n\r]+)/i);
  const messageClass = String(match ? match[1] : "").trim().toLowerCase();
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
  process.stdout.write(`${messageClass}\n${targetName}\n`);
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
  mapfile -t _ack_fields <<<"$parsed"
  message_class="${_ack_fields[0]:-}"
  target_name="${_ack_fields[1]:-}"

  [[ "$message_class" == "dispatch-ack" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 0 ;;
    *) return 1 ;;
  esac
}

worker_dispatch_ack_block_reason() {
  local tool_name="${1:-tool}"

  printf 'PROCEDURE WARNING: agent dispatch-ack required. Detail: %s should not run before the agent sends the assignment receipt signal to team-lead. Next: SendMessage(to: "team-lead", message: "MESSAGE-CLASS: dispatch-ack\nWORK-SURFACE: <assignment surface>\nACK-STATUS: accepted\nPLANNING-BASIS: loading\nTASK-ID: <assigned-id>"). Include TASK-ID only when active task tracking assigned one; otherwise omit TASK-ID rather than writing none.' "$tool_name"
}

lead_sendmessage_is_worker_cleanup_control() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local top_type=""
  local nested_type=""

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
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
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase();
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const nestedMessage = toolInput.message || {};
  const text = flattenText(toolInput.summary)
    .concat(flattenText(toolInput.message || toolInput.content))
    .concat(flattenText(toolInput.description))
    .join("\n");
  const fields = [
    String(toolInput.type || "").trim().toLowerCase(),
    String(nestedMessage.type || "").trim().toLowerCase()
  ];
  process.stdout.write(fields.join("\n"));
} catch {
  process.stdout.write("\n\n\n\n");
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

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
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
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase();
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary)
    .concat(flattenText(toolInput.message || toolInput.content))
    .concat(flattenText(toolInput.description))
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
    field(text, "continuation-class"),
    field(text, "iteration-owner-lane"),
    targetName,
    hasRequiredSkills
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n");
}
NODE
)"
  mapfile -t _continuation_fields <<<"$parsed"
  message_class="${_continuation_fields[0]:-}"
  continuation_class="${_continuation_fields[1]:-}"
  iteration_owner_lane="${_continuation_fields[2]:-}"
  target_name="$(normalize_lane_id "${_continuation_fields[3]:-}")"
  has_required_skills="${_continuation_fields[4]:-false}"

  case "$message_class" in
    reuse|reroute) ;;
    *) return 1 ;;
  esac

  [[ "$continuation_class" == "bounded-iteration" ]] || return 1
  [[ "$has_required_skills" == "true" ]] || return 1

  case "$iteration_owner_lane" in
    developer|reviewer|tester|validator) ;;
    *) return 1 ;;
  esac

  [[ -n "$target_name" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 1 ;;
  esac

  if target_is_already_active_worker "$target_name"; then
    return 0
  fi

  worker_is_standby "$target_name"
}

latest_worker_report_class_for_gate() {
  local worker_name="${1-}"

  [[ -n "$worker_name" ]] || return 1

  WORKER_NAME="$worker_name" WORKER_REPORT_LEDGER="$WORKER_REPORT_LEDGER" node <<'NODE' 2>/dev/null || true
const fs = require("fs");

const ledgerPath = process.env.WORKER_REPORT_LEDGER || "";
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
  process.stdout.write(`${String(latest.messageClass || "").toLowerCase()}\n${String(latest.timestamp || "")}\n`);
}
NODE
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

  parsed="$(latest_worker_report_class_for_gate "$normalized_worker")"
  mapfile -t _probe_report_fields <<<"$parsed"
  last_message_class="${_probe_report_fields[0]:-}"
  last_message_timestamp="${_probe_report_fields[1]:-}"
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
    dispatch-ack|status|scope-pressure)
      printf 'working'
      return 0
      ;;
    blocker)
      printf 'blocked'
      return 0
      ;;
    handoff)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$normalized_worker" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-report-missing'
        return 0
      fi
      printf 'completed'
      return 0
      ;;
    completion)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$normalized_worker" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-report-missing'
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
  local lifecycle_decision=""
  local target_name=""
  local has_required_skills=""
  local target_state=""

  parsed="$(INPUT_JSON="$INPUT" node <<'NODE'
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
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};
const field = (text, name) => {
  const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const match = text.match(new RegExp(`(?:^|\\n)\\s*${escaped}\\s*:\\s*([^\\n\\r]+)`, "i"));
  return String(match ? match[1] : "").trim().toLowerCase();
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const text = flattenText(toolInput.summary)
    .concat(flattenText(toolInput.message || toolInput.content))
    .concat(flattenText(toolInput.description))
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
    field(text, "lifecycle-decision"),
    targetName,
    hasRequiredSkills
  ].join("\n"));
} catch {
  process.stdout.write("\n\n\n\n");
}
NODE
)"
  mapfile -t _monitor_fields <<<"$parsed"
  message_class="${_monitor_fields[0]:-}"
  lifecycle_decision="${_monitor_fields[1]:-}"
  target_name="$(normalize_lane_id "${_monitor_fields[2]:-}")"
  has_required_skills="${_monitor_fields[3]:-false}"

  [[ -n "$target_name" ]] || return 1
  case "$target_name" in
    team-lead|lead|supervisor) return 1 ;;
  esac
  [[ "$has_required_skills" != "true" ]] || return 1
  [[ -z "$lifecycle_decision" ]] || return 1

  case "$message_class" in
    ""|status) ;;
    handoff)
      return 1
      ;;
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
    working|working-report-missing|blocked)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

lead_preflight_block_reason() {
  local tool_name="${1:-tool}"

  case "$tool_name" in
    Agent|TaskCreate|SendMessage)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> lifecycle/reuse check -> retry dispatch/reuse"
      ;;
    TaskUpdate|TaskStop)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> confirm task id from TaskList or task_assignment -> retry task mutation -> resume any pending workflow/development cursor"
      ;;
    TeamDelete|CronDelete)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> confirm closeout/teardown readiness -> retry"
      ;;
    *)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> retry with the tool-specific preflight complete"
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
    # Inspect raw $subcmd because inline script bodies live inside quotes.
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
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|TeamCreate|TeamDelete|WebFetch|WebSearch) return 0 ;;
    Skill)
      [[ "$skill_name" == *session-boot* ]]
      return
      ;;
    Bash)
      printf '%s' "$command" | grep -qE '^[[:space:]]*(pwd|echo[[:space:]]+\$HOME)[[:space:]]*$'
      return
      ;;
    *) return 1 ;;
  esac
}

worker_planning_bootstrap_tool_allowed() {
  local tool_name="${1:-}"
  local command="${2:-}"
  local skill_name="${3:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch) return 0 ;;
    Bash)
      bash_command_is_read_only_context "$command"
      return
      ;;
    Skill)
      [[ "$skill_name" == *work-planning* ]]
      return
      ;;
    *) return 1 ;;
  esac
}

lead_planning_bootstrap_tool_allowed() {
  local tool_name="${1:-}"
  local command="${2:-}"
  local skill_name="${3:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch) return 0 ;;
    Bash)
      bash_command_is_read_only_context "$command"
      return
      ;;
    Skill)
      [[ "$skill_name" == *work-planning* || "$skill_name" == *self-verification* || "$skill_name" == *task-execution* ]]
      return
      ;;
    *) return 1 ;;
  esac
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

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]] && ! session_id_is_known_worker "$SESSION_ID"; then
  if boot_infra_tool_allowed "$TOOL_NAME" "$COMMAND" "$SKILL_NAME_NORM"; then
    exit 0
  fi
fi

if runtime_sender_session_is_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
  if [[ -n "$WORKER_NAME" ]] && worker_dispatch_ack_required "$WORKER_NAME"; then
    if sendmessage_is_dispatch_ack_to_lead; then
      exit 0
    fi
    if reconcile_worker_dispatch_ack_from_transcript "$SESSION_ID" "$WORKER_NAME"; then
      exit 0
    fi
    if worker_dispatch_ack_gate_active_for_session "$SESSION_ID" "$WORKER_NAME"; then
      warn_tool_use "$(worker_dispatch_ack_block_reason "$TOOL_NAME")"
      exit 0
    fi
  fi
  if [[ -n "$WORKER_NAME" ]] && worker_planning_required "$WORKER_NAME"; then
      if worker_planning_bootstrap_tool_allowed "$TOOL_NAME" "$COMMAND" "$SKILL_NAME_NORM"; then
        exit 0
      fi
      warn_tool_use "$(planning_preflight_block "$TOOL_NAME" "Skill(work-planning) -> continue current task")"
      exit 0
    fi
    exit 0
fi

if ! runtime_sender_session_is_worker "$SESSION_ID"; then
  if lead_planning_bootstrap_tool_allowed "$TOOL_NAME" "$COMMAND" "$SKILL_NAME_NORM"; then
    exit 0
  fi
  if lead_sendmessage_is_worker_cleanup_control; then
    exit 0
  fi
  if lead_sendmessage_is_monitoring_probe; then
    exit 0
  fi
  if [[ "$TOOL_NAME" == "Bash" ]] && bash_command_is_safe_git_workflow "$COMMAND"; then
    exit 0
  fi
  if [[ "$TOOL_NAME" == "Bash" ]] && [[ -f "$WP_MARKER" ]] && [[ ! -f "$SV_PLAN_MARKER" ]] && ! bash_command_is_read_only_context "$COMMAND"; then
    warn_tool_use "$(verification_preflight_block "mutable Bash" "Skill(self-verification) -> retry Bash if the command still belongs in the frozen plan")"
    exit 0
  fi
  if self_growth_required "$SESSION_ID" && self_growth_gate_applies_to_tool "$TOOL_NAME"; then
    warn_tool_use "$(self_growth_block)"
    exit 0
  fi
  if procedure_state_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS" || project_continuity_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS"; then
    exit 0
  fi
  if lead_planning_required "$SESSION_ID"; then
    if lead_runtime_prep_allowed_before_dispatch_gate "$TOOL_NAME"; then
      exit 0
    fi
    if lead_sendmessage_is_bounded_iteration_continuation; then
      exit 0
    fi
    case "$TOOL_NAME" in
      Agent|TaskCreate|SendMessage)
        # Hard guard: active runtime dispatch/reuse must not bypass session-boot.
        if [[ "$(get_procedure_state_field "teamRuntimeState" "")" == "active" ]] \
            && [[ ! -f "$SB_LOADED_MARKER" ]]; then
          warn_tool_use "PROCEDURE WARNING: session-boot preflight incomplete. Detail: $TOOL_NAME on active team runtime (procedure-state.json teamRuntimeState=active) requires Skill(session-boot) load first per team-lead.md RPA-3. Monitoring Sequence cannot run without it, allowing ghost agents / stale agents / missed-handoff agents to accumulate without lifecycle-control release. Next: Skill(session-boot) -> retry $TOOL_NAME."
          exit 0
        fi
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
            deny_tool_use "BLOCKED: team-agent-only mandate per task-execution/SKILL.md Step 2 Dispatch law. Detail: Agent dispatch on active team runtime (procedure-state.json teamRuntimeState=active) MUST include BOTH team_name AND name parameters so the spawned agent joins the team runtime as a member addressable via SendMessage by lane name. Standalone subagent shape (Agent without team_name) or unaddressable shape (Agent without name) bypasses team continuity, lifecycle visibility, reuse, and inter-agent coordination — not a valid delegation channel for lane-owned work while team runtime is active. Next: retry Agent with BOTH team_name and name set (e.g., team_name='<active-team>', name='validator')."
            exit 0
          fi
        fi
        # Once WP is observed, missing-SV belongs to sv-gate.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        # Hook-last carve-out: reuse SendMessage may continue after prior SV convergence.
        if [[ "$TOOL_NAME" == "SendMessage" ]] && [[ -f "$SV_CONVERGED_MARKER" ]]; then
          exit 0
        fi
        ;;
      Skill)
        # Hook-last carve-out: specialist skill consults may continue after prior SV convergence.
        if [[ -f "$SV_CONVERGED_MARKER" ]]; then
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
        # Hook-last carve-out: bounded file-edit continuation may proceed after prior SV convergence.
        if [[ -f "$SV_CONVERGED_MARKER" ]]; then
          exit 0
        fi
        ;;
      TeamDelete|CronDelete)
        deny_tool_use "$(runtime_teardown_intent_block_reason "$TOOL_NAME")"
        exit 0
        ;;
    esac
    warn_tool_use "$(lead_preflight_block_reason "$TOOL_NAME")"
    exit 0
  fi
fi

exit 0
