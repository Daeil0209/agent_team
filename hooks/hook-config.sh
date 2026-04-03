#!/usr/bin/env bash

HOOK_DIR="${HOOK_DIR:-$HOME/.claude/hooks}"
LOG_DIR="${LOG_DIR:-$HOME/.claude/logs}"
CLAUDE_ROOT="${CLAUDE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
PROJECT_SKILLS_ROOT="${PROJECT_SKILLS_ROOT:-$CLAUDE_ROOT/skills}"
CLAUDE_PROJECTS_DIR="${CLAUDE_PROJECTS_DIR:-$HOME/.claude/projects}"
mkdir -p "$HOOK_DIR" "$LOG_DIR"

resolve_project_root() {
  local seed=""
  seed="${CLAUDE_PROJECT_DIR:-${PWD:-$(pwd)}}"
  git -C "$seed" rev-parse --show-toplevel 2>/dev/null || printf '%s' "$seed"
}

derive_project_memory_slug() {
  local project_root="${1-}"
  project_root="$(printf '%s' "$project_root" | sed 's#\\#/#g')"
  printf '%s' "$project_root" | sed 's#/#-#g; s#_#-#g'
}

set_default_export() {
  local name="${1:?variable name required}"
  local default_value="${2-}"

  if [[ -z "${!name-}" ]]; then
    printf -v "$name" '%s' "$default_value"
  fi
  export "$name"
}

resolve_project_auto_memory_dir() {
  local project_root=""
  local memory_slug=""
  project_root="$(resolve_project_root)"
  memory_slug="$(derive_project_memory_slug "$project_root")"
  printf '%s/%s/memory' "$CLAUDE_PROJECTS_DIR" "$memory_slug"
}

is_worker_session() {
  # Workers run inside the claude-swarm tmux session.
  # Main session runs on user terminal, NOT inside claude-swarm.
  # This function returns 0 (true) if current session is a worker.
  if [[ "${TMUX:-}" == *"claude-swarm"* ]] && [[ -n "${TMUX_PANE:-}" ]]; then
    return 0
  fi
  return 1
}

target_is_already_active_worker() {
  local target_name="${1-}"
  local norm=""
  norm="$(normalize_lane_id "$target_name")"
  [[ -n "$norm" ]] || return 1
  [[ -f "$SESSION_AGENT_MAP" ]] || return 1
  awk -v worker="$norm" 'tolower($2) == worker {found=1; exit} END {exit !found}' "$SESSION_AGENT_MAP"
}

PROJECT_AUTO_MEMORY_DIR_DEFAULT="$(resolve_project_auto_memory_dir)"
set_default_export PROJECT_AUTO_MEMORY_DIR "$PROJECT_AUTO_MEMORY_DIR_DEFAULT"

set_default_export VIOLATION_LOG "$LOG_DIR/violation-log.txt"
set_default_export SESSION_END_LOG "$LOG_DIR/session-end.log"
set_default_export DISPATCH_LEDGER "$LOG_DIR/.dispatch-ledger"
set_default_export ACTIVITY_LEDGER "$LOG_DIR/.activity-ledger"
set_default_export STALE_WARNED_FILE "$LOG_DIR/.stale-warned"
set_default_export STANDBY_FILE "$LOG_DIR/.standby-approved"
set_default_export KILL_LIST "$LOG_DIR/.kill-agents"
set_default_export STOP_BLOCK_FLAG "$LOG_DIR/.stop-blocked"
set_default_export CLOSEOUT_STATE_FILE "$LOG_DIR/.closeout-state.json"
set_default_export LEGACY_CLOSEOUT_INTENT_FILE "$LOG_DIR/.closeout-intent"
set_default_export HEALTH_CRON_FLAG "$LOG_DIR/.health-cron-needed"
set_default_export HEALTH_CRON_JOB_FILE "$LOG_DIR/.health-cron-job-id"
set_default_export HEALTH_CRON_ROTATION_STATE_FILE "$LOG_DIR/.health-cron-rotation-state.json"
set_default_export TEAM_RUNTIME_ACTIVE_FILE "$LOG_DIR/.team-runtime-active"
set_default_export BOOT_SEQUENCE_COMPLETE_FILE "$LOG_DIR/.boot-sequence-complete"
set_default_export SESSION_BOOT_MARKER_FILE "$LOG_DIR/.session-boot-marker"
set_default_export SUPERVISOR_SESSION_FILE "$LOG_DIR/.supervisor-session-id"
set_default_export PENDING_AGENTS_FILE "$LOG_DIR/.pending-agents"
set_default_export SESSION_AGENT_MAP "$LOG_DIR/.session-agent-map"
set_default_export PENDING_AGENT_MODES_FILE "$LOG_DIR/.pending-agent-modes"
set_default_export SESSION_AGENT_MODE_MAP "$LOG_DIR/.session-agent-mode-map"
set_default_export AGENT_CLAIM_LOCK "$LOG_DIR/.agent-claim.lock"
set_default_export SKILL_AUTH_LOCK "$LOG_DIR/.skill-auth.lock"
set_default_export CLOSEOUT_STATE_LOCK "$LOG_DIR/.closeout-state.lock"
set_default_export HEALTH_CRON_ROTATION_STATE_LOCK "$LOG_DIR/.health-cron-rotation-state.lock"
set_default_export PERMISSION_REQUEST_LOG "$LOG_DIR/permission-request.log"
set_default_export SPECIALIST_SKILL_AUTH_LEDGER "$LOG_DIR/.specialist-skill-auth"

set_default_export STALE_WARN_SECONDS "120"
set_default_export STALE_THRESHOLD_SECONDS "300"
set_default_export PENDING_DISPATCH_STALE_SECONDS "30"
set_default_export HEALTH_CHECK_WINDOW "600"
set_default_export HEALTH_CHECK_GHOST_THRESH "1800"
set_default_export HEALTH_CHECK_SHORT_THRESH "60"
set_default_export HEALTH_CHECK_BASH_THRESH "180"
set_default_export HEALTH_CHECK "$HOOK_DIR/health-check.sh"
set_default_export HEALTH_CHECK_CRON "*/5 * * * *"
set_default_export HEALTH_CHECK_HEARTBEAT_FILE "$LOG_DIR/.health-check-heartbeat"
set_default_export HEALTH_CRON_ROTATION_TTL_SECONDS "300"
set_default_export HOOK_HEALTH_SELF_CHECK_MODE "warn"
set_default_export HOOK_HEALTH_LOG "$LOG_DIR/hook-health.log"
set_default_export HOOK_HEALTH_REQUIRED_HOOKS "compliance-supervisor-edit.sh compliance-supervisor-bash.sh compliance-supervisor-web.sh runtime-entry-gate.sh compliance-agent-dispatch.sh compliance-skill-authorization.sh"
set_default_export RUNTIME_AUTOMATION_MODE "single-primary"
set_default_export RUNTIME_AUTOREAP_ENABLED "1"
set_default_export RUNTIME_KEEP_WATCHDOG_WHEN_IDLE ""
set_default_export RUNTIME_MEM_SOFT_KB "1572864"
set_default_export RUNTIME_MEM_HARD_KB "786432"
set_default_export RUNTIME_MEM_EMERGENCY_KB "393216"
set_default_export RUNTIME_SWAP_HARD_KB "524288"
set_default_export RUNTIME_SWAP_EMERGENCY_KB "131072"
set_default_export RUNTIME_REAP_TERM_GRACE_SECONDS "2"
set_default_export RUNTIME_REAP_MAX_PROCESSES "24"
set_default_export RUNTIME_REAP_COOLDOWN_SECONDS "120"
set_default_export RUNTIME_TMUX_SOCKET_DIR "/tmp/tmux-$(id -u)"

