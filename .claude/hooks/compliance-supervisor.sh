#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"
SESSION_ID_RAW="$(INPUT_JSON="$INPUT" node -e "
try {
  const input = JSON.parse(process.env.INPUT_JSON || '{}');
  process.stdout.write(String(input.session_id || ''));
} catch { process.stdout.write(''); }
" 2>/dev/null || printf '')"
SESSION_ID="$(recover_session_id "$SESSION_ID_RAW" 2>/dev/null || printf '')"

emit_deny() {
  local reason="${1:?reason required}"
  DENY_REASON="$reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Blocked by project compliance policy."
  }
}));
NODE
}

log_violation() {
  local tool="${1:-unknown}" path_hint="${2:-}" reason="${3:-}"
  local log_dir="${LOG_DIR:-${HOME}/.claude/logs}"
  mkdir -p "$log_dir" 2>/dev/null || return 0
  {
    printf '[%s] COMPLIANCE-DENIED tool=%s path=%s reason=%s\n' \
      "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      "$tool" "$path_hint" "$reason" \
      >> "${log_dir}/compliance-violations.log"
  } 2>/dev/null || true
}

is_governance_surface_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1

  case "$candidate_path" in
    */.claude/*) return 0 ;;
    *) return 1 ;;
  esac
}

is_high_traffic_governance_surface_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1

  case "$candidate_path" in
    */.claude/CLAUDE.md|*/.claude/settings.json|*/.claude/settings.*.json|*/.claude/agents/*|*/.claude/hooks/*|*/.claude/rules/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

strip_read_only_null_redirections() {
  local command_text="${1-}"
  printf '%s' "$command_text" | sed -E '
    s@(^|[[:space:]])&>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])[0-9]*>>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])[0-9]*>[[:space:]]*/dev/null([[:space:];|&)]|$)@ @g;
    s@(^|[[:space:]])2>&1([[:space:];|&)]|$)@ @g;
  '
}

allowed_package_or_build_command() {
  local command_text="${1-}"
  [[ -n "$command_text" ]] || return 1

  if printf '%s' "$command_text" | grep -qE '(^|[[:space:]])[^[:space:]]*\.claude/|/\.claude/'; then
    return 1
  fi

  printf '%s' "$command_text" | grep -Eiq '^[[:space:]]*((npm|pnpm|yarn)[[:space:]]+(install|ci|add|remove|run[[:space:]]+(build|test|lint|typecheck))|(uv|python[0-9.]*[[:space:]]+-m[[:space:]]+pip|pip|pip3)[[:space:]]+(install|uninstall|sync|lock|check|freeze|show|list)|make[[:space:]]+([[:alnum:]_.-]+)|cargo[[:space:]]+(build|test|check)|go[[:space:]]+(build|test)|npm[[:space:]]+run[[:space:]]+build)([[:space:]].*)?$'
}

# Destructive sub-command pattern — mirrors the destructive check below for
# per-sub-command validation inside validate_compound_command.
_DESTRUCTIVE_SUBCMD_PATTERN='(^|[[:space:]])git[[:space:]]+reset[[:space:]]+--hard([[:space:]]|$)|(^|[[:space:]])mkfs\.|(^|[[:space:]])dd[[:space:]]+if=|(^|[[:space:]])rm[[:space:]]+-rf[[:space:]]+/([[:space:]]|$)'
_MUTATING_SUBCMD_PATTERN='(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])(sed|perl)[[:space:]]+-i([[:space:]]|$)|>>?|(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push)([[:space:]]|$)'

# validate_compound_command: split cmd on &&/||/; and validate each sub-command.
# denylist-first behavior: fail only when a sub-command is destructive or clearly mutating
# and not accepted by the specific check_fn. Read-only sub-commands may co-exist inside the
# compound command without being enumerated in every allowlist.
validate_compound_command() {
  local cmd="$1"
  local check_fn="$2"
  local subcmd
  while IFS= read -r subcmd; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    if printf '%s' "$subcmd" | grep -Eiq "$_DESTRUCTIVE_SUBCMD_PATTERN"; then
      return 1
    fi
    if "$check_fn" "$subcmd"; then
      continue
    fi
    if printf '%s' "$subcmd" | grep -Eiq "$_MUTATING_SUBCMD_PATTERN"; then
      return 1
    fi
  done < <(printf '%s' "$cmd" | sed 's/&&/\n/g; s/||/\n/g; s/;/\n/g')
  return 0
}

# Allowlist wrappers used as check_fn arguments to validate_compound_command.
# GIT_READONLY_PATTERN, S02_IMPLEMENTATION_PATTERN, and LEAD_OPERATIONAL_ALLOWLIST
# are set in the Bash case block before these wrappers are called.
allowed_git_readonly_subcmd() {
  local sanitized
  sanitized="$(strip_read_only_null_redirections "$1")"
  printf '%s' "$sanitized" | grep -qE "$GIT_READONLY_PATTERN" 2>/dev/null
}

