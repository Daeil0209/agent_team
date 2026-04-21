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

deny_tool_use() {
  local reason="${1:?reason required}"
  local surface_key=""
  surface_key="${TASK_ID:-}"
  if [[ -z "$surface_key" ]]; then
    surface_key="$(printf '%s' "$TARGET_PATHS" | sed -n '1p')"
  fi
  DENY_REASON="$(augment_precheck_block_reason_on_repeat "$SESSION_ID" "$TOOL_NAME" "${surface_key:-generic}" "$reason")" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Task start blocked."
  }
}));
NODE
}

planning_preflight_block() {
  local tool_name="${1:-tool}"
  local next_step="${2:-Skill(work-planning) -> Skill(self-verification) -> retry}"
  printf 'BLOCKED: fresh-turn preflight sequence incomplete. Detail: %s cannot run before observed Skill(work-planning) -> Skill(self-verification) in this user turn. Prior analysis may narrow the plan scope, but it does not replace the fresh-turn sequence. Next first tools: %s.' "$tool_name" "$next_step"
}

self_growth_block() {
  printf 'BLOCKED: self-growth entry required. Detail: current session has confirmed or escalated correction debt. Next: Skill(self-growth-sequence) -> stabilize the request basis -> continue consequential work.'
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

  printf 'BLOCKED: worker dispatch-ack required. Detail: %s cannot run before the worker sends the assignment receipt signal to team-lead. Next: SendMessage(to: "team-lead", message: "MESSAGE-CLASS: dispatch-ack\nTASK-ID: <assigned-id|none>\nWORK-SURFACE: <assignment surface>\nACK-STATUS: accepted|rejected:<reason>\nPLANNING-BASIS: loading|loaded").' "$tool_name"
}

lead_sendmessage_is_lifecycle_control() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local parsed=""
  local message_class=""
  local lifecycle_decision=""
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
    field(text, "message-class"),
    field(text, "lifecycle-decision"),
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
  message_class="${_lifecycle_fields[0]:-}"
  lifecycle_decision="${_lifecycle_fields[1]:-}"
  top_type="${_lifecycle_fields[2]:-}"
  nested_type="${_lifecycle_fields[3]:-}"

  case "$top_type:$nested_type" in
    shutdown_request:*|*:shutdown_request) return 0 ;;
  esac

  case "$lifecycle_decision" in
    reuse|standby|shutdown|hold-for-validation)
      [[ -z "$message_class" || "$message_class" == "control" ]] && return 0
      ;;
  esac

  return 1
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
const teamsRoot = path.join(process.env.HOME_DIR || "", ".claude", "teams");
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
    handoff|completion|hold)
      if [[ -n "$dispatch_at" && "$dispatch_worker" == "$normalized_worker" && ( -z "$last_message_timestamp" || "$last_message_timestamp" < "$dispatch_at" ) ]]; then
        printf 'working-report-missing'
        return 0
      fi
      printf 'completed'
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
    assignment|reuse|reroute|dispatch-ack|handoff|completion|hold|scope-pressure|blocker|control)
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
  local skill_name="${2:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch|Bash) return 0 ;;
    Skill)
      [[ "$skill_name" == *work-planning* ]]
      return
      ;;
    *) return 1 ;;
  esac
}

lead_planning_bootstrap_tool_allowed() {
  local tool_name="${1:-}"
  local skill_name="${2:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch|Bash) return 0 ;;
    Skill)
      [[ "$skill_name" == *work-planning* || "$skill_name" == *self-verification* ]]
      return
      ;;
    *) return 1 ;;
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
      deny_tool_use "$(worker_dispatch_ack_block_reason "$TOOL_NAME")"
      exit 0
    fi
  fi
    if [[ -n "$WORKER_NAME" ]] && worker_planning_required "$WORKER_NAME"; then
      if worker_planning_bootstrap_tool_allowed "$TOOL_NAME" "$SKILL_NAME_NORM"; then
        exit 0
      fi
      deny_tool_use "$(planning_preflight_block "$TOOL_NAME" "Skill(work-planning) -> continue current task")"
      exit 0
    fi
    exit 0
fi

if ! runtime_sender_session_is_worker "$SESSION_ID"; then
  if lead_planning_bootstrap_tool_allowed "$TOOL_NAME" "$SKILL_NAME_NORM"; then
    exit 0
  fi
  if lead_sendmessage_is_lifecycle_control; then
    exit 0
  fi
  if lead_sendmessage_is_monitoring_probe; then
    exit 0
  fi
  if self_growth_required "$SESSION_ID" && self_growth_gate_applies_to_tool "$TOOL_NAME"; then
    deny_tool_use "$(self_growth_block)"
    exit 0
  fi
  if procedure_state_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS" || project_continuity_edit_target_allowed "$TOOL_NAME" "$TARGET_PATHS"; then
    exit 0
  fi
  if lead_planning_required "$SESSION_ID"; then
    case "$TOOL_NAME" in
      Agent|TaskCreate|SendMessage)
        # Dispatch surfaces still require WP+SV, but once WP is observed the
        # remaining missing-SV block belongs to sv-gate to avoid duplicate
        # fresh-turn vs verification denials for the same attempt.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        ;;
      TaskUpdate|TaskStop)
        # Task-state mutation remains consequential on a fresh turn. Once WP is
        # observed, the remaining missing-SV block belongs to sv-gate; exact-id
        # validation stays with validate-task-target after both gates clear.
        if [[ -f "$WP_MARKER" ]]; then
          exit 0
        fi
        ;;
      TeamDelete|CronDelete)
        deny_tool_use "$(runtime_teardown_intent_block_reason "$TOOL_NAME")"
        exit 0
        ;;
    esac
    deny_tool_use "$(lead_preflight_block_reason "$TOOL_NAME")"
    exit 0
  fi
fi

exit 0