# Resolve active claude-swarm tmux socket name
resolve_tmux_socket_name() {
  if [[ -n "${TMUX:-}" ]]; then
    basename "$(printf '%s' "$TMUX" | cut -d',' -f1)"
    return 0
  fi
  local _sock
  for _sock in "/tmp/tmux-$(id -u)"/claude-swarm-*; do
    if [[ -S "$_sock" ]]; then
      basename "$_sock"
      return 0
    fi
  done
  return 1
}
RUNTIME_TMUX_SOCKET_NAME="$(resolve_tmux_socket_name 2>/dev/null || true)"
export RUNTIME_TMUX_SOCKET_NAME

tmux_cmd() { tmux ${RUNTIME_TMUX_SOCKET_NAME:+-L "$RUNTIME_TMUX_SOCKET_NAME"} "$@"; }

set_default_export RUNTIME_PRESSURE_STATE_FILE "$LOG_DIR/.runtime-pressure-state.json"
set_default_export RUNTIME_ORPHAN_AUDIT_LOG "$LOG_DIR/runtime-orphan-audit.log"
set_default_export RUNTIME_REAP_LOG "$LOG_DIR/runtime-reap.log"
set_default_export RUNTIME_REAP_LOCK "$LOG_DIR/.runtime-reap.lock"
set_default_export RUNTIME_REAP_COOLDOWN_FILE "$LOG_DIR/.runtime-reap-cooldown"
set_default_export SESSION_STATE_STALE_THRESHOLD "1800"
set_default_export SESSION_STATE_FRESH_THRESHOLD "900"
set_default_export SPECIALIST_SKILL_ENFORCEMENT_MODE "deny"
set_default_export SPECIALIST_SKILLS_REQUIRING_APPROVAL "sw-spec|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto|bench-sim|int-op"
set_default_export SPECIALIST_SKILL_OWNER_ROLE "developer"
set_default_export USER_PROMPT_CLOSEOUT_INTENT_REASON "user-prompt-explicit-closeout"
set_default_export EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN "(?:\\bclose\\s*out\\b|\\bcloseout\\b|\\bend\\s+(?:the\\s+)?session\\b|\\bexit\\s+(?:the\\s+)?session\\b|\\bshut\\s+down\\b|\\bterminate\\s+(?:the\\s+)?session\\b|\\bwrap\\s+up\\b|\\uC885\\uB8CC(?:\\uD558\\uC790|\\uD574|\\uD560\\uAC70\\uC57C|\\uD560\\uB798|\\uD560\\uAC8C|\\uD560\\uAC8C\\uC694|\\uD560\\uAED8|\\uD560\\uAED8\\uC694|\\uD574\\uC918|\\uD558\\uACE0\\s*\\uB05D\\uB0B4\\uC790)?|\\uC138\\uC158\\s*\\uC885\\uB8CC|\\uC791\\uC5C5\\s*\\uC885\\uB8CC|\\uB05D\\uB0B4\\uC790|\\uB05D\\uB0BC\\uAC8C)"
set_default_export CLOSEOUT_CANCEL_PROMPT_JS_PATTERN "(?:\\bcancel\\s+closeout\\b|\\bdefer\\s+closeout\\b|\\bdo\\s+not\\s+(?:end|exit|close)\\b|\\bkeep\\s+(?:the\\s+)?session\\s+open\\b|\\bcontinue\\s+working\\b|\\bresume\\s+work\\b|\\uC885\\uB8CC\\s*(?:\\uCDE8\\uC18C|\\uBCF4\\uB958)|\\uC138\\uC158\\s*\\uACC4\\uC18D|\\uACC4\\uC18D\\s*\\uC791\\uC5C5|\\uC885\\uB8CC\\s*\\uD558\\uC9C0\\s*\\uB9C8)"
set_default_export NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN "(?:\\bhook(?:s)?\\b|\\bstop\\b|\\bsequence\\b|\\berror(?:s)?\\b|\\bbug(?:s)?\\b|\\bissue(?:s)?\\b|\\bpatch(?:es)?\\b|\\banaly[sz](?:e|ing)?\\b|\\banalysis\\b|\\breview\\b|\\binvestigat(?:e|ion)\\b|\\btest(?:ing)?\\b|\\bsimulat(?:e|ion)\\b|\\bmessage(?:s)?\\b|\\bcause\\b|\\breason\\b|\\bwhy\\b|\\uD6C5|\\uC2DC\\uD000\\uC2A4|\\uC5D0\\uB7EC|\\uBC84\\uADF8|\\uC774\\uC288|\\uD328\\uCE58|\\uBD84\\uC11D|\\uAC80\\uD1A0|\\uD14C\\uC2A4\\uD2B8|\\uC2DC\\uBBAC\\uB808\\uC774\\uC158|\\uBA54\\uC2DC\\uC9C0|\\uC6D0\\uC778)"

set_default_export TEAM_CORE "researcher"
set_default_export TEAM_IMPLEMENTATION "developer|int-op|reviewer|tester|validator"
set_default_export TEAM_SPECIALIST "sw-spec|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto"
set_default_export TEAM_META "bench-sim"
set_default_export S31_ALLOWED_FOREGROUND_ROLES "researcher"
set_default_export MANIFEST_SYNC_DISPATCH_VERB_PATTERN "copy|overwrite|sync|mirror|propagat|deploy|replace"
set_default_export MANIFEST_SYNC_DISPATCH_SCOPE_PATTERN "manifest|~/.claude|/\\.claude|global folder|patch folder|payload|file list|write-scope|original patch|target folder|source folder"
set_default_export REPO_GIT_INSPECTION_PATTERN "git\\s+(log|status|branch(\\s+--show-current)?|remote(\\s+-v)?|diff|stash\\s+list|rev-parse|show)(\\s|$)"
# Match only the global control roots themselves; project subpaths under $HOME must remain allowed.
set_default_export GLOBAL_CONTROL_SURFACE_CD_PATTERN "(^|[[:space:];|&])cd[[:space:]]+((~|\\$HOME)(/\\.claude)?/?|/home/[^/[:space:];|&]+(/\\.claude)?/?)([[:space:];|&]|$)"

