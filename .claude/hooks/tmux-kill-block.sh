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
#   - per-member shutdown via `SendMessage` `{"type":"shutdown_request"}`
#     to the exact live member selected by the runtime cleanup owner (per
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

REASON='tmux kill-* commands are blocked by session-stability policy. Use structured shutdown_request for selected live members or TeamDelete after termination proof.'

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
import sys, json, re, shlex

try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

ti = data.get("tool_input")
cmd = ""
if isinstance(ti, dict):
    cmd = ti.get("command", "") or ""

kill_subcommand = re.compile(r'^kill-[a-z][a-z-]*$', re.IGNORECASE)
separators = {';', '|', '||', '&&', '&'}
tmux_value_opts = {'-L', '-S', '-f', '-c'}

def tokenize(shell_cmd):
    lex = shlex.shlex(shell_cmd, posix=True, punctuation_chars=True)
    lex.whitespace_split = True
    lex.commenters = ''
    return list(lex)

def command_segments(tokens):
    seg = []
    for tok in tokens + [';']:
        if tok in separators:
            if seg:
                yield seg
                seg = []
        else:
            seg.append(tok)

def skip_command_prefix(seg, i):
    while i < len(seg) and re.match(r'^[A-Za-z_][A-Za-z0-9_]*=.*$', seg[i]):
        i += 1
    if i < len(seg) and seg[i] in {'command', 'exec'}:
        i += 1
    if i < len(seg) and seg[i] == 'sudo':
        i += 1
        while i < len(seg) and seg[i].startswith('-'):
            opt = seg[i]
            i += 1
            if opt in {'-u', '-g', '-h', '-p', '-C', '-T'} and i < len(seg):
                i += 1
    return i

def tmux_segment_is_kill(seg):
    i = skip_command_prefix(seg, 0)
    if i >= len(seg) or seg[i] != 'tmux':
        return False
    i += 1
    while i < len(seg) and seg[i].startswith('-'):
        opt = seg[i]
        i += 1
        if opt in tmux_value_opts and i < len(seg):
            i += 1
    return i < len(seg) and bool(kill_subcommand.match(seg[i]))

def shell_c_segment_is_kill(seg):
    i = skip_command_prefix(seg, 0)
    if i >= len(seg) or seg[i] not in {'sh', 'bash', 'zsh'}:
        return False
    i += 1
    while i < len(seg) and seg[i].startswith('-'):
        opt = seg[i]
        i += 1
        if 'c' in opt.lstrip('-') and i < len(seg):
            return contains_tmux_kill(seg[i])
    return False

def contains_tmux_kill(shell_cmd):
    try:
        tokens = tokenize(shell_cmd)
    except Exception:
        return False
    return any(tmux_segment_is_kill(seg) or shell_c_segment_is_kill(seg) for seg in command_segments(tokens))

if contains_tmux_kill(cmd):
    print("MATCH")
PY
)")"
else
  # Fallback bash matcher (best-effort; requires tmux to start a command segment).
  if printf '%s' "$INPUT" \
      | tr '\r' ' ' \
      | grep -E -i -q '(^|[;|&][[:space:]]*)tmux[[:space:]]+([^[:space:];|&]+[[:space:]]+)*kill-[a-z][a-z-]*'; then
    MATCH="MATCH"
  else
    MATCH=""
  fi
fi

if [[ "$MATCH" == "MATCH" ]]; then
  emit_deny
fi

exit 0
