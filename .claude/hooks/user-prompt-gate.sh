#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

# ─── SHARED PARSE: prompt + session_id ──────────────────────────────────────
PARSED_SHARED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);
const input = parseInput();
const prompt = String(input.prompt || "").replace(/\s+/g, " ").trim();
const sessionId = String(input.session_id || "");
process.stdout.write(prompt + "\n" + sessionId + "\n");
NODE
)"
mapfile -t SHARED_FIELDS <<<"$PARSED_SHARED"
USER_PROMPT="${SHARED_FIELDS[0]:-}"
PROMPT_SESSION_ID="${SHARED_FIELDS[1]:-}"
PROMPT_SESSION_ID="$(recover_session_id "$PROMPT_SESSION_ID")"

is_system_generated_followup_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  # Skill/content bridge follow-ups are not fresh user turns.
  if printf '%s' "$prompt" | grep -qE '^(Base directory for this skill:|Tool loaded\.)'; then
    return 0
  fi

  # Pure host notifications carry state; mixed user text re-arms planning.
  if task_notification_only_prompt "$prompt"; then
    return 0
  fi

  # Pure teammate-message completions carry an already-received notification without changing work boundary.
  if teammate_message_only_prompt "$prompt"; then
    return 0
  fi

  return 1
}

task_notification_only_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  TASK_NOTIFICATION_PROMPT="$prompt" node <<'NODE' >/dev/null
const prompt = String(process.env.TASK_NOTIFICATION_PROMPT || "").trim();
if (!/<task-notification\b/i.test(prompt)) process.exit(1);
const stripped = prompt
  .replace(/<task-notification\b[^>]*\/>/giu, " ")
  .replace(/<task-notification\b[^>]*>[\s\S]*?<\/task-notification>/giu, " ")
  .replace(/<task-notification\b[^>]*>[\s\S]*$/giu, " ")
  .replace(/\s+/g, " ")
  .trim();
process.exit(stripped ? 1 : 0);
NODE
}

teammate_message_only_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  TEAMMATE_MESSAGE_PROMPT="$prompt" node <<'NODE' >/dev/null
const prompt = String(process.env.TEAMMATE_MESSAGE_PROMPT || "").trim();
if (!/<teammate-message\b/i.test(prompt)) process.exit(1);
const stripped = prompt
  .replace(/<teammate-message\b[^>]*\/>/giu, " ")
  .replace(/<teammate-message\b[^>]*>[\s\S]*?<\/teammate-message>/giu, " ")
  .replace(/<teammate-message\b[^>]*>[\s\S]*$/giu, " ")
  .replace(/\s+/g, " ")
  .trim();
process.exit(stripped ? 1 : 0);
NODE
}

# Agent sessions skip prompt-level lead enforcement. Use the session registry;
# TMUX naming is only a fallback for contexts without a known id.
if runtime_sender_session_is_worker "$PROMPT_SESSION_ID" || is_worker_session; then
  exit 0
fi

# System-generated prompt follow-ups must not count as fresh user turns.
if is_system_generated_followup_prompt "$USER_PROMPT"; then
  exit 0
fi

# Real user turns reset destructive cleanup approval; stop/cancel is cleanup control.
: > "$USER_APPROVED_DELETE_ROOTS_FILE"

USER_DELETE_APPROVAL_ROOTS="$(USER_PROMPT="$USER_PROMPT" PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" WORKSPACE_ROOT="$(resolve_project_root)" node <<'NODE'
const fs = require("fs");
const path = require("path");

