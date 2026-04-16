#!/usr/bin/env bash

normalize_planning_worker_name() {
  local worker_name="${1-}"
  normalize_lane_id "$worker_name"
}

reset_planning_markers_for_session() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  rm -f \
    "$LOG_DIR/.wp-loaded-${session_id}" \
    "$LOG_DIR/.sv-plan-loaded-${session_id}" \
    "$LOG_DIR/.sv-result-loaded-${session_id}"
}

reset_planning_markers_for_worker() {
  local worker_name="${1-}"
  local session_id=""
  local worker_session_ids=()

  [[ -n "$worker_name" ]] || return 0

  mapfile -t worker_session_ids < <(session_ids_for_worker_name "$worker_name")
  for session_id in "${worker_session_ids[@]}"; do
    [[ -n "$session_id" ]] || continue
    reset_planning_markers_for_session "$session_id"
  done
}

_mark_identity_in_file_locked() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  grep -qxF "$identity" "$target_file" 2>/dev/null && return 0
  printf '%s\n' "$identity" >> "$target_file"
}

_clear_identity_in_file_locked() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -v needle="$identity" '
    {
      line = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
      if (line != needle) {
        print $0
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

identity_present_in_file() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"

  [[ -f "$target_file" ]] || return 1
  grep -qxF "$identity" "$target_file" 2>/dev/null
}

mark_lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  reset_planning_markers_for_session "$session_id"
  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _mark_identity_in_file_locked "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

clear_lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _clear_identity_in_file_locked "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 1

  identity_present_in_file "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

mark_worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0

  reset_planning_markers_for_worker "$worker_name"
  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _mark_identity_in_file_locked "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}

clear_worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _clear_identity_in_file_locked "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}

worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 1

  identity_present_in_file "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}
