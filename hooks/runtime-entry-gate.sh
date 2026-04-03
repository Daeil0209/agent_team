#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const nestedMessage = toolInput.message || {};
  const topType = String(toolInput.type || "");
  const nestedType = String(nestedMessage.type || "");
  const sessionId = String(input.session_id || "");
  const description = String(toolInput.description || "");
  const agentName = String(toolInput.name || "");
  process.stdout.write(`${toolName}\n${topType}\n${nestedType}\n${sessionId}\n${description}\n${agentName}\n`);
} catch {
  process.stdout.write("\n\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
TOP_TYPE="$(printf '%s' "${FIELDS[1]:-}" | tr '[:upper:]' '[:lower:]')"
MESSAGE_TYPE="$(printf '%s' "${FIELDS[2]:-}" | tr '[:upper:]' '[:lower:]')"
SESSION_ID="${FIELDS[3]:-}"
TOOL_DESCRIPTION="${FIELDS[4]:-}"
TOOL_AGENT_NAME="${FIELDS[5]:-}"

if [[ -z "$SESSION_ID" ]]; then
  SESSION_ID="$(current_runtime_session_id)"
fi

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
    Agent|SendMessage|TaskCreate|TaskUpdate|TaskGet|TaskList|TaskOutput|TaskStop) return 0 ;;
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
  # If a team already exists, re-affirm runtime state and skip TeamCreate
  for _rtg_cfg in "$HOME/.claude/teams"/*/config.json; do
    if [[ -f "$_rtg_cfg" ]]; then
      if [[ -n "$SESSION_ID" ]]; then
        record_runtime_session_id "$SESSION_ID"
      fi
      printf '%s | explicit-team-runtime-active\n' \
        "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$TEAM_RUNTIME_ACTIVE_FILE"
      printf '%s | boot-complete\n' \
        "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
      emit_deny "Team already active — runtime re-affirmed. No TeamCreate needed."
      exit 0
    fi
  done

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
    DENY_REASON="Runtime entry preflight blocked TeamCreate. status=${SCAN_STATUS}; mem_kb=${SCAN_MEM_KB}; swap_kb=${SCAN_SWAP_KB}; orphan_sessions=${SCAN_ORPHAN_SESSION_COUNT}; orphan_processes=${SCAN_ORPHAN_PROC_COUNT}; stale_sockets=${SCAN_STALE_SOCKET_COUNT}. Clear runtime pressure before creating a new explicit team runtime."
    if [[ "$REAP_OUTPUT" == REAPED:* ]]; then
      DENY_REASON="${DENY_REASON} Automatic orphan cleanup was attempted but pressure remains."
    fi
    emit_deny "$DENY_REASON"
    exit 0
  fi

  exit 0
fi

if ! runtime_tool_requires_boot_guard "$TOOL_NAME"; then
  exit 0
fi

if [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]]; then
  # Auto-recover: if a team config exists, runtime is active but state file is stale
  for _rtg_cfg in "$HOME/.claude/teams"/*/config.json; do
    if [[ -f "$_rtg_cfg" ]]; then
      printf '%s | explicit-team-runtime-active (auto-recovered)\n' \
        "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$TEAM_RUNTIME_ACTIVE_FILE"
      exit 0
    fi
  done

  if [[ "$TOOL_NAME" == "Agent" && -n "$SESSION_ID" ]] && closeout_intent_is_active "$SESSION_ID"; then
    cleanup_denied_agent_dispatch_residue
    emit_deny "Explicit team runtime is already inactive during Closeout Sequence. Do not dispatch a new Agent after teardown for continuity capture. Finish any helper-assisted continuity update before CronDelete or TeamDelete, or rely on SessionEnd capture."
    exit 0
  fi

  cleanup_denied_agent_dispatch_residue
  emit_deny "Explicit team runtime is not active. Run TeamCreate before using ${TOOL_NAME}."
  exit 0
fi

exit 0
