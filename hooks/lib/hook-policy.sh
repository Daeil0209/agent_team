#!/usr/bin/env bash

HOOK_DIR="${HOOK_DIR:-$HOME/.claude/hooks}"
LOG_DIR="${LOG_DIR:-$HOME/.claude/logs}"
CLAUDE_ROOT="${CLAUDE_ROOT:-$(cd "${HOOK_DIR}/.." && pwd)}"
AGENT_DOCS_ROOT_DEFAULT="${CLAUDE_ROOT}/agents"
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
set_default_export AGENT_DOCS_ROOT "$AGENT_DOCS_ROOT_DEFAULT"
set_default_export AGENT_NAME_REGISTRY_FILE "$LOG_DIR/.agent-name-registry"
set_default_export ROLE_NAME_REGISTRY_FILE "$LOG_DIR/.role-name-registry"
set_default_export SKILL_NAME_REGISTRY_FILE "$LOG_DIR/.skill-name-registry"
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
set_default_export HOOK_HEALTH_REQUIRED_HOOKS "compliance-supervisor-edit.sh compliance-supervisor-bash.sh compliance-supervisor-web.sh runtime-entry-gate.sh compliance-agent-dispatch.sh compliance-sendmessage-dispatch.sh compliance-skill-authorization.sh"
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

command_is_health_check_monitor() {
  local raw_command="${1-}"
  local normalized=""

  [[ -n "$raw_command" ]] || return 1
  normalized="$(printf '%s' "$raw_command" | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed 's/[[:space:]]\+/ /g; s/^ //; s/ $//')"
  [[ "$normalized" == *"health-check.sh"* ]]
}