set_default_export A04_DESTRUCTIVE_PATTERN "(mkfs\\.|dd\\s+if=|>\\s*/dev/(sd|nvme|loop|mem|kmem)|git\\s+reset\\s+--hard)"
set_default_export S02_DIAGNOSTIC_PATTERN "(pytest|python.*-m\\s+pytest|python.*-m\\s+pdb|unittest|strace|ltrace|gdb|lldb|valgrind|node\\s+--inspect|docker\\s+logs|journalctl|uv\\s+run\\s+pytest|npm\\s+(run\\s+)?test|pnpm\\s+(run\\s+)?test|yarn\\s+test|go\\s+test|cargo\\s+test|npx\\s+jest|npx\\s+vitest|(^|[[:space:]])jest([[:space:]]|$)|(^|[[:space:]])vitest([[:space:]]|$))"
set_default_export MAIN_MUTATING_BASH_PATTERN "(^|\\s)(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|git\\s+checkout|git\\s+switch|git\\s+restore|git\\s+reset|git\\s+clean|git\\s+commit|git\\s+merge|git\\s+rebase|git\\s+push|git\\s+pull|sed\\s+-i|perl\\s+-i|tee)(\\s|$)|>>?|(^|\\s):\\s*>"

RUNTIME_TRANSIENT_FILES=(
  "$VIOLATION_LOG"
  "$PERMISSION_REQUEST_LOG"
  "$SESSION_END_LOG"
  "$ACTIVITY_LEDGER"
  "$STALE_WARNED_FILE"
  "$DISPATCH_LEDGER"
  "$STANDBY_FILE"
  "$KILL_LIST"
  "$STOP_BLOCK_FLAG"
  "$HEALTH_CRON_FLAG"
  "$HEALTH_CRON_JOB_FILE"
  "$HEALTH_CRON_ROTATION_STATE_FILE"
  "$HEALTH_CHECK_HEARTBEAT_FILE"
  "$TEAM_RUNTIME_ACTIVE_FILE"
  "$BOOT_SEQUENCE_COMPLETE_FILE"
  "$SESSION_BOOT_MARKER_FILE"
  "$SUPERVISOR_SESSION_FILE"
  "$PENDING_AGENTS_FILE"
  "$SESSION_AGENT_MAP"
  "$PENDING_AGENT_MODES_FILE"
  "$SESSION_AGENT_MODE_MAP"
  "$SPECIALIST_SKILL_AUTH_LEDGER"
)

GOVERNANCE_RESIDUE_FILES=(
  "$CLOSEOUT_STATE_FILE"
  "$LEGACY_CLOSEOUT_INTENT_FILE"
)

SESSION_SCOPED_FILES=(
  "${RUNTIME_TRANSIENT_FILES[@]}"
  "${GOVERNANCE_RESIDUE_FILES[@]}"
)

STARTUP_VOLATILE_FILES=(
  "$BOOT_SEQUENCE_COMPLETE_FILE"
  "$STOP_BLOCK_FLAG"
  "$CLOSEOUT_STATE_FILE"
  "$LEGACY_CLOSEOUT_INTENT_FILE"
  "$TEAM_RUNTIME_ACTIVE_FILE"
  "$PENDING_AGENTS_FILE"
  "$PENDING_AGENT_MODES_FILE"
  "$KILL_LIST"
)

cleanup_session_files() {
  cleanup_runtime_transients
  cleanup_governance_residue
}

clear_tracked_files() {
  local f=""
  for f in "$@"; do
    mkdir -p "$(dirname "$f")"
    : > "$f"
  done
}

cleanup_runtime_transients() {
  clear_tracked_files "${RUNTIME_TRANSIENT_FILES[@]}"
}

cleanup_governance_residue() {
  clear_tracked_files "${GOVERNANCE_RESIDUE_FILES[@]}"
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

resolve_requested_dispatch_name() {
  local explicit_name="${1-}"
  local description="${2-}"
  local resolved_id=""
  local fallback_name=""

  explicit_name="$(printf '%s' "$explicit_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$explicit_name" ]]; then
    printf '%s' "$explicit_name"
    return 0
  fi

  resolved_id="$(resolve_agent_id "$description")"
  if [[ "$resolved_id" != "unknown" ]]; then
    printf '%s' "$resolved_id"
    return 0
  fi

  fallback_name="$(printf '%s' "$description" | sed -n 's/^\([a-zA-Z0-9_-]*\):.*/\1/p')"
  fallback_name="$(printf '%s' "$fallback_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  if [[ -n "$fallback_name" ]]; then
    printf '%s' "$fallback_name"
    return 0
  fi

  printf 'unknown'
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

reset_startup_volatile_state() {
  local f=""
  for f in "${STARTUP_VOLATILE_FILES[@]}"; do
    mkdir -p "$(dirname "$f")"
    : > "$f"
  done
}

runtime_truthy() {
  case "${1-}" in
    1|true|True|TRUE|yes|Yes|YES|on|On|ON) return 0 ;;
    *) return 1 ;;
  esac
}

runtime_automation_single_primary() {
  [[ "${RUNTIME_AUTOMATION_MODE:-}" == "single-primary" ]]
}

runtime_autoreap_enabled() {
  runtime_truthy "${RUNTIME_AUTOREAP_ENABLED:-0}"
}

runtime_keep_watchdog_when_idle() {
  if [[ -n "${RUNTIME_KEEP_WATCHDOG_WHEN_IDLE:-}" ]]; then
    runtime_truthy "$RUNTIME_KEEP_WATCHDOG_WHEN_IDLE"
    return
  fi

  runtime_automation_single_primary
}

cleanup_project_auto_memory() {
  local memory_dir="${PROJECT_AUTO_MEMORY_DIR:-}"
  [[ -n "$memory_dir" ]] || return 0

  rm -rf "$memory_dir"
  mkdir -p "$memory_dir"
}

closeout_intent_is_active() {
  local expected_session_id="${1-}"
  local active_value=""

  active_value="$(get_closeout_state_field active "$expected_session_id")"
  [[ "$active_value" == "true" ]]
}

