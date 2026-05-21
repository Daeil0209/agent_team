#!/usr/bin/env bash
# spawn-prompt-screen-safety.sh
#
# Owner reference: .claude/skills/task-execution/references/message-classes.md
# Team Member Startup Recognition owns the screen-safety rule.
#
# Stage: PreToolUse on Agent.
# Behavior: deny only direct startup-leak primes named by the owner rule.

set -euo pipefail

# Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
# (negative-only-filter doctrine: hooks block only destructive, security-critical, or
# session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
# owned by the lane trio — Skill(governance-modification) + Skill(self-verification) +
# Skill(review-verification) named lenses — and downstream reviewer/validator gates).
# settings.json matcher was removed in the same governance patch; this file-level
# no-op handles already-started agents or local hook harness state after the wiring change.
# File preserved for traceability and potential future narrowing to a negative-only filter.
exit 0

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
if grep -qE '(send|report|emit|announce|declare|confirm|first[[:space:]]+(say|emit|report))[^.]{0,40}(ready|readiness|dispatch-ack|startup[[:space:]]*ack|readiness[[:space:]]*ack|received|context[[:space:]]+loaded|standing[[:space:]]+by|awaiting[[:space:]]+(assignment|packet))' <<<"$prompt_lower" \
  && ! grep -qE '(do[[:space:]]+not|don'\''t|never|no|neither)[^.]{0,60}(send|report|emit|announce|declare|confirm)?[^.]{0,60}(ready|readiness|dispatch-ack|startup[[:space:]]*ack|readiness[[:space:]]*ack|received|context[[:space:]]+loaded|standing[[:space:]]+by|awaiting[[:space:]]+(assignment|packet)|readiness/status/ack)' <<<"$prompt_lower"; then
  violations+=("readiness-or-ack-instruction")
fi

# 2) MESSAGE-CLASS embedded in spawn prompt body.
if grep -q 'MESSAGE-CLASS:' <<<"$SPAWN_PROMPT"; then
  violations+=("message-class-in-spawn-prompt")
fi

# 3) SendMessage embedded in spawn prompt body.
if grep -qi 'sendmessage' <<<"$SPAWN_PROMPT"; then
  violations+=("sendmessage-in-spawn-prompt")
fi

# 4) Communication Plane payload class names instructed as outbound transport in spawn.
if grep -qE '(send|emit|report|return|provide)[^.]{0,40}(completion|scope-pressure|hold[[:space:]]*\|[[:space:]]*blocker|status[[:space:]]+(update|report)|findings[[:space:]]+(count|summary)|count[s]?|paths?|plans?|next[-[:space:]]?action)' <<<"$prompt_lower"; then
  violations+=("comms-plane-payload-instruction")
fi

# 5) Self-description priming language.
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

# Block direct startup-leak primes.
if [[ "$audit_status" == "flagged" ]]; then
  printf '[%s] SPAWN-PROMPT SCREEN-SAFETY DENY: agent=%s team=%s violations=%s | per message-classes.md Team Member Startup Recognition\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "${AGENT_NAME:-unknown}" \
    "${TEAM_NAME:-none}" \
    "$audit_detail" \
    >> "$VIOLATION_LOG"
  hook_emit_pretool_deny "BLOCKED: Agent spawn prompt violates Team Member Startup Recognition. Use role plus screen-safety only; send assignment-grade work after member creation." "Spawn prompt blocked."
fi

exit 0