const prompt = String(process.env.USER_PROMPT || "");
const normalizedPrompt = prompt.replace(/\\/g, "/");
const promptSearch = normalizedPrompt.toLowerCase();
// Korean delete forms include imperative, proposal, compound, and decisive variants.
// Per-turn reset bounds approval to the current user turn.
const deleteIntent = /(\bdelete\b|\bremove\b|삭제\s*(해|해줘|하라|하자|진행|해도\s*돼|하고|해버려)|지워\s*(줘|라|버려)?|날려\s*(줘|라|버려)?|초기화\s*(해|해줘|하라)|리셋\s*(해|해줘|하라)|reset\s+it|remove\s+it)/iu.test(prompt);
if (!deleteIntent) process.exit(0);
const genericRuntimeDeleteIntent = /(\b(delete|remove|cleanup|clean\s+up)\b[^.?!\n]{0,80}\b(active\s+)?(team\s+)?(runtime\s+)?(project\s+root|project\s+folder|project\s+directory|workspace\s+child|generated\s+(output|project)|output\s+root)\b|프로젝트\s*(루트|폴더|디렉터리|결과|출력)?\s*(삭제|지워|날려|정리)|작업\s*(폴더|디렉터리|루트)\s*(삭제|지워|정리)|결과\s*(폴더|디렉터리|출력)\s*(삭제|지워|정리))/iu.test(prompt);

const statePath = process.env.PROCEDURE_STATE_FILE || "";
const workspaceRoot = path.resolve(process.env.WORKSPACE_ROOT || process.cwd());
let state = {};
try {
  state = JSON.parse(fs.readFileSync(statePath, "utf8"));
} catch {
  state = {};
}

const unique = (values) => [...new Set(values.filter(Boolean))];
const activeRuntimeIds = unique([
  typeof state.runtimeSessionId === "string" ? state.runtimeSessionId.trim() : "",
  typeof state.sessionId === "string" ? state.sessionId.trim() : "",
  typeof state.bootSessionId === "string" ? state.bootSessionId.trim() : "",
]);
const isWorkspaceChild = (candidate) => {
  const relative = path.relative(workspaceRoot, candidate).replace(/\\/g, "/");
  return Boolean(relative) && !relative.startsWith("..") && !path.isAbsolute(relative);
};
const isProtectedRelative = (relativePath) => {
  return (
    relativePath === "." ||
    relativePath === "" ||
    relativePath === ".claude" ||
    relativePath.startsWith(".claude/") ||
    relativePath === ".git" ||
    relativePath.startsWith(".git/") ||
    relativePath === "references" ||
    relativePath.startsWith("references/")
  );
};

const roots = [];
const checkpoints = state && state.checkpointStatus && typeof state.checkpointStatus === "object"
  ? state.checkpointStatus
  : {};
for (const value of Object.values(checkpoints)) {
  if (!value || typeof value !== "object") continue;
  if (typeof value.projectRoot === "string" && value.projectRoot.trim()) {
    roots.push(value.projectRoot.trim());
  }
}

