#!/usr/bin/env bash
# Runtime Integrity Recovery
# Sourceable bash helpers for auto-compaction recovery + ghost-state cleanup.
# Governance ownership: .claude/skills/session-boot/references/runtime-state-detail.md
# `## Runtime Integrity Defect Classification` (Domains 1-3, Classes A-I).
#
# Public functions:
#   runtime_integrity_classify <team_name>
#       Print one hook-detectable defect per line: `CLASS=<A|B|C|D|E|F>\tDETAIL=<text>`
#   runtime_integrity_reconcile_nondestructive <team_name>
#       Apply Class B/D/F automatic cleanup. Class C tmux-pane termination stays unavailable.
#   runtime_integrity_destructive_report <team_name>
#       Print HOLD-formatted lines for hook-detectable Class A/E requiring operator approval.
#
# All emissions are stderr-safe for hook composition; stdout reserved for structured output.

set -o pipefail

_rir_uid="$(id -u 2>/dev/null || echo "")"
_rir_teams_root="${HOME:-/}/.claude/teams"
_rir_tasks_root="${HOME:-/}/.claude/tasks"
_rir_tmux_sock_root="/tmp/tmux-${_rir_uid}"

_rir_resolve_socket() {
  # Walk ancestor PIDs first; fall back to first live-responding socket.
  local _pid _name
  _pid="${PPID:-}"
  while [[ -n "$_pid" && "$_pid" != "0" && "$_pid" != "1" ]]; do
    if [[ -S "$_rir_tmux_sock_root/claude-swarm-$_pid" ]] \
       && tmux -L "claude-swarm-$_pid" list-sessions >/dev/null 2>&1; then
      printf 'claude-swarm-%s' "$_pid"
      return 0
    fi
    _pid="$(ps -o ppid= -p "$_pid" 2>/dev/null | tr -d ' ')"
  done
  for _sock in "$_rir_tmux_sock_root"/claude-swarm-*; do
    [[ -S "$_sock" ]] || continue
    _name="$(basename "$_sock")"
    if tmux -L "$_name" list-sessions >/dev/null 2>&1; then
      printf '%s' "$_name"
      return 0
    fi
  done
  return 1
}

_rir_live_agent_pids_for_team() {
  local team="${1-}"
  [[ -n "$team" ]] || return 0
  # Require ARGV[0] (binary path, $2 after `pid=` is the first arg token) to be a claude
  # version path. This rules out bash/awk/python subshells whose args text mentions team
  # flags (including this classifier's own invocation paths under `.claude/`).
  ps -eo pid=,args= 2>/dev/null \
    | awk -v t="--team-name $team" '
        $0 ~ /--agent-id / && $0 ~ t && $2 ~ /\/(\.local\/share\/|.claude\/)?claude\/versions\// {
          print $1
        }'
}

_rir_live_agent_id_for_pid() {
  local pid="${1-}"
  ps -p "$pid" -o args= 2>/dev/null | sed -nE 's/.*--agent-id ([^ ]+).*/\1/p'
}

_rir_pane_has_claude_descendant() {
  local socket="${1-}" pane_id="${2-}"
  local pane_pid=""
  pane_pid="$(tmux -L "$socket" display-message -t "$pane_id" -p '#{pane_pid}' 2>/dev/null || true)"
  [[ "$pane_pid" =~ ^[0-9]+$ ]] || return 1
  ps -eo pid=,ppid=,comm=,args= 2>/dev/null | awk -v PANE_PID="$pane_pid" '
    { pid=$1; ppid=$2; comm=$3; $1=$2=$3=""; parent[pid]=ppid; text[pid]=comm " " $0 }
    END {
      if (PANE_PID == "") exit 1
      live[PANE_PID]=1; changed=1
      while (changed) {
        changed=0
        for (pid in parent) if (live[parent[pid]] && !live[pid]) { live[pid]=1; changed=1 }
      }
      for (pid in live) if (text[pid] ~ /(^|[[:space:]\/])claude([[:space:]\/]|$)/ || text[pid] ~ /claude-code|@anthropic-ai\/claude-code/) exit 0
      exit 1
    }'
}

