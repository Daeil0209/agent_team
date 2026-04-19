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

is_system_generated_followup_prompt() {
  local prompt="${1-}"
  [[ -n "$prompt" ]] || return 1

  # Skill/content bridge messages are system-generated follow-ups, not real user
  # turns. If they re-arm planning enforcement, the lead can never reach
  # TeamCreate/Agent after loading work-planning/self-verification.
  if printf '%s' "$prompt" | grep -qE '^(Base directory for this skill:|Tool loaded\.)'; then
    return 0
  fi

  # Task-notification turns are system-driven completion events, not new user scope.
  # Re-arming the planning gate forces unnecessary full planning cycles after every
  # worker completion, creating a bottleneck mid-task. (#001)
  if printf '%s' "$prompt" | grep -qF '<task-notification>'; then
    return 0
  fi

  return 1
}

# Worker sessions skip prompt-level lead enforcement. Prefer the session
# registry; TMUX naming is only a fallback for contexts without a known id.
if runtime_sender_session_is_worker "$PROMPT_SESSION_ID" || is_worker_session; then
  exit 0
fi

# System-generated prompt follow-ups must not count as fresh user turns.
if is_system_generated_followup_prompt "$USER_PROMPT"; then
  exit 0
fi

# ─── SECTION 1: BOOT ENFORCEMENT ────────────────────────────────────────────
BOOT_CONTEXT=""
BOOT_SUPPRESS="false"

# E-12 fix: Correction pattern detection runs regardless of boot state so that
# self-growth markers are always set when corrections arrive, including during boot.
# Minimal-guidance policy: only explicit self-growth/process-hardening language should
# arm the hard self-growth gate. Ordinary criticism or correction stays "suspected"
# until stronger evidence appears elsewhere in the workflow.
CONFIRMED_CORRECTION_PATTERN="(self[-[:space:]]*growth|self[-[:space:]]*growth[-[:space:]]*sequence|behavior(al)?[[:space:]]+defect|procedural[[:space:]]+defect|process[[:space:]]+failure|self[-[:space:]]*improvement|change[-[:space:]]*sequence|재발[[:space:]]*방지|자기[[:space:]]*성장|셀프[[:space:]]*그로스|행동[[:space:]]*결함|절차[[:space:]]*결함)"
CORRECTION_PATTERN="((너|네|니)[[:space:]]*잘못(했|됐|된|한)?|틀렸|틀린|(네|너|니)[[:space:]]*(오류|실수)|왜[[:space:]]*(이런|그런|또)[[:space:]]*(오류|실수)|하지[[:space:]]*말|또[[:space:]]*(같은[[:space:]]*)?(실수|문제|오류)|안[[:space:]]*된다고[[:space:]]*(했|말했|했잖)|그게[[:space:]]*아니|규정[[:space:]]*무시|절차[[:space:]]*무시|규정[[:space:]]*위반|절차[[:space:]]*위반|(네|너|니)[[:space:]]*(오류|실수)|you.*wrong|wrong.*again|your mistake|that.s a mistake|you shouldn.t|not like that|you missed|don.t do|why did you (ignore|skip|miss|forget|not))"
if printf '%s' "$USER_PROMPT" | grep -qiE "$CONFIRMED_CORRECTION_PATTERN" 2>/dev/null; then
  if [[ -n "$PROMPT_SESSION_ID" ]]; then
    mark_self_growth_required "$PROMPT_SESSION_ID"
  fi
  BOOT_CONTEXT="CTX: self-growth-required. Next: Skill(self-growth-sequence) before consequential fan-out."
elif printf '%s' "$USER_PROMPT" | grep -qiE "$CORRECTION_PATTERN" 2>/dev/null; then
  if [[ -n "$PROMPT_SESSION_ID" ]]; then
    mark_self_growth_suspected "$PROMPT_SESSION_ID"
  fi
  BOOT_CONTEXT="CTX: user-challenge-observed. Treat the prompt as evidence to evaluate, not proof of defect. Preserve prior verified conclusions unless direct evidence or governing rules overturn them. If a real behavioral defect is confirmed, then enter self-growth; otherwise answer the current request from verified evidence."
fi

if [[ -s "$SESSION_BOOT_MARKER_FILE" && ! -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
  BOOT_STARTUP_STATE="$(get_procedure_state_field "startupState" "")"
  if [[ "$BOOT_STARTUP_STATE" == "ready" ]]; then
    printf '%s | boot-complete\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" > "$BOOT_SEQUENCE_COMPLETE_FILE"
  else
    BOOT_CONTEXT="CTX: boot-required. Next: Skill(session-boot) before task-level work."
    BOOT_SUPPRESS="true"
  fi
fi

# ─── SECTION 2: CLOSEOUT INTENT SYNC + TASK-START PLANNING REMINDER ─────────
CLOSEOUT_CONTEXT=""
CLOSEOUT_SUPPRESS="false"
PLANNING_CONTEXT=""
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
    CLOSEOUT_CONTEXT="CTX: closeout-active. Next: Skill(session-closeout) first; keep cleanup inside Closeout Sequence."
    CLOSEOUT_SUPPRESS="true"
    ;;
  clear)
    if closeout_intent_is_active "$PROMPT_SESSION_ID"; then
      clear_closeout_intent "user-prompt-closeout-cancelled" "$PROMPT_SESSION_ID"
    fi
    CLOSEOUT_CONTEXT="CTX: closeout-cleared. Remain in normal monitoring mode until a new explicit end-of-session instruction."
    CLOSEOUT_SUPPRESS="true"
    ;;
esac

if [[ -n "$PROMPT_SESSION_ID" ]] && [[ "$CLOSEOUT_ACTION" != "set" ]] && ! is_system_generated_followup_prompt "$USER_PROMPT"; then
  mark_lead_planning_required "$PROMPT_SESSION_ID"
  PLANNING_CONTEXT="CTX: fresh-turn-preflight. If this turn introduces a new analysis, classification, recommendation, correction, execution, patch, dispatch, or mutation scope, first freeze scope with Skill('work-planning'), then load Skill('self-verification') before reporting conclusions or using consequential tools. Read-only inspection is evidence gathering only; it does not authorize reporting, dispatch, or mutation. Already-reviewed changes may use work-planning only to freeze the current-turn mutation scope. Before observed TeamCreate/Agent/assignment evidence, describe only the next action, not dispatch as already done."
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
if [[ -n "$PLANNING_CONTEXT" ]]; then
  if [[ -n "$COMBINED_CONTEXT" ]]; then
    COMBINED_CONTEXT="$COMBINED_CONTEXT $PLANNING_CONTEXT"
  else
    COMBINED_CONTEXT="$PLANNING_CONTEXT"
  fi
fi

[[ -n "$COMBINED_CONTEXT" ]] || exit 0

SUPPRESS_OUTPUT="false"
[[ "$BOOT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"
[[ "$CLOSEOUT_SUPPRESS" == "true" ]] && SUPPRESS_OUTPUT="true"

ADDITIONAL_CONTEXT="$COMBINED_CONTEXT" SUPPRESS_OUTPUT="$SUPPRESS_OUTPUT" node -e "
const ctx = process.env.ADDITIONAL_CONTEXT || '';
const suppress = process.env.SUPPRESS_OUTPUT === 'true';
const out = {hookSpecificOutput:{hookEventName:'UserPromptSubmit',additionalContext:ctx}};
if (suppress) out.suppressOutput = true;
process.stdout.write(JSON.stringify(out));
"
