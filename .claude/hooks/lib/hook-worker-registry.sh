#!/usr/bin/env bash

target_is_already_active_worker() {
  local target_name="${1-}"
  local norm=""
  norm="$(normalize_lane_id "$target_name")"
  [[ -n "$norm" ]] || return 1
  [[ -f "$SESSION_AGENT_MAP" ]] || return 1
  awk -v worker="$norm" 'tolower($2) == worker {found=1; exit} END {exit !found}' "$SESSION_AGENT_MAP"
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

pending_dispatch_stale_cutoff_iso() {
  date -u -d "-${PENDING_DISPATCH_STALE_SECONDS} seconds" '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || true
}

prune_noncurrent_pending_dispatch_residue() {
  with_lock_file "$AGENT_CLAIM_LOCK" _prune_noncurrent_pending_dispatch_residue_locked
}

_prune_noncurrent_pending_dispatch_residue_locked() {
  local runtime_started_iso=""
  local stale_cutoff_iso=""

  runtime_started_iso="$(current_runtime_activation_iso)"
  stale_cutoff_iso="$(pending_dispatch_stale_cutoff_iso)"
  _prune_pending_dispatch_file_locked "$PENDING_AGENTS_FILE" 3 "$runtime_started_iso" "$stale_cutoff_iso"
  _prune_pending_dispatch_file_locked "$PENDING_AGENT_MODES_FILE" 4 "$runtime_started_iso" "$stale_cutoff_iso"
}

_prune_pending_dispatch_file_locked() {
  local target_file="${1:?target file required}"
  local status_field="${2:?status field required}"
  local runtime_started_iso="${3-}"
  local stale_cutoff_iso="${4-}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v status_field="$status_field" -v runtime_started="$runtime_started_iso" -v stale_cutoff="$stale_cutoff_iso" '
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
      if (status == "PENDING" && stale_cutoff != "" && ts != "" && ts < stale_cutoff) {
        next
      }
      print
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
session_id_is_known_worker() {
  local session_id="${1-}"

  [[ -n "$session_id" ]] || return 1

  if [[ -f "$SESSION_AGENT_MAP" ]] && awk -v sid="$session_id" '$1 == sid {found=1; exit} END {exit found ? 0 : 1}' "$SESSION_AGENT_MAP" 2>/dev/null; then
    return 0
  fi

  if [[ -f "$SESSION_AGENT_MODE_MAP" ]] && awk -v sid="$session_id" '$1 == sid {found=1; exit} END {exit found ? 0 : 1}' "$SESSION_AGENT_MODE_MAP" 2>/dev/null; then
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
# ── Worker config helpers (shared by health-check, agent-activity-monitor) ─
remove_member_from_config() {
  local worker_name="$1"
  [[ -n "$worker_name" ]] || return 1
  local config_file tmp_file updated
  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    tmp_file="${config_file}.tmp.$$"
    updated="$(node -e "
      const fs = require('fs');
      try {
        const config = JSON.parse(fs.readFileSync('${config_file}', 'utf8'));
        if (config.members) {
          const before = config.members.length;
          config.members = config.members.filter(m => m.name !== '${worker_name}');
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
  done
}

worker_name_for_session_id() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  if [[ -f "$SESSION_AGENT_MAP" ]]; then
    awk -v sid="$session_id" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true
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

mark_worker_standby() {
  local worker_name="${1-}"
  [[ -n "$worker_name" ]] || return 0

  mkdir -p "$(dirname "$STANDBY_FILE")"
  touch "$STANDBY_FILE"
  if ! grep -qxF "$worker_name" "$STANDBY_FILE" 2>/dev/null; then
    printf '%s\n' "$worker_name" >> "$STANDBY_FILE"
  fi
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

record_pending_agent_dispatch() {
  local timestamp="${1:?timestamp required}"
  local agent_name="${2:?agent name required}"
  local mode_value="${3:-default}"

  with_lock_file "$AGENT_CLAIM_LOCK" _record_pending_agent_dispatch_locked "$timestamp" "$agent_name" "$mode_value"
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
  drop_worker_rows_from_map_file "$SESSION_AGENT_MAP" "$worker_name"
  for session_id in "${worker_session_ids[@]}"; do
    [[ -n "$session_id" ]] || continue
    drop_session_rows_from_map_file "$SESSION_AGENT_MODE_MAP" "$session_id"
  done
  drop_worker_rows_from_pending_file "$PENDING_AGENTS_FILE" "$worker_name"
  drop_worker_rows_from_pending_file "$PENDING_AGENT_MODES_FILE" "$worker_name"
  remove_member_from_config "$worker_name"
  remove_worker_inboxes "$worker_name"
}

get_worker_pane_id() {
  local worker_name="$1"
  local config_file pane_id
  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    pane_id="$(node -e "
      const c = require('$config_file');
      const m = c.members && c.members.find(m => m.name === '$worker_name');
      if (m && m.tmuxPaneId) process.stdout.write(m.tmuxPaneId);
    " 2>/dev/null || true)"
    if [[ -n "$pane_id" ]]; then
      printf '%s' "$pane_id"
      return 0
    fi
  done
  return 1
}

# ── Memory pressure: auto-shutdown standby workers when mem > 80% ─────────
# Lightweight check designed to run throttled from agent-activity-monitor.sh
# Replaces the cron-based memory monitoring from health-check.sh
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

  # Only act if standby workers exist
  [[ -f "$STANDBY_FILE" && -s "$STANDBY_FILE" ]] || return 0

  local _worker_name _pane_id _shutdown_count=0
  while IFS= read -r _worker_name; do
    [[ -n "$_worker_name" ]] || continue

    # Kill tmux pane
    _pane_id="$(get_worker_pane_id "$_worker_name" 2>/dev/null || true)"
    if [[ -n "$_pane_id" ]]; then
      tmux_cmd kill-pane -t "$_pane_id" 2>/dev/null || true
    fi

    remove_worker_everywhere "$_worker_name"

    _shutdown_count=$(( _shutdown_count + 1 ))
    printf '[%s] MEM-PRESSURE AUTO-SHUTDOWN: %s | pane=%s | mem=%d%%\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" "$_worker_name" "${_pane_id:-none}" "$_mem_pct" >> "$VIOLATION_LOG"
  done < "$STANDBY_FILE"

  # Clear standby file after processing all
  if (( _shutdown_count > 0 )); then
    : > "$STANDBY_FILE"
  fi
}
