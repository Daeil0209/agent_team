#!/usr/bin/env bash
# Runtime session identity — foundation layer — split from hook-runtime-state.sh
# Sourced via hook-config.sh, do not execute directly.

current_runtime_session_id() {
  if [[ -s "$SUPERVISOR_SESSION_FILE" ]]; then
    tr -d '\n' < "$SUPERVISOR_SESSION_FILE" 2>/dev/null || true
  fi
}

current_boot_session_id() {
  if [[ -s "$SESSION_BOOT_MARKER_FILE" ]]; then
    tr -d '\n' < "$SESSION_BOOT_MARKER_FILE" 2>/dev/null || true
  fi
}

recover_session_id() {
  local session_id="${1-}"

  if [[ -n "$session_id" && "$session_id" != "unknown" ]]; then
    printf '%s' "$session_id"
    return 0
  fi

  session_id="$(current_runtime_session_id)"
  if [[ -n "$session_id" ]]; then
    printf '%s' "$session_id"
    return 0
  fi

  session_id="$(current_boot_session_id)"
  if [[ -n "$session_id" ]]; then
    printf '%s' "$session_id"
  fi
}

resolve_closeout_session_id() {
  local session_id="${1-}"

  recover_session_id "$session_id"
}

runtime_owner_session_id() {
  current_runtime_session_id
}

session_is_runtime_owner() {
  local session_id="${1-}"
  local owner_session_id=""

  [[ -n "$session_id" ]] || return 1
  owner_session_id="$(runtime_owner_session_id)"
  [[ -n "$owner_session_id" && "$session_id" == "$owner_session_id" ]]
}

command_is_health_check_monitor() {
  local raw_command="${1-}"
  local normalized=""

  [[ -n "$raw_command" ]] || return 1
  normalized="$(printf '%s' "$raw_command" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//')"
  [[ "$normalized" == *"health-check.sh"* ]]
}

session_end_owns_runtime_state() {
  local session_id="${1-}"
  local supervisor_session_id=""

  supervisor_session_id="$(current_runtime_session_id)"

  if [[ -z "$session_id" ]]; then
    return 0
  fi

  if session_id_is_known_worker "$session_id"; then
    return 1
  fi

  if [[ -n "$supervisor_session_id" ]]; then
    [[ "$session_id" == "$supervisor_session_id" ]]
    return
  fi

  if [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" || -s "$HEALTH_CRON_JOB_FILE" ]]; then
    return 1
  fi

  return 0
}

current_health_cron_job_id() {
  if [[ -s "$HEALTH_CRON_JOB_FILE" ]]; then
    tr -d '\n' < "$HEALTH_CRON_JOB_FILE" 2>/dev/null || true
  fi
}

record_runtime_session_id() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0
  mkdir -p "$(dirname "$SUPERVISOR_SESSION_FILE")"
  printf '%s' "$session_id" > "$SUPERVISOR_SESSION_FILE"
}

clear_runtime_session_id() {
  mkdir -p "$(dirname "$SUPERVISOR_SESSION_FILE")"
  : > "$SUPERVISOR_SESSION_FILE"
}