runtime_integrity_classify() {
  local team="${1-}"
  [[ -n "$team" ]] || { echo "ERROR: team_name required" >&2; return 2; }
  local cfg="$_rir_teams_root/$team/config.json"
  local socket=""
  socket="$(_rir_resolve_socket || true)"

  # Domain 1: A (live process, no config entry)
  local cfg_agent_ids=""
  if [[ -f "$cfg" ]]; then
    cfg_agent_ids="$(python3 -c "import json; c=json.load(open('$cfg')); print(' '.join(m.get('agentId','') for m in c.get('members',[])))" 2>/dev/null || true)"
  fi
  for pid in $(_rir_live_agent_pids_for_team "$team"); do
    local aid
    aid="$(_rir_live_agent_id_for_pid "$pid" || true)"
    [[ -n "$aid" ]] || continue
    if ! printf ' %s ' "$cfg_agent_ids" | grep -qF " $aid "; then
      printf 'CLASS=A\tDETAIL=live-process pid=%s agent-id=%s team=%s no-config-entry\n' "$pid" "$aid" "$team"
    fi
  done

  # Domain 1: B (config entry, dead pane / no claude descendant)
  if [[ -f "$cfg" && -n "$socket" ]]; then
    while IFS=$'\t' read -r name pane_id agent_id; do
      [[ -n "$name" ]] || continue
      [[ "$name" == "team-lead" ]] && continue
      if [[ -z "$pane_id" ]]; then
        printf 'CLASS=B\tDETAIL=config-member name=%s agent-id=%s missing-tmuxPaneId\n' "$name" "$agent_id"
        continue
      fi
      if ! _rir_pane_has_claude_descendant "$socket" "$pane_id"; then
        printf 'CLASS=B\tDETAIL=config-member name=%s agent-id=%s pane=%s no-live-claude\n' "$name" "$agent_id" "$pane_id"
      fi
    done < <(python3 -c "import json; c=json.load(open('$cfg'));
[print(m.get('name',''), m.get('tmuxPaneId',''), m.get('agentId',''), sep='\t') for m in c.get('members',[])]" 2>/dev/null)
  fi

  # Domain 1: C (live pane, no claude descendant)
  if [[ -n "$socket" ]]; then
    while IFS=$'\t' read -r pane_id pane_cmd; do
      [[ -n "$pane_id" ]] || continue
      # Skip bash-only panes that are not agent panes
      if ! _rir_pane_has_claude_descendant "$socket" "$pane_id"; then
        # Only flag if config references this pane id
        if [[ -f "$cfg" ]] && python3 -c "import json,sys; c=json.load(open('$cfg')); sys.exit(0 if any(m.get('tmuxPaneId')=='$pane_id' for m in c.get('members',[])) else 1)" 2>/dev/null; then
          printf 'CLASS=C\tDETAIL=pane=%s socket=%s no-claude-descendant cmd=%s\n' "$pane_id" "$socket" "$pane_cmd"
        fi
      fi
    done < <(tmux -L "$socket" list-panes -a -F '#{pane_id}\t#{pane_current_command}' 2>/dev/null)
  fi

  # Domain 1: D (orphan socket file)
  for _sock in "$_rir_tmux_sock_root"/claude-swarm-*; do
    [[ -S "$_sock" ]] || continue
    local _name
    _name="$(basename "$_sock")"
    if ! tmux -L "$_name" list-sessions >/dev/null 2>&1; then
      printf 'CLASS=D\tDETAIL=orphan-socket=%s\n' "$_sock"
    fi
  done

  # Domain 2: E (UI ↔ config mismatch — surfaced via live-process count > config-entry count for same team)
  if [[ -f "$cfg" ]]; then
    local cfg_count live_count
    cfg_count="$(python3 -c "import json; c=json.load(open('$cfg')); print(sum(1 for m in c.get('members',[]) if m.get('name')!='team-lead'))" 2>/dev/null || echo 0)"
    live_count="$(_rir_live_agent_pids_for_team "$team" | grep -c .)"
    if [[ "$live_count" -ne "$cfg_count" ]]; then
      printf 'CLASS=E\tDETAIL=live-count=%s config-count=%s team=%s\n' "$live_count" "$cfg_count" "$team"
    fi
  fi

  # Domain 2: F (phantom task — highwatermark id with no on-disk record)
  local tasks_dir="$_rir_tasks_root/$team"
  if [[ -f "$tasks_dir/.highwatermark" ]]; then
    local hwm
    hwm="$(cat "$tasks_dir/.highwatermark" 2>/dev/null | tr -d ' ')"
    if [[ "$hwm" =~ ^[0-9]+$ && "$hwm" -gt 0 ]]; then
      if [[ ! -f "$tasks_dir/$hwm.json" ]]; then
        printf 'CLASS=F\tDETAIL=phantom-task highwatermark=%s team=%s no-disk-record\n' "$hwm" "$team"
      fi
    fi
  fi
}

runtime_integrity_reconcile_nondestructive() {
  local team="${1-}"
  [[ -n "$team" ]] || { echo "ERROR: team_name required" >&2; return 2; }
  local cfg="$_rir_teams_root/$team/config.json"
  local socket=""
  socket="$(_rir_resolve_socket || true)"
  local applied_count=0

  # Class B: remove dead config entries
  while IFS=$'\t' read -r class detail; do
    if [[ "$class" == "CLASS=B" ]]; then
      # Extract name from detail
      local dead_name
      dead_name="$(echo "$detail" | sed -nE 's/.*name=([^ ]+).*/\1/p')"
      if [[ -n "$dead_name" && -f "$cfg" ]]; then
        python3 -c "
import json
with open('$cfg') as f: c=json.load(f)
c['members'] = [m for m in c.get('members',[]) if m.get('name') != '$dead_name']
with open('$cfg','w') as f: json.dump(c,f,indent=2)
" 2>/dev/null && applied_count=$((applied_count+1)) && printf 'APPLIED: class=B removed-member=%s\n' "$dead_name"
      fi
    fi
  done < <(runtime_integrity_classify "$team" 2>/dev/null)

  # Class C: tmux-pane termination is prohibited by operator policy.
  while IFS=$'\t' read -r class detail; do
    if [[ "$class" == "CLASS=C" ]]; then
      local orphan_pane
      orphan_pane="$(echo "$detail" | sed -nE 's/.*pane=([^ ]+).*/\1/p')"
      if [[ -n "$orphan_pane" ]]; then
        printf 'SKIPPED: class=C tmux-kill-prohibited pane=%s\n' "$orphan_pane"
      fi
    fi
  done < <(runtime_integrity_classify "$team" 2>/dev/null)

  # Class D: unlink orphan socket files
  for _sock in "$_rir_tmux_sock_root"/claude-swarm-*; do
    [[ -S "$_sock" ]] || continue
    local _name
    _name="$(basename "$_sock")"
    if ! tmux -L "$_name" list-sessions >/dev/null 2>&1; then
      # Skip sockets whose PID-suffix matches a live ancestor (might be racing)
      local sock_pid
      sock_pid="$(echo "$_name" | sed -E 's/^claude-swarm-//')"
      if [[ -n "$sock_pid" ]] && ! kill -0 "$sock_pid" 2>/dev/null; then
        unlink "$_sock" 2>/dev/null \
          && applied_count=$((applied_count+1)) \
          && printf 'APPLIED: class=D unlinked-socket=%s\n' "$_sock"
      fi
    fi
  done

  # Class F: phantom task — log only, do not mutate task store (host owns highwatermark)
  while IFS=$'\t' read -r class detail; do
    if [[ "$class" == "CLASS=F" ]]; then
      printf 'NOTED: class=F %s consume-retained-output-as-completion\n' "$detail"
    fi
  done < <(runtime_integrity_classify "$team" 2>/dev/null)

  printf 'TOTAL-APPLIED: %s\n' "$applied_count"
}

runtime_integrity_destructive_report() {
  local team="${1-}"
  [[ -n "$team" ]] || { echo "ERROR: team_name required" >&2; return 2; }
  local has_destructive=0
  while IFS=$'\t' read -r class detail; do
    case "$class" in
      CLASS=A|CLASS=E)
        printf 'HOLD-REQUIRED: %s %s action=kill-or-reattach operator-approval-required\n' "$class" "$detail"
        has_destructive=1
        ;;
    esac
  done < <(runtime_integrity_classify "$team" 2>/dev/null)
  [[ "$has_destructive" -eq 0 ]] && printf 'CLEAN: no destructive-class defects for team=%s\n' "$team"
}
