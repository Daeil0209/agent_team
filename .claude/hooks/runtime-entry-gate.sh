#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
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
  const nestedMessage = toolInput.message || {};
  const topType = String(toolInput.type || "");
  const nestedType = String(nestedMessage.type || "");
  const sessionId = String(input.session_id || "");
  const description = String(toolInput.description || "");
  const agentName = firstNonEmptyString(
    toolInput.name,
    toolInput.agent_name,
    toolInput.agentName,
    toolInput.worker_name,
    toolInput.workerName,
    toolInput.teammate_name,
    toolInput.teammateName,
    toolInput.target_name,
    toolInput.targetName,
    toolInput.subagent_type,
    toolInput.subagentType,
    toolInput.agent_type,
    toolInput.agentType,
    toolInput.role,
    toolInput.lane
  );
  const agentTeamName = firstNonEmptyString(
    toolInput.team_name,
    toolInput.teamName,
    input.team_name,
    input.teamName
  );
  const recipientName = firstNonEmptyString(
    toolInput.to,
    toolInput.recipient,
    toolInput.target,
    toolInput.teammate,
    nestedMessage.to,
    nestedMessage.recipient
  );
  process.stdout.write([
    toolName,
    topType,
    nestedType,
    sessionId,
    description,
    agentName,
    agentTeamName,
    recipientName
  ].map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
TOP_TYPE="$(printf '%s' "$(decode_field "${FIELDS[1]:-}")" | tr '[:upper:]' '[:lower:]')"
MESSAGE_TYPE="$(printf '%s' "$(decode_field "${FIELDS[2]:-}")" | tr '[:upper:]' '[:lower:]')"
SESSION_ID="$(decode_field "${FIELDS[3]:-}")"
TOOL_DESCRIPTION="$(decode_field "${FIELDS[4]:-}")"
TOOL_AGENT_NAME="$(decode_field "${FIELDS[5]:-}")"
TOOL_AGENT_TEAM_NAME="$(decode_field "${FIELDS[6]:-}")"
TOOL_RECIPIENT_NAME="$(decode_field "${FIELDS[7]:-}")"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

emit_deny() {
  local reason="${1:?reason required}"
  DENY_REASON="$reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Runtime entry is blocked."
  }
}));
NODE
}

emit_runtime_warning() {
  local detail="${1:?detail required}"
  printf '[%s] RUNTIME-ENTRY WARN: %s | tool=%s | session=%s | requested=%s | team=%s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$detail" \
    "${TOOL_NAME:-unknown}" \
    "${SESSION_ID:0:20}" \
    "${TOOL_AGENT_NAME:-unknown}" \
    "${TOOL_AGENT_TEAM_NAME:-unknown}" >> "$VIOLATION_LOG"
}

runtime_inactive_reason() {
  local tool_name="${1:-tool}"
  if [[ "$tool_name" == "Agent" ]]; then
    printf 'BLOCKED: runtime inactive. Next: TeamCreate -> retry Agent.'
    return
  fi
  printf 'BLOCKED: runtime inactive. Next: TeamCreate -> retry %s.' "$tool_name"
}

cleanup_denied_agent_dispatch_residue() {
  local requested_name=""

  [[ "$TOOL_NAME" == "Agent" ]] || return 0
  requested_name="$(resolve_requested_dispatch_name "$TOOL_AGENT_NAME" "$TOOL_DESCRIPTION")"
  drop_latest_unclaimed_pending_dispatch "$requested_name"
  prune_noncurrent_pending_dispatch_residue
}

run_scan() {
  mapfile -t SCAN_FIELDS < <("$HOOK_DIR/runtime-pressure-scan.sh" --session-id "$SESSION_ID")
  SCAN_STATUS="${SCAN_FIELDS[0]:-ok}"
  SCAN_MEM_KB="${SCAN_FIELDS[2]:-0}"
  SCAN_SWAP_KB="${SCAN_FIELDS[3]:-0}"
  SCAN_ORPHAN_PROC_COUNT="${SCAN_FIELDS[4]:-0}"
  SCAN_ORPHAN_SESSION_COUNT="${SCAN_FIELDS[5]:-0}"
  SCAN_STALE_SOCKET_COUNT="${SCAN_FIELDS[8]:-0}"
  SCAN_AUTO_REAP_ELIGIBLE="${SCAN_FIELDS[11]:-false}"
}

