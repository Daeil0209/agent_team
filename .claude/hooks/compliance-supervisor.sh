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
  hook_emit_pretool_deny "$reason" "Blocked by project compliance policy."
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
  local workspace_root
  workspace_root="$(resolve_project_root 2>/dev/null)"
  [[ -n "$workspace_root" ]] || return 1

  # Match only the active workspace's .claude/, not Claude home/runtime paths.
  case "$candidate_path" in
    "$workspace_root"/.claude/*) return 0 ;;
    *) return 1 ;;
  esac
}

is_governance_restricted_write_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1

  # Restrict wholesale Write/NotebookEdit to genuinely stable high-traffic
  # governance surfaces only. `.claude/skills/*` (skill SKILL.md and references)
  # and `.claude/hooks/*` (hook scripts) are routine redesign targets whose
  # wholesale rewrite is reviewed through Skill(governance-modification)
  # Change Sequence + Skill(review-verification) procedure rather than by
  # tool-shape blocking; treating them as restricted is over-broad-blocking per
  # `.claude/reference/work-execution-core-law.md` `## Parallelism And
  # Bottleneck Law` and `.claude/reference/review-and-verification-core-law.md`
  # `## Minimum Executable Information Law`. Top doctrine (CLAUDE.md), settings,
  # agent role spines, and reference core laws remain restricted because they
  # are stable doctrine surfaces, not routine redesign targets.
  case "$candidate_path" in
    */.claude/CLAUDE.md|*/.claude/settings.json|*/.claude/settings.*.json|*/.claude/agents/*|*/.claude/reference/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

nondeveloper_worker_mutation_outside_own_output_scope() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1
  case "${TOOL_NAME:-}" in
    Write|Edit|MultiEdit) ;;
    *) return 1 ;;
  esac
  [[ -n "${SESSION_ID:-}" ]] || return 1
  runtime_sender_session_is_worker "$SESSION_ID" 2>/dev/null || return 1

  local worker_name="" worker_lane="" workspace_root=""
  worker_name="$(worker_name_for_session_id "$SESSION_ID" 2>/dev/null || true)"
  worker_lane="$(resolve_agent_id "$worker_name" 2>/dev/null || true)"
  case "$worker_lane" in
    researcher|reviewer|tester|validator) ;;
    *) return 1 ;;
  esac

  workspace_root="$(resolve_project_root 2>/dev/null || true)"
  [[ -n "$workspace_root" ]] || return 1

  if nondeveloper_worker_mutation_matches_own_output_scope "$worker_name" "$candidate_path" "$workspace_root"; then
    return 1
  fi

  return 0
}

nondeveloper_scope_token_is_empty() {
  local scope_path="${1-}"
  scope_path="$(printf '%s' "$scope_path" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  case "$(printf '%s' "$scope_path" | tr '[:upper:]' '[:lower:]')" in
    ""|"-"|"none"|"n/a"|not-applicable*) return 0 ;;
    *) return 1 ;;
  esac
}

