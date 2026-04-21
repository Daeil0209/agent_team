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

is_governance_restricted_write_path() {
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

strip_full_line_shell_comments() {
  local command_text="${1-}"
  printf '%s' "$command_text" | sed '/^[[:space:]]*#/d'
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
split_compound_command() {
  local cmd="${1-}"

  COMMAND_TEXT="$cmd" node <<'NODE'
const command = String(process.env.COMMAND_TEXT || "");
for (const part of command.split(/&&|\|\||;/)) {
  const trimmed = part.trim();
  if (trimmed) console.log(trimmed);
}
NODE
}

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
  done < <(split_compound_command "$cmd")
  return 0
}

subcommand_targets_governance_surface() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1
  printf '%s' "$subcmd" | grep -qE '(^|[[:space:]])[^[:space:]]*\.claude/|/\.claude/'
}

subcommand_is_mutating_shell() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1
  printf '%s' "$subcmd" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])(sed|perl)[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]]):[[:space:]]*>|[[:space:]]>[[:space:]]*[^[:space:]]'
}

command_mutates_governance_surface() {
  local cmd="${1-}"
  local subcmd=""
  [[ -n "$cmd" ]] || return 1

  while IFS= read -r subcmd; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    if subcommand_targets_governance_surface "$subcmd"; then
      if subcommand_is_git_index_hygiene "$subcmd"; then
        return 0
      fi
      if subcommand_is_mutating_shell "$subcmd"; then
        return 0
      fi
    fi
  done < <(split_compound_command "$cmd")

  return 1
}

subcommand_is_git_index_hygiene() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1
  printf '%s' "$subcmd" | grep -Eiq '^[[:space:]]*git[[:space:]]+rm([[:space:]]+[^[:space:]]+)*[[:space:]]+--cached([[:space:]]|$)|^[[:space:]]*git[[:space:]]+update-index([[:space:]]+[^[:space:]]+)*[[:space:]]+--(force-remove|remove)([[:space:]]|$)|^[[:space:]]*git[[:space:]]+restore([[:space:]]+[^[:space:]]+)*[[:space:]]+--staged([[:space:]]|$)'
}

subcommand_targets_repo_test_surface_only() {
  local subcmd="${1-}"
  local project_root=""
  [[ -n "$subcmd" ]] || return 1

  project_root="$(resolve_project_root)"
  COMMAND_TEXT="$subcmd" PROJECT_ROOT="$project_root" node <<'NODE'
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const root = String(process.env.PROJECT_ROOT || process.cwd());

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";

  for (let index = 0; index < text.length; index += 1) {
    const ch = text[index];
    if (quote) {
      if (ch === quote) {
        quote = "";
      } else if (ch === "\\" && quote === '"' && index + 1 < text.length) {
        current += text[++index];
      } else {
        current += ch;
      }
      continue;
    }

    if (ch === '"' || ch === "'") {
      quote = ch;
      continue;
    }

    if (/\s/.test(ch)) {
      if (current) {
        words.push(current);
        current = "";
      }
      continue;
    }

    current += ch;
  }

  if (quote) return null;
  if (current) words.push(current);
  return words;
}

const words = tokenize(command);
if (!words || words.length === 0) process.exit(1);

const reserved = new Set([
  "git",
  "rm",
  "update-index",
  "restore",
  "HEAD",
  "--",
  "--cached",
  "--staged",
  "--force-remove",
  "--remove",
]);