log_runtime_preflight() {
  local stage="${1:?stage required}"
  local reap_output="${2:-none}"
  printf '%s | session=%s | stage=%s | status=%s | mem_kb=%s | swap_kb=%s | orphan_sessions=%s | orphan_processes=%s | stale_sockets=%s | reap=%s\n' \
    "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
    "${SESSION_ID:-unknown}" \
    "$stage" \
    "$SCAN_STATUS" \
    "$SCAN_MEM_KB" \
    "$SCAN_SWAP_KB" \
    "$SCAN_ORPHAN_SESSION_COUNT" \
    "$SCAN_ORPHAN_PROC_COUNT" \
    "$SCAN_STALE_SOCKET_COUNT" \
    "$reap_output" >> "$RUNTIME_ORPHAN_AUDIT_LOG"
}

runtime_tool_requires_boot_guard() {
  case "${1:-}" in
    SendMessage|TaskCreate|TaskUpdate|TaskGet|TaskList|TaskOutput|TaskStop) return 0 ;;
    *) return 1 ;;
  esac
}

sendmessage_is_closeout_exempt() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  if [[ "$TOP_TYPE" == "shutdown_request" || "$MESSAGE_TYPE" == "shutdown_request" ]]; then
    return 0
  fi

  if [[ -n "$SESSION_ID" ]] && closeout_intent_is_active "$SESSION_ID"; then
    return 0
  fi

  return 1
}

if [[ "$TOOL_NAME" == "TeamCreate" ]]; then
  # Only current-session pane-backed runtime proves redundant TeamCreate.
  if _rtg_cfg="$(current_session_live_team_config "$SESSION_ID" 2>/dev/null)"; then
    if [[ -n "$SESSION_ID" ]]; then
      record_runtime_session_id "$SESSION_ID"
      mark_procedure_startup_ready "$SESSION_ID"
    fi
	    printf '%s | explicit-team-runtime-active | source=%s\n' \
	      "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$_rtg_cfg" > "$TEAM_RUNTIME_ACTIVE_FILE"
	    printf '%s | boot-complete\n' \
	      "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
	    record_team_runtime_state "$SESSION_ID" "active" "live-config"
	    emit_deny "BLOCKED: runtime already active. Next: reuse current runtime; no TeamCreate needed."
	    exit 0
	  fi

  if [[ -n "$TOOL_AGENT_TEAM_NAME" ]]; then
    _team_name_safe="$(
      TEAM_NAME="$TOOL_AGENT_TEAM_NAME" node <<'NODE'
const name = String(process.env.TEAM_NAME || "");
if (!name || name.includes("/") || name.includes("\\") || name === "." || name === "..") process.exit(1);
process.stdout.write(name);
NODE
    )" || _team_name_safe=""
    if [[ -n "$_team_name_safe" ]]; then
      _requested_team_config="$HOME/.claude/teams/$_team_name_safe/config.json"
      if [[ -f "$_requested_team_config" ]]; then
        if _live_cfg="$(active_team_config_live 2>/dev/null || true)" && [[ "$_live_cfg" == "$_requested_team_config" ]]; then
          emit_deny "BLOCKED: team_name collision with live runtime '${TOOL_AGENT_TEAM_NAME}'. Next: reuse that runtime only if it is current-session owned, otherwise choose a unique session-scoped team_name."
          exit 0
        fi
        emit_deny "BLOCKED: team_name collision: '$TOOL_AGENT_TEAM_NAME' already has config residue. Next: retry TeamCreate with a unique session-scoped team_name; use TeamDelete only after stale-runtime cleanup is explicitly safe."
        exit 0
      fi
    fi
  fi

  run_scan

  REAP_OUTPUT=""
  if runtime_automation_single_primary && runtime_autoreap_enabled && [[ "$SCAN_AUTO_REAP_ELIGIBLE" == "true" ]]; then
    REAP_OUTPUT="$("$HOOK_DIR/cleanup-orphan-runtime.sh" --auto --session-id "$SESSION_ID" --reason "runtime-entry-team-create" 2>/dev/null || true)"
    run_scan
  fi

  if [[ -n "$REAP_OUTPUT" ]] || [[ "$SCAN_STATUS" != "ok" ]] || (( SCAN_ORPHAN_PROC_COUNT > 0 )) || (( SCAN_STALE_SOCKET_COUNT > 0 )); then
    log_runtime_preflight "runtime-entry-team-create" "${REAP_OUTPUT:-none}"
  fi

  if [[ "$SCAN_STATUS" == "hard" || "$SCAN_STATUS" == "emergency" ]]; then
    DENY_REASON="BLOCKED: runtime-entry pressure. status=${SCAN_STATUS}; mem_kb=${SCAN_MEM_KB}; swap_kb=${SCAN_SWAP_KB}; orphan_sessions=${SCAN_ORPHAN_SESSION_COUNT}; orphan_processes=${SCAN_ORPHAN_PROC_COUNT}; stale_sockets=${SCAN_STALE_SOCKET_COUNT}. Next: clear runtime pressure -> retry TeamCreate."
    if [[ "$REAP_OUTPUT" == REAPED:* ]]; then
      DENY_REASON="${DENY_REASON} Auto-reap attempted; pressure remains."
    fi
    emit_deny "$DENY_REASON"
    exit 0
  fi

  exit 0
