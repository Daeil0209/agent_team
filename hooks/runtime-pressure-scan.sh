#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

CURRENT_SESSION_ID="${RUNTIME_SESSION_ID_OVERRIDE:-}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --session-id)
      CURRENT_SESSION_ID="${2-}"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

if [[ -z "$CURRENT_SESSION_ID" ]]; then
  CURRENT_SESSION_ID="$(current_runtime_session_id)"
fi

MEMINFO_SOURCE="${RUNTIME_MEMINFO_SOURCE:-/proc/meminfo}"
PS_SOURCE="${RUNTIME_PS_SOURCE:-}"

read_meminfo_kb() {
  local field="${1:?field required}"
  awk -v field="$field" '$1 == field ":" {print $2; exit}' "$MEMINFO_SOURCE" 2>/dev/null
}

MEM_AVAILABLE_KB="$(read_meminfo_kb "MemAvailable")"
SWAP_FREE_KB="$(read_meminfo_kb "SwapFree")"
SWAP_TOTAL_KB="$(read_meminfo_kb "SwapTotal")"
MEM_AVAILABLE_KB="${MEM_AVAILABLE_KB:-0}"
SWAP_FREE_KB="${SWAP_FREE_KB:-0}"
SWAP_TOTAL_KB="${SWAP_TOTAL_KB:-0}"

if [[ -n "$PS_SOURCE" && -f "$PS_SOURCE" ]]; then
  PROCESS_SCAN_SOURCE="$(cat "$PS_SOURCE")"
else
  PROCESS_SCAN_SOURCE="$(ps -eo pid=,ppid=,rss=,args= 2>/dev/null || true)"
fi

ORPHAN_PROCESS_COUNT=0
ORPHAN_SESSION_COUNT=0
ORPHAN_RSS_KB=0
ORPHAN_SESSION_IDS=""
ORPHAN_PID_LIST=""
STALE_SOCKET_COUNT=0
STALE_SOCKET_LIST=""
STATUS="ok"
AUTO_REAP_ELIGIBLE="false"

if runtime_automation_single_primary && [[ -n "$CURRENT_SESSION_ID" ]]; then
  ORPHAN_SCAN="$(
    printf '%s\n' "$PROCESS_SCAN_SOURCE" | awk -v current="$CURRENT_SESSION_ID" '
      {
        pid = $1
        rss = $3
        sid = ""
        for (i = 4; i <= NF; i++) {
          if (($i == "--parent-session-id" || $i == "parent-session-id") && (i + 1) <= NF) {
            sid = $(i + 1)
            break
          }
          if ($i ~ /^--parent-session-id=/) {
            sid = substr($i, length("--parent-session-id=") + 1)
            break
          }
        }
        if (sid == "" || sid == current) {
          next
        }
        printf "%s|%s|%s\n", sid, pid, rss
      }
    '
  )"

  declare -A ORPHAN_SESSION_SEEN=()
  while IFS='|' read -r orphan_session orphan_pid orphan_rss; do
    [[ -n "$orphan_session" ]] || continue
    ORPHAN_PROCESS_COUNT=$((ORPHAN_PROCESS_COUNT + 1))
    ORPHAN_RSS_KB=$((ORPHAN_RSS_KB + ${orphan_rss:-0}))
    if [[ -z "$ORPHAN_PID_LIST" ]]; then
      ORPHAN_PID_LIST="$orphan_pid"
    else
      ORPHAN_PID_LIST="${ORPHAN_PID_LIST}|${orphan_pid}"
    fi
    if [[ -z "${ORPHAN_SESSION_SEEN[$orphan_session]+x}" ]]; then
      ORPHAN_SESSION_SEEN["$orphan_session"]=1
      ORPHAN_SESSION_COUNT=$((ORPHAN_SESSION_COUNT + 1))
      if [[ -z "$ORPHAN_SESSION_IDS" ]]; then
        ORPHAN_SESSION_IDS="$orphan_session"
      else
        ORPHAN_SESSION_IDS="${ORPHAN_SESSION_IDS}|${orphan_session}"
      fi
    fi
  done <<<"$ORPHAN_SCAN"
fi

if [[ -d "$RUNTIME_TMUX_SOCKET_DIR" ]]; then
  while IFS= read -r socket_path; do
    [[ -n "$socket_path" ]] || continue
    socket_name="${socket_path##*/}"
    socket_is_stale="false"

    # Check if the tmux socket is actually responsive.
    # The socket name suffix is NOT guaranteed to be a tmux PID
    # (e.g., claude-swarm-24 uses the Claude process PID, not the tmux server PID).
    if ! tmux -L "$socket_name" list-sessions &>/dev/null; then
      socket_is_stale="true"
    fi

    if [[ "$socket_is_stale" == "true" ]]; then
      STALE_SOCKET_COUNT=$((STALE_SOCKET_COUNT + 1))
      if [[ -z "$STALE_SOCKET_LIST" ]]; then
        STALE_SOCKET_LIST="$socket_path"
      else
        STALE_SOCKET_LIST="${STALE_SOCKET_LIST}|${socket_path}"
      fi
    fi
  done < <(find "$RUNTIME_TMUX_SOCKET_DIR" -maxdepth 1 \( -type s -o -type f \) -name 'claude-swarm-*' 2>/dev/null | sort)
fi