const candidates = words.filter((word) => {
  const trimmed = word.replace(/^['"]|['"]$/g, "");
  if (!trimmed || trimmed.startsWith("-") || reserved.has(trimmed)) return false;
  return trimmed.includes("/") || trimmed.startsWith("tests");
});

if (candidates.length === 0) process.exit(1);

const ok = candidates.every((candidate) => {
  const trimmed = candidate.replace(/^['"]|['"]$/g, "");
  const resolved = path.resolve(root, trimmed);
  const relative = path.relative(root, resolved).replace(/\\/g, "/");
  return relative.startsWith("tests/claude-hooks/");
});

process.exit(ok ? 0 : 1);
NODE
}

command_is_allowed_repo_test_index_hygiene() {
  local cmd="${1-}"
  local subcmd=""
  [[ -n "$cmd" ]] || return 1

  while IFS= read -r subcmd; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    subcommand_is_git_index_hygiene "$subcmd" || return 1
    subcommand_targets_repo_test_surface_only "$subcmd" || return 1
  done < <(split_compound_command "$cmd")

  return 0
}

command_removes_team_runtime_dir() {
  local cmd="${1-}"
  local team_rm_pattern=""
  [[ -n "$cmd" ]] || return 1

  team_rm_pattern="(^|[[:space:];|&])rm([[:space:]]+-[A-Za-z0-9_-]+)*[[:space:]]+(--[[:space:]]+)?([^;|&[:space:]]+[[:space:]]+)*['\"]?((~|[$]HOME|/home/[^/[:space:]'\"]+)/[.]claude/teams)(/[^[:space:];|&'\"]*)?['\"]?([[:space:];|&]|$)"
  [[ "$cmd" =~ $team_rm_pattern ]]
}

command_uses_interpreter_fs_mutation() {
  local cmd="${1-}"
  local trimmed=""
  [[ -n "$cmd" ]] || return 1

  trimmed="${cmd#"${cmd%%[![:space:]]*}"}"
  if ! printf '%s' "$trimmed" | grep -Eiq '^([^[:space:]/]+/)?(node|nodejs|python([0-9]+([.][0-9]+)?)?)([[:space:]]|$)'; then
    return 1
  fi

  if printf '%s' "$cmd" | grep -Eiq "([^[:alnum:]_.]|^)(fs[.])?(rmSync|rm|rmdirSync|rmdir|unlinkSync|unlink|writeFileSync|writeFile|appendFileSync|appendFile|renameSync|rename|cpSync|cp|copyFileSync|copyFile|mkdirSync|mkdir|chmodSync|chmod|chownSync|chown|truncateSync|truncate|createWriteStream|openSync)[[:space:]]*[(]"; then
    return 0
  fi
  if printf '%s' "$cmd" | grep -Eiq "require[[:space:]]*[(][[:space:]]*['\"]fs['\"][[:space:]]*[)][[:space:]]*[.][[:space:]]*(rmSync|rm|rmdirSync|unlinkSync|unlink|writeFileSync|writeFile|appendFileSync|appendFile|renameSync|rename|cpSync|cp|copyFileSync|copyFile|mkdirSync|mkdir|chmodSync|chmod|chownSync|chown|truncateSync|truncate|createWriteStream|openSync)[[:space:]]*[(]"; then
    return 0
  fi
  if printf '%s' "$cmd" | grep -Eiq "(child_process|execSync|exec|spawnSync|spawn).*['\"][^'\"]*(^|[^[:alnum:]_])(rm|mv|cp|touch|mkdir|chmod|chown|tee|sed[[:space:]]+-i|perl[[:space:]]+-i|git[[:space:]]+(reset|clean|checkout|restore|push))([^[:alnum:]_]|$)"; then
    return 0
  fi
  if printf '%s' "$cmd" | grep -Eiq "(shutil[.]rmtree|os[.](remove|unlink|rmdir|rename|replace)|Path[(][^)]*[)][.](unlink|rmdir|write_text|write_bytes|rename|replace)|[.]write_text[[:space:]]*[(]|[.]write_bytes[[:space:]]*[(]|open[[:space:]]*[(][^)]*,[[:space:]]*['\"][wa+]|subprocess[.](run|call|Popen|check_call|check_output).*['\"][^'\"]*(^|[^[:alnum:]_])(rm|mv|cp|touch|mkdir|chmod|chown|tee|sed[[:space:]]+-i|perl[[:space:]]+-i|git[[:space:]]+(reset|clean|checkout|restore|push))([^[:alnum:]_]|$))"; then
    return 0
  fi

  return 1
}

bounded_generated_cleanup_command() {
  local cmd="${1-}"
  local project_root=""
  [[ -n "$cmd" ]] || return 1

  project_root="$(resolve_project_root)"
  COMMAND_TEXT="$cmd" PROJECT_ROOT="$project_root" node "$HOOK_LIB_DIR/generated-command-policy.js" cleanup
}

bounded_generated_reset_scaffold_command() {
  local cmd="${1-}"
  local project_root=""
  [[ -n "$cmd" ]] || return 1

  project_root="$(resolve_project_root)"
  COMMAND_TEXT="$cmd" PROJECT_ROOT="$project_root" node "$HOOK_LIB_DIR/generated-command-policy.js" reset-scaffold
}

user_approved_delete_command() {
  local cmd="${1-}"
  [[ -n "$cmd" && -s "$USER_APPROVED_DELETE_ROOTS_FILE" ]] || return 1

  COMMAND_TEXT="$cmd" \
  APPROVED_ROOTS_FILE="$USER_APPROVED_DELETE_ROOTS_FILE" \
  WORKSPACE_ROOT="$(resolve_project_root)" \
  node <<'NODE'
const fs = require("fs");
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const rootsFile = String(process.env.APPROVED_ROOTS_FILE || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";
  for (let index = 0; index < text.length; index += 1) {
    const ch = text[index];
    if (quote) {
      if (ch === quote) quote = "";
      else if (ch === "\\" && quote === '"' && index + 1 < text.length) current += text[++index];
      else current += ch;
      continue;
    }
    if (ch === '"' || ch === "'") {
      quote = ch;
      continue;
    }
    if (/\s/.test(ch)) {
      if (current) {
        words.push(current);
        current = "";
      }
      continue;
    }
    current += ch;
  }
  if (quote) return null;
  if (current) words.push(current);
  return words;
}

if (!command.trim() || /[|;&<>`$*?[\]{}]/.test(command)) process.exit(1);
const words = tokenize(command);
if (!words || words.length < 3 || words[0] !== "rm") process.exit(1);

let sawRecursive = false;
let sawForce = false;
const targets = [];
for (let index = 1; index < words.length; index += 1) {
  const word = words[index];
  if (word === "--") continue;
  if (word.startsWith("-")) {
    if (!/^-+[rf]+$/.test(word)) process.exit(1);
    if (word.includes("r")) sawRecursive = true;
    if (word.includes("f")) sawForce = true;
    continue;
  }
  targets.push(path.resolve(word));
}
if (!sawRecursive || !sawForce || targets.length !== 1) process.exit(1);

let approved = [];
try {
  approved = fs.readFileSync(rootsFile, "utf8")
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter(Boolean)
    .map((line) => path.resolve(line));
} catch {
  process.exit(1);
}

const target = targets[0];
const relative = path.relative(workspaceRoot, target).replace(/\\/g, "/");
if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) process.exit(1);
if (
  relative === "." ||
  relative === "" ||
  relative === ".claude" ||
  relative.startsWith(".claude/") ||
  relative === ".git" ||
  relative.startsWith(".git/") ||
  relative === "references" ||
  relative.startsWith("references/")
) process.exit(1);
if (!approved.includes(target)) process.exit(1);

process.exit(0);
NODE
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
  local sanitized="${1-}"
  printf '%s' "$sanitized" | grep -qE "$S02_IMPLEMENTATION_PATTERN" 2>/dev/null || return 1

  if printf '%s' "$sanitized" | grep -Eiq '^[[:space:]]*(mkdir|touch|cp|chmod)([[:space:]]|$)'; then
    worker_impl_fs_paths_within_workspace "$sanitized" || return 1
  fi

  return 0
}

worker_impl_fs_paths_within_workspace() {
  local subcmd="${1-}"
  local workspace_root=""
  [[ -n "$subcmd" ]] || return 1

  workspace_root="$(resolve_project_root)"
  COMMAND_TEXT="$subcmd" WORKSPACE_ROOT="$workspace_root" node <<'NODE'
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "").trim();
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));

function tokenize(text) {
  const words = [];
  let current = "";
  let quote = "";

  for (let index = 0; index < text.length; index += 1) {
    const ch = text[index];
    if (quote) {
      if (ch === quote) {
        quote = "";
      } else if (ch === "\\" && quote === '"' && index + 1 < text.length) {
        current += text[++index];
      } else {
        current += ch;
      }
      continue;
    }

    if (ch === '"' || ch === "'") {
      quote = ch;
      continue;
    }

    if (/\s/.test(ch)) {
      if (current) {
        words.push(current);
        current = "";
      }
      continue;
    }

    current += ch;
  }

  if (quote) return null;
  if (current) words.push(current);
  return words;
}

function insideWorkspace(candidate) {
  if (!candidate) return false;
  if (/^[~$]/.test(candidate)) return false;
  if (/[`|;&<>{}]/.test(candidate)) return false;
  const resolved = path.resolve(workspaceRoot, candidate);
  const relative = path.relative(workspaceRoot, resolved).replace(/\\/g, "/");
  return relative === "" || (!relative.startsWith("..") && !path.isAbsolute(relative));
}

const words = tokenize(command);
if (!words || words.length < 2) process.exit(1);

const verb = words[0];
let paths = [];

if (verb === "mkdir" || verb === "touch") {
  for (let index = 1; index < words.length; index += 1) {
    const word = words[index];
    if (word === "--") continue;
    if (word.startsWith("-")) continue;
    paths.push(word);
  }
  if (!paths.length) process.exit(1);
} else if (verb === "chmod") {
  const filtered = [];
  for (let index = 1; index < words.length; index += 1) {
    const word = words[index];
    if (word === "--") continue;
    if (word.startsWith("-")) continue;
    filtered.push(word);
  }
  if (filtered.length < 2) process.exit(1);
  paths = filtered.slice(1);
} else if (verb === "cp") {
  let targetDirectory = "";
  const positional = [];

  for (let index = 1; index < words.length; index += 1) {
    const word = words[index];
    if (word === "--") continue;
    if (word === "-t" || word === "--target-directory") {
      if (index + 1 >= words.length) process.exit(1);
      targetDirectory = words[++index];
      continue;
    }
    if (word.startsWith("--target-directory=")) {
      targetDirectory = word.slice("--target-directory=".length);
      continue;
    }
    if (word.startsWith("-")) continue;
    positional.push(word);
  }

  if (targetDirectory) {
    paths = [targetDirectory];
  } else {
    if (positional.length < 2) process.exit(1);
    paths = [positional[positional.length - 1]];
  }
} else {
  process.exit(0);
}

if (!paths.every(insideWorkspace)) process.exit(1);
process.exit(0);
NODE
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

allowed_safe_git_repo_recovery_subcmd() {
  local sanitized
  sanitized="$(strip_read_only_null_redirections "${1-}")"
  [[ -n "$sanitized" ]] || return 1

  # Minimal repo-recovery allowance: clearing a stale Git index lock is
  # bounded, local, and does not mutate governance surfaces.
  printf '%s' "$sanitized" | grep -Eiq '^[[:space:]]*rm([[:space:]]+-f)?[[:space:]]+((\./)?\.git/index\.lock|[^[:space:]]*/\.git/index\.lock)[[:space:]]*$'
}

allowed_lead_context_subcmd() {
  local subcmd="${1-}"

  if allowed_lead_operational_subcmd "$subcmd"; then
    return 0
  fi

  if allowed_git_readonly_subcmd "$subcmd"; then
    return 0
  fi

  if allowed_safe_git_repo_recovery_subcmd "$subcmd"; then
    return 0
  fi

  return 1
}

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const filePath = String(toolInput.file_path || toolInput.path || "");
  const command = String(toolInput.command || "");
  process.stdout.write([toolName, filePath, command].map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
FILE_PATH="$(decode_field "${FIELDS[1]:-}")"
COMMAND="$(decode_field "${FIELDS[2]:-}")"

CANONICAL_PATH=""
if [[ -n "$FILE_PATH" ]]; then
  CANONICAL_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || printf '%s' "$FILE_PATH")"
fi

case "$TOOL_NAME" in
  Edit|Update|MultiEdit|Write|NotebookEdit)
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
              emit_deny "Procedure state must not be overwritten wholesale. Use exact structured Edit, Update, or MultiEdit checkpoint updates for .claude/state/procedure-state.json."
              log_violation "$TOOL_NAME" "$CANONICAL_PATH" "procedure-state-wholesale-write" || true
              exit 0
              ;;
          esac
        fi

        if is_governance_restricted_write_path "$CANONICAL_PATH"; then
          case "$TOOL_NAME" in
            Write|NotebookEdit)
              emit_deny "High-traffic governance surfaces under .claude must not be overwritten wholesale. Use structured Edit, Update, or MultiEdit changes so governance intent remains reviewable."
              log_violation "$TOOL_NAME" "$CANONICAL_PATH" "governance-wholesale-write" || true
              exit 0
              ;;
          esac
        fi
      fi
    fi
    ;;

  Bash)
    CLEAN_COMMAND="$(strip_full_line_shell_comments "$COMMAND" | tr '\n' ' ')"
    if command_removes_team_runtime_dir "$CLEAN_COMMAND"; then
      emit_deny "Team runtime directory cleanup must use TeamDelete, not shell rm. Verify live-worker state first; if only stale residue remains, use TeamDelete or report the exact residual state."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "team-runtime-shell-delete" || true
      exit 0
    fi
    # Governance surface protection is unconditional — runs before any session-type allowlist.
    # This ensures worker sessions cannot bypass governance-surface protection via pattern match.
    if command_mutates_governance_surface "$CLEAN_COMMAND"; then
      emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit, Update, or MultiEdit changes so policy and hook edits remain reviewable."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation-early" || true
      exit 0
    fi
    if command_uses_interpreter_fs_mutation "$CLEAN_COMMAND"; then
      emit_deny "Interpreter-based filesystem mutation is blocked. Use structured file tools for edits or the bounded generated-output cleanup path for approved cleanup roots."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "interpreter-fs-mutation" || true
      exit 0
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
    if user_approved_delete_command "$CLEAN_COMMAND"; then
      exit 0
    fi
    if printf '%s' "$CLEAN_COMMAND" | grep -Eiq '(^|[[:space:];|&])rm([[:space:]]+-[A-Za-z0-9_-]*[rf][A-Za-z0-9_-]*[rf][A-Za-z0-9_-]*|[[:space:]]+-r[[:space:]]+-f|[[:space:]]+-f[[:space:]]+-r)([[:space:]]|$)'; then
      emit_deny "Recursive delete target is not approved for this user turn. Delete is allowed only when the current user prompt explicitly names the generated artifact root, and the command is a standalone rm -rf of that exact approved root. Stop/cancel requests must use lifecycle control, not filesystem deletion."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "unapproved-recursive-delete" || true
      exit 0
    fi
    if bounded_generated_cleanup_command "$CLEAN_COMMAND"; then
      exit 0
    fi
    if bounded_generated_reset_scaffold_command "$CLEAN_COMMAND"; then
      exit 0
    fi
    if command_is_allowed_repo_test_index_hygiene "$CLEAN_COMMAND"; then
      exit 0
    fi

    # V-06 fix: Allow worker sessions to run diagnostic/test patterns.
    # Developer implementation commands — allowed for worker sessions
    # E-20 fix: moved AFTER destructive command check to prevent compound-command bypass.
    S02_IMPLEMENTATION_PATTERN='(^|[[:space:]])((mkdir|touch|cp|chmod)|git[[:space:]]+(add|commit|status|log|diff|show|branch|tag|stash|fetch|clone)|npm[[:space:]]+(run|test|build|install)|pip[[:space:]]+(install|freeze)|python|python3|node|npx|tsc|curl|make|cargo|go[[:space:]]+(build|test|run)|diff|wc|sort|pytest|jest|mocha)([[:space:]]|$)'
    if [[ -n "$SESSION_ID" ]] && runtime_sender_session_is_worker "$SESSION_ID" 2>/dev/null; then
      if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
        if validate_compound_command "$CLEAN_COMMAND" allowed_worker_impl_subcmd; then
          exit 0
        fi
        if printf '%s' "$CLEAN_COMMAND" | grep -qE "$S02_IMPLEMENTATION_PATTERN" 2>/dev/null; then
          emit_deny "Worker implementation shell paths must stay within the workspace root. Use workspace-bounded paths or structured tools for out-of-workspace mutations."
          log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "worker-impl-path-outside-workspace" || true
          exit 0
        fi
      else
        if allowed_worker_impl_subcmd "$CLEAN_COMMAND"; then
          exit 0
        fi
        if printf '%s' "$CLEAN_COMMAND" | grep -qE "$S02_IMPLEMENTATION_PATTERN" 2>/dev/null; then
          emit_deny "Worker implementation shell paths must stay within the workspace root. Use workspace-bounded paths or structured tools for out-of-workspace mutations."
          log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "worker-impl-path-outside-workspace" || true
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
    # Allow a narrowly-bounded Git recovery sub-command (stale index lock
    # cleanup) to coexist with read-only Git inspection and normal lead Git
    # operations without opening general mutable-shell bypasses.
    TRIMMED_LEAD_CMD="${CLEAN_COMMAND#"${CLEAN_COMMAND%%[![:space:]]*}"}"
    if printf '%s' "$CLEAN_COMMAND" | grep -qE '(&&|\|\||;)'; then
      if validate_compound_command "$CLEAN_COMMAND" allowed_lead_context_subcmd; then
        exit 0
      fi
    else
      if allowed_safe_git_repo_recovery_subcmd "$CLEAN_COMMAND"; then
        exit 0
      fi
      for allowed_pattern in "${LEAD_OPERATIONAL_ALLOWLIST[@]}"; do
          if [[ "$TRIMMED_LEAD_CMD" == "${allowed_pattern}"* ]]; then
              exit 0  # Permit allowlisted operational command
          fi
      done
    fi

    if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push)([[:space:]]|$)|(^|[[:space:]])sed[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]])perl[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]]):[[:space:]]*>|[[:space:]]>[[:space:]]*[^[:space:]]'; then
      if command_mutates_governance_surface "$SANITIZED_COMMAND"; then
        emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit, Update, or MultiEdit changes so policy and hook edits remain reviewable."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation" || true
        exit 0
      fi
      emit_deny "Mutable shell command blocked. Read-only Bash discovery is allowed. Reclassify the action: use structured file tools for edits, a bounded generated-output cleanup command for cleanup, or the bounded reset-scaffold pattern for approved generated roots. Worker/developer reroute is not a bypass for the same blocked shell shape."
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
