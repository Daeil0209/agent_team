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
	    collectPaths(toolInput).join("\n")
	  ];
	  process.stdout.write(fields.join("\n"));
	} catch {
	  process.stdout.write("\n\n\n\n\n");
	}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
SESSION_ID="${FIELDS[1]:-}"
AGENT_ID="${FIELDS[2]:-}"
AGENT_TYPE="${FIELDS[3]:-}"
COMMAND="${FIELDS[4]:-}"
TARGET_PATHS="$(printf '%s\n' "${FIELDS[@]:5}")"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

deny_tool_use() {
  local reason="${1:?reason required}"
  DENY_REASON="$reason" node <<'NODE'
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
  printf 'BLOCKED: planning preflight incomplete. Detail: %s requires fresh work-planning. Next: %s.' "$tool_name" "$next_step"
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

lead_preflight_block_reason() {
  local tool_name="${1:-tool}"

  case "$tool_name" in
    Agent|TaskCreate|SendMessage)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> lifecycle/reuse check -> retry dispatch/reuse"
      ;;
    TaskUpdate|TaskStop)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> confirm task id from TaskList or task_assignment -> retry"
      ;;
    TeamDelete|CronDelete)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> confirm closeout/teardown readiness -> retry"
      ;;
    *)
      planning_preflight_block "$tool_name" "Skill(work-planning) -> Skill(self-verification) -> retry with the tool-specific preflight complete"
      ;;
  esac
}

boot_infra_tool_allowed() {
  local tool_name="${1:-}"
  local command="${2:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|TeamCreate|TeamDelete|WebFetch|WebSearch) return 0 ;;
    Bash)
      printf '%s' "$command" | grep -qE '^[[:space:]]*(pwd|echo[[:space:]]+\$HOME)[[:space:]]*$'
      return
      ;;
    *) return 1 ;;
  esac
}

planning_bootstrap_tool_allowed() {
  local tool_name="${1:-}"

  case "$tool_name" in
    Read|Grep|Glob|LS|ToolSearch|TaskList|TaskGet|TaskOutput|WebFetch|WebSearch|Bash) return 0 ;;
    *) return 1 ;;
  esac
}

if [[ -z "$TOOL_NAME" || -z "$SESSION_ID" ]]; then
  exit 0
fi

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]] && ! session_id_is_known_worker "$SESSION_ID"; then
  if boot_infra_tool_allowed "$TOOL_NAME" "$COMMAND"; then
    exit 0
  fi
fi

if runtime_sender_session_is_worker "$SESSION_ID"; then
  WORKER_NAME="$(worker_name_for_session_id "$SESSION_ID")"
    if [[ -n "$WORKER_NAME" ]] && worker_planning_required "$WORKER_NAME"; then
      if planning_bootstrap_tool_allowed "$TOOL_NAME" "$COMMAND"; then
        exit 0
      fi
      deny_tool_use "$(planning_preflight_block "$TOOL_NAME" "Skill(work-planning) -> continue current task")"
      exit 0
    fi
    exit 0
fi

if ! runtime_sender_session_is_worker "$SESSION_ID"; then
  if planning_bootstrap_tool_allowed "$TOOL_NAME" "$COMMAND"; then
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
    deny_tool_use "$(lead_preflight_block_reason "$TOOL_NAME")"
    exit 0
  fi
fi

exit 0
