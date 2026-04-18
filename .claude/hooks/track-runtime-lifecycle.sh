#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
source "$(dirname "$0")/lib/hook-tool-response.sh"
INPUT="$(cat)"

TIMESTAMP="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
SETTINGS_DEFAULT_MODE="$(node -e "
try {
  const fs = require('fs');
  const j = JSON.parse(fs.readFileSync(process.argv[1], 'utf8'));
  process.stdout.write(String((j.permissions || {}).defaultMode || ''));
} catch {}
" "$CLAUDE_ROOT/settings.json" 2>/dev/null || true)"

resolve_permission_mode_fields() {
  local raw_mode="${1-}"
  local resolved_effective_mode=""
  local resolved_mode=""
  local permission_basis=""
  local permission_source=""

  if [[ -n "$raw_mode" ]]; then
    resolved_effective_mode="$raw_mode"
    resolved_mode="explicit"
    permission_basis="dispatch-packet"
    permission_source="tool_input.mode"
  elif [[ -n "$SETTINGS_DEFAULT_MODE" ]]; then
    resolved_effective_mode="$SETTINGS_DEFAULT_MODE"
    resolved_mode="legacy-default"
    permission_basis="settings-default"
    permission_source="settings.permissions.defaultMode"
  else
    resolved_effective_mode="unspecified"
    resolved_mode="inferred"
    permission_basis="runtime-fallback"
    permission_source="missing-mode"
  fi

  printf '%s\n%s\n%s\n%s\n' \
    "$resolved_effective_mode" \
    "$resolved_mode" \
    "$permission_basis" \
    "$permission_source"
}

# ─── ROUTE BY TOOL NAME ──────────────────────────────────────────────────────
TOOL_NAME="$(INPUT_JSON="$INPUT" node -e "
try {
  process.stdout.write(JSON.parse(process.env.INPUT_JSON || '{}').tool_name || '');
} catch {}
" 2>/dev/null || echo "")"

