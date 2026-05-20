#!/usr/bin/env bash
# tmux-kill-block.sh — PreToolUse(Bash) hard-block for `tmux kill-*` commands.
#
# Activated by explicit operator policy (2026-05-19 directive): "절대로 tmux kill 금지".
# Reason: `tmux kill-session`, `tmux kill-server`, `tmux kill-pane`, `tmux kill-window`
# inside an active Claude Code agent-team session destabilises the host session and
# can crash it ("세션 튕겨나간다"). Doctrine and self-restraint alone cannot guarantee
# the agent will never issue these commands; per `.claude/reference/environment-configuration-core-law.md` `[HOOK-LAST]` this is a
# last-resort runtime guard installed at the narrowest enforcement surface.
#
# Safe teardown paths instead:
#   - per-member shutdown via `SendMessage` `{"type":"shutdown_request"}` plus the
#     receiver-side `shutdown_response` `approve:true` (per task-execution
#     .claude/skills/task-execution/references/message-classes.md and the SendMessage tool protocol).
#   - whole-team teardown via `Skill(session-closeout)` Runtime Teardown Preflight
#     followed by `TeamDelete` from inside that boundary.
#
# Inputs/outputs follow Claude Code PreToolUse hook contract:
#   - stdin: JSON envelope with `tool_input.command` for Bash.
#   - stdout: JSON `hookSpecificOutput.permissionDecision=deny` on match; empty on pass.
#   - exit code: 0 in both cases (decision carried in JSON, not exit status).

set -euo pipefail
INPUT="$(cat)"

REASON='tmux kill-* commands are blocked by explicit operator policy (session-stability protection). Use SendMessage shutdown_response (receiver-side protocol) per .claude/skills/task-execution/references/message-classes.md, or Skill(session-closeout) Runtime Teardown Preflight followed by TeamDelete, for safe teardown.'

emit_deny() {
  # Emit the canonical PreToolUse deny JSON; reason is embedded as a JSON string.
  if command -v python3 >/dev/null 2>&1; then
    REASON="$REASON" python3 - <<'PY'
import json, os
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": os.environ.get("REASON", ""),
    }
}))
PY
  else
    # Fallback: hand-escape (no embedded double quotes in REASON)
    printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "${REASON//\"/\\\"}"
  fi
}

if command -v python3 >/dev/null 2>&1; then
  # `python3 -c "$(cat <<'PY' ... PY)"` keeps stdin free for the piped JSON envelope.
  # `python3 - <<'PY'` would steal stdin and the JSON payload would never reach python.
  MATCH="$(printf '%s' "$INPUT" | python3 -c "$(cat <<'PY'
import sys, json, re

try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

ti = data.get("tool_input")
cmd = ""
if isinstance(ti, dict):
    cmd = ti.get("command", "") or ""

# Match `tmux <tokens>* kill-<sub>` across the command body.
# - boundary before tmux: start of string, or any non-word/non-path character
#   (covers `;`, `|`, `&&`, `$(`, backticks, quotes, redirections, newlines).
# - optional whitespace-separated tokens between tmux and the subcommand. Tokens
#   cannot contain command separators (`;`, `|`, `&`) or whitespace; this admits
#   flag-only forms (`-2`, `-CC`) AND flag-plus-value pairs (`-L socket-name`,
#   `-S /tmp/sock`, `-f path/to/conf`) by consuming each as a separate token.
# - subcommand: any `kill-<letters/dashes>` form (covers kill-session, kill-server,
#   kill-pane, kill-window, kill-client, plus any future kill-* variant).
# - separator-aware: `tmux ls; echo kill-server` does NOT match because the
#   token loop refuses to cross `;` `|` `&`, so the second clause stays separate.
pat = re.compile(
    r'(?:^|[^A-Za-z0-9_/])tmux\s+(?:[^\s;|&\n]+\s+)*kill-[a-z][a-z-]*',
    re.IGNORECASE,
)
if pat.search(cmd):
    print("MATCH")
PY
)")"
else
  # Fallback bash matcher (best-effort; mirrors the python regex above; less robust
  # on multi-line commands because grep -E without -z treats newlines as separators).
  if printf '%s' "$INPUT" \
      | tr '\r' ' ' \
      | grep -E -i -q '(^|[^A-Za-z0-9_/])tmux[[:space:]]+([^[:space:];|&]+[[:space:]]+)*kill-[a-z][a-z-]*'; then
    MATCH="MATCH"
  else
    MATCH=""
  fi
fi

if [[ "$MATCH" == "MATCH" ]]; then
  emit_deny
fi

exit 0