session_has_only_operational_activity() {
  local session_id="${1-}"

  [[ -n "$session_id" ]] || return 1
  [[ -f "$ACTIVITY_LEDGER" ]] || return 1

  awk -F' \\| ' -v sid="$session_id" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    function allowed(tool) {
      return tool == "Read" \
        || tool == "ToolSearch" \
        || tool == "Grep" \
        || tool == "Glob" \
        || tool == "TeamCreate" \
        || tool == "CronCreate" \
        || tool == "CronDelete" \
        || tool == "TeamDelete"
    }
    {
      current_session = trim($2)
      if (current_session != sid) {
        next
      }

      tool = trim($5)
      seen = 1

      if (tool == "" || tool ~ /^Bash:/ || !allowed(tool)) {
        blocked = 1
        exit
      }
    }
    END {
      exit (seen && !blocked) ? 0 : 1
    }
  ' "$ACTIVITY_LEDGER"
}

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

resolve_closeout_session_id() {
  local session_id="${1-}"

  if [[ -n "$session_id" ]]; then
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

closeout_continuity_file_path() {
  local project_root=""
  project_root="$(resolve_project_root)"
  printf '%s/.claude/session-state.md' "$project_root"
}

current_closeout_continuity_state() {
  local state_file=""
  local state_age=0

  state_file="$(closeout_continuity_file_path)"
  if [[ ! -f "$state_file" ]]; then
    printf 'missing'
    return 0
  fi

  state_age=$(( $(date +%s) - $(stat -c %Y "$state_file" 2>/dev/null || echo 0) ))
  if [[ "$state_age" -gt "$SESSION_STATE_STALE_THRESHOLD" ]]; then
    printf 'stale'
  else
    printf 'current'
  fi
}

closeout_validation_owner_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field validationOwnerState "$expected_session_id" "unknown"
}

closeout_acceptance_evidence_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field acceptanceEvidenceState "$expected_session_id" "unknown"
}

closeout_supervisor_review_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field supervisorReviewState "$expected_session_id" "not-needed"
}

closeout_continuity_state() {
  local expected_session_id="${1-}"
  get_closeout_state_field continuityState "$expected_session_id" "$(current_closeout_continuity_state)"
}

closeout_hold_reason() {
  local expected_session_id="${1-}"
  get_closeout_state_field holdReason "$expected_session_id" ""
}

closeout_teardown_governance_ready() {
  local expected_session_id="${1-}"
  local validation_state=""
  local evidence_state=""

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"

  [[ "$validation_state" == "assigned" || "$validation_state" == "not-needed" ]] \
    && [[ "$evidence_state" == "present" || "$evidence_state" == "not-needed" ]]
}

closeout_unresolved_governance_present() {
  local expected_session_id="${1-}"
  local validation_state=""
  local evidence_state=""
  local supervisor_state=""

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"
  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"

  [[ "$validation_state" == "missing" || "$validation_state" == "unknown" ]] \
    || [[ "$evidence_state" == "missing" || "$evidence_state" == "unknown" ]] \
    || [[ "$supervisor_state" == "required" || "$supervisor_state" == "missing" || "$supervisor_state" == "unknown" ]]
}

closeout_governance_complete() {
  local expected_session_id="${1-}"
  local supervisor_state=""
  local continuity_state=""

  closeout_clean_pre_sessionend_ready "$expected_session_id" || return 1

  continuity_state="$(closeout_continuity_state "$expected_session_id")"
  [[ "$continuity_state" == "current" || "$continuity_state" == "captured-clean" || "$continuity_state" == "captured-with-warnings" ]]
}

closeout_clean_pre_sessionend_ready() {
  local expected_session_id="${1-}"
  local supervisor_state=""

  current_runtime_workers_drained || return 1
  [[ ! -s "$HEALTH_CRON_JOB_FILE" ]] || return 1
  [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] || return 1
  closeout_teardown_governance_ready "$expected_session_id" || return 1

  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"
  [[ "$supervisor_state" == "completed" || "$supervisor_state" == "not-needed" ]] || return 1
}