nondeveloper_candidate_matches_scope_path() {
  local candidate_path="${1-}"
  local workspace_root="${2-}"
  local scope_path="${3-}"
  local prefix_mode="${4:-exact}"
  local canonical_scope=""

  [[ -n "$candidate_path" && -n "$workspace_root" ]] || return 1
  scope_path="$(printf '%s' "$scope_path" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  nondeveloper_scope_token_is_empty "$scope_path" && return 1

  case "$scope_path" in
    /*) canonical_scope="$(realpath -m "$scope_path" 2>/dev/null || printf '%s' "$scope_path")" ;;
    *) canonical_scope="$(realpath -m "$workspace_root/$scope_path" 2>/dev/null || printf '%s/%s' "$workspace_root" "$scope_path")" ;;
  esac

  [[ "$candidate_path" == "$canonical_scope" ]] && return 0
  if [[ "$prefix_mode" == "prefix" || "$scope_path" == */ || -d "$canonical_scope" ]]; then
    case "$candidate_path" in
      "$canonical_scope"/*) return 0 ;;
    esac
  fi

  return 1
}

nondeveloper_candidate_matches_write_scope_list() {
  local candidate_path="${1-}"
  local workspace_root="${2-}"
  local scope_list="${3-}"
  local scope_path=""

  [[ -n "$scope_list" ]] || return 1
  while IFS= read -r scope_path; do
    if nondeveloper_candidate_matches_scope_path "$candidate_path" "$workspace_root" "$scope_path" "prefix"; then
      return 0
    fi
  done < <(printf '%s\n' "$scope_list" | tr ',;' '\n\n')

  return 1
}

nondeveloper_worker_mutation_matches_own_output_scope() {
  local worker_name="${1-}"
  local candidate_path="${2-}"
  local workspace_root="${3-}"
  [[ -n "$worker_name" && -n "$candidate_path" && -n "$workspace_root" ]] || return 1
  [[ -f "${WORKER_RETAINED_CARRIER_MAP:-}" ]] || return 1

  local retained_path write_scope
  while IFS='|' read -r mapped_worker _task_id retained_path write_scope _rest; do
    [[ "$mapped_worker" == "$worker_name" ]] || continue
    if nondeveloper_candidate_matches_scope_path "$candidate_path" "$workspace_root" "$retained_path" "exact"; then
      return 0
    fi
    if nondeveloper_candidate_matches_write_scope_list "$candidate_path" "$workspace_root" "$write_scope"; then
      return 0
    fi
  done < "$WORKER_RETAINED_CARRIER_MAP"

  return 1
}

is_hook_runtime_artifact_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1
  local workspace_root rel
  workspace_root="$(resolve_project_root 2>/dev/null)"
  [[ -n "$workspace_root" ]] || return 1

  case "$candidate_path" in
    "$workspace_root"/.claude/hooks/.playwright-mcp/*|"$workspace_root"/.claude/hooks/*.png|"$workspace_root"/.claude/hooks/*.jpg|"$workspace_root"/.claude/hooks/*.jpeg|"$workspace_root"/.claude/hooks/*.webp|"$workspace_root"/.claude/hooks/*.gif|"$workspace_root"/.claude/hooks/*.log|"$workspace_root"/.claude/hooks/*.jsonl|"$workspace_root"/.claude/hooks/*.tmp|"$workspace_root"/.claude/hooks/*.cache)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_retired_skill_reference_md_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1

  [[ "$candidate_path" =~ /[.]claude/skills/[^/]+/reference[.]md$ ]]
}

is_governance_reference_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1

  # Restrict reference-wholesale-write to core-law references under
  # `.claude/reference/*` only. Skill trigger-bound references under
  # `.claude/skills/*/references/*` are routine redesign targets whose
  # wholesale rewrite is reviewed through Skill(governance-modification)
  # Change Sequence + Skill(review-verification) procedure, not by
  # tool-shape blocking. Treating skill references as restricted is
  # over-broad-blocking per `.claude/reference/work-execution-core-law.md`
  # `## Parallelism And Bottleneck Law` and
  # `.claude/reference/review-and-verification-core-law.md`
  # `## Minimum Executable Information Law`.
  [[ "$candidate_path" == */.claude/reference/* ]]
}

is_secret_or_credential_path() {
  local candidate_path="${1-}"
  [[ -n "$candidate_path" ]] || return 1
  local workspace_root basename
  workspace_root="$(resolve_project_root 2>/dev/null || printf '')"
  basename="$(basename "$candidate_path" 2>/dev/null || printf '%s' "$candidate_path")"

  case "$basename" in
    .env|.env.*|credentials.json|*.pem|*.key|*.p12|*.pfx)
      return 0
      ;;
  esac

  [[ -n "$workspace_root" ]] || return 1
  case "$candidate_path" in
    "$workspace_root"/secrets|"$workspace_root"/secrets/*|*/secrets|*/secrets/*)
      return 0
      ;;
  esac

  return 1
}

mutation_payload_exceeds_compact_surface_budget() {
  local char_count="${1-0}"
  local line_count="${2-0}"
  local max_chars="${COMPACT_SURFACE_MAX_CHARS:-8000}"
  local max_lines="${COMPACT_SURFACE_MAX_LINES:-150}"

  [[ "$char_count" =~ ^[0-9]+$ ]] || char_count=0
  [[ "$line_count" =~ ^[0-9]+$ ]] || line_count=0
  [[ "$max_chars" =~ ^[0-9]+$ ]] || max_chars=8000
  [[ "$max_lines" =~ ^[0-9]+$ ]] || max_lines=150

  # Warning-only [HOOK-LAST] signal for massive accidental governance dumps.
  (( char_count > max_chars || line_count > max_lines ))
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

# Strip quoted data for substring scans; suitable for guard heuristics only.
strip_quoted_regions() {
  printf '%s' "${1-}" | sed -E "s/'[^']*'/ /g; s/\"[^\"]*\"/ /g"
}

# Strip heredoc bodies for substring scans; suitable for guard heuristics only.
# Truncates at the first heredoc marker (<< or <<-) with optional quoted
# delimiter; the redirect target appears BEFORE <<, the heredoc body is stdin
# content and never itself a mutation target. Prevents heredoc payloads that
# legitimately cite governance paths (audit findings, doc generation, etc.)
# from being mis-classified as governance-surface mutation.
strip_heredoc_regions() {
  printf '%s' "${1-}" | sed -E "s/[[:space:]]*<<-?[[:space:]]*['\"]?[A-Za-z_][A-Za-z_0-9]*.*\$//"
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

# Destructive sub-command patterns for compound validation.
_GIT_RESET_HARD_PATTERN='(^|[[:space:]])git[[:space:]]+reset[[:space:]]+--hard([[:space:]]|$)'
_CATASTROPHIC_SUBCMD_PATTERN='(^|[[:space:]])mkfs\.|(^|[[:space:]])dd[[:space:]]+if=|(^|[[:space:]])rm[[:space:]]+-rf[[:space:]]+/([[:space:]]|$)'
_DESTRUCTIVE_SUBCMD_PATTERN="${_GIT_RESET_HARD_PATTERN}|${_CATASTROPHIC_SUBCMD_PATTERN}"
_MUTATING_SUBCMD_PATTERN="${HOOK_MUTATING_SHELL_COMMAND_PATTERN}|>>?|${HOOK_MUTATING_GIT_COMMAND_PATTERN}"
GIT_READONLY_PATTERN='git[[:space:]]+(status|log|diff|show|branch[[:space:]]*(-[lva]|--list)|describe|ls-files|ls-tree|rev-parse|cat-file|remote[[:space:]]+(-v|--verbose))([[:space:]]|$)'

# Split cmd on shell command separators and validate each sub-command denylist-first.
split_compound_command() {
  local cmd="${1-}"

  # Quote-aware split avoids false mutable-shell denies.
  COMMAND_TEXT="$cmd" node <<'NODE'
const cmd = String(process.env.COMMAND_TEXT || "");
const parts = [];
let cur = "", inS = false, inD = false, bt = false, pd = 0, i = 0;
while (i < cmd.length) {
  const c = cmd[i], n = cmd[i + 1];
  const q = inS || inD || bt || pd > 0;
  if (!q) {
    if (c === "&" && n === "&") { parts.push(cur); cur = ""; i += 2; continue; }
    if (c === "|" && n === "|") { parts.push(cur); cur = ""; i += 2; continue; }
    if (c === ";") { parts.push(cur); cur = ""; i += 1; continue; }
    if (c === "\r" || c === "\n") {
      parts.push(cur);
      cur = "";
      i += (c === "\r" && n === "\n") ? 2 : 1;
      continue;
    }
    if (c === "$" && n === "(") { pd++; cur += c + n; i += 2; continue; }
  } else if (!inS && !inD && !bt && pd > 0 && c === ")") { pd--; cur += c; i++; continue; }
  if (!inD && !bt && pd === 0 && c === "'") inS = !inS;
  else if (!inS && !bt && pd === 0 && c === '"') inD = !inD;
  else if (!inS && !inD && pd === 0 && c === "`") bt = !bt;
  cur += c;
  i++;
}
parts.push(cur);
for (const p of parts) { const t = p.trim(); if (t) console.log(t); }
NODE
}

validate_compound_command() {
  local cmd="$1"
  local check_fn="$2"
  local subcmd
  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
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
  local workspace_root
  workspace_root="$(resolve_project_root 2>/dev/null)"
  [[ -n "$workspace_root" ]] || return 1
  # Match workspace .claude/ only: absolute workspace paths or cwd-relative paths.
  if printf '%s' "$subcmd" | grep -qF "$workspace_root/.claude/"; then
    return 0
  fi
  printf '%s' "$subcmd" | grep -qE '(^|[[:space:]])(\./)?\.claude/[^[:space:]]'
}

# Narrow rm/rmdir carve-out for non-restricted .claude residue only: one path,
# no recursion/globs/subshells, and every compound segment must qualify.
command_is_narrow_nonrestricted_claude_file_rm() {
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1
  # Whole-command rejections: pipes / or-else / command substitution
  printf '%s' "$cmd" | grep -qE '\||`|\$\(' && return 1
  local subcmd target
  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    printf '%s' "$subcmd" | grep -Eiq '(^|[[:space:]])rm[[:space:]]+(-[A-Za-z0-9_-]*[rR])' && return 1
    if printf '%s' "$subcmd" | grep -Eq '^rm([[:space:]]+-f)?[[:space:]]+[^[:space:]*?\[]+$'; then
      target="$(printf '%s' "$subcmd" | sed -E 's/^rm([[:space:]]+-f)?[[:space:]]+([^[:space:]]+)$/\2/')"
    elif printf '%s' "$subcmd" | grep -Eq '^rmdir[[:space:]]+[^[:space:]*?\[]+$'; then
      target="$(printf '%s' "$subcmd" | sed -E 's/^rmdir[[:space:]]+([^[:space:]]+)$/\1/')"
    else
      return 1
    fi
    [[ -n "$target" ]] || return 1
    printf '%s' "$target" | grep -qE '\.claude/' || return 1
    # Restrict narrow-rm carve-out to stable doctrine surfaces only.
    # `.claude/skills/*` (skill SKILL.md and references) and `.claude/hooks/*`
    # are routine redesign targets whose file removal is reviewed through
    # Skill(governance-modification) Change Sequence + Skill(review-verification)
    # procedure rather than by tool-shape blocking. Treating them as
    # restricted-rm is over-broad-blocking per
    # `.claude/reference/work-execution-core-law.md` `## Parallelism And
    # Bottleneck Law`. Top doctrine (CLAUDE.md), settings, agent role spines,
    # and reference core laws remain restricted.
    printf '%s' "$target" | grep -qE '\.claude/(CLAUDE\.md|settings\.(json|[^/]*\.json)|agents/|reference/)' && return 1
  done < <(printf '%s\n' "$cmd" | sed -E 's/&&/\n/g; s/;/\n/g; s/&/\n/g')
  return 0
}

# Returns 0 (true) iff some explicit output-redirect target token in subcmd
# resolves under .claude/. Approximate static analysis: extract the token
# immediately following `>` or `>>` and match against workspace-absolute or
# cwd-relative .claude/ prefixes. Used by subcommand_is_mutating_shell to
# gate redirect-only classification so read-only .claude/ enumeration whose
# output is redirected outside .claude/ is not falsely treated as governance
# mutation. Mutating exec keywords (rm/mv/cp/install/touch/mkdir/rmdir/chmod/
# chown/tee/sed -i/perl -i) and dynamic-expansion redirect targets remain
# governed by their own predicates upstream and downstream of this check.
subcommand_redirect_targets_governance() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1
  local workspace_root target
  workspace_root="$(resolve_project_root 2>/dev/null)"
  # Dynamic-expansion redirect targets (`$VAR`, `$(...)`, backticks) defeat
  # static analysis; conservatively treat such cases as governance-targeting.
  if printf '%s' "$subcmd" | grep -oE '[>][>]?[[:space:]]*[^[:space:]|;&]+' \
      | grep -qE '(\$|`)'; then
    return 0
  fi
  for target in $(printf '%s' "$subcmd" \
      | grep -oE '[>][>]?[[:space:]]*[^[:space:]|;&]+' \
      | sed -E 's/^[>]+[[:space:]]*//'); do
    [[ -n "$target" ]] || continue
    if [[ -n "$workspace_root" && "$target" == "$workspace_root/.claude/"* ]]; then
      return 0
    fi
    case "$target" in
      .claude/*|./.claude/*) return 0 ;;
    esac
  done
  return 1
}

subcommand_is_mutating_shell() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1
  # Mutating exec keywords classify as mutation regardless of textual target;
  # their bounded carve-outs and target-deny gates apply downstream.
  if printf '%s' "$subcmd" | grep -Eiq "${HOOK_MUTATING_SHELL_COMMAND_PATTERN}"; then
    return 0
  fi
  # Redirect operators (`: >`, ` > `, ` >> `) classify as mutation only when
  # the redirect target resolves under .claude/. Read-only enumeration of
  # .claude/ whose output is redirected outside .claude/ (canonical work
  # artifact root claude_doc/<work-name>/ per environment-output-root-
  # filesystem-law) is not governance-surface mutation, and over-broad
  # classification here is a confirmed defect per CLAUDE.md `## 4. Review
  # And Verification Philosophy` and review-and-verification-core-law
  # `## Minimum Executable Information Law`.
  if printf '%s' "$subcmd" \
      | grep -Eq '(^|[[:space:]]):[[:space:]]*>|[[:space:]]>[[:space:]]*[^[:space:]]'; then
    subcommand_redirect_targets_governance "$subcmd"
    return $?
  fi
  return 1
}

# Bounded .claude relocation/structure carve-out: mv only to trusted archive
# roots with traversal/symlink defense; mkdir only adds .claude structure.
command_is_narrow_governance_relocation() {
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1
  printf '%s' "$cmd" | grep -qE '\||`|\$\(' && return 1
  local subcmd
  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    if printf '%s' "$subcmd" | grep -Eq '^mv([[:space:]]+-n)?[[:space:]]+[^[:space:]*?\[]+[[:space:]]+[^[:space:]*?\[]+$'; then
      local rest src dest
      rest="$(printf '%s' "$subcmd" | sed -E 's/^mv([[:space:]]+-n)?[[:space:]]+//')"
      src="${rest% *}"
      dest="${rest##* }"
      printf '%s' "$src" | grep -qE '\.claude/' || return 1
      printf '%s' "$dest" | grep -qE '\.claude/' || return 1
      # Reject traversal that could fake an archival segment.
      printf '%s' "$src" | grep -qE '(^|/)\.\.(/|$)' && return 1
      printf '%s' "$dest" | grep -qE '(^|/)\.\.(/|$)' && return 1
      # Destination must stay under trusted hooks/skills archive roots.
      printf '%s' "$dest" | grep -qE '\.claude/(hooks|skills)/(legacy|archive|deprecated)/' || return 1
      # Resolve parent to block archive-root symlink escapes.
      local dest_parent="${dest%/*}"
      if [[ -e "$dest_parent" ]]; then
        local canonical
        canonical="$(realpath -- "$dest_parent" 2>/dev/null)" || return 1
        printf '%s' "$canonical" | grep -qE '\.claude/(hooks|skills)/(legacy|archive|deprecated)(/|$)' || return 1
      fi
      continue
    fi
	    if printf '%s' "$subcmd" | grep -Eq '^mkdir([[:space:]]+-p)?([[:space:]]+[^[:space:]*?\[]+)+$'; then
	      local rest p
	      rest="$(printf '%s' "$subcmd" | sed -E 's/^mkdir([[:space:]]+-p)?[[:space:]]+//')"
	      for p in $rest; do
	        printf '%s' "$p" | grep -qE '\.claude/' || return 1
	        printf '%s' "$p" | grep -qE '(^|/)\.claude/hooks/\.playwright-mcp(/|$)' && return 1
	        printf '%s' "$p" | grep -qE '(^|/)\.claude/skills/[^/]+/reference\.md/?$' && return 1
	      done
	      continue
	    fi
    return 1
  done < <(printf '%s\n' "$cmd" | sed -E 's/&&/\n/g; s/;/\n/g; s/&/\n/g')
  return 0
}

# command_is_governance_restricted_file_rm_with_approval is defined in
# lib/hook-governance-rm-approval.sh (sourced by hook-config.sh).

command_mutates_governance_surface() {
  local cmd="${1-}"
  local subcmd=""
  [[ -n "$cmd" ]] || return 1

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
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
  COMMAND_TEXT="$subcmd" PROJECT_ROOT="$project_root" HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" node <<'NODE'
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const root = String(process.env.PROJECT_ROOT || process.cwd());

const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);
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

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    subcommand_is_git_index_hygiene "$subcmd" || return 1
    subcommand_targets_repo_test_surface_only "$subcmd" || return 1
  done < <(split_compound_command "$cmd")

  return 0
}

mutable_find_target_deny_reason() {
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1

  COMMAND_TEXT="$cmd" \
    WORKSPACE_ROOT="$(resolve_project_root)" \
    HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" \
    node <<'NODE'
const path = require("path");
const command = String(process.env.COMMAND_TEXT || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));
const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);

const mutatingExec = new Set([
  "rm", "rmdir", "mv", "cp", "touch", "mkdir", "chmod", "chown", "tee",
  "bash", "sh", "python", "python3", "node", "nodejs",
]);

function clean(word) {
  return String(word || "").replace(/^['"]|['"]$/g, "");
}

function base(word) {
  return path.basename(clean(word)).replace(/[;{}]+$/g, "");
}

function hasMutableFindAction(words, findIndex) {
  for (let i = findIndex + 1; i < words.length; i++) {
    const word = clean(words[i]);
    if (word === "-delete") return true;
    if (word === "-exec" || word === "-execdir") {
      const execWord = base(words[i + 1] || "");
      if (mutatingExec.has(execWord) || /^python[0-9.]*$/.test(execWord)) return true;
    }
  }
  return false;
}

function findTargets(words, findIndex) {
  const targets = [];
  let i = findIndex + 1;
  while (i < words.length) {
    const word = clean(words[i]);
    if (word === "-H" || word === "-L" || word === "-P") {
      i += 1;
      continue;
    }
    if (word === "-D") {
      i += 2;
      continue;
    }
    if (/^-O[0-9]?$/.test(word)) {
      i += 1;
      continue;
    }
    break;
  }
  for (; i < words.length; i++) {
    const word = clean(words[i]);
    if (word === "--") continue;
    if (!word || word === "(" || word === ")" || word === "!" || word.startsWith("-")) break;
    targets.push(word);
  }
  return targets.length > 0 ? targets : ["."];
}

function restrictedReason(target) {
  if (/[`$(){}*?[\]]/.test(target)) return "find-target-metacharacters-unsafe:" + target;
  const resolved = path.resolve(workspaceRoot, target);
  const rel = path.relative(workspaceRoot, resolved).replace(/\\/g, "/");
  if (!rel || rel === ".") return "workspace-root-traversal:" + target;
  if (rel.startsWith("..") || path.isAbsolute(rel)) return "outside-workspace:" + target;
  for (const prefix of [".claude", ".git", ".runtime", "references", "secrets"]) {
    if (rel === prefix || rel.startsWith(prefix + "/")) return "protected-" + prefix.replace(".", "") + ":" + target;
  }
  const filename = path.basename(resolved);
  if (/^\.env(\..*)?$/.test(filename) ||
      filename === "credentials.json" ||
      /\.(pem|key|p12|pfx)$/.test(filename)) {
    return "protected-secret-file:" + target;
  }
  return "";
}

for (const sub of command.split(/(?:&&|\|\||;)/).map((s) => s.trim()).filter(Boolean)) {
  const words = tokenize(sub);
  if (!words || words.length === 0) continue;
  for (let i = 0; i < words.length; i++) {
    if (base(words[i]) !== "find") continue;
    if (!hasMutableFindAction(words, i)) continue;
    for (const target of findTargets(words, i)) {
      const reason = restrictedReason(target);
      if (reason) {
        process.stdout.write(reason);
        process.exit(0);
      }
    }
  }
}
process.stdout.write("");
NODE
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
  local interpreter_entry=""
  local mutation_detected=0
  local protected_target_pattern=""
  [[ -n "$cmd" ]] || return 1

  trimmed="${cmd#"${cmd%%[![:space:]]*}"}"
  interpreter_entry='^((env([[:space:]]+(-[[:alnum:]]+|[[:alpha:]_][[:alnum:]_]*=[^[:space:]]+))*|uv[[:space:]]+run|npm[[:space:]]+exec([[:space:]]+--)?|npx([[:space:]]+-y)?)[[:space:]]+)*([^[:space:]/]+/)?(node|nodejs|python([0-9]+([.][0-9]+)?)?)([[:space:]]|$)'
  if ! printf '%s' "$trimmed" | grep -Eiq "$interpreter_entry"; then
    return 1
  fi

  if printf '%s' "$cmd" | grep -Eiq "([^[:alnum:]_.]|^)(fs[.])?(rmSync|rm|rmdirSync|rmdir|unlinkSync|unlink|writeFileSync|writeFile|appendFileSync|appendFile|renameSync|rename|cpSync|cp|copyFileSync|copyFile|mkdirSync|mkdir|chmodSync|chmod|chownSync|chown|truncateSync|truncate|createWriteStream|openSync|write_text|write_bytes|touch|replace|symlink_to|hardlink_to)[[:space:]]*[(]"; then
    mutation_detected=1
  fi
  if printf '%s' "$cmd" | grep -Eiq "require[[:space:]]*[(][[:space:]]*['\"]fs['\"][[:space:]]*[)][[:space:]]*[.][[:space:]]*(rmSync|rm|rmdirSync|unlinkSync|unlink|writeFileSync|writeFile|appendFileSync|appendFile|renameSync|rename|cpSync|cp|copyFileSync|copyFile|mkdirSync|mkdir|chmodSync|chmod|chownSync|chown|truncateSync|truncate|createWriteStream|openSync)[[:space:]]*[(]"; then
    mutation_detected=1
  fi
  if printf '%s' "$cmd" | grep -Eiq "(child_process|execSync|exec|spawnSync|spawn).*['\"][^'\"]*(^|[^[:alnum:]_])(rm|mv|cp|touch|mkdir|chmod|chown|tee|sed[[:space:]]+-i|perl[[:space:]]+-i|git[[:space:]]+(reset|clean|checkout|restore|push))([^[:alnum:]_]|$)"; then
    mutation_detected=1
  fi
  if printf '%s' "$cmd" | grep -Eiq "(shutil[.]rmtree|os[.](remove|unlink|rmdir|rename|replace)|Path[(][^)]*[)][.](unlink|rmdir|write_text|write_bytes|rename|replace)|[.]write_text[[:space:]]*[(]|[.]write_bytes[[:space:]]*[(]|open[[:space:]]*[(][^)]*,[[:space:]]*['\"][wa+]|subprocess[.](run|call|Popen|check_call|check_output).*['\"][^'\"]*(^|[^[:alnum:]_])(rm|mv|cp|touch|mkdir|chmod|chown|tee|sed[[:space:]]+-i|perl[[:space:]]+-i|git[[:space:]]+(reset|clean|checkout|restore|push))([^[:alnum:]_]|$))"; then
    mutation_detected=1
  fi

  [[ "$mutation_detected" -eq 1 ]] || return 1

  protected_target_pattern='(^|[^[:alnum:]_.-])([.]claude|[.]git|[.]runtime|secrets)(/|$)|(^|[/[:space:]])([.]env([.]|$)|credentials[.]json|[^/[:space:]]+[.](pem|key|p12|pfx))([[:space:]/;|&)]|$)|(^|[[:space:]])(~|[$]HOME|/home/[^/[:space:]]+)/[.]claude/teams(/|[[:space:]]|$)|(^|[[:space:]])/(etc|var|usr|bin|sbin|boot|dev|proc|sys|run)(/|[[:space:]]|$)'
  if printf '%s' "$cmd" | grep -Eiq "$protected_target_pattern"; then
    return 0
  fi
  if printf '%s' "$cmd" | grep -Eiq "open[[:space:]]*[(][^)]*references/[^)]*,[[:space:]]*['\"][wa+]|Path[(][^)]*references/[^)]*[)][.](unlink|rmdir|write_text|write_bytes|rename|replace)"; then
    return 0
  fi

  return 1
}

bash_secret_read_deny_reason() {
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1

  COMMAND_TEXT="$cmd" \
  WORKSPACE_ROOT="$(resolve_project_root)" \
  HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" \
  node <<'NODE'
const path = require("path");
const command = String(process.env.COMMAND_TEXT || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));
const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);

const readers = new Set(["cat", "head", "tail", "nl", "less", "more", "strings", "xxd", "od", "base64"]);
const patternReaders = new Set(["grep", "egrep", "fgrep", "rg", "sed", "awk"]);
const valueOptions = new Set([
  "-A", "-B", "-C", "-m", "-n", "-e", "-f", "-E", "-F", "-P",
  "--after-context", "--before-context", "--context", "--max-count",
  "--regexp", "--file", "--encoding", "--type", "--glob"
]);

const clean = (word) => String(word || "").replace(/^['"]|['"]$/g, "");
const base = (word) => path.basename(clean(word));
const commandName = (word) => path.basename(clean(word)).toLowerCase();
const isSecretTarget = (word) => {
  const target = clean(word);
  if (!target || target === "--") return "";
  const normalized = target.replace(/\\/g, "/");
  const resolved = path.resolve(workspaceRoot, normalized);
  const rel = path.relative(workspaceRoot, resolved).replace(/\\/g, "/");
  if (rel === "secrets" || rel.startsWith("secrets/")) return "protected-secrets-dir:" + target;
  const filename = base(target);
  if (/^\.env(\..*)?$/.test(filename) ||
      filename === "credentials.json" ||
      /\.(pem|key|p12|pfx)$/i.test(filename)) {
    return "protected-secret-file:" + target;
  }
  return "";
};

const optionTakesValue = (cmd, word) => {
  if (valueOptions.has(word)) return true;
  if ((cmd === "head" || cmd === "tail") && /^-[cnqv]$/.test(word)) return true;
  return false;
};

const parts = command.split(/(?:&&|\|\||;)/).map((part) => part.trim()).filter(Boolean);
for (const part of parts) {
  const words = tokenize(part);
  if (!words || words.length < 2) continue;
  const cmd = commandName(words[0]);
  if (!readers.has(cmd) && !patternReaders.has(cmd)) continue;

  let skipNext = false;
  let skippedPattern = false;
  let afterDoubleDash = false;
  for (let index = 1; index < words.length; index += 1) {
    const raw = words[index];
    const word = clean(raw);
    if (!word) continue;
    if (skipNext) {
      skipNext = false;
      continue;
    }
    if (!afterDoubleDash && word === "--") {
      afterDoubleDash = true;
      continue;
    }
    if (!afterDoubleDash && word.startsWith("-")) {
      if (optionTakesValue(cmd, word)) {
        const optionValueReason = isSecretTarget(words[index + 1]);
        if (optionValueReason) {
          process.stdout.write(optionValueReason);
          process.exit(0);
        }
        skipNext = true;
      }
      continue;
    }
    if (patternReaders.has(cmd) && !skippedPattern) {
      skippedPattern = true;
      continue;
    }
    const reason = isSecretTarget(word);
    if (reason) {
      process.stdout.write(reason);
      process.exit(0);
    }
  }
}
process.exit(1);
NODE
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

user_approved_delete_subcommand() {
  local cmd="${1-}"
  local sanitized_cmd=""
  [[ -n "$cmd" && -s "$USER_APPROVED_DELETE_ROOTS_FILE" ]] || return 1
  sanitized_cmd="$(strip_read_only_null_redirections "$cmd")"

  COMMAND_TEXT="$sanitized_cmd" \
  APPROVED_ROOTS_FILE="$USER_APPROVED_DELETE_ROOTS_FILE" \
  WORKSPACE_ROOT="$(resolve_project_root)" \
  HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" \
  node <<'NODE'
const fs = require("fs");
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "");
const rootsFile = String(process.env.APPROVED_ROOTS_FILE || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));

const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);
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

process.stdout.write(target);
process.exit(0);
NODE
}

subcommand_is_read_only_reporting() {
  local subcmd="${1-}"
  [[ -n "$subcmd" ]] || return 1

  if printf '%s' "$subcmd" | grep -Eiq "$_DESTRUCTIVE_SUBCMD_PATTERN"; then
    return 1
  fi
  if subcommand_is_mutating_shell "$subcmd"; then
    return 1
  fi

  return 0
}

command_is_lead_authorized_apt_install() {
  # Lead-only system dependency install carve-out; reject destructive companions.
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1
  printf '%s' "$cmd" | grep -Eq '(^|[[:space:]]|\|)sudo[[:space:]]+(-S[[:space:]]+)?(apt(-get)?)[[:space:]]+install[[:space:]]+-y[[:space:]]+[A-Za-z0-9._+-]' || return 1
  if printf '%s' "$cmd" | grep -Eiq '(^|[[:space:]]|;|&&|\|\|)(rm|dd|mkfs|fdisk|shutdown|reboot|poweroff|halt|setcap|setfacl)([[:space:]]|$)|>[[:space:]]*/(etc|bin|usr|sbin|opt|var|root)/|chmod[[:space:]]+(\+s|[0-7]*[2-7][0-7]{3})'; then
    return 1
  fi
  return 0
}

