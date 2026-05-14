#!/usr/bin/env bash
# spawn-prompt-screen-safety.sh
#
# Owner reference: .claude/skills/task-execution/references/assignment-packet.md
#   "`Agent` member-creation prompt screen-safety clause: no `ready`,
#    `context loaded`, `awaiting assignment`, startup ACK, `MESSAGE-CLASS`,
#    handoff, completion, status, findings, counts, paths, plans,
#    next-action prose, or instruction to send such startup transport"
#
# Stage: PreToolUse on Agent.
# Behavior: inspect the spawn prompt for readiness-priming, ACK-priming,
#   MESSAGE-CLASS embedding, and Communication-Plane payload instruction
#   patterns. WARN (audit log only) — never DENY. Detection log enables
#   verification of doctrine compliance across sessions.
# Why advisory (not block): false-positive risk on legitimate prompts; hook
#   serves as observation + behavioral nudge per `[HOOK-LAST]` last-resort
#   principle. Blocking remains message-classes.md Team Member Startup Recognition enforcement at
#   adherence layer.

set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { encode } = require(process.env.HOOK_JSON_HELPERS);
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const fields = [
    String(input.tool_name || ""),
    String(toolInput.prompt || ""),
    String(
      toolInput.name ||
      toolInput.subagent_type ||
      toolInput.subagentType ||
      toolInput.agent_type ||
      toolInput.agentType ||
      ""
    ),
    String(toolInput.team_name || toolInput.teamName || ""),
    String(input.session_id || "")
  ];
  process.stdout.write(fields.map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TOOL_NAME="$(hook_decode_base64_field "${FIELDS[0]:-}")"
SPAWN_PROMPT="$(hook_decode_base64_field "${FIELDS[1]:-}")"
AGENT_NAME="$(hook_decode_base64_field "${FIELDS[2]:-}")"
TEAM_NAME="$(hook_decode_base64_field "${FIELDS[3]:-}")"
SESSION_ID="$(hook_decode_base64_field "${FIELDS[4]:-}")"

[[ "$TOOL_NAME" == "Agent" ]] || exit 0
[[ -n "$SPAWN_PROMPT" ]] || exit 0

# All spawn-prompt inspection is case-insensitive on a lowercased copy.
prompt_lower="$(printf '%s' "$SPAWN_PROMPT" | tr '[:upper:]' '[:lower:]')"

violations=()

# 1) Explicit readiness/ACK transport instruction in spawn prompt body.
#    Pattern targets verbs (send|report|emit|announce|declare|confirm|first say|first emit)
#    paired with readiness/ack/receipt nouns. message-classes.md Team Member Startup Recognition forbids these.
if grep -qE '(send|report|emit|announce|declare|confirm|first[[:space:]]+(say|emit|report))[^.]{0,40}(ready|readiness|dispatch-ack|startup[[:space:]]*ack|readiness[[:space:]]*ack|received|context[[:space:]]+loaded|standing[[:space:]]+by|awaiting[[:space:]]+(assignment|packet))' <<<"$prompt_lower"; then
  violations+=("readiness-or-ack-instruction")
fi

# 2) MESSAGE-CLASS embedded in spawn prompt body.
#    MESSAGE-CLASS travels through SendMessage envelope, never inside the
#    spawn prompt body. message-classes.md ### Team Member Startup Recognition.
if grep -q 'MESSAGE-CLASS:' <<<"$SPAWN_PROMPT"; then
  violations+=("message-class-in-spawn-prompt")
fi

# 3) Communication-Plane payload class names instructed as outbound transport in spawn.
#    handoff / completion / scope-pressure / hold|blocker / status payloads must NEVER be
#    requested through the spawn prompt — they belong to assignment-grade SendMessage.
if grep -qE '(send|emit|report|return|provide)[^.]{0,40}(handoff|completion|scope-pressure|hold[[:space:]]*\|[[:space:]]*blocker|status[[:space:]]+(update|report)|findings[[:space:]]+(count|summary)|count[s]?|paths?|plans?|next[-[:space:]]?action)' <<<"$prompt_lower"; then
  violations+=("comms-plane-payload-instruction")
fi

# 4) "Describe what you will do" priming language.
#    LLM compliance variance is highest when the spawn prompt invites self-description.
if grep -qE '(describe|tell[[:space:]]+(me|us)|explain[[:space:]]+(your|what[[:space:]]+you))[^.]{0,40}(plan|approach|next[[:space:]]+step|first[[:space:]]+(step|action)|what[[:space:]]+you[[:space:]]+will)' <<<"$prompt_lower"; then
  violations+=("self-description-prime")
fi

# Always write a per-spawn audit record. Verification reads this log to count
# clean-vs-flagged spawns across a session.
audit_dir="${VIOLATION_LOG%/*}"
if [[ -n "$audit_dir" && ! -d "$audit_dir" ]]; then
  mkdir -p "$audit_dir" 2>/dev/null || true
fi
audit_log="${audit_dir:-${HOME}/.claude/logs}/spawn-prompt-audit.log"
mkdir -p "${audit_log%/*}" 2>/dev/null || true

audit_status="clean"
audit_detail="-"
if [[ "${#violations[@]}" -gt 0 ]]; then
  audit_status="flagged"
  audit_detail="$(IFS=,; printf '%s' "${violations[*]}")"
fi

printf '[%s] SPAWN-PROMPT-AUDIT status=%s team=%s agent=%s session=%s violations=%s prompt_chars=%d\n' \
  "$(date '+%Y-%m-%d %H:%M:%S')" \
  "$audit_status" \
  "${TEAM_NAME:-none}" \
  "${AGENT_NAME:-unknown}" \
  "${SESSION_ID:-unknown}" \
  "$audit_detail" \
  "${#SPAWN_PROMPT}" \
  >> "$audit_log"

# Emit a warning row to the shared violation log only when flagged.
if [[ "$audit_status" == "flagged" ]]; then
  printf '[%s] SPAWN-PROMPT SCREEN-SAFETY WARN: agent=%s team=%s violations=%s | per message-classes.md Team Member Startup Recognition; rewrite spawn prompt to role + screen-safety only, route work via assignment-grade SendMessage\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "${AGENT_NAME:-unknown}" \
    "${TEAM_NAME:-none}" \
    "$audit_detail" \
    >> "$VIOLATION_LOG"
fi

exit 0
