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
  local live_config=""
  local config_files=()
  local summarized=""

  live_config="$(active_team_config_live 2>/dev/null || true)"

  for config_file in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$config_file" ]] || continue
    config_files+=("$config_file")
  done

  if [[ ${#config_files[@]} -eq 0 ]]; then
    printf '%s\n' "Team runtime snapshot: no team config files under $HOME/.claude/teams."
    return 0
  fi

  summarized="${config_files[0]}"
  if [[ ${#config_files[@]} -gt 1 ]]; then
    summarized+=" (+$(( ${#config_files[@]} - 1 )) more)"
  fi

  if [[ -n "$live_config" ]]; then
    printf '%s\n' "Team runtime snapshot: live team config detected at $live_config (session-owned panes attached; workers may be idle and require SendMessage to act — 'live' ≠ 'actively processing')."
    _member_names="$(CONFIG_FILE="$live_config" node -e "
      try {
        const c=JSON.parse(require('fs').readFileSync(process.env.CONFIG_FILE,'utf8'));
        const names=(c.members||[]).map(m=>m.name).filter(Boolean);
        if(names.length)process.stdout.write(names.join(', '));
      } catch {}
    " 2>/dev/null || true)"
    if [[ -n "$_member_names" ]]; then
      printf '%s\n' "Team members: $_member_names"
    fi
    if [[ "$summarized" != "$live_config" ]]; then
      printf '%s\n' "Observed team config files: $summarized"
    fi
    return 0
  fi

  printf '%s\n' "Team runtime snapshot: config files exist but no live worker panes were detected."
  printf '%s\n' "Observed team config files: $summarized"
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
  printf '%s\n' "Lead session | root: $REPO_ROOT | boot before team runtime"
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
