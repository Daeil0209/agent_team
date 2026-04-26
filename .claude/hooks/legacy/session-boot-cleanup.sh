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
prune_noncurrent_pending_dispatch_residue
if [[ -n "$SESSION_ID" ]]; then
  printf '%s' "$SESSION_ID" > "$SESSION_BOOT_MARKER_FILE"
fi

if [ -n "${TMUX:-}" ]; then
  tmux_cmd set-hook -g after-split-window 'select-pane -t :.0' 2>/dev/null || true
  tmux_cmd set-hook -g after-new-window 'select-pane -t :.0' 2>/dev/null || true
fi

REPO_ROOT="$(resolve_project_root)"
CONTINUITY_PATH="$(realpath -m "$REPO_ROOT/.claude/session-state.md" 2>/dev/null || printf '%s' "$REPO_ROOT/.claude/session-state.md")"

if is_worker_session; then
  # Worker session — do NOT emit team-lead Boot Sequence
  printf '%s\n' \
    "You are a WORKER agent dispatched by the team lead." \
    "Do NOT perform Boot Sequence, TeamCreate, CronCreate, or any team-lead orchestration." \
    "Do NOT spawn sub-agents, create teams, or register health-check crons." \
    "Do NOT act as a supervisor or orchestrator." \
    "Follow ONLY the specific task instructions you received from the team lead." \
    "Active project root: $REPO_ROOT"
else
  reset_startup_volatile_state
  printf '%s\n' \
    "SessionStart:startup hook success: Boot Sequence is MANDATORY. Execute Boot Sequence BEFORE any user-facing response." \
    "Main session role: team lead." \
    "Active project root: $REPO_ROOT" \
    "BOOT SPEED: In your FIRST tool-call turn, execute ALL THREE in parallel: (1) Read $CONTINUITY_PATH, (2) ToolSearch query=\"select:TeamCreate\" max_results=1, (3) Bash: ls \$HOME/.claude/teams/*/config.json 2>/dev/null to check team existence." \
    "BOOT SPEED: In your SECOND turn, call TeamCreate if no team config exists, then IMMEDIATELY respond to the user's original message. Do NOT output a boot-status report — answer the user." \
    "Use the continuity read only as a startup anchor. Do not stop at a context summary." \
    "Do not probe repo-local .claude/hooks during normal boot to rediscover these runtime-owned values." \
    "Do not run repo-context reconstruction, git status/log/branch/remote, or enumerate optional project-local .claude paths during startup unless continuity is missing, contradictory, or the user explicitly asks for repository analysis." \
    "Apply the same root-local rule to the current repo, clone, or worktree." \
    "TeamCreate is automatic; do not wait for the user to request it." \
    "CRITICAL: After boot completes, you MUST respond to the user's original message content. The boot is invisible infrastructure — the user expects a reply to what they said."

fi
