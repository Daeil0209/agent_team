#!/usr/bin/env bash

self_growth_clear_state_locked() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  _clear_identity_in_file_locked "$SELF_GROWTH_PENDING_FILE" "$session_id"
  _clear_identity_in_file_locked "$SELF_GROWTH_SUSPECTED_FILE" "$session_id"
}

self_growth_clear_state() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  with_lock_file "$SELF_GROWTH_DISCIPLINE_LOCK" self_growth_clear_state_locked "$session_id"
}
