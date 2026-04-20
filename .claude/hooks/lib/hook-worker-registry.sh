#!/usr/bin/env bash

target_is_already_active_worker() {
  local target_name="${1-}"
  local norm=""
  norm="$(normalize_lane_id "$target_name")"
  [[ -n "$norm" ]] || return 1
  [[ -f "$SESSION_AGENT_MAP" ]] || return 1
  awk -v worker="$norm" 'tolower($2) == worker {found=1; exit} END {exit !found}' "$SESSION_AGENT_MAP"
}

worker_is_standby() {
  local worker_name="${1-}"
  local normalized_worker=""

  [[ -n "$worker_name" && -f "$STANDBY_FILE" ]] || return 1
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 1

  awk -v worker="$normalized_worker" '
    {
      entry = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", entry)
      if (tolower(entry) == worker) {
        found = 1
        exit
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$STANDBY_FILE" 2>/dev/null
}
drop_session_claims_from_pending_file() {
  local target_file="${1:?target file required}"
  local session_id="${2:?session id required}"
  local status_field="${3:?status field required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v sid="$session_id" -v status_field="$status_field" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      status = trim($status_field)
      if (status == "CLAIMED:" sid) {
        next
      }
      print
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

drop_session_rows_from_map_file() {
  local target_file="${1:?target file required}"
  local session_id="${2:?session id required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -v sid="$session_id" '$1 != sid { print }' "$target_file" > "$temp_file"
  atomic_replace_file "$temp_file" "$target_file"
}

cleanup_worker_session_records() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  drop_session_rows_from_map_file "$SESSION_AGENT_MAP" "$session_id"
  drop_session_rows_from_map_file "$SESSION_AGENT_MODE_MAP" "$session_id"
  drop_session_claims_from_pending_file "$PENDING_AGENTS_FILE" "$session_id" 3
  drop_session_claims_from_pending_file "$PENDING_AGENT_MODES_FILE" "$session_id" 4
}

current_runtime_activation_iso() {
  local runtime_epoch=""

  [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] || return 0
  runtime_epoch="$(stat -c %Y "$TEAM_RUNTIME_ACTIVE_FILE" 2>/dev/null || true)"
  [[ "$runtime_epoch" =~ ^[0-9]+$ ]] || return 0
  date -u -d "@$runtime_epoch" '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || true
}

pending_dispatch_retention_cutoff_iso() {
  local retention_seconds="${PENDING_DISPATCH_RETENTION_SECONDS:-\
${GOVERNANCE_HEAVY_PENDING_DISPATCH_STALE_SECONDS:-${PENDING_DISPATCH_STALE_SECONDS:-120}}}"

  date -u -d "-${retention_seconds} seconds" '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || true
}

pending_dispatch_stale_cutoff_iso() {
  date -u -d "-${PENDING_DISPATCH_STALE_SECONDS:-120} seconds" '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || true
}

prune_noncurrent_pending_dispatch_residue() {
  with_lock_file "$AGENT_CLAIM_LOCK" _prune_noncurrent_pending_dispatch_residue_locked
}

_prune_noncurrent_pending_dispatch_residue_locked() {
  local runtime_started_iso=""
  local stale_cutoff_iso=""
  local retention_cutoff_iso=""

  runtime_started_iso="$(current_runtime_activation_iso)"
  stale_cutoff_iso="$(pending_dispatch_stale_cutoff_iso)"
  retention_cutoff_iso="$(pending_dispatch_retention_cutoff_iso)"
  _prune_pending_dispatch_file_locked "$PENDING_AGENTS_FILE" 3 "$runtime_started_iso" "$stale_cutoff_iso" "$retention_cutoff_iso"
  _prune_pending_dispatch_file_locked "$PENDING_AGENT_MODES_FILE" 4 "$runtime_started_iso" "$stale_cutoff_iso" "$retention_cutoff_iso"
}

_prune_pending_dispatch_file_locked() {
  local target_file="${1:?target file required}"
  local status_field="${2:?status field required}"
  local runtime_started_iso="${3-}"
  local stale_cutoff_iso="${4-}"
  local retention_cutoff_iso="${5-}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' \
    -v status_field="$status_field" \
    -v runtime_started="$runtime_started_iso" \
    -v stale_cutoff="$stale_cutoff_iso" \
    -v retention_cutoff="$retention_cutoff_iso" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    function invalid_name(raw_name, normalized) {
      normalized = tolower(trim(raw_name))
      return normalized == "" || normalized == "unknown" || normalized == "unknown-agent"
    }
    {
      ts = trim($1)
      name = trim($2)
      status = trim($(status_field))
      if (status == "") {
        next
      }
      if (invalid_name(name)) {
        next
      }
      if (runtime_started != "" && ts != "" && ts < runtime_started) {
        next
      }
      if ((status == "PENDING" || status == "UNCLAIMED_STALE") && retention_cutoff != "" && ts != "" && ts < retention_cutoff) {
        next
      }
      if (status == "PENDING" && stale_cutoff != "" && ts != "" && ts < stale_cutoff) {
        status = "UNCLAIMED_STALE"
      }
      if (status_field == 3) {
        printf "%s | %s | %s\n", ts, name, status
      } else {
        mode = trim($3)
        printf "%s | %s | %s | %s\n", ts, name, mode, status
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

drop_latest_unclaimed_pending_dispatch() {
  local worker_name="${1-}"
  local normalized_worker=""

  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  with_lock_file "$AGENT_CLAIM_LOCK" _drop_latest_unclaimed_pending_dispatch_locked "$normalized_worker"
}

_drop_latest_unclaimed_pending_dispatch_locked() {
  local normalized_worker="${1:?normalized worker required}"

  _drop_latest_unclaimed_pending_dispatch_from_file_locked "$PENDING_AGENTS_FILE" 3 "$normalized_worker"
  _drop_latest_unclaimed_pending_dispatch_from_file_locked "$PENDING_AGENT_MODES_FILE" 4 "$normalized_worker"
}

_drop_latest_unclaimed_pending_dispatch_from_file_locked() {
  local target_file="${1:?target file required}"
  local status_field="${2:?status field required}"
  local normalized_worker="${3:?normalized worker required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v status_field="$status_field" -v worker="$normalized_worker" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      raw[NR] = $0
      name[NR] = tolower(trim($2))
      status[NR] = trim($(status_field))
      if (name[NR] == worker && status[NR] == "PENDING") {
        chosen = NR
      }
    }
    END {
      for (i = 1; i <= NR; i++) {
        if (i != chosen) {
          print raw[i]
        }
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

summarize_current_runtime_worker_residue() {
  local live_workers=""
  local pending_workers=""
  local claimed_workers=""
  local residue=()

  prune_noncurrent_pending_dispatch_residue

  if [[ -f "$SESSION_AGENT_MAP" ]]; then
    local _all_map_workers=""
    _all_map_workers="$(awk '
      {
        worker = $2
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", worker)
        if (worker != "") {
          print worker
        }
      }
    ' "$SESSION_AGENT_MAP" 2>/dev/null | sort -u)"

    live_workers="$(printf '%s\n' "$_all_map_workers" | paste -sd, -)"
  fi

  if [[ -f "$PENDING_AGENTS_FILE" ]]; then
    pending_workers="$(awk -F' \\| ' '
      function trim(value) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
        return value
      }
      {
        name = trim($2)
        status = trim($3)
        if (name != "" && status == "PENDING") {
          print name
        }
      }
    ' "$PENDING_AGENTS_FILE" 2>/dev/null | sort -u | paste -sd, -)"

    claimed_workers="$(awk -F' \\| ' '
      function trim(value) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
        return value
      }
      {
        name = trim($2)
        status = trim($3)
        if (name == "" || status !~ /^CLAIMED:/) {
          next
        }
        session_id = status
        sub(/^CLAIMED:/, "", session_id)
        printf "%s@%s\n", name, session_id
      }
    ' "$PENDING_AGENTS_FILE" 2>/dev/null | sort -u | paste -sd, -)"
  fi

  if [[ -n "$live_workers" ]]; then
    residue+=("live_workers=${live_workers}")
  fi
  if [[ -n "$pending_workers" ]]; then
    residue+=("pending_dispatches=${pending_workers}")
  fi
  if [[ -n "$claimed_workers" ]]; then
    residue+=("claimed_dispatches=${claimed_workers}")
  fi
  if [[ ${#residue[@]} -eq 0 ]]; then
    return 0
  fi

  printf '%s' "${residue[0]}"
  local idx=""
  for idx in "${!residue[@]}"; do
    if [[ "$idx" == "0" ]]; then
      continue
    fi
    printf '; %s' "${residue[$idx]}"
  done
}

current_runtime_workers_drained() {
  local residue=""
  residue="$(summarize_current_runtime_worker_residue)"
  [[ -z "$residue" ]]
}

current_runtime_worker_names() {
  prune_noncurrent_pending_dispatch_residue

  {
    if [[ -f "$SESSION_AGENT_MAP" ]]; then
      awk '
        {
          worker = $2
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", worker)
          if (worker != "") {
            print worker
          }
        }
      ' "$SESSION_AGENT_MAP" 2>/dev/null
    fi

    if [[ -f "$PENDING_AGENTS_FILE" ]]; then
      awk -F' \\| ' '
        function trim(value) {
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
          return value
        }
        {
          name = trim($2)
          status = trim($3)
          if (name != "" && status == "PENDING") {
            print name
          }
        }
      ' "$PENDING_AGENTS_FILE" 2>/dev/null
    fi
  } | awk '
    {
      key = tolower($0)
      if (key == "" || seen[key]) {
        next
      }
      seen[key] = 1
      print $0
    }
  '
}

current_runtime_worker_count() {
  current_runtime_worker_names | awk 'NF { count++ } END { print count + 0 }'
}

unclaimed_pending_agent_dispatch_count() {
  [[ -f "$PENDING_AGENTS_FILE" ]] || { printf '0'; return 0; }

  awk -F' \\| ' '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      name = trim($2)
      status = trim($3)
      if (name != "" && status == "PENDING") {
        count++
      }
    }
    END {
      print count + 0
    }
  ' "$PENDING_AGENTS_FILE" 2>/dev/null
}

has_unclaimed_pending_agent_dispatch() {
  local pending_count="0"

  prune_noncurrent_pending_dispatch_residue
  pending_count="$(unclaimed_pending_agent_dispatch_count)"
  [[ "$pending_count" =~ ^[0-9]+$ ]] || return 1
  (( pending_count > 0 ))
}

session_id_is_known_worker() {
  local session_id="${1-}"

  [[ -n "$session_id" ]] || return 1

  if [[ -f "$SESSION_AGENT_MAP" ]] \
    && awk -v sid="$session_id" '$1 == sid {found=1; exit} END {exit found ? 0 : 1}' \
      "$SESSION_AGENT_MAP" 2>/dev/null; then
    return 0
  fi

  if [[ -f "$SESSION_AGENT_MODE_MAP" ]] \
    && awk -v sid="$session_id" '$1 == sid {found=1; exit} END {exit found ? 0 : 1}' \
      "$SESSION_AGENT_MODE_MAP" 2>/dev/null; then
    return 0
  fi

  if [[ -f "$PENDING_AGENTS_FILE" ]] && awk -F' \\| ' -v sid="$session_id" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      status = trim($3)
      if (status == "CLAIMED:" sid) {
        found = 1
        exit
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$PENDING_AGENTS_FILE" 2>/dev/null; then
    return 0
  fi

  if [[ -f "$PENDING_AGENT_MODES_FILE" ]] && awk -F' \\| ' -v sid="$session_id" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      status = trim($4)
      if (status == "CLAIMED:" sid) {
        found = 1
        exit
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$PENDING_AGENT_MODES_FILE" 2>/dev/null; then
    return 0
  fi

  return 1
}

canonicalize_worker_sender_name() {
  local raw_name="${1-}"
  local normalized_name=""
  local canonical_name=""

  normalized_name="$(canonicalize_runtime_lane_id "$raw_name")"
  [[ -n "$normalized_name" ]] || return 1

  case "$normalized_name" in
    unknown|unknown-agent|supervisor|runtime-monitor)
      return 1
      ;;
  esac

  if canonical_name="$(canonical_registered_agent_name "$normalized_name" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return 0
  fi

  if canonical_name="$(canonical_registered_role_name "$normalized_name" 2>/dev/null)"; then
    printf '%s' "$canonical_name"
    return 0
  fi

  printf '%s' "$normalized_name"
}

resolve_runtime_sender_name() {
  local session_id="${1-}"
  local agent_id="${2-}"
  local agent_name="${3-}"
  local agent_type="${4-}"
  local teammate_name="${5-}"
  local candidate=""
  local resolved=""

  if [[ -n "$session_id" ]]; then
    resolved="$(worker_name_for_session_id "$session_id")"
    if [[ -n "$resolved" ]]; then
      printf '%s' "$resolved"
      return 0
    fi
  fi

  for candidate in "$agent_name" "$agent_id" "$agent_type" "$teammate_name"; do
    resolved="$(canonicalize_worker_sender_name "$candidate" 2>/dev/null || true)"
    if [[ -n "$resolved" ]]; then
      printf '%s' "$resolved"
      return 0
    fi
  done

  return 1
}

runtime_sender_session_is_worker() {
  local session_id="${1-}"

  [[ -n "$session_id" ]] || return 1
  session_id_is_known_worker "$session_id" || return 1
  session_is_runtime_owner "$session_id" && return 1
  return 0
}
# ── Worker config helpers (shared by health-check, agent-activity-monitor) ─
remove_member_from_config() {
  local worker_name="$1"
  [[ -n "$worker_name" ]] || return 1
  local config_file
  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    with_lock_file "$(team_config_hook_lock_file "$config_file")" _remove_member_from_config_impl "$config_file" "$worker_name"
  done
}

_remove_member_from_config_impl() {
  local config_file="$1" worker_name="$2" tmp_file updated
  tmp_file="${config_file}.tmp.$$"
  updated="$(CONFIG_FILE="$config_file" WORKER_NAME="$worker_name" node -e "
    const fs = require('fs');
    try {
      const config = JSON.parse(fs.readFileSync(process.env.CONFIG_FILE, 'utf8'));
      if (config.members) {
        const before = config.members.length;
        config.members = config.members.filter(m => m.name !== process.env.WORKER_NAME);
        if (config.members.length < before) {
          process.stdout.write(JSON.stringify(config, null, 2));
        }
      }
    } catch(e) {}
  " 2>/dev/null || true)"
  if [[ -n "$updated" ]]; then
    printf '%s\n' "$updated" > "$tmp_file" && mv -f "$tmp_file" "$config_file"
  else
    rm -f "$tmp_file" 2>/dev/null || true
  fi
}

worker_name_for_session_id() {
  local session_id="${1-}"
  local resolved_name=""
  [[ -n "$session_id" ]] || return 0

  if [[ -f "$SESSION_AGENT_MAP" ]]; then
    resolved_name="$(awk -v sid="$session_id" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
    if [[ -n "$resolved_name" ]]; then
      printf '%s' "$resolved_name"
      return 0
    fi
  fi

  claimed_worker_name_for_session_id "$session_id"
}

claimed_worker_name_for_session_id() {
  local session_id="${1-}"
  local resolved_name=""

  [[ -n "$session_id" ]] || return 0

  if [[ -f "$PENDING_AGENTS_FILE" ]]; then
    resolved_name="$(awk -F' \\| ' -v sid="$session_id" '
      function trim(value) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
        return value
      }
      {
        name = trim($2)
        status = trim($3)
        if (name != "" && status == "CLAIMED:" sid) {
          print name
          exit
        }
      }
    ' "$PENDING_AGENTS_FILE" 2>/dev/null || true)"
    if [[ -n "$resolved_name" ]]; then
      printf '%s' "$resolved_name"
      return 0
    fi
  fi

  if [[ -f "$PENDING_AGENT_MODES_FILE" ]]; then
    awk -F' \\| ' -v sid="$session_id" '
      function trim(value) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
        return value
      }
      {
        name = trim($2)
        status = trim($4)
        if (name != "" && status == "CLAIMED:" sid) {
          print name
          exit
        }
      }
    ' "$PENDING_AGENT_MODES_FILE" 2>/dev/null || true
  fi
}

session_ids_for_worker_name() {
  local worker_name="${1-}"
  local normalized_worker=""

  [[ -n "$worker_name" && -f "$SESSION_AGENT_MAP" ]] || return 0
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  awk -v worker="$normalized_worker" '
    {
      name = $2
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
      if (tolower(name) == worker) {
        print $1
      }
    }
  ' "$SESSION_AGENT_MAP" 2>/dev/null || true
}

_mark_worker_standby_locked() {
  local worker_name="${1-}"
  mkdir -p "$(dirname "$STANDBY_FILE")"
  touch "$STANDBY_FILE"
  if ! grep -qxF "$worker_name" "$STANDBY_FILE" 2>/dev/null; then
    printf '%s\n' "$worker_name" >> "$STANDBY_FILE"
  fi
}

mark_worker_standby() {
  local worker_name="${1-}"
  [[ -n "$worker_name" ]] || return 0

  with_lock_file "${STANDBY_FILE}.lock" _mark_worker_standby_locked "$worker_name"
}

clear_worker_standby() {
  local worker_name="${1-}"
  local normalized_worker=""
  local temp_file=""

  [[ -n "$worker_name" && -f "$STANDBY_FILE" ]] || return 0
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  temp_file="$(make_atomic_temp_file "$STANDBY_FILE")"
  awk -v worker="$normalized_worker" '
    {
      entry = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", entry)
      if (tolower(entry) != worker) {
        print $0
      }
    }
  ' "$STANDBY_FILE" > "$temp_file"
  atomic_replace_file "$temp_file" "$STANDBY_FILE"
}

_update_idle_pending_locked() {
  local action="${1:?action required}"
  local worker_name="${2-}"
  local idle_reason="${3-}"
  local completed_task="${4-}"
  local completed_status="${5-}"
  local normalized_worker=""
  local temp_file=""
  local timestamp=""

  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  mkdir -p "$(dirname "$IDLE_DECISION_PENDING_FILE")"
  touch "$IDLE_DECISION_PENDING_FILE"
  temp_file="$(make_atomic_temp_file "$IDLE_DECISION_PENDING_FILE")"
  timestamp="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

  awk -F' \\| ' \
    -v action="$action" \
    -v worker="$normalized_worker" \
    -v raw_worker="$worker_name" \
    -v ts="$timestamp" \
    -v idle_reason="$idle_reason" \
    -v completed_task="$completed_task" \
    -v completed_status="$completed_status" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      name = trim($2)
      if (tolower(name) == worker) {
        next
      }
      print
    }
    END {
      if (action == "mark") {
        printf "%s | %s | %s | %s | %s\n", ts, raw_worker, idle_reason, completed_task, completed_status
      }
    }
  ' "$IDLE_DECISION_PENDING_FILE" > "$temp_file"

  atomic_replace_file "$temp_file" "$IDLE_DECISION_PENDING_FILE"
}

mark_worker_idle_pending() {
  local worker_name="${1-}"
  local idle_reason="${2-unknown}"
  local completed_task="${3-none}"
  local completed_status="${4-none}"

  [[ -n "$worker_name" ]] || return 0
  with_lock_file \
    "$IDLE_DECISION_PENDING_LOCK" \
    _update_idle_pending_locked \
    "mark" \
    "$worker_name" \
    "$idle_reason" \
    "$completed_task" \
    "$completed_status"
}

clear_worker_idle_pending() {
  local worker_name="${1-}"
  [[ -n "$worker_name" ]] || return 0
  with_lock_file "$IDLE_DECISION_PENDING_LOCK" _update_idle_pending_locked "clear" "$worker_name"
}

worker_is_idle_pending() {
  local worker_name="${1-}"
  local normalized_worker=""

  [[ -n "$worker_name" && -f "$IDLE_DECISION_PENDING_FILE" ]] || return 1
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 1

  awk -F' \\| ' -v worker="$normalized_worker" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      name = trim($2)
      if (tolower(name) == worker) {
        found = 1
        exit
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$IDLE_DECISION_PENDING_FILE" 2>/dev/null
}

idle_pending_worker_count() {
  [[ -f "$IDLE_DECISION_PENDING_FILE" ]] || { printf '0'; return 0; }

  awk -F' \\| ' '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      worker = tolower(trim($2))
      if (worker != "" && !seen[worker]) {
        seen[worker] = 1
        count++
      }
    }
    END {
      print count + 0
    }
  ' "$IDLE_DECISION_PENDING_FILE" 2>/dev/null
}

idle_pending_worker_summary() {
  [[ -f "$IDLE_DECISION_PENDING_FILE" ]] || return 0

  awk -F' \\| ' '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      worker = trim($2)
      if (worker == "" || seen[tolower(worker)]) {
        next
      }
      seen[tolower(worker)] = 1
      names[++count] = worker
    }
    END {
      for (idx = 1; idx <= count; idx++) {
        if (idx > 1) {
          printf ","
        }
        printf "%s", names[idx]
      }
    }
  ' "$IDLE_DECISION_PENDING_FILE" 2>/dev/null
}

# Count idle-pending workers scoped to the given work-surface.
# Workers whose stored surface file matches target_surface are counted.
# Workers with no surface file (unknown surface) are always counted — safe fallback.
# Workers on a different known surface are excluded.
# When target_surface is empty, falls back to global count (all workers counted).
idle_pending_worker_count_for_surface() {
  local target_surface="${1-}"
  local norm_surface=""

  [[ -f "$IDLE_DECISION_PENDING_FILE" ]] || { printf '0'; return 0; }

  norm_surface="$(printf '%s' "$target_surface" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"

  awk -F' \\| ' -v norm_surf="$norm_surface" -v log_dir="$LOG_DIR" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    function worker_surface(wkey,    surf_file, surf) {
      gsub(/[^a-z0-9_-]/, "-", wkey)
      surf_file = log_dir "/.worker-surface-" wkey
      surf = ""
      if ((getline surf < surf_file) > 0) {
        close(surf_file)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", surf)
        return tolower(surf)
      }
      close(surf_file)
      return ""
    }
    {
      worker = tolower(trim($2))
      if (worker == "" || seen[worker]) {
        next
      }
      seen[worker] = 1
      if (norm_surf == "") {
        count++
        next
      }
      wsurface = worker_surface(worker)
      if (wsurface == "" || wsurface == norm_surf) {
        count++
      }
    }
    END {
      print count + 0
    }
  ' "$IDLE_DECISION_PENDING_FILE" 2>/dev/null
}

# Return comma-separated names of idle-pending workers scoped to the given work-surface.
# Applies the same surface-matching logic as idle_pending_worker_count_for_surface.
idle_pending_worker_summary_for_surface() {
  local target_surface="${1-}"
  local norm_surface=""

  [[ -f "$IDLE_DECISION_PENDING_FILE" ]] || return 0

  norm_surface="$(printf '%s' "$target_surface" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"

  awk -F' \\| ' -v norm_surf="$norm_surface" -v log_dir="$LOG_DIR" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    function worker_surface(wkey,    surf_file, surf) {
      gsub(/[^a-z0-9_-]/, "-", wkey)
      surf_file = log_dir "/.worker-surface-" wkey
      surf = ""
      if ((getline surf < surf_file) > 0) {
        close(surf_file)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", surf)
        return tolower(surf)
      }
      close(surf_file)
      return ""
    }
    {
      worker = trim($2)
      if (worker == "" || seen[tolower(worker)]) {
        next
      }
      if (norm_surf != "") {
        wsurface = worker_surface(tolower(worker))
        if (wsurface != "" && wsurface != norm_surf) {
          next
        }
      }
      seen[tolower(worker)] = 1
      names[++count] = worker
    }
    END {
      for (idx = 1; idx <= count; idx++) {
        if (idx > 1) {
          printf ","
        }
        printf "%s", names[idx]
      }
    }
  ' "$IDLE_DECISION_PENDING_FILE" 2>/dev/null
}

record_pending_agent_dispatch() {
  local timestamp="${1:?timestamp required}"
  local agent_name="${2:?agent name required}"
  local mode_value="${3:-default}"
  local lane_hint="${4:-}"
  local canonical_agent_name=""
  local dispatch_agent_lane=""

  dispatch_agent_lane="${lane_hint:-$(resolve_agent_id "$agent_name")}"
  [[ -n "$dispatch_agent_lane" \
    && "$dispatch_agent_lane" != "unknown" \
    && "$dispatch_agent_lane" != "team-lead" ]] || return 0
  agent_registry_has_name "$dispatch_agent_lane" || return 0
  # Keep runtime instance labels distinct. Only exact aliases collapse to a
  # canonical agent name.
  if canonical_agent_name="$(canonical_dispatch_agent_name "$agent_name" 2>/dev/null)"; then
    agent_name="$canonical_agent_name"
  fi
  agent_name="$(sanitize_ledger_field "$agent_name")"

  with_lock_file \
    "$AGENT_CLAIM_LOCK" \
    _record_pending_agent_dispatch_locked \
    "$timestamp" \
    "$agent_name" \
    "$mode_value"
}

_record_pending_agent_dispatch_locked() {
  local timestamp="${1:?timestamp required}"
  local agent_name="${2:?agent name required}"
  local mode_value="${3:-default}"

  printf '%s | %s | PENDING\n' "$timestamp" "$agent_name" >> "$PENDING_AGENTS_FILE"
  printf '%s | %s | %s | PENDING\n' "$timestamp" "$agent_name" "$mode_value" >> "$PENDING_AGENT_MODES_FILE"
}

drop_worker_rows_from_map_file() {
  local target_file="${1:?target file required}"
  local worker_name="${2-}"
  local normalized_worker=""
  local temp_file=""

  [[ -n "$worker_name" && -f "$target_file" ]] || return 0
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  temp_file="$(make_atomic_temp_file "$target_file")"
  awk -v worker="$normalized_worker" '
    {
      name = $2
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
      if (tolower(name) != worker) {
        print
      }
    }
  ' "$target_file" > "$temp_file"
  atomic_replace_file "$temp_file" "$target_file"
}

drop_worker_rows_from_pending_file() {
  local target_file="${1:?target file required}"
  local worker_name="${2-}"
  local normalized_worker=""
  local temp_file=""

  [[ -n "$worker_name" && -f "$target_file" ]] || return 0
  normalized_worker="$(normalize_lane_id "$worker_name")"
  [[ -n "$normalized_worker" ]] || return 0

  temp_file="$(make_atomic_temp_file "$target_file")"
  awk -F' \\| ' -v worker="$normalized_worker" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      name = trim($2)
      if (tolower(name) != worker) {
        print
      }
    }
  ' "$target_file" > "$temp_file"
  atomic_replace_file "$temp_file" "$target_file"
}

remove_worker_inboxes() {
  local worker_name="${1-}"
  local team_dir=""
  local inbox_path=""

  [[ -n "$worker_name" ]] || return 0
  for team_dir in "$HOME/.claude/teams"/*/; do
    [[ -d "$team_dir" ]] || continue
    inbox_path="${team_dir}inboxes/${worker_name}.json"
    if [[ -f "$inbox_path" ]]; then
      rm -f "$inbox_path"
    fi
  done
}

remove_worker_everywhere() {
  local worker_name="${1-}"
  local session_id=""
  local worker_session_ids=()
  [[ -n "$worker_name" ]] || return 0

  mapfile -t worker_session_ids < <(session_ids_for_worker_name "$worker_name")

  clear_worker_standby "$worker_name"
  clear_worker_idle_pending "$worker_name"
  local _wsurface_key=""
  _wsurface_key="$(printf '%s' "$worker_name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]/-/g')"
  rm -f "$LOG_DIR/.worker-surface-${_wsurface_key}" 2>/dev/null || true
  rm -f "$LOG_DIR/.worker-shard-boundary-${_wsurface_key}" 2>/dev/null || true
  drop_worker_rows_from_map_file "$SESSION_AGENT_MAP" "$worker_name"
  for session_id in "${worker_session_ids[@]}"; do
    [[ -n "$session_id" ]] || continue
    drop_session_rows_from_map_file "$SESSION_AGENT_MODE_MAP" "$session_id"
  done
  drop_worker_rows_from_pending_file "$PENDING_AGENTS_FILE" "$worker_name"
  drop_worker_rows_from_pending_file "$PENDING_AGENT_MODES_FILE" "$worker_name"
  if declare -F clear_worker_planning_required >/dev/null 2>&1; then
    clear_worker_planning_required "$worker_name"
  fi
  remove_member_from_config "$worker_name"
  remove_worker_inboxes "$worker_name"
}

get_worker_pane_id() {
  local worker_name="$1"
  local config_file pane_id
  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    pane_id="$(CONFIG_FILE="$config_file" WORKER_NAME="$worker_name" node -e "
      const c = JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE, 'utf8'));
      const m = c.members && c.members.find(m => m.name === process.env.WORKER_NAME);
      if (m && m.tmuxPaneId) process.stdout.write(m.tmuxPaneId);
    " 2>/dev/null || true)"
    if [[ -n "$pane_id" ]]; then
      printf '%s' "$pane_id"
      return 0
    fi
  done
  return 1
}

team_config_pane_ids() {
  local config_file="${1-}"
  [[ -f "$config_file" ]] || return 0

  CONFIG_FILE="$config_file" node <<'NODE' 2>/dev/null || true
const fs = require("fs");
try {
  const config = JSON.parse(fs.readFileSync(process.env.CONFIG_FILE || "", "utf8"));
  const members = Array.isArray(config.members) ? config.members : [];
  for (const member of members) {
    const paneId = String((member && member.tmuxPaneId) || "").trim();
    if (paneId) console.log(paneId);
  }
} catch {}
NODE
}

team_config_lead_session_id() {
  local config_file="${1-}"
  [[ -f "$config_file" ]] || return 0

  CONFIG_FILE="$config_file" node <<'NODE' 2>/dev/null || true
const fs = require("fs");
try {
  const config = JSON.parse(fs.readFileSync(process.env.CONFIG_FILE || "", "utf8"));
  const leadSessionId = String(config.leadSessionId || "").trim();
  if (leadSessionId) process.stdout.write(leadSessionId);
} catch {}
NODE
}

team_config_has_live_pane() {
  local config_file="${1:?config file required}"
  local pane_id=""

  [[ -f "$config_file" ]] || return 1
  while IFS= read -r pane_id; do
    [[ -n "$pane_id" ]] || continue
    if tmux_cmd display-message -t "$pane_id" -p '' >/dev/null 2>&1; then
      return 0
    fi
  done < <(team_config_pane_ids "$config_file")

  return 1
}

current_session_live_team_config() {
  local session_id="${1-}"
  local config_file=""
  local lead_session_id=""

  [[ -n "$session_id" ]] || return 1

  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    if ! team_config_has_live_pane "$config_file"; then
      continue
    fi
    lead_session_id="$(team_config_lead_session_id "$config_file")"
    if [[ -n "$lead_session_id" && "$lead_session_id" == "$session_id" ]]; then
      printf '%s' "$config_file"
      return 0
    fi
  done

  return 1
}

active_team_config_live() {
  local config_file=""
  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    if team_config_has_live_pane "$config_file"; then
      printf '%s' "$config_file"
      return 0
    fi
  done
  return 1
}

# Memory pressure never bypasses message-first lifecycle. This helper may log
# pressure on preserved standby workers, but supervisor-led shutdown_request or
# explicit reuse still owns the lifecycle decision.
_memory_pressure_shutdown_standby_locked() {
  local _mem_pct="${1:-0}"
  local _standby_count=0

  # Only act if standby workers exist
  [[ -f "$STANDBY_FILE" && -s "$STANDBY_FILE" ]] || return 0

  _standby_count="$(grep -cve '^[[:space:]]*$' "$STANDBY_FILE" 2>/dev/null || echo 0)"
  (( _standby_count > 0 )) || return 0

  printf '[%s] MEM-PRESSURE STANDBY HOLD: %d standby worker(s) preserved at mem=%d%%. '\
'Runtime pressure does not bypass message-first shutdown; supervisor must coordinate shutdown_request or explicit reuse.\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" "$_standby_count" "$_mem_pct" >> "$VIOLATION_LOG"
}

memory_pressure_shutdown_standby() {
  local _meminfo="${RUNTIME_MEMINFO_SOURCE:-/proc/meminfo}"
  local _mem_total _mem_avail _mem_used _mem_pct

  _mem_total="$(awk '$1=="MemTotal:"{print $2;exit}' "$_meminfo" 2>/dev/null || echo 0)"
  _mem_avail="$(awk '$1=="MemAvailable:"{print $2;exit}' "$_meminfo" 2>/dev/null || echo 0)"
  _mem_total="${_mem_total:-0}"
  _mem_avail="${_mem_avail:-0}"

  [[ "$_mem_total" -gt 0 ]] || return 0

  _mem_used=$(( _mem_total - _mem_avail ))
  if (( _mem_used < 0 )); then _mem_used=0; fi
  _mem_pct=$(( _mem_used * 100 / _mem_total ))

  # Only act at >80% memory usage
  (( _mem_pct > 80 )) || return 0

  with_lock_file "${STANDBY_FILE}.lock" _memory_pressure_shutdown_standby_locked "$_mem_pct"
}
