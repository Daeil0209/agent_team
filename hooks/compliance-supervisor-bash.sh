#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const command = (input.tool_input && input.tool_input.command) || "";
  const agentId = input.agent_id || "";
  const sessionId = input.session_id || "";
  const agentType = input.agent_type || "";
  process.stdout.write(`${command}\n${agentId}\n${sessionId}\n${agentType}\n`);
} catch {
  process.stdout.write("\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
COMMAND="${FIELDS[0]:-}"
AGENT_ID="${FIELDS[1]:-}"
SESSION_ID="${FIELDS[2]:-}"
AGENT_TYPE="${FIELDS[3]:-}"

if [[ -z "$COMMAND" ]]; then
  exit 0
fi

STRIPPED_COMMAND="$(printf '%s' "$COMMAND" | sed "s/['\"]//g")"
CLEAN_COMMAND="$(printf '%s' "$STRIPPED_COMMAND" | sed 's/#[^!].*$//')"
# Remove benign stderr/stdout suppression so non-mutating inspection commands do not trip the mutating-bash guard.
MATCH_COMMAND="$(printf '%s' "$CLEAN_COMMAND" | sed -E \
  -e 's/(^|[[:space:];|&])([0-9]+)?>>?[[:space:]]*\/dev\/null([[:space:];|&)]|$)/\1\3/g' \
  -e 's/(^|[[:space:];|&])([0-9]+)?>[[:space:]]*&[[:space:]]*[0-9-]+([[:space:];|&)]|$)/\1\3/g')"
CMD_LOG="${COMMAND%%$'\n'*}"

if printf '%s' "$CLEAN_COMMAND" | grep -v '^\s*#' | grep -qEi "$A04_DESTRUCTIVE_PATTERN"; then
  printf '[%s] A-04 BLOCKED: Destructive command: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[A-04] Destructive system command detected and blocked by safety guardrails."}}
EOF
  exit 0
fi

if [[ -n "$AGENT_ID" ]]; then
  if [[ -z "$AGENT_TYPE" ]] && [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MAP" ]]; then
    AGENT_TYPE="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  fi
  if printf '%s' "$MATCH_COMMAND" | grep -qEi "$MAIN_MUTATING_BASH_PATTERN"; then
    case "$AGENT_TYPE" in
      researcher)
        printf '[%s] RESEARCHER-BASH BLOCKED: Mutating Bash from researcher: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
        cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Researcher is a read-only evidence lane. Use Bash only for inspection or observation, not mutating commands."}}
EOF
        exit 0
        ;;
      reviewer)
        printf '[%s] REVIEWER-BASH BLOCKED: Mutating Bash from reviewer: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
        cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Reviewer is a read-only acceptance lane. Use Bash only for inspection, rendering, or observation, not mutating commands."}}
EOF
        exit 0
        ;;
      validator)
        printf '[%s] VALIDATOR-BASH BLOCKED: Mutating Bash from validator: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
        cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Validator is a read-only final validation lane. Use Bash only for inspection or observation, not mutating commands."}}
EOF
        exit 0
        ;;
    esac
  fi
  exit 0
fi

if printf '%s' "$COMMAND" | grep -v '^\s*#' | grep -qE "$S02_DIAGNOSTIC_PATTERN"; then
  printf '[%s] S-02 BLOCKED: Diagnostic command from supervisor: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"S-02 VIOLATION: Main session must delegate diagnostic commands to the researcher worker."}}
EOF
  exit 0
fi

if [[ -z "$AGENT_ID" ]]; then
  if printf '%s' "$CLEAN_COMMAND" | grep -q 'inspect-repo-context\.sh'; then
    REPO_ROOT_CANONICAL="$(realpath -m "$(resolve_project_root)" 2>/dev/null || resolve_project_root)"
    CD_TARGET="$(printf '%s' "$CLEAN_COMMAND" | sed -nE 's/.*(^|[[:space:];|&])cd[[:space:]]+([^[:space:];|&]+).*/\2/p' | head -n1)"
    if [[ -n "$CD_TARGET" ]]; then
      CD_TARGET_CANONICAL="$(realpath -m "$CD_TARGET" 2>/dev/null || printf '%s' "$CD_TARGET")"
      if [[ "$CD_TARGET_CANONICAL" != "$REPO_ROOT_CANONICAL" ]]; then
        printf '[%s] MAIN-REPO-ANCHOR BLOCKED: inspect-repo-context from %s (expected %s)\n' \
          "$(date '+%Y-%m-%d %H:%M:%S')" \
          "${CD_TARGET_CANONICAL:0:200}" \
          "${REPO_ROOT_CANONICAL:0:200}" >> "$VIOLATION_LOG"
        cat <<EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Boot repo-context inspection must start from the active project repo root ($REPO_ROOT_CANONICAL). Do not guess repo paths from team names, team directories, or prior sessions."}}
EOF
        exit 0
      fi
    fi
  fi

  if printf '%s' "$CLEAN_COMMAND" | grep -qEi "$REPO_GIT_INSPECTION_PATTERN"; then
    if printf '%s' "$CLEAN_COMMAND" | grep -qEi "$GLOBAL_CONTROL_SURFACE_CD_PATTERN"; then
      printf '[%s] MAIN-GIT-CONTEXT BLOCKED: Global control surface used for repo git inspection: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${CMD_LOG:0:200}" >> "$VIOLATION_LOG"
      cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Repository git inspection must stay anchored to the active project repo root. Do not run git log/status/branch/remote from $HOME or $HOME/.claude; use the session cwd or git rev-parse --show-toplevel first."}}
EOF
      exit 0
    fi
  fi
fi

# Exempt only the explicit runtime helper scripts that the lead may call as orchestration aids.
# Do not exempt arbitrary writes under .claude/hooks or .claude/logs, because that would reopen direct
# main-thread mutation of hook code and runtime state.
SUPERVISOR_EXEMPT_PATTERN='(health-check\.sh|cleanup-orphan-runtime\.sh|runtime-pressure-scan\.sh|mark-(release|standby|complete|force-stop|health-cron-rotation|health-cron-job|closeout-intent)\.sh|clear-(health-cron-rotation|health-cron-job|closeout-intent)\.sh)'

exit 0
