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
SESSION_START_RUNTIME_SNAPSHOT_PRESENT=0

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
    SESSION_START_RUNTIME_SNAPSHOT_PRESENT=1
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
  if [[ "$SESSION_START_RUNTIME_SNAPSHOT_PRESENT" == "0" ]]; then
    mark_procedure_startup_ready "$SESSION_ID"
    printf '%s | boot-complete | clean-session-start\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
  fi
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

# --- Curtain Constitutional Self-Check ---
# PROTECTED-LOCAL-RESTATEMENT-BASIS: see .claude/reference/modification-core-law.md ## Constitutional Curtain Protection for canonical owner and constitutional-curtain-visibility basis.
# PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE
# This block is enumerated as constitutionally-protected per
# .claude/reference/modification-core-law.md ## Constitutional Curtain Protection.
# Verifies that constitutional curtain enforcement chain remains wired and
# uneroded after any prior governance patch waves. Mandatory; not skippable by
# HOOK_HEALTH_SELF_CHECK_MODE.
# Forensic basis: claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md
# documents 3+ prior reporting-prohibition patch waves eroded by subsequent
# "Consolidate/Tighten/Reduce/Sweep" commits. Self-validation surfaces erosion
# at session-start moment instead of next leak observation.
# Approval basis: 2026-05-26 curtain-constitutional-fix-2026-05-26
# (user-authorized via "독립적이면서 안전한 보완 패치를 신중하게 진행해").

curtain_issues=()

# (1) Verify constitutional section in CLAUDE.md
if ! grep -q '^## Constitutional Reporting Curtain$' "$CLAUDE_ROOT/CLAUDE.md" 2>/dev/null; then
  curtain_issues+=("CLAUDE.md missing '## Constitutional Reporting Curtain' section (constitutional invariant (a) topmost compromised)")
fi

# (2) Verify constitutional 4-invariant detail in reporting-core-law.md
if ! grep -q '^## Constitutional 4-Invariant Detail$' "$CLAUDE_ROOT/reference/reporting-core-law.md" 2>/dev/null; then
  curtain_issues+=("reporting-core-law.md missing '## Constitutional 4-Invariant Detail' section (constitutional invariant (c) priority executable detail compromised)")
fi

# (3) Verify constitutional curtain protection in modification-core-law.md
if ! grep -q '^## Constitutional Curtain Protection$' "$CLAUDE_ROOT/reference/modification-core-law.md" 2>/dev/null; then
  curtain_issues+=("modification-core-law.md missing '## Constitutional Curtain Protection' section (constitutional invariant (d) always-maintained recurrence barrier compromised)")
fi

# (4) Verify curtain-breach defect class in review-and-verification-core-law.md
if ! grep -q 'curtain-breach' "$CLAUDE_ROOT/reference/review-and-verification-core-law.md" 2>/dev/null; then
  curtain_issues+=("review-and-verification-core-law.md missing 'curtain-breach' hard-deny defect class (constitutional invariant (d) audit catch compromised)")
fi

# (5) Verify SendMessage envelope hook wired in settings.json
if ! grep -q 'reporting-curtain-envelope-gate.sh' "$CLAUDE_ROOT/settings.json" 2>/dev/null; then
  curtain_issues+=("settings.json missing reporting-curtain-envelope-gate.sh wiring (SendMessage envelope curtain layer compromised)")
fi

# (6) Verify Stop response hook wired in settings.json
if ! grep -q 'assistant-response-curtain-gate.sh' "$CLAUDE_ROOT/settings.json" 2>/dev/null; then
  curtain_issues+=("settings.json missing assistant-response-curtain-gate.sh wiring on Stop event (main response curtain layer compromised)")
fi

