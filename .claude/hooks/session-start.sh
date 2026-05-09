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
refresh_procedure_state_sensors "$SESSION_ID"
update_procedure_state_fields \
  "$SESSION_ID" \
  bootSessionId "$SESSION_ID" \
  startupState "booting"

if [ -n "${TMUX:-}" ]; then
  tmux_cmd set-hook -g after-split-window 'select-pane -t :.0' 2>/dev/null || true
  tmux_cmd set-hook -g after-new-window 'select-pane -t :.0' 2>/dev/null || true
fi

REPO_ROOT="$(resolve_project_root)"

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

if runtime_sender_session_is_worker "$SESSION_ID" || is_worker_session; then
  # Agent session — do NOT emit team-lead Boot Sequence
  printf '%s\n' "Agent session | root: $REPO_ROOT"
else
  reset_startup_volatile_state
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
  # Derive the wired-hook basename list directly from settings.json (single source of truth).
  # Health check verifies every hook actually wired by the harness has its .sh file on disk.
  wired_hooks="$(node -e '
    const fs=require("fs");
    const p=process.argv[1];
    const j=JSON.parse(fs.readFileSync(p,"utf8"));
    const hooks=j.hooks||{};
    const seen=new Set();
    for (const event of Object.values(hooks)) {
      if (!Array.isArray(event)) continue;
      for (const matcher of event) {
        const list=matcher.hooks||[];
        for (const h of list) {
          const cmd=h.command||"";
          const m=cmd.match(/\/hooks\/([\w-]+\.sh)/);
          if (m) seen.add(m[1]);
        }
      }
    }
    for (const name of Array.from(seen).sort()) process.stdout.write(name+"\n");
  ' "$settings_file" 2>/dev/null || true)"
  while IFS= read -r hook_name; do
    [[ -n "$hook_name" ]] || continue
    [[ -f "$HOOK_DIR/$hook_name" ]] || issues+=("missing hook file: $hook_name")
  done <<<"$wired_hooks"
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