fi

if [[ "$TOOL_NAME" != "Agent" ]] && ! runtime_tool_requires_boot_guard "$TOOL_NAME"; then
  exit 0
fi

if [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]]; then
  if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
    case "$TOOL_NAME" in
      TaskList|TaskGet|TaskOutput)
        exit 0
        ;;
    esac
  fi

  # Auto-recover only when the current session already owns a pane-backed team runtime.
	  if _rtg_cfg="$(current_session_live_team_config "$SESSION_ID" 2>/dev/null)"; then
	    [[ -n "$SESSION_ID" ]] && mark_procedure_startup_ready "$SESSION_ID"
	    printf '%s | explicit-team-runtime-active (auto-recovered) | source=%s\n' \
	      "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$_rtg_cfg" > "$TEAM_RUNTIME_ACTIVE_FILE"
	    record_team_runtime_state "$SESSION_ID" "active" "live-config"
	    exit 0
	  fi

  if [[ "$TOOL_NAME" == "Agent" && -n "$SESSION_ID" ]] && closeout_intent_is_active "$SESSION_ID"; then
    cleanup_denied_agent_dispatch_residue
    emit_deny "BLOCKED: runtime inactive during closeout. Next: finish closeout continuity path; do not dispatch Agent after teardown."
    exit 0
  fi

  if [[ "$TOOL_NAME" == "Agent" ]]; then
    cleanup_denied_agent_dispatch_residue
    emit_deny "$(runtime_inactive_reason "$TOOL_NAME")"
    exit 0
  fi

  if sendmessage_is_closeout_exempt; then
    exit 0
  fi

  cleanup_denied_agent_dispatch_residue
  emit_deny "$(runtime_inactive_reason "$TOOL_NAME")"
  exit 0
fi

# Pinpoint must-block: SendMessage to a teammate name that does not appear in the live team
# config causes silent ghost-dispatch (tool reports success while the message is never delivered).
# Block this to preserve runtime truth; pass through when config or member list cannot be
# resolved, and bypass for shutdown_request lifecycle control messages.
if [[ "$TOOL_NAME" == "SendMessage" && -s "$TEAM_RUNTIME_ACTIVE_FILE" && -n "$TOOL_RECIPIENT_NAME" ]]; then
  if [[ "$TOP_TYPE" != "shutdown_request" && "$MESSAGE_TYPE" != "shutdown_request" ]]; then
    if _rtg_live_cfg="$(active_team_config_live 2>/dev/null)" && [[ -n "$_rtg_live_cfg" && -f "$_rtg_live_cfg" ]]; then
      _rtg_member_list="$(CONFIG_FILE="$_rtg_live_cfg" node -e "
        try {
          const c = JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE, 'utf8'));
          const names = (c.members || []).map(m => m && m.name).filter(Boolean);
          process.stdout.write(names.join(','));
        } catch {}
      " 2>/dev/null || true)"
      if [[ -n "$_rtg_member_list" ]]; then
        if ! printf '%s' ",${_rtg_member_list}," | grep -qF ",${TOOL_RECIPIENT_NAME},"; then
          emit_deny "BLOCKED: SendMessage target '${TOOL_RECIPIENT_NAME}' is not a member of the live team. Members: ${_rtg_member_list}. Next: correct the 'to' field to a live team member, or use Agent for non-team dispatch."
          exit 0
        fi
      fi
    fi
  fi
fi

exit 0