closeout_hold_pre_stop_ready() {
  local expected_session_id="${1-}"
  local hold_reason=""

  current_runtime_workers_drained || return 1
  [[ ! -s "$HEALTH_CRON_JOB_FILE" ]] || return 1
  [[ ! -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] || return 1
  closeout_unresolved_governance_present "$expected_session_id" || return 1

  hold_reason="$(closeout_hold_reason "$expected_session_id")"
  [[ -n "$hold_reason" ]]
}

closeout_cleanup_eligibility() {
  local expected_session_id="${1-}"
  local continuity_state=""

  continuity_state="$(closeout_continuity_state "$expected_session_id")"

  if closeout_governance_complete "$expected_session_id" && [[ "$continuity_state" == "captured-clean" || "$continuity_state" == "captured-with-warnings" ]]; then
    printf 'ready'
    return 0
  fi

  if closeout_hold_pre_stop_ready "$expected_session_id" && [[ "$continuity_state" == "captured-with-warnings" ]]; then
    printf 'ready'
    return 0
  fi

  printf 'blocked'
}

closeout_governance_blockers() {
  local expected_session_id="${1-}"
  local blockers=()
  local validation_state=""
  local evidence_state=""
  local supervisor_state=""
  local continuity_state=""

  validation_state="$(closeout_validation_owner_state "$expected_session_id")"
  evidence_state="$(closeout_acceptance_evidence_state "$expected_session_id")"
  supervisor_state="$(closeout_supervisor_review_state "$expected_session_id")"
  continuity_state="$(closeout_continuity_state "$expected_session_id")"

  if [[ "$validation_state" != "assigned" && "$validation_state" != "not-needed" ]]; then
    blockers+=("validation-owner=${validation_state}")
  fi
  if [[ "$evidence_state" != "present" && "$evidence_state" != "not-needed" ]]; then
    blockers+=("acceptance-evidence=${evidence_state}")
  fi
  if [[ "$supervisor_state" != "completed" && "$supervisor_state" != "not-needed" ]]; then
    blockers+=("supervisor-review=${supervisor_state}")
  fi
  if [[ "$continuity_state" == "stale" || "$continuity_state" == "missing" || "$continuity_state" == "unknown" ]]; then
    blockers+=("continuity=${continuity_state}")
  fi

  if [[ ${#blockers[@]} -eq 0 ]]; then
    return 0
  fi

  printf '%s' "${blockers[0]}"
  local idx=""
  for idx in "${!blockers[@]}"; do
    if [[ "$idx" == "0" ]]; then
      continue
    fi
    printf ', %s' "${blockers[$idx]}"
  done
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

get_closeout_state_field() {
  local field="${1:?field required}"
  local expected_session_id="${2-}"
  local default_value="${3-}"
  local resolved_session_id=""

  resolved_session_id="$(resolve_closeout_session_id "$expected_session_id")"
  [[ -n "$resolved_session_id" ]] || {
    printf '%s' "$default_value"
    return 0
  }

  FIELD="$field" EXPECTED_SESSION_ID="$resolved_session_id" DEFAULT_VALUE="$default_value" CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" node <<'NODE'
const fs = require("fs");

try {
  const raw = fs.readFileSync(process.env.CLOSEOUT_STATE_FILE || "", "utf8").trim();
  if (!raw) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const state = JSON.parse(raw);
  const expectedSessionId = process.env.EXPECTED_SESSION_ID || "";
  const stateSessionId = String(state.sessionId || "");
  if (expectedSessionId && (!stateSessionId || stateSessionId !== expectedSessionId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const field = process.env.FIELD || "";
  const value = state[field];
  if (value === undefined || value === null || value === "") {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
  } else {
    process.stdout.write(String(value));
  }
} catch {
  process.stdout.write(process.env.DEFAULT_VALUE || "");
}
NODE
}

update_closeout_state_fields() {
  local session_id="${1-}"
  local update_lines=""

  shift || true
  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  [[ -n "$session_id" ]] || return 0

  while [[ $# -gt 1 ]]; do
    update_lines+="${1}=${2}"$'\n'
    shift 2
  done

  with_lock_file "$CLOSEOUT_STATE_LOCK" _update_closeout_state_fields_impl "$session_id" "$update_lines"
}

_update_closeout_state_fields_impl() {
  local session_id="${1-}"
  local update_lines="${2-}"
  local workers_drained_value="false"
  local health_cron_removed_value="true"
  local runtime_removed_value="true"
  local continuity_state_value=""

  current_runtime_workers_drained && workers_drained_value="true"
  [[ -s "$HEALTH_CRON_JOB_FILE" ]] && health_cron_removed_value="false"
  [[ -s "$TEAM_RUNTIME_ACTIVE_FILE" ]] && runtime_removed_value="false"
  continuity_state_value="$(current_closeout_continuity_state)"

  SESSION_ID="$session_id" \
  UPDATE_LINES="$update_lines" \
  WORKERS_DRAINED_VALUE="$workers_drained_value" \
  HEALTH_CRON_REMOVED_VALUE="$health_cron_removed_value" \
  RUNTIME_REMOVED_VALUE="$runtime_removed_value" \
  CONTINUITY_STATE_VALUE="$continuity_state_value" \
  CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");

const path = process.env.CLOSEOUT_STATE_FILE || "";
const sessionId = process.env.SESSION_ID || "";
const updateLines = String(process.env.UPDATE_LINES || "")
  .split(/\n/)
  .filter(Boolean);

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) previous = JSON.parse(raw);
} catch {}

const updates = {};
for (const line of updateLines) {
  const idx = line.indexOf("=");
  if (idx <= 0) continue;
  updates[line.slice(0, idx)] = line.slice(idx + 1);
}

const workersDrained = process.env.WORKERS_DRAINED_VALUE === "true";
const healthCronRemoved = process.env.HEALTH_CRON_REMOVED_VALUE === "true";
const runtimeRemoved = process.env.RUNTIME_REMOVED_VALUE === "true";
const sensedContinuityState = process.env.CONTINUITY_STATE_VALUE || "unknown";
const previousContinuityState = previous.continuityState || "";
const stickyContinuityState = ["captured-clean", "captured-with-warnings"].includes(previousContinuityState)
  ? previousContinuityState
  : "";
const continuityState = updates.continuityState || stickyContinuityState || sensedContinuityState || "unknown";
const validationOwnerState = updates.validationOwnerState || previous.validationOwnerState || "unknown";
const acceptanceEvidenceState = updates.acceptanceEvidenceState || previous.acceptanceEvidenceState || "unknown";
const supervisorReviewState = updates.supervisorReviewState || previous.supervisorReviewState || "not-needed";
const holdReason = updates.holdReason !== undefined ? updates.holdReason : (previous.holdReason || "");
const closeoutDisposition = updates.closeoutDisposition || previous.closeoutDisposition || (previous.active === true ? "blocked" : "none");

const teardownGovernanceReady =
  ["assigned", "not-needed"].includes(validationOwnerState) &&
  ["present", "not-needed"].includes(acceptanceEvidenceState);

const governanceComplete =
  workersDrained &&
  healthCronRemoved &&
  runtimeRemoved &&
  teardownGovernanceReady &&
  ["completed", "not-needed"].includes(supervisorReviewState) &&
  ["current", "captured-clean", "captured-with-warnings"].includes(continuityState);

const unresolvedGovernance =
  ["missing", "unknown"].includes(validationOwnerState) ||
  ["missing", "unknown"].includes(acceptanceEvidenceState) ||
  ["required", "missing", "unknown"].includes(supervisorReviewState);

const holdPreStopReady =
  workersDrained &&
  healthCronRemoved &&
  runtimeRemoved &&
  unresolvedGovernance &&
  Boolean(holdReason);

const cleanupEligibility =
  (governanceComplete && ["captured-clean", "captured-with-warnings"].includes(continuityState))
    || (holdPreStopReady && continuityState === "captured-with-warnings")
    ? "ready"
    : "blocked";

const next = {
  ...previous,
  sessionId: previous.sessionId || sessionId,
  workersDrained,
  healthCronRemoved,
  runtimeRemoved,
  validationOwnerState,
  acceptanceEvidenceState,
  supervisorReviewState,
  continuityState,
  holdReason,
  closeoutDisposition,
  cleanupEligibility,
  ...updates
};

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}

refresh_closeout_state_sensors() {
  local session_id="${1-}"

  session_id="$(resolve_closeout_session_id "$session_id")"
  [[ -n "$session_id" ]] || return 0
  [[ -f "$CLOSEOUT_STATE_FILE" ]] || return 0

  update_closeout_state_fields "$session_id"
}

set_closeout_intent() {
  local reason="${1-}"
  local source="${2:-manual-helper}"
  local phase="${3:-intent_marked}"
  local session_id="${4:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  _write_closeout_state "true" "$session_id" "$source" "${reason:-explicit-closeout-intent}" "$phase"
  if session_has_only_operational_activity "$session_id"; then
    mark_closeout_governance_packet "not-needed" "not-needed" "not-used" "not-needed" "$session_id"
  fi
  update_closeout_state_fields "$session_id"
}

advance_closeout_phase() {
  local phase="${1:?phase required}"
  local session_id="${2:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  if ! closeout_intent_is_active "$session_id"; then
    return 0
  fi

  _write_closeout_state "true" "$session_id" "" "" "$phase"
  update_closeout_state_fields "$session_id"
}

clear_closeout_intent() {
  local reason="${1:-closeout-cleared}"
  local session_id="${2:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  _write_closeout_state "false" "$session_id" "clear-helper" "$reason" "inactive"
  update_closeout_state_fields "$session_id"
}

mark_closeout_governance_packet() {
  local validation_state="${1:-unknown}"
  local acceptance_state="${2:-unknown}"
  local supervisor_state="${3:-not-needed}"
  local session_id="${4:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  update_closeout_state_fields \
    "$session_id" \
    validationOwnerState "$validation_state" \
    acceptanceEvidenceState "$acceptance_state" \
    supervisorReviewState "$supervisor_state"
}

prepare_closeout_hold_state() {
  local hold_reason="${1:-governance-hold}"
  local session_id="${2:-}"

  session_id="$(resolve_closeout_session_id "$session_id")"

  update_closeout_state_fields \
    "$session_id" \
    holdReason "$hold_reason" \
    closeoutDisposition "hold"
}

health_cron_rotation_is_active() {
  local expected_session_id="${1-}"
  local expected_target_job_id="${2-}"
  local active_value=""

  active_value="$(get_health_cron_rotation_state_field active "$expected_session_id" "$expected_target_job_id")"
  [[ "$active_value" == "true" ]]
}

get_health_cron_rotation_state_field() {
  local field="${1:?field required}"
  local expected_session_id="${2-}"
  local expected_target_job_id="${3-}"
  local default_value="${4-}"

  FIELD="$field" \
  EXPECTED_SESSION_ID="$expected_session_id" \
  EXPECTED_TARGET_JOB_ID="$expected_target_job_id" \
  DEFAULT_VALUE="$default_value" \
  ROTATION_STATE_FILE="$HEALTH_CRON_ROTATION_STATE_FILE" \
  ROTATION_TTL_SECONDS="$HEALTH_CRON_ROTATION_TTL_SECONDS" \
  node <<'NODE'
const fs = require("fs");

try {
  const raw = fs.readFileSync(process.env.ROTATION_STATE_FILE || "", "utf8").trim();
  if (!raw) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const state = JSON.parse(raw);
  if (state.active !== true) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const expectedSessionId = process.env.EXPECTED_SESSION_ID || "";
  const stateSessionId = String(state.sessionId || "");
  if (expectedSessionId && (!stateSessionId || stateSessionId !== expectedSessionId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const expectedTargetJobId = process.env.EXPECTED_TARGET_JOB_ID || "";
  const stateTargetJobId = String(state.targetJobId || "");
  if (expectedTargetJobId && (!stateTargetJobId || stateTargetJobId !== expectedTargetJobId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const ttlSeconds = Number(process.env.ROTATION_TTL_SECONDS || 0);
  if (ttlSeconds > 0) {
    const updatedAt = Date.parse(String(state.updatedAt || state.requestedAt || ""));
    if (!Number.isFinite(updatedAt) || updatedAt <= 0 || (Date.now() - updatedAt) > ttlSeconds * 1000) {
      process.stdout.write(process.env.DEFAULT_VALUE || "");
      process.exit(0);
    }
  }

  const field = process.env.FIELD || "";
  const value = state[field];
  if (value === undefined || value === null || value === "") {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
  } else {
    process.stdout.write(String(value));
  }
} catch {
  process.stdout.write(process.env.DEFAULT_VALUE || "");
}
NODE
}

set_health_cron_rotation_intent() {
  local reason="${1-}"
  local source="${2:-manual-helper}"
  local phase="${3:-rotation_requested}"
  local session_id="${4:-}"
  local target_job_id="${5:-}"
  local replacement_job_id="${6:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  if [[ -z "$target_job_id" ]]; then
    target_job_id="$(current_health_cron_job_id)"
  fi
  [[ -n "$target_job_id" ]] || return 1

  _write_health_cron_rotation_state "true" "$session_id" "$source" "${reason:-explicit-health-cron-rotation}" "$phase" "$target_job_id" "$replacement_job_id"
}

advance_health_cron_rotation_phase() {
  local phase="${1:?phase required}"
  local session_id="${2:-}"
  local target_job_id="${3:-}"
  local replacement_job_id="${4:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  if [[ -n "$target_job_id" ]]; then
    if ! health_cron_rotation_is_active "$session_id" "$target_job_id"; then
      return 0
    fi
  elif ! health_cron_rotation_is_active "$session_id"; then
    return 0
  fi

  _write_health_cron_rotation_state "true" "$session_id" "" "" "$phase" "$target_job_id" "$replacement_job_id"
}

clear_health_cron_rotation_intent() {
  local reason="${1:-health-cron-rotation-cleared}"
  local session_id="${2:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi

  _write_health_cron_rotation_state "false" "$session_id" "clear-helper" "$reason" "inactive" "" ""
}

_write_health_cron_rotation_state() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local target_job_id="${6-}"
  local replacement_job_id="${7-}"

  with_lock_file "$HEALTH_CRON_ROTATION_STATE_LOCK" _write_health_cron_rotation_state_impl "$active" "$session_id" "$source" "$reason" "$phase" "$target_job_id" "$replacement_job_id"
}

_write_health_cron_rotation_state_impl() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local target_job_id="${6-}"
  local replacement_job_id="${7-}"
  local event_ts=""

  event_ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  mkdir -p "$(dirname "$HEALTH_CRON_ROTATION_STATE_FILE")"

  STATE_ACTIVE="$active" \
  STATE_SESSION_ID="$session_id" \
  STATE_SOURCE="$source" \
  STATE_REASON="$reason" \
  STATE_PHASE="$phase" \
  STATE_TARGET_JOB_ID="$target_job_id" \
  STATE_REPLACEMENT_JOB_ID="$replacement_job_id" \
  EVENT_TS="$event_ts" \
  ROTATION_STATE_FILE="$HEALTH_CRON_ROTATION_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");
const path = process.env.ROTATION_STATE_FILE || "";
const now = process.env.EVENT_TS || new Date().toISOString();
const active = process.env.STATE_ACTIVE === "true";

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) {
    previous = JSON.parse(raw);
  }
} catch {}

const sessionId = process.env.STATE_SESSION_ID || previous.sessionId || "";
const source = process.env.STATE_SOURCE || previous.source || (active ? "manual-helper" : "");
const reason = process.env.STATE_REASON || previous.reason || "";
const phase = process.env.STATE_PHASE || (active ? previous.phase || "rotation_requested" : "inactive");
const targetJobId = process.env.STATE_TARGET_JOB_ID || previous.targetJobId || "";
const replacementJobId = process.env.STATE_REPLACEMENT_JOB_ID || previous.replacementJobId || "";

const next = active
  ? {
      active: true,
      sessionId,
      source,
      reason: reason || "explicit-health-cron-rotation",
      phase,
      targetJobId,
      replacementJobId,
      requestedAt: previous.active ? previous.requestedAt || now : now,
      updatedAt: now,
      clearedAt: ""
    }
  : {
      active: false,
      sessionId,
      source,
      reason,
      phase: "inactive",
      targetJobId: "",
      replacementJobId: "",
      requestedAt: "",
      updatedAt: now,
      clearedAt: now,
      lastActiveSessionId: previous.sessionId || sessionId || "",
      lastActiveSource: previous.source || "",
      lastActiveReason: previous.reason || "",
      lastActivePhase: previous.phase || "",
      lastActiveTargetJobId: previous.targetJobId || "",
      lastReplacementJobId: previous.replacementJobId || "",
      lastActiveRequestedAt: previous.requestedAt || ""
    };

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}

_write_closeout_state() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"

  with_lock_file "$CLOSEOUT_STATE_LOCK" _write_closeout_state_impl "$active" "$session_id" "$source" "$reason" "$phase"
}

_write_closeout_state_impl() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local event_ts=""

  event_ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  mkdir -p "$(dirname "$CLOSEOUT_STATE_FILE")"

  STATE_ACTIVE="$active" \
  STATE_SESSION_ID="$session_id" \
  STATE_SOURCE="$source" \
  STATE_REASON="$reason" \
  STATE_PHASE="$phase" \
  EVENT_TS="$event_ts" \
  CLOSEOUT_STATE_FILE="$CLOSEOUT_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");
const path = process.env.CLOSEOUT_STATE_FILE || "";
const now = process.env.EVENT_TS || new Date().toISOString();
const active = process.env.STATE_ACTIVE === "true";

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) {
    previous = JSON.parse(raw);
  }
} catch {}

const sessionId = process.env.STATE_SESSION_ID || previous.sessionId || "";
const source = process.env.STATE_SOURCE || previous.source || (active ? "manual-helper" : "");
const reason = process.env.STATE_REASON || previous.reason || "";
const phase = process.env.STATE_PHASE || (active ? previous.phase || "intent_marked" : "inactive");

const next = active
  ? {
      active: true,
      sessionId,
      source,
      reason: reason || "explicit-closeout-intent",
      phase,
      requestedAt: previous.active ? previous.requestedAt || now : now,
      updatedAt: now,
      clearedAt: "",
      workersDrained: previous.workersDrained,
      healthCronRemoved: previous.healthCronRemoved,
      runtimeRemoved: previous.runtimeRemoved,
      validationOwnerState: previous.validationOwnerState,
      acceptanceEvidenceState: previous.acceptanceEvidenceState,
      supervisorReviewState: previous.supervisorReviewState,
      continuityState: previous.continuityState,
      holdReason: previous.holdReason || "",
      closeoutDisposition: previous.closeoutDisposition || "blocked",
      cleanupEligibility: previous.cleanupEligibility || "blocked"
    }
  : {
      active: false,
      sessionId,
      source,
      reason,
      phase: "inactive",
      requestedAt: "",
      updatedAt: now,
      clearedAt: now,
      workersDrained: previous.workersDrained,
      healthCronRemoved: previous.healthCronRemoved,
      runtimeRemoved: previous.runtimeRemoved,
      validationOwnerState: previous.validationOwnerState,
      acceptanceEvidenceState: previous.acceptanceEvidenceState,
      supervisorReviewState: previous.supervisorReviewState,
      continuityState: previous.continuityState,
      holdReason: previous.holdReason || "",
      closeoutDisposition: previous.closeoutDisposition || "none",
      cleanupEligibility: previous.cleanupEligibility || "blocked",
      lastActiveSessionId: previous.sessionId || sessionId || "",
      lastActiveSource: previous.source || "",
      lastActiveReason: previous.reason || "",
      lastActivePhase: previous.phase || "",
      lastActiveRequestedAt: previous.requestedAt || ""
    };

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}

with_lock_file() {
  local lock_file="${1:?lock file required}"
  shift

  mkdir -p "$(dirname "$lock_file")"

  (
    flock -x 9
    "$@"
  ) 9>>"$lock_file"
}

make_atomic_temp_file() {
  local target_file="${1:?target file required}"
  mkdir -p "$(dirname "$target_file")"
  mktemp "$(dirname "$target_file")/.tmp.$(basename "$target_file").XXXXXX"
}

atomic_replace_file() {
  local source_file="${1:?source file required}"
  local target_file="${2:?target file required}"
  mkdir -p "$(dirname "$target_file")"
  mv -f "$source_file" "$target_file"
}

append_line_locked() {
  local lock_file="${1:?lock file required}"
  local target_file="${2:?target file required}"
  local line="${3-}"

  with_lock_file "$lock_file" _append_line_locked_impl "$target_file" "$line"
}

_append_line_locked_impl() {
  local target_file="${1:?target file required}"
  local line="${2-}"

  mkdir -p "$(dirname "$target_file")"
  printf '%s\n' "$line" >> "$target_file"
}

pipe_list_has_token() {
  local list="${1-}"
  local token="${2-}"
  local item=""

  [[ -n "$list" ]] || return 1
  [[ -n "$token" ]] || return 1

  IFS='|' read -r -a _pipe_items <<< "$list"
  for item in "${_pipe_items[@]}"; do
    [[ "$item" == "$token" ]] && return 0
  done
  return 1
}

normalize_skill_id() {
  local raw="${1-}"
  local normalized=""

  normalized="$(printf '%s' "$raw" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s/^[`"'\''[:space:]]*//; s/[`"'\''[:space:]]*$//')"
  if [[ "$normalized" == */SKILL.md ]]; then
    normalized="$(basename "$(dirname "$normalized")")"
  elif [[ "$normalized" == */* ]]; then
    normalized="$(basename "$normalized")"
  else
    normalized="${normalized##*:}"
  fi
  normalized="$(printf '%s' "$normalized" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  printf '%s' "$normalized"
}

resolve_active_skill_path() {
  local skill_id=""
  skill_id="$(normalize_skill_id "${1-}")"
  printf '%s' "$PROJECT_SKILLS_ROOT/$skill_id/SKILL.md"
}

active_skill_exists() {
  local skill_path=""
  skill_path="$(resolve_active_skill_path "${1-}")"
  [[ -f "$skill_path" ]]
}

normalize_lane_id() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

canonicalize_runtime_lane_id() {
  local raw=""
  raw="$(normalize_lane_id "${1-}")"

  case "$raw" in
    *:*)
      raw="${raw#*:}"
      ;;
  esac

  printf '%s' "$raw"
}

normalize_surface_id() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed 's/|/%7C/g; s/[[:space:]]\+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

sanitize_ledger_field() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '\n' ' ' | sed 's/|/%7C/g; s/[[:space:]]\+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

specialist_skill_requires_explicit_approval() {
  local skill_id=""
  skill_id="$(normalize_skill_id "${1-}")"
  pipe_list_has_token "$SPECIALIST_SKILLS_REQUIRING_APPROVAL" "$skill_id" && active_skill_exists "$skill_id"
}

role_local_skill_owner_role() {
  local skill_id=""
  skill_id="$(normalize_skill_id "${1-}")"

  case "$skill_id" in
    researcher|developer|reviewer|tester|validator)
      active_skill_exists "$skill_id" || return 1
      printf '%s' "$skill_id"
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

role_local_skill_requires_matching_role() {
  role_local_skill_owner_role "${1-}" >/dev/null
}

skill_requires_explicit_approval() {
  specialist_skill_requires_explicit_approval "${1-}"
}

resolve_agent_id() {
  local desc="${1:-}"
  local prefix=""
  local lower_desc=""

  prefix="$(printf '%s' "$desc" | sed -n 's/^\([a-zA-Z_-]*\):.*/\1/p' | tr '[:upper:]' '[:lower:]')"
  case "$prefix" in
    team-lead|teamlead|lead) echo "team-lead"; return ;;
    researcher) echo "researcher"; return ;;
    developer|dev-[a-z]) echo "developer"; return ;;
    int-op|integration-operator) echo "int-op"; return ;;
    reviewer) echo "reviewer"; return ;;
    tester) echo "tester"; return ;;
    validator|val-ref) echo "validator"; return ;;
    sw-spec) echo "sw-spec"; return ;;
    biz-sys) echo "biz-sys"; return ;;
    ui-ux) echo "ui-ux"; return ;;
    edu-spec) echo "edu-spec"; return ;;
    eng-spec) echo "eng-spec"; return ;;
    math-spec) echo "math-spec"; return ;;
    doc-auto) echo "doc-auto"; return ;;
    bench-sim) echo "bench-sim"; return ;;
  esac

  lower_desc="$(printf '%s' "$desc" | tr '[:upper:]' '[:lower:]')"
  case "$lower_desc" in
    *team-lead*|*team\ lead*) echo "team-lead"; return ;;
    *integration?operator*|*int-op*) echo "int-op"; return ;;
    *validate?against?reference*|*validator*|*val-ref*) echo "validator"; return ;;
    *software?specialist*|*software?spec*|*sw-spec*) echo "sw-spec"; return ;;
    *business?system*|*biz-sys*) echo "biz-sys"; return ;;
    *ui?ux?specialist*|*ui-ux*) echo "ui-ux"; return ;;
    *education?specialist*|*edu-spec*) echo "edu-spec"; return ;;
    *engineering?specialist*|*eng-spec*) echo "eng-spec"; return ;;
    *mathematics?specialist*|*math-spec*) echo "math-spec"; return ;;
    *document?automation*|*doc-auto*) echo "doc-auto"; return ;;
    *benchmark?simulator*|*bench-sim*) echo "bench-sim"; return ;;
    *researcher*) echo "researcher"; return ;;
    *developer*) echo "developer"; return ;;
    *reviewer*) echo "reviewer"; return ;;
    *tester*) echo "tester"; return ;;
  esac

  echo "unknown"
}

