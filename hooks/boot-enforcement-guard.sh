#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/hook-config.sh"

# Worker session → not our concern
is_worker_session && exit 0

# === BOOT COMPLETE: POL reminder + correction detection ===
if [[ -s "$BOOT_SEQUENCE_COMPLETE_FILE" ]]; then
  
  # Read user prompt from stdin (hook receives JSON with prompt field)
  INPUT=$(cat)
  USER_PROMPT=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('prompt',''))" 2>/dev/null || echo "")
  
  # Correction pattern detection (Korean + English)
  CORRECTION_PATTERN="(왜.*안|잘못|틀[렸린]|다시.*해|하지.*말|또.*같은|안.*된다고|그게.*아니|못하는|규정.*무시|절차.*무시|wrong|mistake|shouldn.t|not like that|you missed|don.t do|why did you)"
  
  if echo "$USER_PROMPT" | grep -qiP "$CORRECTION_PATTERN" 2>/dev/null; then
    # Strong trigger: correction detected
    CONTEXT="SELF-GROWTH TRIGGER: User correction detected. BEFORE responding: (1) Record defect to \$HOME/.claude/.self-growth-log (append 1 line), (2) Classify: non-compliance or missing rule, (3) Dispatch a Self-Growth agent for correction via Self-Growth Sequence, (4) Then respond with changed behavior. Do NOT just apologize."
  else
    # Lightweight reminder: every message
    CONTEXT="PRE-RESPONSE: Execute Primary Operating Loop - (1) Classify message type, (2) Determine governance tier, (3) Follow tier procedure, (4) Verify before responding."
  fi
  
  cat <<EOJSON
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "$CONTEXT"
  }
}
EOJSON
  exit 0
fi

# === BOOT NOT COMPLETE ===

# SessionStart hook hasn't run yet (no boot marker) → not ready to enforce
[[ -s "$SESSION_BOOT_MARKER_FILE" ]] || exit 0

# Boot not complete → inject enforcement reminder
cat <<'JSON'
{
  "suppressOutput": true,
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "BOOT SEQUENCE NOT YET COMPLETE. In ONE turn, execute in parallel: (1) Read session-state.md, (2) ToolSearch select:TeamCreate, (3) check team existence. Next turn: TeamCreate if needed + respond to the user's message. Do NOT output boot status — just answer the user after boot."
  }
}
JSON
