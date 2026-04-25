#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  process.stdout.write(`${String(input.session_id || "")}\n`);
} catch {
  process.stdout.write("\n");
}
NODE
)"

SESSION_ID="$(printf '%s' "$PARSED" | tr -d '\n')"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

# --- Session Boot Cleanup ---
prune_noncurrent_pending_dispatch_residue
if [[ -n "$SESSION_ID" ]]; then
  printf '%s' "$SESSION_ID" > "$SESSION_BOOT_MARKER_FILE"
fi

ensure_procedure_state_surfaces
clear_stale_team_state_for_new_session "$SESSION_ID"
CONTINUITY_SEED_ACTION="$(seed_project_continuity_from_global_if_missing)"
refresh_procedure_state_sensors "$SESSION_ID"
update_procedure_state_fields \
  "$SESSION_ID" \
  bootSessionId "$SESSION_ID" \
  continuitySeedAction "$CONTINUITY_SEED_ACTION" \
  startupState "booting"

if [ -n "${TMUX:-}" ]; then
  tmux_cmd set-hook -g after-split-window 'select-pane -t :.0' 2>/dev/null || true
  tmux_cmd set-hook -g after-new-window 'select-pane -t :.0' 2>/dev/null || true
fi

REPO_ROOT="$(resolve_project_root)"
CONTINUITY_PATH="$(effective_continuity_file_path)"