user_approved_delete_command() {
  local cmd="${1-}"
  local subcmd=""
  local saw_delete="false"
  local delete_root=""
  local candidate_root=""
  [[ -n "$cmd" && -s "$USER_APPROVED_DELETE_ROOTS_FILE" ]] || return 1

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue

    candidate_root=""
    if candidate_root="$(user_approved_delete_subcommand "$subcmd")"; then
      [[ "$saw_delete" == "false" ]] || return 1
      delete_root="$candidate_root"
      saw_delete="true"
      continue
    fi

    if subcommand_is_read_only_reporting "$subcmd"; then
      continue
    fi

    return 1
  done < <(split_compound_command "$cmd")

  [[ "$saw_delete" == "true" ]]
}

# Compound variant of command_is_governance_restricted_file_rm_with_approval:
# allows exactly one approved governance-file rm followed by read-only
# reporting subcommands (e.g. `rm <approved> && ls <approved>`). No additional
# mutation, no second rm, no compound nesting.
command_is_governance_file_rm_compound_with_readonly_followup() {
  local cmd="${1-}"
  local subcmd=""
  local saw_delete="false"
  [[ -n "$cmd" && -s "$USER_APPROVED_DELETE_ROOTS_FILE" ]] || return 1
  printf '%s' "$cmd" | grep -qE '\||`|\$\(' && return 1

  while IFS= read -r subcmd || [[ -n "$subcmd" ]]; do
    subcmd="${subcmd#"${subcmd%%[![:space:]]*}"}"
    subcmd="${subcmd%"${subcmd##*[![:space:]]}"}"
    [[ -z "$subcmd" ]] && continue
    if command_is_governance_restricted_file_rm_with_approval "$subcmd" >/dev/null; then
      [[ "$saw_delete" == "false" ]] || return 1
      saw_delete="true"
      continue
    fi
    if subcommand_is_read_only_reporting "$subcmd"; then
      continue
    fi
    return 1
  done < <(split_compound_command "$cmd")

  [[ "$saw_delete" == "true" ]]
}

command_has_internal_progress_banner() {
  local cmd="${1-}"
  [[ -n "$cmd" ]] || return 1

  COMMAND_TEXT="$cmd" node <<'NODE'
const command = String(process.env.COMMAND_TEXT || "");
const parts = [];
let cur = "", inS = false, inD = false, bt = false, pd = 0;
for (let i = 0; i < command.length; i += 1) {
  const c = command[i], n = command[i + 1];
  const quoted = inS || inD || bt || pd > 0;
  if (!quoted && (c === ";" || c === "\n" || (c === "&" && n === "&") || (c === "|" && n === "|"))) {
    parts.push(cur.trim());
    cur = "";
    if ((c === "&" && n === "&") || (c === "|" && n === "|")) i += 1;
    continue;
  }
  if (!inD && !bt && pd === 0 && c === "'") inS = !inS;
  else if (!inS && !bt && pd === 0 && c === '"') inD = !inD;
  else if (!inS && !inD && pd === 0 && c === "`") bt = !bt;
  else if (!inS && !inD && !bt && c === "$" && n === "(") { pd += 1; cur += c + n; i += 1; continue; }
  else if (!inS && !inD && !bt && pd > 0 && c === ")") pd -= 1;
  cur += c;
}
parts.push(cur.trim());

const echoLiteral = /^(?:command\s+)?(?:printf|echo)\b/i;
const bannerOrProgress = /(={3,}|-{3,}|\b(file counts?|tasks?|phase|wave|progress|corpus|survey|measur(?:e|ed|ing|ement)?|planning|dispatch|runtime|ready|boot|startup|started|start|loaded|checking|now|next|inventory|written|wrote|saved|captured|prior|stale|verify|verified|complete|completed|completion|finished|done|success|passed|current corpus|git history)\b|작업|진행|측정|조사|계획|디스패치|런타임|준비|로드|시작|착수|완료|성공|통과|끝|인벤토리|작성|캡처|이전|스테일|검증)/i;
function hasUnquotedRedirect(part) {
  let s = false, d = false, b = false, p = 0;
  for (let i = 0; i < part.length; i += 1) {
    const c = part[i], n = part[i + 1];
    if (!d && !b && p === 0 && c === "'") s = !s;
    else if (!s && !b && p === 0 && c === '"') d = !d;
    else if (!s && !d && p === 0 && c === "`") b = !b;
    else if (!s && !d && !b && c === "$" && n === "(") { p += 1; i += 1; }
    else if (!s && !d && !b && p > 0 && c === ")") p -= 1;
    else if (!s && !d && !b && p === 0 && c === ">") return true;
  }
  return false;
}
for (const part of parts) {
  if (!echoLiteral.test(part)) continue;
  if (hasUnquotedRedirect(part)) continue;
  if (bannerOrProgress.test(part)) process.exit(0);
}
process.exit(1);
NODE
}

# Allowlist wrappers used as check_fn arguments to validate_compound_command.
# Shared patterns are defined once before these wrappers.
# S02_IMPLEMENTATION_PATTERN stays case-local; sender context is required.
# Lead context uses exact predicates below; broad operational prefixes must not bypass later mutation checks.
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
  COMMAND_TEXT="$subcmd" WORKSPACE_ROOT="$workspace_root" HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" node <<'NODE'
const path = require("path");

const command = String(process.env.COMMAND_TEXT || "").trim();
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));