get_agent_category() {
  local id="${1:-}"
  case "$id" in
    researcher) echo "research" ;;
    developer|int-op) echo "implementation" ;;
    reviewer|tester) echo "review" ;;
    validator) echo "validation" ;;
    sw-spec|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto) echo "specialist" ;;
    bench-sim) echo "meta" ;;
    *) echo "other" ;;
  esac
}

check_agent_property() {
  local id="${1:-}"
  local prop="${2:-}"

  case "$prop" in
    requires_mode_auto)
      case "$id" in
        developer|int-op) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    requires_plan)
      case "$id" in
        developer|sw-spec|int-op) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    plan_exempt)
      case "$id" in
        researcher|reviewer|tester|validator|bench-sim|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto) echo "true" ;;
        *) echo "false" ;;
      esac
      ;;
    *)
      echo "false"
      ;;
  esac
}

is_subagent() {
  local input="${1:-}"
  if [[ -z "$input" ]]; then
    echo "false"
    return
  fi
  INPUT_JSON="$input" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(input.agent_id ? "true" : "false");
} catch {
  process.stdout.write("false");
}
NODE
}

normalize_dispatch_text() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed 's/[[:space:]]\+/ /g; s/^[[:space:]]*//; s/[[:space:]]*$//'
}

dispatch_is_manifest_sync_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1

  if [[ "$desc" == *"task-class: manifest-sync"* ]]; then
    return 0
  fi

  # If TASK-CLASS is explicitly set to a different value, respect that classification
  if dispatch_field_present "$desc" "task-class"; then
    return 1
  fi

  if printf '%s' "$desc" | grep -Eq "$MANIFEST_SYNC_DISPATCH_VERB_PATTERN" \
    && printf '%s' "$desc" | grep -Eq "$MANIFEST_SYNC_DISPATCH_SCOPE_PATTERN"; then
    return 0
  fi

  return 1
}

