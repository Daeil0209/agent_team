#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

# ─── SHARED PARSE: prompt + session_id ──────────────────────────────────────
PARSED_SHARED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const prompt = String(input.prompt || "").replace(/\s+/g, " ").trim();
  const sessionId = String(input.session_id || "");
  process.stdout.write(prompt + "\n" + sessionId + "\n");
} catch {
  process.stdout.write("\n\n");
}
NODE
)"
mapfile -t SHARED_FIELDS <<<"$PARSED_SHARED"
USER_PROMPT="${SHARED_FIELDS[0]:-}"
PROMPT_SESSION_ID="${SHARED_FIELDS[1]:-}"
PROMPT_SESSION_ID="$(recover_session_id "$PROMPT_SESSION_ID")"

# Strip harness wrapper blocks before correction detection so generated metadata
# is not mistaken for user-authored defect language. Other prompt consumers use raw text.
sanitize_prompt_for_correction_detection() {
  local raw="${1-}"
  RAW_PROMPT="$raw" node <<'NODE'
const raw = String(process.env.RAW_PROMPT || "");
const HARNESS_WRAPPERS = [
  "system-reminder",
  "command-name",
  "command-message",
  "command-args",
  "command-output",
  "local-command-stdout",
  "local-command-stderr",
  "local-command-caveat",
  "task-notification",
  "teammate-message",
];
let stripped = raw;
for (const tag of HARNESS_WRAPPERS) {
  const block = new RegExp(`<${tag}\\b[^>]*>[\\s\\S]*?<\\/${tag}>`, "giu");
  const selfClose = new RegExp(`<${tag}\\b[^>]*\\/>`, "giu");
  const orphanOpen = new RegExp(`<${tag}\\b[^>]*>`, "giu");
  const orphanClose = new RegExp(`<\\/${tag}\\s*>`, "giu");
  stripped = stripped
    .replace(block, " ")
    .replace(selfClose, " ")
    .replace(orphanOpen, " ")
    .replace(orphanClose, " ");
}
stripped = stripped.replace(/\s+/g, " ").trim();
process.stdout.write(stripped);
NODE
}
USER_PROMPT_FOR_PATTERNS="$(sanitize_prompt_for_correction_detection "$USER_PROMPT")"

is_system_generated_followup_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  # Skill/content bridge follow-ups are not fresh user turns.
  if printf '%s' "$prompt" | grep -qE '^(Base directory for this skill:|Tool loaded\.)'; then
    return 0
  fi

  # Pure task notifications carry state; mixed user text re-arms planning.
  if task_notification_only_prompt "$prompt"; then
    return 0
  fi

  # Pure teammate-message handoffs are notification-only carry-forward.
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

status_runtime_recovery_context() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  USER_PROMPT="$prompt" \
  PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" \
  node <<'NODE' 2>/dev/null || true
const fs = require("fs");

const prompt = String(process.env.USER_PROMPT || "").trim();
if (!prompt) process.exit(0);