const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);
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

sendmessage_schema_deny_reason() {
  INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  if (String(input.tool_name || "") !== "SendMessage") process.exit(1);

  const toolInput = input.tool_input || {};
  const hasSummary = typeof toolInput.summary === "string" && toolInput.summary.trim() !== "";
  const summary = hasSummary ? toolInput.summary.trim() : "";
  const message = toolInput.message;
  const messageIsString = typeof message === "string";
  const messageText = messageIsString ? message.trim() : "";
  const isState = (value) => /^(dispatch-ack|subjob-done)$/i.test(String(value || "").trim());

  if (messageIsString && !hasSummary) {
    if (isState(messageText)) {
      process.stdout.write(`state-token-string-without-summary:${messageText.toLowerCase()}`);
    } else {
      process.stdout.write("string-message-without-summary");
    }
    process.exit(0);
  }

  if (isState(summary) && messageIsString && messageText !== "") {
    process.stdout.write(`state-token-body-not-empty:${summary.toLowerCase()}`);
    process.exit(0);
  }

  if (isState(messageText)) {
    process.stdout.write(`state-token-in-message-body:${messageText.toLowerCase()}`);
    process.exit(0);
  }

  process.exit(1);
} catch {
  process.exit(1);
}
NODE
}

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const filePath = String(toolInput.file_path || toolInput.path || "");
  const command = String(toolInput.command || "");
  const textContent =
    typeof toolInput.content === "string" ? toolInput.content
    : typeof toolInput.text === "string" ? toolInput.text
    : typeof toolInput.file_text === "string" ? toolInput.file_text
    : typeof toolInput.fileText === "string" ? toolInput.fileText
    : "";
  const mutationChunks = [];
  if (textContent) mutationChunks.push(textContent);

  const addMaybeString = (value) => {
    if (typeof value === "string" && value.length > 0) mutationChunks.push(value);
  };

  addMaybeString(toolInput.new_string);
  addMaybeString(toolInput.newString);
  addMaybeString(toolInput.new_text);
  addMaybeString(toolInput.newText);
  addMaybeString(toolInput.update);
  addMaybeString(toolInput.patch);
  addMaybeString(toolInput.replacement);
  addMaybeString(toolInput.insert_text);
  addMaybeString(toolInput.insertText);

  if (Array.isArray(toolInput.edits)) {
    for (const edit of toolInput.edits) {
      if (!edit || typeof edit !== "object") continue;
      addMaybeString(edit.content);
      addMaybeString(edit.text);
      addMaybeString(edit.new_string);
      addMaybeString(edit.newString);
      addMaybeString(edit.new_text);
      addMaybeString(edit.newText);
      addMaybeString(edit.update);
      addMaybeString(edit.patch);
      addMaybeString(edit.replacement);
      addMaybeString(edit.insert_text);
      addMaybeString(edit.insertText);
    }
  }

  const mutationText = mutationChunks.join("\n");
  const normalizedMutationText = mutationText.replace(/\r\n/g, "\n");
  const mutationChars = String(mutationText.length);
  const mutationLines = String(mutationText.length === 0 ? 0 : normalizedMutationText.split("\n").length);
  process.stdout.write([toolName, filePath, command, mutationChars, mutationLines].map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TOOL_NAME="$(hook_decode_base64_field "${FIELDS[0]:-}")"
FILE_PATH="$(hook_decode_base64_field "${FIELDS[1]:-}")"
COMMAND="$(hook_decode_base64_field "${FIELDS[2]:-}")"
MUTATION_CONTENT_CHARS="$(hook_decode_base64_field "${FIELDS[3]:-}")"
MUTATION_CONTENT_LINES="$(hook_decode_base64_field "${FIELDS[4]:-}")"

CANONICAL_PATH=""
if [[ -n "$FILE_PATH" ]]; then
  CANONICAL_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || printf '%s' "$FILE_PATH")"