case "$TOOL_NAME" in

  # ── Agent: dispatch tracking ──────────────────────────────────────────────
  Agent)
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
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
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
  const toolInput = input.tool_input || {};
  const toolResponse = input.tool_response || {};
	  const fields = [
	    collectAgentDispatchText(toolInput),
	    firstNonEmptyString(
	      toolInput.name,
	      toolInput.agent_name,
      toolInput.agentName,
      toolInput.worker_name,
      toolInput.workerName,
      toolInput.teammate_name,
      toolInput.teammateName,
	      toolInput.target_name,
	      toolInput.targetName
	    ),
	    firstNonEmptyString(
	      toolInput.subagent_type,
	      toolInput.subagentType,
	      toolInput.agent_type,
	      toolInput.agentType,
	      toolInput.role,
	      toolInput.lane,
	      toolInput.agent_name,
	      toolInput.agentName
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
  process.stdout.write("\n\n\n\n\n\n");
}
NODE
)"
    mapfile -t FIELDS <<<"$PARSED"
    decode_field() {
      local encoded="${1-}"
      [[ -z "$encoded" ]] && { printf ''; return 0; }
      printf '%s' "$encoded" | base64 -d
	    }
	    DESCRIPTION="$(decode_field "${FIELDS[0]:-}")"
	    AGENT_NAME="$(decode_field "${FIELDS[1]:-}")"
	    AGENT_LANE_HINT="$(decode_field "${FIELDS[2]:-}")"
	    MODE="$(decode_field "${FIELDS[3]:-}")"
	    SESSION_ID="$(recover_session_id "$(decode_field "${FIELDS[4]:-}")")"
	    SUCCESS_VALUE="$(printf '%s' "$(decode_field "${FIELDS[5]:-}")" | tr '[:upper:]' '[:lower:]')"
	    IS_ERROR_VALUE="$(printf '%s' "$(decode_field "${FIELDS[6]:-}")" | tr '[:upper:]' '[:lower:]')"
	    ERROR_VALUE="$(decode_field "${FIELDS[7]:-}")"

    tool_response_succeeded || exit 0

    if [[ -z "$AGENT_NAME" ]]; then
      AGENT_NAME="${AGENT_LANE_HINT:-$(resolve_requested_dispatch_name "" "$DESCRIPTION")}"
    fi

    [[ -n "$AGENT_NAME" && "$AGENT_NAME" != "unknown" ]] || exit 0
    AGENT_LANE_HINT="${AGENT_LANE_HINT:-$AGENT_NAME}"
	    DISPATCH_AGENT_LANE="$(resolve_agent_id "$AGENT_LANE_HINT")"
	    [[ -n "$DISPATCH_AGENT_LANE" && "$DISPATCH_AGENT_LANE" != "unknown" && "$DISPATCH_AGENT_LANE" != "team-lead" ]] || exit 0
	    agent_registry_has_name "$DISPATCH_AGENT_LANE" || exit 0

    if [[ "$DISPATCH_AGENT_LANE" == "researcher" ]]; then
      RESEARCH_MODE_NORM="$(normalize_dispatch_text "$(dispatch_field_raw_value "$DESCRIPTION" "RESEARCH-MODE" 2>/dev/null || true)")"
      SHARD_ID_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "SHARD-ID" 2>/dev/null || true)"
      if [[ "$RESEARCH_MODE_NORM" == "sharded" || -n "$SHARD_ID_RAW" || "$(dispatch_field_present "$DESCRIPTION" "SHARD-BOUNDARY" 2>/dev/null && printf yes || true)" == "yes" ]]; then
        SHARD_ID_SAFE="$(printf '%s' "$SHARD_ID_RAW" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9_-]+/-/g; s/^-+//; s/-+$//')"
        if [[ -n "$SHARD_ID_SAFE" ]]; then
          if [[ -z "$AGENT_NAME" ]] || canonical_dispatch_agent_name "$AGENT_NAME" >/dev/null 2>&1; then
            AGENT_NAME="researcher-${SHARD_ID_SAFE}"
          fi
        fi
      fi
    fi

    if CANONICAL_AGENT_NAME="$(canonical_dispatch_agent_name "$AGENT_NAME" 2>/dev/null)"; then
      AGENT_NAME="$CANONICAL_AGENT_NAME"
    fi

    mapfile -t PERMISSION_FIELDS < <(resolve_permission_mode_fields "$MODE")
    EFFECTIVE_MODE="${PERMISSION_FIELDS[0]:-unspecified}"
    RESOLVED_MODE="${PERMISSION_FIELDS[1]:-inferred}"
    PERMISSION_BASIS="${PERMISSION_FIELDS[2]:-runtime-fallback}"
    PERMISSION_SOURCE="${PERMISSION_FIELDS[3]:-missing-mode}"

	    clear_worker_standby "$AGENT_NAME"
	    record_pending_agent_dispatch "$TIMESTAMP" "$AGENT_NAME" "$EFFECTIVE_MODE" "$DISPATCH_AGENT_LANE"
	    mark_worker_planning_required "$AGENT_NAME"
	    record_permission_provenance "$SESSION_ID" "$RESOLVED_MODE" "$PERMISSION_BASIS" "$PERMISSION_SOURCE" "$MODE" "$AGENT_NAME"
	    mark_team_dispatch_pending "$SESSION_ID" "$AGENT_NAME" "agent-dispatch"

	    if [[ ! -s "$HEALTH_CRON_FLAG" ]]; then
      printf '1\n' > "$HEALTH_CRON_FLAG"
      printf '[%s] HEALTH-CRON: first agent dispatched\n' "$(date '+%Y-%m-%d %H:%M:%S')" >> "$VIOLATION_LOG"
    fi
    ;;

  # ── TeamCreate|TeamDelete|CronCreate|CronDelete: runtime state tracking ───
  TeamCreate|TeamDelete|CronCreate|CronDelete)
    PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
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
  process.stdout.write(`${commandLike}\n${responseId}\n${inputId}\n${sessionId}\n${successValue}\n${isErrorValue}\n${errorValue}\n`);
} catch {
  process.stdout.write("\n\n\n\n\n\n\n");
}
NODE
)"
    mapfile -t FIELDS <<<"$PARSED"
    COMMAND_LIKE="${FIELDS[0]:-}"
    RESPONSE_ID="${FIELDS[1]:-}"
    INPUT_ID="${FIELDS[2]:-}"
    SESSION_ID="${FIELDS[3]:-}"
    SUCCESS_VALUE="$(printf '%s' "${FIELDS[4]:-}" | tr '[:upper:]' '[:lower:]')"
    IS_ERROR_VALUE="$(printf '%s' "${FIELDS[5]:-}" | tr '[:upper:]' '[:lower:]')"
    ERROR_VALUE="${FIELDS[6]:-}"

    is_health_check_cron() {
      local raw="${1-}"
      local normalized=""
      [[ -n "$raw" ]] || return 1
      normalized="$(printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//')"
      [[ "$normalized" == *"health-check.sh"* ]] && return 0
      printf '%s' "$normalized" | grep -Eq '^health[- ]check:' && return 0
      return 1
    }

    mark_runtime_active() {
      printf '%s | explicit-team-runtime-active\n' "$TIMESTAMP" > "$TEAM_RUNTIME_ACTIVE_FILE"
    }
    clear_runtime_active() { : > "$TEAM_RUNTIME_ACTIVE_FILE"; }
    mark_boot_complete() {
      printf '%s | boot-complete\n' "$TIMESTAMP" > "$BOOT_SEQUENCE_COMPLETE_FILE"
    }
    clear_boot_complete() { : > "$BOOT_SEQUENCE_COMPLETE_FILE"; }
    record_health_cron() {
      local job_id="$1"
      [[ -n "$job_id" ]] || return 0
      printf '%s\n' "$job_id" > "$HEALTH_CRON_JOB_FILE"
      [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] && mark_boot_complete
    }
    clear_health_cron() {
      : > "$HEALTH_CRON_JOB_FILE"
      [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] && clear_boot_complete
    }

    # TeamCreate "Already leading" re-affirms runtime only when the current
    # session can actually corroborate ownership of a pane-backed live config.
	    if [[ "$TOOL_NAME" == "TeamCreate" ]] && ! tool_response_succeeded; then
	      if [[ "$ERROR_VALUE" == *"Already leading"* ]] && _current_cfg="$(current_session_live_team_config "$SESSION_ID" 2>/dev/null || true)" && [[ -n "$_current_cfg" ]]; then
	        if [[ -n "$SESSION_ID" ]]; then
	          record_runtime_session_id "$SESSION_ID"
	          mark_procedure_startup_ready "$SESSION_ID"
	        fi
	        mark_runtime_active
	        mark_boot_complete
	        record_team_runtime_state "$SESSION_ID" "active" "live-config"
	      fi
	      exit 0
	    fi

    tool_response_succeeded || exit 0

    case "$TOOL_NAME" in
	      TeamCreate)
	        if [[ -n "$SESSION_ID" ]]; then
	          record_runtime_session_id "$SESSION_ID"
	          mark_procedure_startup_ready "$SESSION_ID"
	        fi
	        mark_runtime_active
	        mark_boot_complete
	        record_team_runtime_state "$SESSION_ID" "active" "team-create"
	        clear_team_dispatch_state "$SESSION_ID"
	        ;;
	      TeamDelete)
	        clear_runtime_active
	        clear_boot_complete
	        clear_runtime_session_id
	        clear_health_cron_rotation_intent "team-runtime-removed" "$SESSION_ID"
	        record_team_runtime_state "$SESSION_ID" "inactive" "none"
	        clear_team_dispatch_state "$SESSION_ID"
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
    ;;

  *)
    exit 0
    ;;
esac

exit 0
