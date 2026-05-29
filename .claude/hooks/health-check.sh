#!/usr/bin/env bash
set -euo pipefail

# Periodic agent and runtime capacity check for explicit team-runtime sessions.
# Usage: bash "$HOME/.claude/hooks/health-check.sh" [window] [short_threshold] [bash_threshold]
# Output: optional runtime-capacity lines + STALE/STANDBY lines + SUMMARY line

source "$(dirname "$0")/hook-config.sh"

mkdir -p "$(dirname "$HEALTH_CHECK_HEARTBEAT_FILE")"
date -u '+%Y-%m-%dT%H:%M:%SZ' > "$HEALTH_CHECK_HEARTBEAT_FILE"

WINDOW="${1:-$HEALTH_CHECK_WINDOW}"
SHORT_THRESH="${2:-$HEALTH_CHECK_SHORT_THRESH}"
BASH_THRESH="${3:-$HEALTH_CHECK_BASH_THRESH}"

run_scan() {
  mapfile -t SCAN_FIELDS < <("$HOOK_DIR/runtime-pressure-scan.sh")
  SCAN_STATUS="${SCAN_FIELDS[0]:-ok}"
  SCAN_MEM_KB="${SCAN_FIELDS[2]:-0}"
  SCAN_SWAP_KB="${SCAN_FIELDS[3]:-0}"
  SCAN_ORPHAN_PROC_COUNT="${SCAN_FIELDS[4]:-0}"
  SCAN_ORPHAN_SESSION_COUNT="${SCAN_FIELDS[5]:-0}"
  SCAN_STALE_SOCKET_COUNT="${SCAN_FIELDS[8]:-0}"
  SCAN_SUMMARY="${SCAN_FIELDS[11]:-}"
}

run_scan

if [[ "$SCAN_STATUS" != "ok" ]] || (( SCAN_ORPHAN_PROC_COUNT > 0 )) || (( SCAN_STALE_SOCKET_COUNT > 0 )); then
  printf '%s | session=%s | stage=health-check | status=%s | mem_kb=%s | swap_kb=%s | orphan_sessions=%s | orphan_processes=%s | stale_sockets=%s\n' \
    "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
    "$(current_runtime_session_id)" \
    "$SCAN_STATUS" \
    "$SCAN_MEM_KB" \
    "$SCAN_SWAP_KB" \
    "$SCAN_ORPHAN_SESSION_COUNT" \
    "$SCAN_ORPHAN_PROC_COUNT" \
    "$SCAN_STALE_SOCKET_COUNT" >> "$RUNTIME_ORPHAN_AUDIT_LOG"
fi

CAPACITY_LINES=()
if [[ "$SCAN_STATUS" != "ok" ]] || (( SCAN_ORPHAN_PROC_COUNT > 0 )) || (( SCAN_STALE_SOCKET_COUNT > 0 )); then
  CAPACITY_LINES+=("RUNTIME [${SCAN_STATUS^^}]: mem_kb=${SCAN_MEM_KB} | swap_kb=${SCAN_SWAP_KB} | orphan_sessions=${SCAN_ORPHAN_SESSION_COUNT} | orphan_processes=${SCAN_ORPHAN_PROC_COUNT} | stale_sockets=${SCAN_STALE_SOCKET_COUNT}")
fi

STANDBY_LIST=""
if [[ -f "$STANDBY_FILE" ]]; then
  STANDBY_LIST="$(tr '\n' '|' < "$STANDBY_FILE" | sed 's/|$//')"
fi

# Memory stats for SUMMARY display (same /proc/meminfo source as runtime-pressure-scan.sh)
_MEMINFO_FILE="${RUNTIME_MEMINFO_SOURCE:-/proc/meminfo}"
_MEM_TOTAL_KB="$(awk '$1=="MemTotal:"{print $2;exit}' "$_MEMINFO_FILE" 2>/dev/null || true)"
_SWAP_TOTAL_KB="$(awk '$1=="SwapTotal:"{print $2;exit}' "$_MEMINFO_FILE" 2>/dev/null || true)"
_MEM_TOTAL_KB="${_MEM_TOTAL_KB:-0}"
_SWAP_TOTAL_KB="${_SWAP_TOTAL_KB:-0}"
_MEM_STATS="$(awk -v avail_kb="$SCAN_MEM_KB" -v total_kb="$_MEM_TOTAL_KB" \
  -v swap_free_kb="$SCAN_SWAP_KB" -v swap_total_kb="$_SWAP_TOTAL_KB" '