allowed_worker_impl_subcmd() {
  printf '%s' "$1" | grep -qE "$S02_IMPLEMENTATION_PATTERN" 2>/dev/null
}

allowed_lead_operational_subcmd() {
  local subcmd="${1-}"
  local trimmed="${subcmd#"${subcmd%%[![:space:]]*}"}"
  local pat
  for pat in "${LEAD_OPERATIONAL_ALLOWLIST[@]}"; do
    if [[ "$trimmed" == "${pat}"* ]]; then
      return 0
    fi
  done
  return 1
}

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const filePath = String(toolInput.file_path || toolInput.path || "");
  const command = String(toolInput.command || "");
  process.stdout.write(`${toolName}\n${filePath}\n${command}\n`);
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
TOOL_NAME="${FIELDS[0]:-}"
FILE_PATH="${FIELDS[1]:-}"
COMMAND="${FIELDS[2]:-}"

CANONICAL_PATH=""
if [[ -n "$FILE_PATH" ]]; then
  CANONICAL_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || printf '%s' "$FILE_PATH")"
fi

case "$TOOL_NAME" in
  Edit|MultiEdit|Write|NotebookEdit)
    if [[ -n "$CANONICAL_PATH" ]]; then
      BASENAME="$(basename "$CANONICAL_PATH" 2>/dev/null || printf '%s' "$CANONICAL_PATH")"
      if [[ "$CANONICAL_PATH" == */references/* ]]; then
        emit_deny "Reference materials under ./references are read-only. Copy them to a working location before modifying them."
        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "references-readonly" || true
        exit 0
      fi

      case "$BASENAME" in
        .env|.env.*|credentials.json|*.pem|*.key)
          emit_deny "Direct edits to credential or secret files are blocked in this project."
          log_violation "$TOOL_NAME" "$CANONICAL_PATH" "credential-file" || true
          exit 0
          ;;
      esac

      if is_governance_surface_path "$CANONICAL_PATH"; then
        if procedure_state_target_exact "$CANONICAL_PATH"; then
          case "$TOOL_NAME" in
            Write|NotebookEdit)
              emit_deny "Procedure state must not be overwritten wholesale. Use exact structured Edit or MultiEdit checkpoint updates for .claude/state/procedure-state.json."
              log_violation "$TOOL_NAME" "$CANONICAL_PATH" "procedure-state-wholesale-write" || true
              exit 0
              ;;
          esac
        fi

        if is_high_traffic_governance_surface_path "$CANONICAL_PATH"; then
          case "$TOOL_NAME" in
            Write|NotebookEdit)
              emit_deny "High-traffic governance surfaces under .claude must not be overwritten wholesale. Use structured Edit or MultiEdit changes so governance intent remains reviewable."
              log_violation "$TOOL_NAME" "$CANONICAL_PATH" "governance-wholesale-write" || true
              exit 0
              ;;
          esac
        fi
      fi
    fi
    ;;

  Bash)
    CLEAN_COMMAND="$(printf '%s' "$COMMAND" | tr '\n' ' ')"
    # Governance surface protection is unconditional — runs before any session-type allowlist.
    # This ensures worker sessions cannot bypass governance-surface protection via pattern match.
    if printf '%s' "$CLEAN_COMMAND" | grep -qE '(^|[[:space:]])[^[:space:]]*\.claude/|/\.claude/'; then
      if printf '%s' "$CLEAN_COMMAND" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|sed[[:space:]]+-i([[:space:]]|$)|perl[[:space:]]+-i([[:space:]]|$)'; then
        emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit or MultiEdit changes so policy and hook edits remain reviewable."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation-early" || true
        exit 0
      fi
    fi
    if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
      if validate_compound_command "$CLEAN_COMMAND" allowed_package_or_build_command; then
        exit 0
      fi
    else
      if allowed_package_or_build_command "$CLEAN_COMMAND"; then
        exit 0
      fi
    fi
    SANITIZED_COMMAND="$(strip_read_only_null_redirections "$CLEAN_COMMAND")"

    GIT_READONLY_PATTERN='git[[:space:]]+(status|log|diff|show|branch[[:space:]]*(-[lva]|--list)|describe|ls-files|ls-tree|rev-parse|cat-file|remote[[:space:]]+(-v|--verbose))([[:space:]]|$)'
    if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
      if validate_compound_command "$CLEAN_COMMAND" allowed_git_readonly_subcmd; then
        exit 0
      fi
    else
      if printf '%s' "$SANITIZED_COMMAND" | grep -qE "$GIT_READONLY_PATTERN" 2>/dev/null; then
        exit 0
      fi
    fi

    if printf '%s' "$CLEAN_COMMAND" | grep -Eiq '(^|[[:space:]])git[[:space:]]+reset[[:space:]]+--hard([[:space:]]|$)|(^|[[:space:]])mkfs\.|(^|[[:space:]])dd[[:space:]]+if=|(^|[[:space:]])rm[[:space:]]+-rf[[:space:]]+/([[:space:]]|$)'; then
      emit_deny "Destructive shell command blocked. Use a safer bounded command or obtain explicit user approval first."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "destructive-shell" || true
      exit 0
    fi

    # V-06 fix: Allow worker sessions to run diagnostic/test patterns.
    # Developer implementation commands — allowed for worker sessions
    # E-20 fix: moved AFTER destructive command check to prevent compound-command bypass.
    S02_IMPLEMENTATION_PATTERN='(^|[[:space:]])(git[[:space:]]+(add|commit|status|log|diff|show|branch|tag|stash|fetch|clone)|(mkdir|touch|cp|chmod)[[:space:]]|npm[[:space:]]+(run|test|build|install)|pip[[:space:]]+(install|freeze)|python[[:space:]]|python3[[:space:]]|node[[:space:]]|npx[[:space:]]|tsc[[:space:]]|curl[[:space:]]|make[[:space:]]|cargo[[:space:]]|go[[:space:]]+(build|test|run)|diff[[:space:]]|wc[[:space:]]|sort[[:space:]]|pytest|jest|mocha)([[:space:]]|$)'
    if [[ -n "$SESSION_ID" ]] && runtime_sender_session_is_worker "$SESSION_ID" 2>/dev/null; then
      if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
        if validate_compound_command "$CLEAN_COMMAND" allowed_worker_impl_subcmd; then
          exit 0
        fi
      else
        if printf '%s' "$CLEAN_COMMAND" | grep -qE "$S02_IMPLEMENTATION_PATTERN" 2>/dev/null; then
          exit 0
        fi
      fi
    fi

    # E-9: Lead session operational allowlist — basic git and filesystem operations.
    # Runs AFTER destructive command check and AFTER governance surface mutation check.
    # Bypasses only the general mutable-Bash block; safety-critical checks above still apply.
    LEAD_OPERATIONAL_ALLOWLIST=(
        "git commit"
        "git push"
        "git checkout"
        "git merge"
        "git add"
        "git stash"
        "git pull"
        "mkdir"
        "touch "
        "cp "
        "mv "
        "ln "
        "node "
        "python "
        "python3 "
        "npx "
        "tsc "
        "curl "
        "chmod "
    )

    # Check if this is an allowlisted operational command (prefix match only).
    # Substring match is intentionally avoided: a compound command such as
    # "rm /important && git commit" would match "git commit" anywhere in the
    # string and bypass the mutable-command block below — a compliance bypass.
    TRIMMED_LEAD_CMD="${CLEAN_COMMAND#"${CLEAN_COMMAND%%[![:space:]]*}"}"
    if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
      if validate_compound_command "$CLEAN_COMMAND" allowed_lead_operational_subcmd; then
        exit 0
      fi
    else
      for allowed_pattern in "${LEAD_OPERATIONAL_ALLOWLIST[@]}"; do
          if [[ "$TRIMMED_LEAD_CMD" == "${allowed_pattern}"* ]]; then
              exit 0  # Permit allowlisted operational command
          fi
      done
    fi

    if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push)([[:space:]]|$)|(^|[[:space:]])sed[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]])perl[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]]):[[:space:]]*>|[[:space:]]>[[:space:]]*[^[:space:]]'; then
      if printf '%s' "$SANITIZED_COMMAND" | grep -qE '(^|[[:space:]])[^[:space:]]*\.claude/|/\.claude/'; then
        emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit or MultiEdit changes so policy and hook edits remain reviewable."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation" || true
        exit 0
      fi
      emit_deny "Mutable shell command blocked. Read-only Bash discovery is allowed, but file-changing shell actions require a safer tool path or explicit authorization."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "mutable-shell" || true
      exit 0
    fi

    if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])find([[:space:]]|$).*([[:space:]]-delete([[:space:]]|$)|[[:space:]]-exec([[:space:]]|$)|[[:space:]]-execdir([[:space:]]|$))'; then
      emit_deny "Mutable find actions are blocked. Use find only for read-only discovery."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "mutable-find" || true
      exit 0
    fi

    if printf '%s' "$SANITIZED_COMMAND" | grep -q 'references/'; then
      if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])(cp|mv|rm|install|tee)([[:space:]]|$)|sed[[:space:]]+-i|perl[[:space:]]+-i'; then
        emit_deny "Reference materials under ./references must not be modified in place."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "references-shell-mutation" || true
        exit 0
      fi
    fi
    ;;
esac

exit 0
