#!/usr/bin/env bash
set -euo pipefail

# Periodic worker and runtime capacity check for explicit team-runtime sessions.
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
  SCAN_AUTO_REAP_ELIGIBLE="${SCAN_FIELDS[11]:-false}"
  SCAN_SUMMARY="${SCAN_FIELDS[12]:-}"
}

run_scan

REAP_OUTPUT=""
if runtime_automation_single_primary && runtime_autoreap_enabled && [[ "$SCAN_AUTO_REAP_ELIGIBLE" == "true" ]]; then
  REAP_OUTPUT="$("$HOOK_DIR/cleanup-orphan-runtime.sh" --auto --reason "health-check" 2>/dev/null || true)"
  run_scan
fi

if [[ -n "$REAP_OUTPUT" ]] || [[ "$SCAN_STATUS" != "ok" ]] || (( SCAN_ORPHAN_PROC_COUNT > 0 )) || (( SCAN_STALE_SOCKET_COUNT > 0 )); then
  printf '%s | session=%s | stage=health-check | status=%s | mem_kb=%s | swap_kb=%s | orphan_sessions=%s | orphan_processes=%s | stale_sockets=%s | reap=%s\n' \
    "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
    "$(current_runtime_session_id)" \
    "$SCAN_STATUS" \
    "$SCAN_MEM_KB" \
    "$SCAN_SWAP_KB" \
    "$SCAN_ORPHAN_SESSION_COUNT" \
    "$SCAN_ORPHAN_PROC_COUNT" \
    "$SCAN_STALE_SOCKET_COUNT" \
    "${REAP_OUTPUT:-none}" >> "$RUNTIME_ORPHAN_AUDIT_LOG"
fi

CAPACITY_LINES=()
if [[ "$REAP_OUTPUT" == REAPED:* ]]; then
  CAPACITY_LINES+=("AUTOREAP:${REAP_OUTPUT#REAPED: }")
fi
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

# Filter STALE/GHOST lines for workers not in any team config or agent map
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

# Auto-shutdown STANDBY workers when memory usage exceeds 80%.
# Reuses _MEM_TOTAL_KB (total) and SCAN_MEM_KB (available) already computed above.
# Memory usage variables removed (unused after B2 library refactor)

# get_worker_pane_id() — now provided by hook-config.sh

memory_pressure_shutdown_standby

for line in "${CAPACITY_LINES[@]}"; do
  printf '%s\n' "$line"
done

# Auto force-kill ghost agents after the configured ghost threshold.
while IFS= read -r _ghost_line; do
  [[ "$_ghost_line" == GHOST:* ]] || continue
  _ghost_name="${_ghost_line#GHOST: }"
  _ghost_name="${_ghost_name%% | *}"
  if [[ -n "$_ghost_name" ]]; then
    _ghost_pane="$(get_worker_pane_id "$_ghost_name" 2>/dev/null || true)"
    if [[ -n "$_ghost_pane" ]] && tmux_cmd display-message -t "$_ghost_pane" -p '' 2>/dev/null; then
      # pane alive but unresponsive — force-kill
      "$HOOK_DIR/mark-force-stop.sh" "$_ghost_name" 2>/dev/null || true
    else
      # pane already dead — skip, ghost-member-cleanup handles config
      printf 'GHOST-PANE-DEAD-SKIP: %s | cleanup deferred to ghost-member-cleanup\n' "$_ghost_name"
    fi
  fi
done <<< "$RESULT"
echo "$RESULT"

# ── Ghost member cleanup ──────────────────────────────────────────────
# Remove config.json entries whose tmux panes no longer exist.
# This prevents terminated workers from appearing as phantom teammates in the UI.
for _gc_config_file in "$HOME/.claude/teams"/*/config.json; do
  [[ -f "$_gc_config_file" ]] || continue
  _gc_ghost_list="$(CONFIG_FILE="$_gc_config_file" node -e "
    try {
      const config = JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE, 'utf8'));
      (config.members || []).forEach(m => {
        if (m.name && m.name !== 'team-lead') {
          process.stdout.write(m.name + '|' + m.tmuxPaneId + '\n');
        }
      });
    } catch(e) {}
  " 2>/dev/null || true)"

  while IFS='|' read -r _gc_name _gc_pane; do
    [[ -n "$_gc_name" ]] || continue
    if [[ -z "$_gc_pane" ]]; then
      remove_worker_everywhere "$_gc_name"
    else
      _gc_alive=false
      for _retry in 1 2 3; do
        if tmux_cmd display-message -t "$_gc_pane" -p '' 2>/dev/null; then
          _gc_alive=true
          break
        fi
        sleep 0.5
      done
      if [[ "$_gc_alive" == "false" ]]; then
        remove_worker_everywhere "$_gc_name"
      fi
    fi
  done <<< "$_gc_ghost_list"
done

if [[ "$RESULT" == CRON_PAUSE* ]]; then
  : > "$HEALTH_CRON_FLAG"
fi

exit 0