const explicitPathMatches = normalizedPrompt.match(/(?:[a-zA-Z]:)?\/[^\s"'`]+/g) || [];
for (const rawPath of explicitPathMatches) {
  const candidate = path.resolve(rawPath);
  const relative = path.relative(workspaceRoot, candidate).replace(/\\/g, "/");
  if (isWorkspaceChild(candidate) && !isProtectedRelative(relative)) {
    roots.push(candidate);
  }
}

const explicitRelativeMatches = normalizedPrompt.match(/[A-Za-z0-9._-]+(?:\/[A-Za-z0-9._-]+)*/g) || [];
for (const rawRelative of explicitRelativeMatches) {
  const relative = rawRelative.replace(/^\.\/+/, "").replace(/\/+$/, "");
  if (!relative || !/[._/-]/.test(relative)) continue;
  if (relative.includes("..")) continue;
  if (isProtectedRelative(relative)) continue;
  const candidate = path.resolve(workspaceRoot, relative);
  if (isWorkspaceChild(candidate)) {
    roots.push(candidate);
  }
}

const approved = [];
for (const root of unique(roots)) {
  const normalizedRoot = root.replace(/\\/g, "/");
  const base = path.basename(normalizedRoot);
  if (!base) continue;
  const resolvedRoot = path.resolve(root);
  const relative = path.relative(workspaceRoot, resolvedRoot).replace(/\\/g, "/");
  if (isProtectedRelative(relative)) continue;
  const explicitToken = normalizedRoot.toLowerCase();
  const relativeToken = relative.toLowerCase();
  if (promptSearch.includes(explicitToken) || promptSearch.includes(relativeToken)) {
    approved.push(resolvedRoot);
  }
}

// Generic delete approval resolves from exactly one active team-runtime project
// root only when the prompt names project-root or output cleanup intent.
// Safety: workspace child, protected roots excluded, and exactly one candidate;
// ambiguity grants no approval.
if (approved.length === 0 && genericRuntimeDeleteIntent) {
  const home = String(process.env.HOME || "");
  if (home) {
    const teamsDir = path.join(home, ".claude", "teams");
    const candidates = [];
    try {
      if (fs.existsSync(teamsDir)) {
        for (const entry of fs.readdirSync(teamsDir, { withFileTypes: true })) {
          if (!entry.isDirectory()) continue;
          const configPath = path.join(teamsDir, entry.name, "config.json");
          if (!fs.existsSync(configPath)) continue;
          let cfg = {};
          try { cfg = JSON.parse(fs.readFileSync(configPath, "utf8")); } catch {}
          if (
            activeRuntimeIds.length > 0 &&
            typeof cfg.leadSessionId === "string" &&
            cfg.leadSessionId.trim() &&
            !activeRuntimeIds.includes(cfg.leadSessionId.trim())
          ) {
            continue;
          }
          let candidate = "";
          if (cfg && typeof cfg.projectRoot === "string" && cfg.projectRoot.trim()) {
            candidate = path.resolve(cfg.projectRoot.trim());
          } else if (cfg && typeof cfg.workspaceRoot === "string" && cfg.workspaceRoot.trim()) {
            candidate = path.resolve(cfg.workspaceRoot.trim());
          } else {
            const description = cfg && typeof cfg.description === "string"
              ? cfg.description.replace(/\\/g, "/")
              : "";
            // Active team configs often carry the project output root only in
            // human-readable description text. Use it as a narrow same-runtime
            // cleanup hint; existence and workspace-boundary checks still apply.
            const descProject = description.match(/(?:^|[\s`"'(:])((?:\.\/)?projects\/[A-Za-z0-9._-]+(?:\/[A-Za-z0-9._-]+)*)(?:[\/.。,\s`"')]|$)/i);
            if (descProject && descProject[1]) {
              const guessFromDescription = path.resolve(workspaceRoot, descProject[1].replace(/^\.\/+/, "").replace(/\/+$/, ""));
              try { if (fs.existsSync(guessFromDescription)) candidate = guessFromDescription; } catch {}
            }
            // Fallback: try suffix-stripped team name first (handles common
            // `<project>-build|dev|prod|test|staging` convention), then bare
            // team name (handles custom suffixes / no-suffix naming). Both
            // require existence to add as candidate.
            if (!candidate) {
              const projectName = entry.name.replace(/-(build|dev|prod|test|staging)$/i, "");
              const guess = path.resolve(workspaceRoot, projectName);
              try { if (fs.existsSync(guess)) candidate = guess; } catch {}
              if (!candidate && projectName !== entry.name) {
                const guess2 = path.resolve(workspaceRoot, entry.name);
                try { if (fs.existsSync(guess2)) candidate = guess2; } catch {}
              }
            }
          }
          if (!candidate) continue;
          // [RISK-MITIGATION-R3] Uniform existence check — without this, a stale
          // `projectRoot` pointing to a deleted/never-created in-workspace path
          // would be auto-armed (rm would later fail noisily, but the gate would
          // have lied about "approved"). Reject non-existent candidates outright.
          try { if (!fs.existsSync(candidate)) continue; } catch { continue; }
          // [RISK-MITIGATION-R5] Symlink resolution — `path.resolve` does NOT
          // follow symlinks, so a `projectRoot` symlink pointing outside the
          // workspace would silently pass `isWorkspaceChild` (which uses
          // `path.relative` on the symlink's lexical path). Resolve the real
          // path before workspace-boundary checks. If realpath fails (broken
          // link, permission), reject candidate.
          try {
            candidate = fs.realpathSync(candidate);
          } catch { continue; }
          const relative = path.relative(workspaceRoot, candidate).replace(/\\/g, "/");
          if (!relative || relative.startsWith("..") || path.isAbsolute(relative)) continue;
          if (isProtectedRelative(relative)) continue;
          if (!isWorkspaceChild(candidate)) continue;
          candidates.push(candidate);
        }
      }
    } catch {}
    const uniqueCandidates = unique(candidates);
    if (uniqueCandidates.length === 1) {
      approved.push(uniqueCandidates[0]);
    }
  }
}

process.stdout.write(unique(approved).join("\n"));
NODE
)"
if [[ -n "$USER_DELETE_APPROVAL_ROOTS" ]]; then
  printf '%s\n' "$USER_DELETE_APPROVAL_ROOTS" > "$USER_APPROVED_DELETE_ROOTS_FILE"
fi

# Record whether the current real user turn explicitly requested expanded
# report detail. Pre-emission reporting discipline uses this to preserve the
# reporting-law exception for exact internal material requested by the user.
REPORT_DETAIL_REQUEST="$(USER_PROMPT="$USER_PROMPT" node <<'NODE'
const prompt = String(process.env.USER_PROMPT || "");
const explicitDetail = /(\bdetails?\b|\bevidence\b|\bfile\s*:\s*line\b|\bfull\s+list\b|\bcomplete\s+list\b|\braw\b|\benumerat(e|ed)\b|\bcit(e|es|ation|ations)\b|\bverbose\b|\beverything\b|\bentire\b|상세|자세히|근거|증거|파일\s*:\s*라인|전체\s*목록|전체|전부|모두|원문|나열|열거|인용)/iu.test(prompt);
process.stdout.write(explicitDetail ? "explicit-detail-request" : "default-concise");
NODE
)"
update_procedure_state_fields "$PROMPT_SESSION_ID" reportDetailRequest "$REPORT_DETAIL_REQUEST"

# ─── SECTION 1: BOOT MARKER SYNC ────────────────────────────────────────────
if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
  BOOT_STARTUP_STATE="$(get_procedure_state_field "startupState" "")"
  if [[ "$BOOT_STARTUP_STATE" == "ready" ]]; then
    printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
  fi
fi

# ─── SECTION 2: CLOSEOUT INTENT SYNC + TASK-START PLANNING MARKER ───────────
CLOSEOUT_ACTION="$(USER_PROMPT="$USER_PROMPT" \
  EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN="${EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN:-}" \
  CLOSEOUT_CANCEL_PROMPT_JS_PATTERN="${CLOSEOUT_CANCEL_PROMPT_JS_PATTERN:-}" \
  NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN="${NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN:-}" \
  node <<'NODE'
try {
  const prompt = process.env.USER_PROMPT || "";
  const closeoutRe = new RegExp(process.env.EXPLICIT_CLOSEOUT_PROMPT_JS_PATTERN || "^$", "iu");
  const cancelRe = new RegExp(process.env.CLOSEOUT_CANCEL_PROMPT_JS_PATTERN || "^$", "iu");
  const nonExecRe = new RegExp(process.env.NON_EXECUTION_CLOSEOUT_PROMPT_JS_PATTERN || "^$", "iu");
  let action = "none";
  if (prompt) {
    if (cancelRe.test(prompt)) {
      action = "clear";
    } else if (closeoutRe.test(prompt) && !nonExecRe.test(prompt)) {
      action = "set";
    }
  }
  process.stdout.write(action);
} catch {
  process.stdout.write("none");
}
NODE
)"

case "$CLOSEOUT_ACTION" in
  set)
    clear_lead_planning_required "$PROMPT_SESSION_ID"
    set_closeout_intent "$USER_PROMPT_CLOSEOUT_INTENT_REASON" "user-prompt" "intent_marked" "$PROMPT_SESSION_ID"
    ;;
  clear)
    if closeout_intent_is_active "$PROMPT_SESSION_ID"; then
      clear_closeout_intent "user-prompt-closeout-cancelled" "$PROMPT_SESSION_ID"
    fi
    ;;
esac


exit 0