describe_team_runtime_snapshot() {
  local config_file=""
  local current_live_config=""
  local live_config=""
  local live_lead_session_id=""
  local config_files=()
  local snapshot_label=""

  current_live_config="$(current_session_live_team_config "$SESSION_ID" 2>/dev/null || true)"
  live_config="$(active_team_config_live 2>/dev/null || true)"

  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    config_files+=("$config_file")
  done

  if [[ ${#config_files[@]} -eq 0 ]]; then
    return 0
  fi

  if [[ -n "$current_live_config" ]]; then
    live_config="$current_live_config"
    snapshot_label="Team runtime snapshot: current-session live runtime detected at $live_config."
  elif [[ -n "$live_config" ]]; then
    live_lead_session_id="$(team_config_lead_session_id "$live_config" 2>/dev/null || true)"
    snapshot_label="Team runtime snapshot: carry-over live runtime detected at $live_config (owner session ${live_lead_session_id:-unknown}); corroborate before reuse."
  fi

  if [[ -n "$live_config" ]]; then
    printf '%s\n' "$snapshot_label"
    return 0
  fi

  return 0
}

describe_procedure_state_team_channel() {
  local runtime_state=""
  local runtime_evidence=""
  local dispatch_state=""
  local dispatch_evidence=""
  local pending_worker=""
  local claimed_worker=""
  local project_continuity_state=""
  local global_continuity_state=""
  local mirror_status=""
  local current_live_config=""
  local live_config=""
  local meaningful="false"
  local parts=()

  runtime_state="$(get_procedure_state_field "teamRuntimeState" "")"
  runtime_evidence="$(get_procedure_state_field "teamExistenceEvidence" "")"
  dispatch_state="$(get_procedure_state_field "teamDispatchState" "")"
  dispatch_evidence="$(get_procedure_state_field "teamDispatchEvidence" "")"
  pending_worker="$(get_procedure_state_field "lastPendingWorker" "")"
  claimed_worker="$(get_procedure_state_field "lastClaimedWorker" "")"
  project_continuity_state="$(get_procedure_state_field "projectContinuityState" "")"
  global_continuity_state="$(get_procedure_state_field "globalContinuityState" "")"
  mirror_status="$(get_procedure_state_field "continuityMirrorStatus" "")"
  current_live_config="$(current_session_live_team_config "$SESSION_ID" 2>/dev/null || true)"
  live_config="$(active_team_config_live 2>/dev/null || true)"

  if [[ -n "$runtime_state" && "$runtime_state" != "inactive" ]]; then
    meaningful="true"
  fi
  if [[ -n "$dispatch_state" && "$dispatch_state" != "none" ]]; then
    meaningful="true"
  fi
  if [[ -n "$pending_worker" || -n "$claimed_worker" ]]; then
    meaningful="true"
  fi

  [[ "$meaningful" == "true" ]] || return 0

  if [[ -z "$current_live_config" && -z "$live_config" ]]; then
    if [[ "$project_continuity_state" != "current" && "$global_continuity_state" != "current" ]]; then
      return 0
    fi
    if [[ "$mirror_status" == "diverged" ]]; then
      return 0
    fi
  fi

  if [[ -n "$runtime_state" ]] && { [[ "$runtime_state" != "inactive" ]] || [[ -n "$pending_worker" || -n "$claimed_worker" ]] || [[ -n "$dispatch_state" && "$dispatch_state" != "none" ]]; }; then
    parts+=("runtime=${runtime_state}${runtime_evidence:+/${runtime_evidence}}")
  fi
  if [[ -n "$dispatch_state" ]] && { [[ "$dispatch_state" != "none" ]] || [[ -n "$pending_worker" || -n "$claimed_worker" ]]; }; then
    parts+=("dispatch=${dispatch_state}${dispatch_evidence:+/${dispatch_evidence}}")
  fi
  if [[ -n "$pending_worker" ]]; then
    parts+=("pending=${pending_worker}")
  fi
  if [[ -n "$claimed_worker" ]]; then
    parts+=("claimed=${claimed_worker}")
  fi

  if [[ ${#parts[@]} -gt 0 ]]; then
    printf '%s' "Persisted team state channel (corroborate before dispatch):"
    local idx=""
    for idx in "${!parts[@]}"; do
      if [[ "$idx" == "0" ]]; then
        printf ' %s' "${parts[$idx]}"
      else
        printf '; %s' "${parts[$idx]}"
      fi
    done
    printf '\n'
  fi
}

if runtime_sender_session_is_worker "$SESSION_ID" || is_worker_session; then
  # Worker session — do NOT emit team-lead Boot Sequence
  printf '%s\n' "Worker session | root: $REPO_ROOT"
else
  reset_startup_volatile_state
  # Reap dead workers from team config at boot to prevent ghost accumulation
  if command -v tmux &>/dev/null && [ -n "${TMUX:-}" ]; then
    _boot_session="$(tmux display-message -p '#S' 2>/dev/null || echo "")"
    if [ -n "$_boot_session" ]; then
      _boot_live_panes="$(tmux list-panes -t "$_boot_session" -F '#{pane_id}' 2>/dev/null || true)"
      for _boot_cfg in "$HOME/.claude/teams"/*/config.json; do
        [ -f "$_boot_cfg" ] || continue
        _boot_pane_ids="$(team_config_pane_ids "$_boot_cfg")"
        [ -n "$_boot_pane_ids" ] || continue
        while IFS= read -r _boot_pane; do
          [ -n "$_boot_pane" ] || continue
          if ! printf '%s\n' "$_boot_live_panes" | grep -qF "$_boot_pane"; then
            _boot_worker="$(CONFIG_FILE="$_boot_cfg" PANE_ID="$_boot_pane" node -e "
              try {
                const c=JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE,'utf8'));
                const m=(c.members||[]).find(m=>m.tmuxPaneId===process.env.PANE_ID);
                if(m&&m.name)process.stdout.write(m.name);
              } catch {}
            " 2>/dev/null || true)"
            if [ -n "$_boot_worker" ]; then
              remove_worker_everywhere "$_boot_worker" 2>/dev/null || true
            fi
          fi
        done <<< "$_boot_pane_ids"
      done
    fi
  fi
  describe_team_runtime_snapshot
fi

# --- Refresh Name Registry ---
refresh_name_registry

# --- Hook Health Self-Check ---
mode="${HOOK_HEALTH_SELF_CHECK_MODE:-warn}"
[[ "$mode" == "off" ]] && exit 0

settings_file="$CLAUDE_ROOT/settings.json"
timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
issues=()

if [[ ! -f "$settings_file" ]]; then
  issues+=("missing settings.json: $settings_file")
else
  wired="$(node -e '
    const fs=require("fs");
    const p=process.argv[1];
    const j=JSON.parse(fs.readFileSync(p,"utf8"));
    const hooks=JSON.stringify(j.hooks||{});
    process.stdout.write(hooks);
  ' "$settings_file" 2>/dev/null || true)"
  for hook_name in $HOOK_HEALTH_REQUIRED_HOOKS; do
    [[ -f "$HOOK_DIR/$hook_name" ]] || issues+=("missing hook file: $hook_name")
    printf '%s' "$wired" | grep -qF "$hook_name" || issues+=("not wired in settings.json: $hook_name")
  done
fi

if [[ ${#issues[@]} -gt 0 ]]; then
  {
    printf '%s | HOOK-HEALTH | WARN\n' "$timestamp"
    printf '%s\n' "${issues[@]}"
  } >> "$HOOK_HEALTH_LOG"
  {
    printf '[%s] HOOK-HEALTH WARN:\n' "$(date '+%Y-%m-%d %H:%M:%S')"
    printf -- '- %s\n' "${issues[@]}"
  } >> "$VIOLATION_LOG"
fi

exit 0