# (7) Verify both curtain hook scripts exist with non-empty body
for curtain_hook in reporting-curtain-envelope-gate.sh assistant-response-curtain-gate.sh; do
  hook_path="$HOOK_DIR/$curtain_hook"
  if [[ ! -f "$hook_path" ]] || [[ ! -s "$hook_path" ]]; then
    curtain_issues+=("curtain hook script missing or empty: $curtain_hook")
  fi
done

# (8) Verify identity-layer atomic-check clause present in all 6 role files
for role_file in developer.md researcher.md reviewer.md team-lead.md tester.md validator.md; do
  role_path="$CLAUDE_ROOT/agents/$role_file"
  if [[ -f "$role_path" ]]; then
    if ! grep -q 'Atomic-check procedure (executable at every emission moment)' "$role_path"; then
      curtain_issues+=("$role_file missing identity-layer atomic-check clause (constitutional invariant (c) priority identity-spawn priming compromised)")
    fi
  fi
done

# (9) Verify PROTECTED-CURTAIN-SURFACE markers on key curtain text surfaces
for marker_file in CLAUDE.md reference/reporting-core-law.md reference/reporting-prohibition-law.md reference/modification-core-law.md; do
  marker_path="$CLAUDE_ROOT/$marker_file"
  if [[ -f "$marker_path" ]]; then
    if ! grep -q 'PROTECTED-CURTAIN-SURFACE' "$marker_path"; then
      curtain_issues+=("$marker_file missing PROTECTED-CURTAIN-SURFACE marker (silent removal-first cleanup vector reopened)")
    fi
  fi
done

# (10) Verify canonical PROTECTED-CURTAIN-SURFACE enumeration wording-drift detection
# Round 3 CP-B install (gov-comprehensive-audit-patch-2026-05-26) — verifies that the
# canonical Enumerated protected surfaces list at modification-core-law.md
# ## Constitutional Curtain Protection still contains the expected surface tokens.
# Wording drift on any expected token triggers additionalContext violation report
# without auto-normalizing the protected surface (operator-policy-choice routing).
canonical_enum_check="$CLAUDE_ROOT/reference/modification-core-law.md"
if [[ -f "$canonical_enum_check" ]]; then
  for expected_token in 'Constitutional Reporting Curtain' 'reporting-core-law.md' 'reporting-prohibition-law.md' 'Constitutional Curtain Protection' 'curtain-breach' 'Curtained Communication' 'reporting-curtain-envelope-gate.sh' 'assistant-response-curtain-gate.sh' 'curtain-validation block' 'curtain hook wiring'; do
    if ! grep -qF "$expected_token" "$canonical_enum_check"; then
      curtain_issues+=("modification-core-law.md ## Constitutional Curtain Protection enumeration drift: expected surface token missing: $expected_token (canonical enumeration drift — Round 3 CP-B audit)")
    fi
  done
fi

if [[ ${#curtain_issues[@]} -gt 0 ]]; then
  {
    printf '%s | CURTAIN-CONSTITUTIONAL | VIOLATION\n' "$timestamp"
    printf '%s\n' "${curtain_issues[@]}"
  } >> "$HOOK_HEALTH_LOG"
  {
    printf '[%s] CURTAIN-CONSTITUTIONAL VIOLATION:\n' "$(date '+%Y-%m-%d %H:%M:%S')"
    printf -- '- %s\n' "${curtain_issues[@]}"
    printf 'Restore curtain protection per .claude/reference/modification-core-law.md ## Constitutional Curtain Protection before continuing work. Forensic: claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md.\n'
  } >> "$VIOLATION_LOG"
  # Emit additionalContext to surface violation at session-start
  printf '\nCURTAIN-CONSTITUTIONAL-FIX VIOLATION DETECTED at session-start:\n'
  printf -- '- %s\n' "${curtain_issues[@]}"
  printf 'Required action: restore curtain protection per .claude/reference/modification-core-law.md ## Constitutional Curtain Protection before continuing work. Bypass prohibition: constitutional-curtain enforcement is not skippable.\n'
fi

exit 0
