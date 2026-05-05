#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

AUTO_MODE="false"
CURRENT_SESSION_ID=""
REASON="manual-runtime-cleanup"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --auto)
      AUTO_MODE="true"
      shift
      ;;
    --session-id)
      CURRENT_SESSION_ID="${2-}"
      shift 2
      ;;
    --reason)
      REASON="${2-}"
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

within_reap_cooldown_locked() {
  local now_epoch="" last_epoch="" delta=""

  runtime_truthy "$AUTO_MODE" || return 1
  [[ -f "$RUNTIME_REAP_COOLDOWN_FILE" ]] || return 1

  last_epoch="$(tr -d '\n' < "$RUNTIME_REAP_COOLDOWN_FILE" 2>/dev/null || true)"
  [[ "$last_epoch" =~ ^[0-9]+$ ]] || return 1

  now_epoch="$(date -u +%s)"
  delta=$((now_epoch - last_epoch))
  (( delta < RUNTIME_REAP_COOLDOWN_SECONDS ))
}

record_reap_cooldown_locked() {
  runtime_truthy "$AUTO_MODE" || return 0
  mkdir -p "$(dirname "$RUNTIME_REAP_COOLDOWN_FILE")"
  date -u +%s > "$RUNTIME_REAP_COOLDOWN_FILE"
}

cleanup_orphan_runtime_locked() {
  local scan_output=""
  local status="" mem_available_kb="" swap_free_kb=""
  local orphan_process_count="" orphan_session_count="" orphan_rss_kb=""
  local orphan_session_ids="" stale_socket_count="" orphan_pid_list=""
  local stale_socket_list="" auto_reap_eligible="" summary=""
  local -a orphan_pids=()
  local -a stale_sockets=()
  local pid="" path=""
  local reported_process_count=0
  local reported_socket_count=0
  local now_iso=""

  if ! runtime_automation_single_primary; then
    printf 'SKIP: runtime automation mode is not single-primary\n'
    return 0
  fi

  if [[ -z "$CURRENT_SESSION_ID" ]]; then
    printf 'SKIP: current runtime session id is unavailable\n'
    return 0
  fi

  if within_reap_cooldown_locked; then
    printf 'COOLDOWN: runtime auto-reap cooldown is still active\n'
    return 0
  fi

  mapfile -t SCAN_FIELDS < <("$HOOK_DIR/runtime-pressure-scan.sh" --session-id "$CURRENT_SESSION_ID")
  status="${SCAN_FIELDS[0]:-ok}"
  mem_available_kb="${SCAN_FIELDS[2]:-0}"
  swap_free_kb="${SCAN_FIELDS[3]:-0}"
  orphan_process_count="${SCAN_FIELDS[4]:-0}"
  orphan_session_count="${SCAN_FIELDS[5]:-0}"
  orphan_rss_kb="${SCAN_FIELDS[6]:-0}"
  orphan_session_ids="${SCAN_FIELDS[7]:-}"
  stale_socket_count="${SCAN_FIELDS[8]:-0}"
  orphan_pid_list="${SCAN_FIELDS[9]:-}"
  stale_socket_list="${SCAN_FIELDS[10]:-}"
  auto_reap_eligible="${SCAN_FIELDS[11]:-false}"
  summary="${SCAN_FIELDS[12]:-}"

  if (( orphan_process_count == 0 )) && (( stale_socket_count == 0 )); then
    printf 'NOOP: no orphan runtime residue detected\n'
    return 0
  fi

  if [[ -n "$orphan_pid_list" ]]; then
    IFS='|' read -r -a orphan_pids <<<"$orphan_pid_list"
  fi
  if [[ -n "$stale_socket_list" ]]; then
    IFS='|' read -r -a stale_sockets <<<"$stale_socket_list"
  fi

  reported_process_count="${#orphan_pids[@]}"
  reported_socket_count="${#stale_sockets[@]}"
  record_reap_cooldown_locked

  now_iso="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf '%s | session=%s | reason=%s | reported_processes=%d | reported_sockets=%d | before=%s\n' \
    "$now_iso" \
    "$CURRENT_SESSION_ID" \
    "$REASON" \
    "$reported_process_count" \
    "$reported_socket_count" \
    "$summary" >> "$RUNTIME_REAP_LOG"

  printf 'OBSERVED: orphan_sessions=%s | orphan_processes=%s | stale_sockets=%s | mem_kb=%s | swap_kb=%s | auto=%s\n' \
    "$orphan_session_count" \
    "$orphan_process_count" \
    "$stale_socket_count" \
    "$mem_available_kb" \
    "$swap_free_kb" \
    "$AUTO_MODE"
}

with_lock_file "$RUNTIME_REAP_LOCK" cleanup_orphan_runtime_locked
