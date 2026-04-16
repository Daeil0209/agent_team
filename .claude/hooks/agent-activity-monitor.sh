#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const sessionId = input.session_id || "unknown";
  const toolName = input.tool_name || "unknown";
  const cwd = input.cwd || "unknown";
  const agentId = input.agent_id || "";
  const agentType = input.agent_type || "";
  const command = (input.tool_input && input.tool_input.command) || "";
  process.stdout.write(`${sessionId}\n${toolName}\n${cwd}\n${agentId}\n${agentType}\n${command}\n`);
} catch {
  process.stdout.write("unknown\nunknown\nunknown\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
SESSION_ID="${FIELDS[0]:-unknown}"
TOOL_NAME="${FIELDS[1]:-unknown}"
CWD="${FIELDS[2]:-unknown}"
AGENT_ID="${FIELDS[3]:-}"
AGENT_TYPE="${FIELDS[4]:-}"
COMMAND="${FIELDS[5]:-}"

claim_pending_agent() {
  local preferred_name="${1:-}"
  local claimed_name=""
  local claimed_mode=""
  local claim_output=""

  if [[ -z "$SESSION_ID" || "$SESSION_ID" == "unknown" ]]; then
    return 0
  fi

  if [[ -f "$SESSION_AGENT_MAP" ]] && awk -v sid="$SESSION_ID" '$1 == sid {found=1} END {exit found ? 0 : 1}' "$SESSION_AGENT_MAP" 2>/dev/null; then
    return 0
  fi

  claim_output="$(with_lock_file "$AGENT_CLAIM_LOCK" _claim_pending_agent_locked "$SESSION_ID" "$preferred_name")"
  mapfile -t CLAIM_FIELDS <<<"$claim_output"
  claimed_name="${CLAIM_FIELDS[0]:-}"
  claimed_mode="${CLAIM_FIELDS[1]:-}"

  if [[ -n "$claimed_name" ]]; then
    AGENT_TYPE="$claimed_name"
  fi
}

_claim_pending_agent_locked() {
  local session_id="${1:?session id required}"
  local preferred_name="${2:-}"
  local claimed_name=""
  local claimed_mode=""
  local mode_target_name=""

  touch "$PENDING_AGENTS_FILE" "$PENDING_AGENT_MODES_FILE" "$SESSION_AGENT_MAP" "$SESSION_AGENT_MODE_MAP"

  claimed_name="$(awk -v sid="$session_id" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  claimed_mode="$(awk -v sid="$session_id" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MODE_MAP" 2>/dev/null || true)"

  if [[ -z "$claimed_name" ]]; then
    claimed_name="$(_claim_pending_name_file "$PENDING_AGENTS_FILE" "$session_id" "$preferred_name")"
  fi

  if [[ -n "$claimed_name" ]] && ! awk -v sid="$session_id" '$1 == sid {found=1} END {exit found ? 0 : 1}' "$SESSION_AGENT_MAP" 2>/dev/null; then
    printf '%s %s\n' "$session_id" "$claimed_name" >> "$SESSION_AGENT_MAP"
  fi

  mode_target_name="${claimed_name:-$preferred_name}"
  if [[ -n "$claimed_mode" ]]; then
    :
  elif [[ -n "$mode_target_name" ]]; then
    claimed_mode="$(_claim_pending_mode_file "$PENDING_AGENT_MODES_FILE" "$session_id" "$mode_target_name")"
  fi

  if [[ -n "$claimed_mode" ]] && ! awk -v sid="$session_id" '$1 == sid {found=1} END {exit found ? 0 : 1}' "$SESSION_AGENT_MODE_MAP" 2>/dev/null; then
    printf '%s %s\n' "$session_id" "$claimed_mode" >> "$SESSION_AGENT_MODE_MAP"
  fi

  printf '%s\n%s\n' "$claimed_name" "$claimed_mode"
}

_claim_pending_name_file() {
  local target_file="${1:?target file required}"
  local session_id="${2:?session id required}"
  local preferred_name="${3:-}"
  local temp_file=""
  local meta_file=""
  local claimed_name=""

  temp_file="$(make_atomic_temp_file "$target_file")"
  meta_file="${temp_file}.meta"

  awk -F' \\| ' -v sid="$session_id" -v preferred="$preferred_name" -v meta="$meta_file" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      ts[NR] = trim($1)
      name[NR] = trim($2)
      status[NR] = trim($3)
      if (status[NR] == "PENDING") {
        if (!first_pending) {
          first_pending = NR
        }
        if (preferred != "" && name[NR] == preferred && !preferred_pending) {
          preferred_pending = NR
        }
      }
    }
    END {
      chosen = preferred_pending ? preferred_pending : first_pending
      if (chosen) {
        print name[chosen] > meta
      }
      for (i = 1; i <= NR; i++) {
        current_status = status[i]
        if (i == chosen) {
          current_status = "CLAIMED:" sid
        }
        printf "%s | %s | %s\n", ts[i], name[i], current_status
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
  if [[ -f "$meta_file" ]]; then
    claimed_name="$(head -n 1 "$meta_file" || true)"
    rm -f "$meta_file"
  fi

  printf '%s' "$claimed_name"
}

_claim_pending_mode_file() {
  local target_file="${1:?target file required}"
  local session_id="${2:?session id required}"
  local target_name="${3:?target name required}"
  local temp_file=""
  local meta_file=""
  local claimed_mode=""

  temp_file="$(make_atomic_temp_file "$target_file")"
  meta_file="${temp_file}.meta"

  awk -F' \\| ' -v sid="$session_id" -v target="$target_name" -v meta="$meta_file" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      ts[NR] = trim($1)
      name[NR] = trim($2)
      mode[NR] = trim($3)
      status[NR] = trim($4)
      if (status[NR] == "PENDING") {
        if (!first_pending) {
          first_pending = NR
        }
        if (target != "" && name[NR] == target && !named_pending) {
          named_pending = NR
        }
      }
    }
    END {
      chosen = named_pending ? named_pending : first_pending
      if (chosen) {
        print mode[chosen] > meta
      }
      for (i = 1; i <= NR; i++) {
        current_status = status[i]
        if (i == chosen) {
          current_status = "CLAIMED:" sid
        }
        printf "%s | %s | %s | %s\n", ts[i], name[i], mode[i], current_status
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
  if [[ -f "$meta_file" ]]; then
    claimed_mode="$(head -n 1 "$meta_file" || true)"
    rm -f "$meta_file"
  fi

  printf '%s' "$claimed_mode"
}

if [[ -n "$AGENT_ID" ]]; then
  if [[ -z "$AGENT_TYPE" ]]; then
    AGENT_TYPE="$AGENT_ID"
  fi
  claim_pending_agent "$AGENT_TYPE"
else
  BOOT_SESSION_ID=""
  if [[ -f "$SESSION_BOOT_MARKER_FILE" ]]; then
    BOOT_SESSION_ID="$(tr -d '\n' < "$SESSION_BOOT_MARKER_FILE" 2>/dev/null || true)"
  fi
  if session_is_runtime_owner "$SESSION_ID"; then
    AGENT_TYPE="supervisor"
  elif command_is_health_check_monitor "$COMMAND"; then
    AGENT_TYPE="runtime-monitor"
  elif [[ -z "$(current_runtime_session_id)" && -n "$BOOT_SESSION_ID" && "$SESSION_ID" == "$BOOT_SESSION_ID" ]]; then
    AGENT_TYPE="supervisor"
  elif has_unclaimed_pending_agent_dispatch; then
    claim_pending_agent "$AGENT_TYPE"
    AGENT_TYPE="$(worker_name_for_session_id "$SESSION_ID")"
  elif runtime_sender_session_is_worker "$SESSION_ID"; then
    claim_pending_agent "$AGENT_TYPE"
    AGENT_TYPE="$(worker_name_for_session_id "$SESSION_ID")"
  elif [[ -f "$SESSION_AGENT_MAP" ]] && grep -q "^${SESSION_ID} " "$SESSION_AGENT_MAP" 2>/dev/null; then
    AGENT_TYPE="$(grep "^${SESSION_ID} " "$SESSION_AGENT_MAP" | head -1 | awk '{print $2}')"
  else
    # Non-runtime main sessions should not claim pending worker slots.
    # Worker recovery may still succeed through the shared runtime sender resolver.
    AGENT_TYPE="unknown-agent"
  fi
fi

if [[ -n "$AGENT_ID" ]] && [[ -f "$KILL_LIST" ]] && awk -F'|' -v name="$AGENT_TYPE" '$2 == name' "$KILL_LIST" 2>/dev/null | grep -q .; then
  if [[ "$TOOL_NAME" != "SendMessage" ]]; then
    cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[AGENT-KILL] Agent terminated by supervisor. Tool calls blocked."}}
EOF
    exit 0
  fi
fi

CWD_SUFFIX="$(echo "$CWD" | awk -F'/' '{if(NF>=2) print $(NF-1)"/"$NF; else print $NF}')"
TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
if [[ "$AGENT_TYPE" == "unknown-agent" ]]; then
  exit 0
fi

if [[ "$TOOL_NAME" == "Bash" ]]; then
  CMD_SUMMARY="$(printf '%s' "$COMMAND" | head -c 50 | tr '|"\\' '_')"
  printf '%s | %s | %s | %s | Bash:%s\n' "$TIMESTAMP" "$SESSION_ID" "$AGENT_TYPE" "$CWD_SUFFIX" "$CMD_SUMMARY" >> "$ACTIVITY_LEDGER"
else
  printf '%s | %s | %s | %s | %s\n' "$TIMESTAMP" "$SESSION_ID" "$AGENT_TYPE" "$CWD_SUFFIX" "$TOOL_NAME" >> "$ACTIVITY_LEDGER"
fi

# ── Memory pressure check (throttled, supervisor only) ────────────────────
# Replaces cron-based health-check memory monitoring.
# Runs at most once per 60s to avoid overhead on every tool call.
if [[ "$AGENT_TYPE" == "supervisor" ]]; then
  _MEM_CHECK_THROTTLE="$LOG_DIR/.mem-check-throttle"
  _MEM_CHECK_INTERVAL=60
  _should_check=false

  if [[ ! -f "$_MEM_CHECK_THROTTLE" ]]; then
    _should_check=true
  else
    _last_check=$(stat -c %Y "$_MEM_CHECK_THROTTLE" 2>/dev/null || echo 0)
    _now=$(date +%s)
    if (( _now - _last_check > _MEM_CHECK_INTERVAL )); then
      _should_check=true
    fi
  fi

  if [[ "$_should_check" == "true" ]]; then
    touch "$_MEM_CHECK_THROTTLE" 2>/dev/null || true
    memory_pressure_shutdown_standby
  fi
fi

exit 0