BEGIN {
  used_kb = total_kb - avail_kb
  if (used_kb < 0) used_kb = 0
  pct = (total_kb > 0) ? int(used_kb * 100 / total_kb) : 0
  if (total_kb >= 1048576) {
    t_val = sprintf("%.1fG", total_kb / 1048576)
    u_val = sprintf("%.1fG", used_kb / 1048576)
  } else {
    t_val = sprintf("%.0fM", total_kb / 1024)
    u_val = sprintf("%.0fM", used_kb / 1024)
  }
  swap_used_kb = swap_total_kb - swap_free_kb
  if (swap_used_kb < 0) swap_used_kb = 0
  swap_pct = (swap_total_kb > 0) ? int(swap_used_kb * 100 / swap_total_kb) : 0
  if (swap_total_kb >= 1048576) {
    st_val = sprintf("%.1fG", swap_total_kb / 1048576)
    su_val = sprintf("%.1fG", swap_used_kb / 1048576)
  } else {
    st_val = sprintf("%.0fM", swap_total_kb / 1024)
    su_val = sprintf("%.0fM", swap_used_kb / 1024)
  }
  printf "mem: %s/%s (%d%%) swap: %s/%s (%d%%)", u_val, t_val, pct, su_val, st_val, swap_pct
}' 2>/dev/null || true)"

if [[ ! -f "$ACTIVITY_LEDGER" ]]; then
  for line in "${CAPACITY_LINES[@]}"; do
    printf '%s\n' "$line"
  done
  echo "SUMMARY: 0 active, 0 standby (no ledger)${_MEM_STATS:+ | $_MEM_STATS}"
  exit 0
fi

KEEP_WATCHDOG="false"
if runtime_keep_watchdog_when_idle; then
  KEEP_WATCHDOG="true"
fi

RESULT="$(TZ=UTC gawk -F' \\| ' \
  -v window="$WINDOW" \
  -v short_threshold="$SHORT_THRESH" \
  -v bash_threshold="$BASH_THRESH" \
  -v ghost_threshold="${HEALTH_CHECK_GHOST_THRESH:-1800}" \
  -v standby="$STANDBY_LIST" \
  -v keep_watchdog="$KEEP_WATCHDOG" '
function in_list(item, list,    n, arr, i) {
  if (list == "") return 0
  n = split(list, arr, "|")
  for (i = 1; i <= n; i++) {
    if (arr[i] == item) return 1
  }
  return 0
}
{
  gsub(/^ +| +$/, "", $1); gsub(/^ +| +$/, "", $2); gsub(/^ +| +$/, "", $3); gsub(/^ +| +$/, "", $5)
  if ($1 == "" || $3 == "" || $5 == "") next
  if ($1 !~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}/) next
  ts = $1
  gsub(/[-T:Z]/, " ", ts)
  epoch = mktime(ts)
  if (epoch <= 0) next
  aid = $3
  if (aid == "supervisor" || aid == "unknown-agent") next
  if ($2 == "TEAMMATE_IDLE" || $2 == "TEAMMATE_IDLE_DEBUG") next
  if (epoch > last_epoch[aid]) {
    last_epoch[aid] = epoch
    last_tool[aid] = $5
  }
}
END {
  now = systime()
  long_bash = "sleep|npm|pnpm|yarn|uv|pip|make|build|install|compile|docker|git.clone|wget|curl.*-o"
  active = 0
  stale = 0
  standby_count = 0

  for (a in last_epoch) {
    delta = now - last_epoch[a]
    if (a == "runtime-monitor" || a == "unknown-agent") continue
    if (in_list(a, standby)) {
      standby_count++
      standby_lines[standby_count] = sprintf("STANDBY: %s | %ds idle | approved", a, delta)
      continue
    }
    if (delta > window) continue

    tool = last_tool[a]
    is_bash = (substr(tool, 1, 5) == "Bash:")
    if (is_bash) {
      cmd = substr(tool, 6)
      is_long = match(cmd, long_bash)
      threshold = is_long ? bash_threshold : short_threshold
      label = is_long ? "BASH_LONG" : "BASH_SHORT"
    } else {
      threshold = short_threshold
      label = "INSTANT"
    }

    if (delta > threshold) {
      if (delta > ghost_threshold) {
        printf "GHOST: %s | %ds idle | %s | %s\n", a, delta, label, tool
      } else {
        printf "STALE: %s | %ds idle | %s | %s\n", a, delta, label, tool
        stale++
      }
    } else {
      active++
    }
  }

  for (i = 1; i <= standby_count; i++) print standby_lines[i]

  if (active == 0 && stale == 0 && standby_count > 0 && keep_watchdog != "true") {
    printf "CRON_PAUSE: All agents standby (%d standby). CronDelete health-check and clear .health-cron-job-id.\n", standby_count
    exit
  }

  printf "SUMMARY: %d active, %d standby\n", active, standby_count
}
' "$ACTIVITY_LEDGER")"