fi

if [[ "$TOOL_NAME" == "SendMessage" ]]; then
  SENDMESSAGE_DENY_REASON="$(sendmessage_schema_deny_reason 2>/dev/null || true)"
  if [[ -n "$SENDMESSAGE_DENY_REASON" ]]; then
    emit_deny "SendMessage state signals require summary-only transport. Use summary: dispatch-ack/subjob-done and message: single ASCII space; do not put the state token in message."
    log_violation "$TOOL_NAME" "$SENDMESSAGE_DENY_REASON" "sendmessage-summary-schema" || true
    exit 0
  fi
fi

	case "$TOOL_NAME" in
	  Edit|MultiEdit|Write|NotebookEdit)
	    if [[ -n "$CANONICAL_PATH" ]]; then
	      BASENAME="$(basename "$CANONICAL_PATH" 2>/dev/null || printf '%s' "$CANONICAL_PATH")"
		      if nondeveloper_worker_mutation_outside_own_output_scope "$CANONICAL_PATH"; then
		        emit_deny "Non-developer lane Write/Edit/MultiEdit is restricted to its frozen RETAINED-OUTPUT-PATH or declared WRITE-SCOPE. Use developer-owned edit/write authority for source, governance, producer artifact, or another lane's output mutation."
		        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "nondeveloper-mutation-outside-own-output-scope" || true
		        exit 0
		      fi

		      if is_hook_runtime_artifact_path "$CANONICAL_PATH"; then
		        emit_deny "Runtime artifacts must not be created under .claude/hooks. Route task-created tool output to the frozen project output root, or route runtime-owned state to a runtime-owned filesystem surface named by work-runtime-boundary-law."
	        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "hook-runtime-artifact-path" || true
	        exit 0
	      fi

	      if is_governance_reference_path "$CANONICAL_PATH"; then
	        case "$TOOL_NAME" in
	          Write|NotebookEdit)
	            if [[ -e "$CANONICAL_PATH" ]]; then
	              emit_deny "Governance reference materials must not be Write/NotebookEdit on EXISTING files (wholesale rewrite blocks diff review). Use structured Edit/MultiEdit instead; Skill(governance-modification) and Skill(self-verification) discipline required."
	              log_violation "$TOOL_NAME" "$CANONICAL_PATH" "references-wholesale-write" || true
	              exit 0
	            fi
	            ;;
	        esac
        # Structured reference edits are allowed; wholesale rewrite is blocked above.
	        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "references-structured-edit-allowed" || true
        # fall through to allow structured governance reference maintenance
	      fi

      if is_secret_or_credential_path "$CANONICAL_PATH"; then
        emit_deny "Direct edits to credential or secret files are blocked in this project."
        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "credential-file" || true
        exit 0
      fi

      if procedure_state_target_exact "$CANONICAL_PATH"; then
        case "$TOOL_NAME" in
          Write|NotebookEdit)
            emit_deny "Procedure state must not be overwritten wholesale. Use exact structured Edit/MultiEdit checkpoint updates for .runtime/procedure-state.json."
            log_violation "$TOOL_NAME" "$CANONICAL_PATH" "procedure-state-wholesale-write" || true
            exit 0
            ;;
        esac
      fi

      if is_governance_surface_path "$CANONICAL_PATH"; then

        if is_governance_restricted_write_path "$CANONICAL_PATH"; then
          case "$TOOL_NAME" in
            Write|NotebookEdit)
              if [[ -e "$CANONICAL_PATH" ]]; then
                emit_deny "Protected governance surfaces under .claude (CLAUDE.md, reference laws, agent spines, governance/review/self-verification/task-execution/team-lead/reporting/runtime-boundary surfaces) must not be overwritten wholesale. Use structured Edit/MultiEdit changes so governance intent remains reviewable."
                log_violation "$TOOL_NAME" "$CANONICAL_PATH" "governance-wholesale-write" || true
                exit 0
              fi
              ;;
          esac
        fi
      fi

    # Compact-surface budget applies only to workspace governance surfaces.
      if ! procedure_state_target_exact "$CANONICAL_PATH" \
        && is_governance_surface_path "$CANONICAL_PATH" \
        && mutation_payload_exceeds_compact_surface_budget "$MUTATION_CONTENT_CHARS" "$MUTATION_CONTENT_LINES"; then
        log_violation "$TOOL_NAME" "$CANONICAL_PATH" "large-file-mutation-warning" || true
        exit 0
      fi
    fi
    ;;

  Bash)
    CLEAN_COMMAND="$(strip_full_line_shell_comments "$COMMAND" | tr '\n' ' ')"
    # Ignore quoted separators for compound-command checks; real unquoted
    # separators still route through validate_compound_command.
    UNQUOTED_CLEAN="$(strip_quoted_regions "$CLEAN_COMMAND")"
    if command_has_internal_progress_banner "$CLEAN_COMMAND"; then
      emit_deny "Assistant-authored Bash progress/banner output is blocked. Remove echo/printf headings and use user-requested output, minimal machine-readable facts, quiet checks, exit status, or retained artifacts."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "bash-internal-progress-banner-deny" || true
      exit 0
    fi
    if command_removes_team_runtime_dir "$CLEAN_COMMAND"; then
      emit_deny "Team runtime directory cleanup must use TeamDelete, not shell rm. Verify live-agent state first; if only stale residue remains, use TeamDelete or report the exact residual state."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "team-runtime-shell-delete" || true
      exit 0
    fi
    # Narrow non-restricted .claude orphan-file rm carve-out.
    if command_is_narrow_nonrestricted_claude_file_rm "$CLEAN_COMMAND"; then
      exit 0
    fi
    # Narrow single-file rm of governance-restricted .claude/ surfaces with
    # explicit approval marker (lib/hook-governance-rm-approval.sh).
    if command_is_governance_restricted_file_rm_with_approval "$CLEAN_COMMAND" >/dev/null; then
      exit 0
    fi
    # Compound variant: one approved governance-file rm + read-only reporting.
    if command_is_governance_file_rm_compound_with_readonly_followup "$CLEAN_COMMAND"; then
      exit 0
    fi
    # Allow content-preserving .claude relocation and structure commands before broad mutation checks.
    if command_is_narrow_governance_relocation "$CLEAN_COMMAND"; then
      exit 0
    fi
    # Governance protection runs before session allowlists; strip inert redirs/quotes/heredocs first.
    MUTATION_CHECK_COMMAND="$(strip_heredoc_regions "$(strip_quoted_regions "$(strip_read_only_null_redirections "$CLEAN_COMMAND")")")"
    if command_mutates_governance_surface "$MUTATION_CHECK_COMMAND"; then
      emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit/MultiEdit changes so policy and hook edits remain reviewable."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation-early" || true
      exit 0
    fi
	    if command_uses_interpreter_fs_mutation "$CLEAN_COMMAND"; then
	      emit_deny "Interpreter-based mutation of protected filesystem surfaces is blocked. Use structured file tools for governance/reference edits or keep generated output inside the approved project root."
	      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "interpreter-fs-mutation" || true
	      exit 0
	    fi
	    if printf '%s' "$UNQUOTED_CLEAN" | grep -qE '(&&|\|\||;)'; then
	      if validate_compound_command "$CLEAN_COMMAND" allowed_package_or_build_command; then
	        exit 0
      fi
    else
      if allowed_package_or_build_command "$CLEAN_COMMAND"; then
        exit 0
      fi
    fi
    SANITIZED_COMMAND="$(strip_read_only_null_redirections "$CLEAN_COMMAND")"
    SECRET_READ_DENY_REASON="$(bash_secret_read_deny_reason "$SANITIZED_COMMAND" 2>/dev/null || true)"
    if [[ -n "$SECRET_READ_DENY_REASON" ]]; then
      emit_deny "Secret read target restricted (${SECRET_READ_DENY_REASON}). Use non-secret evidence or a redacted artifact."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "secret-read-target" || true
      exit 0
    fi

	    if printf '%s' "$UNQUOTED_CLEAN" | grep -qE '(&&|\|\||;)'; then
      if validate_compound_command "$CLEAN_COMMAND" allowed_git_readonly_subcmd; then
        exit 0
      fi
    else
      if printf '%s' "$SANITIZED_COMMAND" | grep -qE "$GIT_READONLY_PATTERN" 2>/dev/null; then
        exit 0
      fi
    fi

    # Block catastrophic primitives only: filesystem format, raw block-device write, root delete.
    if printf '%s' "$CLEAN_COMMAND" | grep -Eiq "$_CATASTROPHIC_SUBCMD_PATTERN"; then
      emit_deny "Catastrophic shell primitive blocked (mkfs/dd if=/rm -rf /). Use a safer bounded command or obtain explicit user approval first."
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "catastrophic-shell" || true
      exit 0
    fi
    if user_approved_delete_command "$CLEAN_COMMAND"; then
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
    # Pinpoint prohibition for rm/rmdir: deny ONLY when target is outside the
    # workspace boundary or on a protected workspace path (.claude/, .git/,
    # references/). Workspace-internal non-protected targets pass by default
    # per CLAUDE.md over-broad-blocking and escalation rules.
    # Catastrophic system targets (rm -rf /) are caught above. Governance
    # shell mutation of .claude/ is caught by command_mutates_governance_surface
    # above. Reserved hard-deny categories (MANIFEST: secrets, .claude shell
    # mutation, runtime/team-state corruption, read-only reference mutation)
    # are guarded by their own narrow checks; this block only adds the
    # outside-workspace and protected-relative pinpoints for shell rm/rmdir.
    if printf '%s' "$UNQUOTED_CLEAN" | grep -Eiq '(^|[[:space:];|&])(rm|rmdir)([[:space:]]|$)'; then
      RM_TARGET_DENY_REASON="$(COMMAND_TEXT="$CLEAN_COMMAND" \
        WORKSPACE_ROOT="$(resolve_project_root)" \
        HOOK_COMMAND_TOKENIZER="$HOOK_LIB_DIR/hook-command-tokenizer.js" \
        node <<'NODE' 2>/dev/null