STATUS="ok"
if (( MEM_AVAILABLE_KB <= RUNTIME_MEM_EMERGENCY_KB )); then
  STATUS="emergency"
elif (( MEM_AVAILABLE_KB <= RUNTIME_MEM_HARD_KB )); then
  STATUS="hard"
elif (( MEM_AVAILABLE_KB <= RUNTIME_MEM_SOFT_KB )); then
  STATUS="soft"
fi

if (( SWAP_TOTAL_KB > 0 )); then
  if (( SWAP_FREE_KB <= RUNTIME_SWAP_EMERGENCY_KB )); then
    STATUS="emergency"
  elif (( SWAP_FREE_KB <= RUNTIME_SWAP_HARD_KB )) && [[ "$STATUS" != "emergency" ]]; then
    STATUS="hard"
  fi
fi

if (( ORPHAN_PROCESS_COUNT > 0 )) && [[ "$STATUS" == "ok" || "$STATUS" == "soft" ]]; then
  STATUS="orphan"
fi

if (( STALE_SOCKET_COUNT > 0 )) && [[ "$STATUS" == "ok" ]]; then
  STATUS="soft"
fi

if runtime_automation_single_primary && runtime_autoreap_enabled && [[ -n "$CURRENT_SESSION_ID" ]]; then
  if (( ORPHAN_PROCESS_COUNT > 0 || STALE_SOCKET_COUNT > 0 )); then
    AUTO_REAP_ELIGIBLE="true"
  fi
fi

SUMMARY="status=${STATUS};mem_kb=${MEM_AVAILABLE_KB};swap_kb=${SWAP_FREE_KB};orphan_sessions=${ORPHAN_SESSION_COUNT};orphan_processes=${ORPHAN_PROCESS_COUNT};orphan_rss_kb=${ORPHAN_RSS_KB};stale_sockets=${STALE_SOCKET_COUNT}"

STATE_FILE="$RUNTIME_PRESSURE_STATE_FILE" \
STATUS="$STATUS" \
CURRENT_SESSION_ID="$CURRENT_SESSION_ID" \
MEM_AVAILABLE_KB="$MEM_AVAILABLE_KB" \
SWAP_FREE_KB="$SWAP_FREE_KB" \
SWAP_TOTAL_KB="$SWAP_TOTAL_KB" \
ORPHAN_PROCESS_COUNT="$ORPHAN_PROCESS_COUNT" \
ORPHAN_SESSION_COUNT="$ORPHAN_SESSION_COUNT" \
ORPHAN_RSS_KB="$ORPHAN_RSS_KB" \
ORPHAN_SESSION_IDS="$ORPHAN_SESSION_IDS" \
ORPHAN_PID_LIST="$ORPHAN_PID_LIST" \
STALE_SOCKET_COUNT="$STALE_SOCKET_COUNT" \
STALE_SOCKET_LIST="$STALE_SOCKET_LIST" \
AUTO_REAP_ELIGIBLE="$AUTO_REAP_ELIGIBLE" \
SUMMARY="$SUMMARY" \
node <<'NODE'
const fs = require("fs");
const path = require("path");

const stateFile = process.env.STATE_FILE || "";
if (!stateFile) {
  process.exit(0);
}

const splitList = (value) =>
  String(value || "")
    .split("|")
    .map((item) => item.trim())
    .filter(Boolean);

const state = {
  scannedAt: new Date().toISOString(),
  automationMode: process.env.RUNTIME_AUTOMATION_MODE || "single-primary",
  status: process.env.STATUS || "ok",
  currentSessionId: process.env.CURRENT_SESSION_ID || "",
  memAvailableKb: Number(process.env.MEM_AVAILABLE_KB || 0),
  swapFreeKb: Number(process.env.SWAP_FREE_KB || 0),
  swapTotalKb: Number(process.env.SWAP_TOTAL_KB || 0),
  orphanProcessCount: Number(process.env.ORPHAN_PROCESS_COUNT || 0),
  orphanSessionCount: Number(process.env.ORPHAN_SESSION_COUNT || 0),
  orphanRssKb: Number(process.env.ORPHAN_RSS_KB || 0),
  orphanSessionIds: splitList(process.env.ORPHAN_SESSION_IDS),
  orphanPids: splitList(process.env.ORPHAN_PID_LIST).map((value) => Number(value)),
  staleSocketCount: Number(process.env.STALE_SOCKET_COUNT || 0),
  staleSockets: splitList(process.env.STALE_SOCKET_LIST),
  autoReapEligible: String(process.env.AUTO_REAP_ELIGIBLE || "") === "true",
  summary: process.env.SUMMARY || ""
};

fs.mkdirSync(path.dirname(stateFile), { recursive: true });
fs.writeFileSync(stateFile, `${JSON.stringify(state, null, 2)}\n`);
NODE

printf '%s\n' \
  "$STATUS" \
  "$CURRENT_SESSION_ID" \
  "$MEM_AVAILABLE_KB" \
  "$SWAP_FREE_KB" \
  "$ORPHAN_PROCESS_COUNT" \
  "$ORPHAN_SESSION_COUNT" \
  "$ORPHAN_RSS_KB" \
  "$ORPHAN_SESSION_IDS" \
  "$STALE_SOCKET_COUNT" \
  "$ORPHAN_PID_LIST" \
  "$STALE_SOCKET_LIST" \
  "$AUTO_REAP_ELIGIBLE" \
  "$SUMMARY"