dispatch_field_present() {
  local raw_value=""
  raw_value="$(dispatch_field_raw_value "${1-}" "${2-}" 2>/dev/null || true)"
  [[ -n "$raw_value" ]]
}

dispatch_field_value_matches() {
  local raw_value=""
  local field=""
  local value_pattern=""
  field="$(normalize_dispatch_text "${2-}")"
  value_pattern="${3-}"

  [[ -n "$field" && -n "$value_pattern" ]] || return 1
  raw_value="$(dispatch_field_raw_value "${1-}" "$field" 2>/dev/null || true)"
  [[ -n "$raw_value" ]] || return 1
  raw_value="$(normalize_dispatch_text "$raw_value")"
  printf '%s' "$raw_value" | grep -Eq "^(${value_pattern})$"
}

dispatch_field_raw_value() {
  local field=""
  local raw_desc="${1-}"
  field="$(normalize_dispatch_text "${2-}")"

  [[ -n "$raw_desc" && -n "$field" ]] || return 1

  printf '%s\n' "$raw_desc" | awk -v field="$field" '
    BEGIN { IGNORECASE = 1 }
    {
      line = $0
      while (length(line) > 0) {
        split_index = index(line, ";")
        if (split_index > 0) {
          segment = substr(line, 1, split_index - 1)
          line = substr(line, split_index + 1)
        } else {
          segment = line
          line = ""
        }

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", segment)
        if (segment == "") {
          continue
        }

        if (match(segment, /^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$/, parts)) {
          key = tolower(parts[1])
          value = parts[2]
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
          if (key == field && length(value) > 0) {
            print value
            exit
          }
        }
      }
    }
  '
}

dispatch_field_pipe_list_matches() {
  local raw_value=""
  local allowed_pattern=""
  local entry=""
  raw_value="$(dispatch_field_raw_value "${1-}" "${2-}")"
  allowed_pattern="${3-}"

  [[ -n "$raw_value" && -n "$allowed_pattern" ]] || return 1

  IFS='|' read -r -a entries <<< "$raw_value"
  for entry in "${entries[@]}"; do
    entry="$(normalize_dispatch_text "$entry")"
    if [[ -z "$entry" ]] || ! printf '%s' "$entry" | grep -Eq "^(${allowed_pattern})$"; then
      return 1
    fi
  done

  return 0
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
