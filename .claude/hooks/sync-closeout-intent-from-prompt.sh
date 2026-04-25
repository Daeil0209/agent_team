#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const prompt = String(input.prompt || "").replace(/\s+/g, " ").trim();
  const sessionId = String(input.session_id || "");
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

  process.stdout.write(`${action}\n${sessionId}\n`);
} catch {
  process.stdout.write("none\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"
ACTION="${FIELDS[0]:-none}"
PROMPT_SESSION_ID="${FIELDS[1]:-}"
ADDITIONAL_CONTEXT=""

case "$ACTION" in
  set)
    set_closeout_intent "$USER_PROMPT_CLOSEOUT_INTENT_REASON" "user-prompt" "intent_marked" "$PROMPT_SESSION_ID"
    ADDITIONAL_CONTEXT="Explicit user-directed closeout intent is already active for this turn because the current user prompt explicitly requests session end. Load the session-closeout skill first. If the prompt also requests bounded pre-closeout cleanup, perform that cleanup inside Closeout Sequence and then proceed directly to shutdown_request, tracked CronDelete, and TeamDelete without probing the closeout gate first."
    ;;
  clear)
    if closeout_intent_is_active "$PROMPT_SESSION_ID"; then
      clear_closeout_intent "user-prompt-closeout-cancelled" "$PROMPT_SESSION_ID"
    fi
    ADDITIONAL_CONTEXT="Explicit closeout intent is not active for this turn. If closeout was deferred or canceled, remain in monitoring mode until the user gives a new explicit end-of-session instruction."
    ;;
  *)
    exit 0
    ;;
esac

ADDITIONAL_CONTEXT="$ADDITIONAL_CONTEXT" node <<'NODE'
process.stdout.write(JSON.stringify({
  suppressOutput: true,
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    additionalContext: process.env.ADDITIONAL_CONTEXT || ""
  }
}));
NODE

exit 0