const path = require("path");
const command = String(process.env.COMMAND_TEXT || "");
const workspaceRoot = path.resolve(String(process.env.WORKSPACE_ROOT || process.cwd()));
const { tokenize } = require(process.env.HOOK_COMMAND_TOKENIZER);
if (!command.trim()) { process.stdout.write("empty-command"); process.exit(0); }
const parts = command.split(/(?:&&|\|\||;)/).map(s => s.trim()).filter(Boolean);
function firstGlobIndex(value) {
  return ["*", "?", "["]
    .map((token) => value.indexOf(token))
    .filter((index) => index >= 0)
    .sort((a, b) => a - b)[0] ?? -1;
}
function staticTargetRoot(raw) {
  const value = String(raw);
  const firstGlob = firstGlobIndex(value);
  if (firstGlob < 0) return value;
  let prefix = value.slice(0, firstGlob);
  const slash = Math.max(prefix.lastIndexOf("/"), prefix.lastIndexOf("\\"));
  return slash >= 0 ? prefix.slice(0, slash + 1) : ".";
}
function isRecursiveRm(words) {
  for (let i = 1; i < words.length; i++) {
    const word = words[i];
    if (word === "--") continue;
    if (word.startsWith("-") && /r/i.test(word)) return true;
  }
  return false;
}
for (const sub of parts) {
  const words = tokenize(sub);
  if (!words || words.length < 2) continue;
  if (!["rm", "rmdir"].includes(words[0])) continue;
  if (/[`$(){}]/.test(sub)) {
    process.stdout.write("rm-subcommand-metacharacters-unsafe"); process.exit(0);
  }
  const recursive = words[0] === "rm" && isRecursiveRm(words);
  for (let i = 1; i < words.length; i++) {
    const w = words[i];
    if (w === "--" || w.startsWith("-")) continue;
    const targetRoot = staticTargetRoot(w);
    const resolved = path.resolve(workspaceRoot, targetRoot);
    const rel = path.relative(workspaceRoot, resolved).replace(/\\/g, "/");
    if (recursive && firstGlobIndex(w) >= 0 && (!rel || rel === "." || rel === "claude_doc")) {
      process.stdout.write("root-recursive-glob:" + w); process.exit(0);
    }
    if (!rel || rel.startsWith("..") || path.isAbsolute(rel)) {
      process.stdout.write("outside-workspace:" + w); process.exit(0);
    }
    if (rel === ".claude" || rel.startsWith(".claude/")) {
      process.stdout.write("protected-claude:" + w); process.exit(0);
    }
    if (rel === ".git" || rel.startsWith(".git/")) {
      process.stdout.write("protected-git:" + w); process.exit(0);
    }
    if (rel === "references" || rel.startsWith("references/")) {
      process.stdout.write("protected-references:" + w); process.exit(0);
    }
    if (rel === ".runtime" || rel.startsWith(".runtime/")) {
      process.stdout.write("protected-runtime:" + w); process.exit(0);
    }
    if (rel === "secrets" || rel.startsWith("secrets/")) {
      process.stdout.write("protected-secrets-dir:" + w); process.exit(0);
    }
    // Mirrors the shared structured-edit secret-file deny pattern.
    const base = require("path").basename(resolved);
    if (/^\.env(\..*)?$/.test(base) ||
        base === "credentials.json" ||
        /\.(pem|key|p12|pfx)$/.test(base)) {
      process.stdout.write("protected-secret-file:" + w); process.exit(0);
    }
  }
}
process.stdout.write("");
NODE
)"
      if [[ -n "$RM_TARGET_DENY_REASON" ]]; then
        emit_deny "Delete target restricted (${RM_TARGET_DENY_REASON}). Blocked: outside-workspace targets, protected paths, unsafe dynamic expansion, and root-level recursive globs. Reserved hard-deny categories are guarded separately."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "rm-target-restricted" || true
        exit 0
      fi
    fi
    # Do not allow-list-block ordinary worker dev commands; objective filesystem guards handle risky edges.

    # No broad lead operational prefix allowlist. Exact predicates below handle
    # read-only git inspection and bounded stale-index-lock recovery; other
    # mutation-capable commands continue to the normal warning/deny checks.
    LEAD_OPERATIONAL_ALLOWLIST=()

    # Broad prefix allowlists would let compound mutation bypass.
    # Narrow stale-index-lock cleanup may coexist with read-only Git inspection.
    TRIMMED_LEAD_CMD="${CLEAN_COMMAND#"${CLEAN_COMMAND%%[![:space:]]*}"}"
    if printf '%s' "$UNQUOTED_CLEAN" | grep -qE '(&&|\|\||;)'; then
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

    UNQUOTED_SANITIZED="$(strip_quoted_regions "$SANITIZED_COMMAND")"
    if printf '%s' "$UNQUOTED_SANITIZED" | grep -Eiq '(^|[[:space:]])(rm|mv|cp|install|touch|mkdir|rmdir|chmod|chown|tee)([[:space:]]|$)|(^|[[:space:]])git[[:space:]]+(checkout|switch|restore|reset|clean|commit|merge|rebase|push)([[:space:]]|$)|(^|[[:space:]])sed[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]])perl[[:space:]]+-i([[:space:]]|$)|(^|[[:space:]]):[[:space:]]*>|[[:space:]]>[[:space:]]*[^[:space:]]'; then
      # Lead-only approved system dependency install; agents must hold for setup.
      if [[ -n "$SESSION_ID" ]] && ! runtime_sender_session_is_worker "$SESSION_ID" 2>/dev/null; then
        if command_is_lead_authorized_apt_install "$CLEAN_COMMAND"; then
          exit 0
        fi
      fi
      # Content-preserving relocation/structure carve-out: see definition near subcommand_is_mutating_shell.
      if command_is_narrow_governance_relocation "$SANITIZED_COMMAND"; then
        exit 0
      fi
      if command_mutates_governance_surface "$(strip_heredoc_regions "$SANITIZED_COMMAND")"; then
        emit_deny "Mutable shell commands touching .claude governance surfaces are blocked. Use structured Edit/MultiEdit changes so policy and hook edits remain reviewable."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "governance-shell-mutation" || true
        exit 0
      fi
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "mutable-shell-warning" || true
      exit 0
    fi

    if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])find([[:space:]]|$).*([[:space:]]-delete([[:space:]]|$)|[[:space:]]-exec(dir)?([[:space:]]|$))'; then
      FIND_TARGET_DENY_REASON="$(mutable_find_target_deny_reason "$CLEAN_COMMAND" 2>/dev/null)"
      if [[ -n "$FIND_TARGET_DENY_REASON" ]]; then
        emit_deny "Mutable find target restricted (${FIND_TARGET_DENY_REASON}). Narrow the find target to a workspace-internal non-protected path."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "mutable-find-target-restricted" || true
        exit 0
      fi
      log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "mutable-find-warning" || true
      exit 0
    fi

	    if printf '%s' "$SANITIZED_COMMAND" | grep -Eq '[.]claude/(reference/|skills/[^[:space:];|&]+/references/)'; then
      if printf '%s' "$SANITIZED_COMMAND" | grep -Eiq '(^|[[:space:]])(cp|mv|rm|install|tee)([[:space:]]|$)|sed[[:space:]]+-i|perl[[:space:]]+-i'; then
	        emit_deny "Governance reference materials must not be modified in place."
        log_violation "$TOOL_NAME" "${CLEAN_COMMAND:0:80}" "references-shell-mutation" || true
        exit 0
      fi
    fi
    ;;
esac

exit 0