# Filter STALE/GHOST lines for agents not in any team config or agent map
_REGISTERED_WORKERS=""
for _fr_cfg in "$HOME/.claude/teams"/*/config.json; do
  [[ -f "$_fr_cfg" ]] || continue
  _REGISTERED_WORKERS+="$(CONFIG_FILE="$_fr_cfg" node -e "
    try {
      const c = JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE, 'utf8'));
      (c.members || []).forEach(m => { if (m.name) process.stdout.write(m.name + '\n'); });
    } catch(e) {}
  " 2>/dev/null || true)"
  _REGISTERED_WORKERS+=$'\n'
done
if [[ -f "$STANDBY_FILE" ]]; then
  _REGISTERED_WORKERS+="$(cat "$STANDBY_FILE" 2>/dev/null || true)"
fi
if [[ -f "$SESSION_AGENT_MAP" ]]; then
  _REGISTERED_WORKERS+="$(awk '{print $2}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
fi

_FILTERED_RESULT=""
while IFS= read -r _fr_line; do
  if [[ "$_fr_line" == STALE:* ]] || [[ "$_fr_line" == GHOST:* ]]; then
    _fr_worker="${_fr_line#*: }"
    _fr_worker="${_fr_worker%% | *}"
    if printf '%s\n' "$_REGISTERED_WORKERS" | grep -qxF "$_fr_worker"; then
      _FILTERED_RESULT+="${_fr_line}"$'\n'
    fi
  else
    _FILTERED_RESULT+="${_fr_line}"$'\n'
  fi
done <<< "$RESULT"
RESULT="${_FILTERED_RESULT%$'\n'}"

# Append memory stats to SUMMARY line
if [[ -n "$_MEM_STATS" ]]; then
  RESULT="$(printf '%s\n' "$RESULT" | awk -v ms="$_MEM_STATS" '/^SUMMARY:/ { print $0 " | " ms; next } { print }')"
fi

# remove_member_from_config() — now provided by hook-config.sh

# Memory pressure reports standby hold state. It does not terminate agents.
memory_pressure_report_standby_hold

for line in "${CAPACITY_LINES[@]}"; do
  printf '%s\n' "$line"
done

# Report ghost agents. Do not force-kill from this monitor.
while IFS= read -r _ghost_line; do
  [[ "$_ghost_line" == GHOST:* ]] || continue
  _ghost_name="${_ghost_line#GHOST: }"
  _ghost_name="${_ghost_name%% | *}"
  if [[ -n "$_ghost_name" ]]; then
    printf 'GHOST-REPORTED: %s | cleanup deferred to session-closeout or explicit recovery\n' "$_ghost_name"
  fi
done <<< "$RESULT"
echo "$RESULT"

if [[ "$RESULT" == CRON_PAUSE* ]]; then
  : > "$HEALTH_CRON_FLAG"
fi

exit 0