const statusPromptRe =
  /(?:\bstatus\b|\bprogress\b|\bcurrent state\b|\bwhat remains\b|\bwhat(?:'s| is) left\b|\bwhat are you doing\b|\bwhy (?:did|are) you stop(?:ped)?\b|\bwhat is happening\b|\bwhere are we\b|지금[^.\n]{0,20}(?:뭐|무엇|어디|상태|진행|남|멈)|현재[^.\n]{0,20}(?:상태|진행|남)|뭐하고 있|무엇을 하고 있|어디까지|왜 멈|왜 안|남은 게|뭐가 남았|진행 상황|현재 상태)/iu;
if (!statusPromptRe.test(prompt)) process.exit(0);

// Per [HOOK-LAST]: hook is observation-only. Detailed runtime-state diagnosis is
// owned by team-lead via session-boot Monitoring Sequence + agents/team-lead.md
// RPA-3/RPA-9. Emit a single bare cue and let the lead read procedure-state +
// classify the runtime situation against the canonical truth-rules.md ladder.
const stateFile = String(process.env.PROCEDURE_STATE_FILE || "");
let stateExists = false;
try { stateExists = fs.statSync(stateFile).isFile(); } catch {}

if (stateExists) {
  process.stdout.write("CTX: status-like prompt. Owner cue: read procedure-state, apply session-boot Monitoring Sequence per agents/team-lead.md RPA-3, then surface one primary truth per RPA-9 (verified result / blocker / next action / closeout residual). Hook ledgers are observation only per task-execution/references/truth-rules.md.");
} else {
  process.stdout.write("CTX: status-like prompt. Owner cue: no procedure-state present; report only verified next action or blocker per agents/team-lead.md RPA-9 single-primary-surface rule.");
}
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

# Real user turns reset destructive cleanup approval; stop/cancel is lifecycle control.
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

# ─── SECTION 1: BOOT ENFORCEMENT ────────────────────────────────────────────
BOOT_CONTEXT=""
BOOT_SUPPRESS="false"
DELIVERY_CONTEXT=""

# Correction detection runs before boot handling. It emits context only; owner
# skills classify route and hardening need.
SELF_GROWTH_TERM_PATTERN="(self[-[:space:]]*growth|self[-[:space:]]*growth[-[:space:]]*sequence|self[-[:space:]]*improvement|change[-[:space:]]*sequence|재발[[:space:]]*방지|자기[[:space:]]*성장|셀프[[:space:]]*그로스)"
SELF_GROWTH_EXECUTION_INTENT_PATTERN="(진입|실행|로드|적용|수행|패치|보완|고쳐|수정|하드닝|enter|run|load|apply|execute|patch|harden|fix)"
CONFIRMED_CORRECTION_PATTERN="((${SELF_GROWTH_TERM_PATTERN})[^.?!]{0,80}${SELF_GROWTH_EXECUTION_INTENT_PATTERN}|(behavior(al)?[[:space:]]+defect|procedural[[:space:]]+defect|process[[:space:]]+failure|행동[[:space:]]*결함|절차[[:space:]]*결함)[^.?!]{0,80}(확정|맞|발생|고쳐|보완|수정|패치|confirmed|actual|fix|harden))"
CORRECTION_PATTERN="((너|네|니)[[:space:]]*잘못(했|됐|된|한)?|틀렸|틀린|(네|너|니)[[:space:]]*(오류|실수)|왜[[:space:]]*(이런|그런|또)[[:space:]]*(오류|실수)|하지[[:space:]]*말|또[[:space:]]*(같은[[:space:]]*)?(실수|문제|오류)|안[[:space:]]*된다고[[:space:]]*(했|말했|했잖)|그게[[:space:]]*아니|규정[[:space:]]*무시|절차[[:space:]]*무시|규정[[:space:]]*위반|절차[[:space:]]*위반|(네|너|니)[[:space:]]*(오류|실수)|you.*wrong|wrong.*again|your mistake|that.s a mistake|you shouldn.t|not like that|you missed|don.t do|why did you (ignore|skip|miss|forget|not))"
if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$CONFIRMED_CORRECTION_PATTERN" 2>/dev/null; then
  BOOT_CONTEXT="CTX: self-growth-evidence. User prompt supplies possible defect evidence. Owner cue: classify owner, recurrence path, and hardening need before consequential fan-out."
elif printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$CORRECTION_PATTERN" 2>/dev/null; then
  BOOT_CONTEXT="CTX: user-challenge-evidence. User challenge observed. Evidence cue: prompt is not defect proof; prior verified conclusions stand unless direct evidence or governing rules overturn them; confirmed behavioral defect may open self-growth classification."
fi

DELIVERY_INCIDENT_PATTERN="(double[-[:space:]]*click|더블클릭|start[._-]?bat|start[._-]?sh|launcher|아이콘|실행[^.]{0,20}(안[[:space:]]*돼|안돼|안됨|실패)|안[[:space:]]*열리|won.t[[:space:]]+launch|doesn.t[[:space:]]+launch|launch[[:space:]]+fail)"
BURDEN_SHIFT_PROMPT_PATTERN="(내[[:space:]]*손이[[:space:]]*가|더블클릭만|hands[-[:space:]]*off|low[-[:space:]]*touch|cmd|powershell|terminal|명령[[:space:]]*(프롬프트|입력)|터미널|삭제[[:space:]]*후|node_modules|\\.next)"

if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$DELIVERY_INCIDENT_PATTERN" 2>/dev/null; then
  DELIVERY_CONTEXT="CTX: delivery-incident-evidence. Reported user-run-path failure may reopen acceptance. Evidence cue: promised user run path, hands-off remediation surface, and run-path proof need owner verification."
fi

if printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$DELIVERY_INCIDENT_PATTERN" 2>/dev/null \
  && printf '%s' "$USER_PROMPT_FOR_PATTERNS" | grep -qiE "$BURDEN_SHIFT_PROMPT_PATTERN" 2>/dev/null; then
  DELIVERY_CONTEXT="CTX: delivery-remediation-evidence. A promised hands-off delivery path may have failed and pulled the user into recovery steps. Evidence cue: acceptance reopen, agent-owned remediation, and self-growth classification may be relevant."
fi

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
  BOOT_STARTUP_STATE="$(get_procedure_state_field "startupState" "")"
  if [[ "$BOOT_STARTUP_STATE" == "ready" ]]; then
    printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
  else
    BOOT_CONTEXT="CTX: boot-state. Boot sequence is incomplete. Owner cue: session-boot before task-level work."
    BOOT_SUPPRESS="true"
  fi
fi

# ─── SECTION 2: CLOSEOUT INTENT SYNC + TASK-START PLANNING REMINDER ─────────
CLOSEOUT_CONTEXT=""
CLOSEOUT_SUPPRESS="false"
PLANNING_CONTEXT=""
RECOVERY_CONTEXT=""
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
    CLOSEOUT_CONTEXT="CTX: closeout-intent-state. Explicit closeout intent marked. Owner cue: session-closeout owns teardown and residual truth."
    CLOSEOUT_SUPPRESS="true"
    ;;
  clear)
    if closeout_intent_is_active "$PROMPT_SESSION_ID"; then
      clear_closeout_intent "user-prompt-closeout-cancelled" "$PROMPT_SESSION_ID"
    fi
    CLOSEOUT_CONTEXT="CTX: closeout-intent-state. Explicit closeout cancellation observed. Owner cue: closeout state cleared until a new explicit end-of-session instruction."
    CLOSEOUT_SUPPRESS="true"
    ;;
esac

if [[ -n "$PROMPT_SESSION_ID" ]] && [[ "$CLOSEOUT_ACTION" != "set" ]] && ! is_system_generated_followup_prompt "$USER_PROMPT"; then
  # A fresh prompt alone is not a planning owner. Priority 0 decides whether a boundary opened.
  # Keep the routine planning-required marker silent; only exceptional owner cues emit context.
  mark_lead_planning_required "$PROMPT_SESSION_ID"
  RECOVERY_CONTEXT="$(status_runtime_recovery_context "$USER_PROMPT")"
fi

# ─── OUTPUT ──────────────────────────────────────────────────────────────────
COMBINED_CONTEXT="$BOOT_CONTEXT"
if [[ -n "$CLOSEOUT_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $CLOSEOUT_CONTEXT"
  else
    COMBINED_CONTEXT="$CLOSEOUT_CONTEXT"
  fi
fi
if [[ -n "$RECOVERY_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $RECOVERY_CONTEXT"
  else
    COMBINED_CONTEXT="$RECOVERY_CONTEXT"
  fi
fi
if [[ -n "$PLANNING_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $PLANNING_CONTEXT"
  else
    COMBINED_CONTEXT="$PLANNING_CONTEXT"
  fi
fi
if [[ -n "$DELIVERY_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $DELIVERY_CONTEXT"
  else
    COMBINED_CONTEXT="$DELIVERY_CONTEXT"
  fi
fi

[[ -n "$COMBINED_CONTEXT" ]] || exit 0

SUPPRESS_OUTPUT="false"
[[ "$BOOT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"
[[ "$CLOSEOUT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"

hook_emit_user_prompt_context "$COMBINED_CONTEXT" "User prompt context." "$SUPPRESS_OUTPUT"
