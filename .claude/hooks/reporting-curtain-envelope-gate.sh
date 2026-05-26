#!/usr/bin/env bash
# reporting-curtain-envelope-gate.sh
#
# PROTECTED-LOCAL-RESTATEMENT-BASIS: see .claude/reference/modification-core-law.md ## Constitutional Curtain Protection for canonical owner and constitutional-curtain-visibility basis.
# PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE
# This hook is enumerated as constitutionally-protected per
# .claude/reference/modification-core-law.md ## Constitutional Curtain Protection.
# Disabling, removing, or weakening this hook (script body, hook wiring in
# settings.json, or registration in MANIFEST.md) requires:
#   1. Skill(governance-modification) Step 3 review-verification packet
#   2. Validator pre-approval (CLAIM-CEILING: validator-final-verdict, PASS verdict)
#   3. User notification with constitutional invariant + forensic erosion cycle disclosure
#   4. User acknowledgment or absence of objection in the same turn segment
# Approval basis for the in-place script: 2026-05-21 prior reporting-prohibition
# patch wave (commit c361c8a) + 2026-05-26 constitutional re-confirmation
# (curtain-constitutional-fix-2026-05-26, user-authorized via "독립적이면서 안전한
# 보완 패치를 신중하게 진행해").
#
# Active hook: PreToolUse on SendMessage
#
# Purpose
#   Enforce the reporting-prohibition envelope rule at runtime as a binary
#   curtain between internal work and the user surface. This hook is the
#   structural complement to the identity-layer Curtained Communication
#   attribute in agent role files (IR-3 in lane roles; attribute (i) in
#   team-lead identity). Together they make reporting-prohibition independent
#   of governance-text changes: identity primes intent at spawn moment;
#   this hook enforces transport at composition moment.
#
# Protected failure
#   Upward state-class SendMessage envelope discipline violations — lane
#   putting MESSAGE-CLASS header plus receiver-required detail in the
#   message body instead of the canonical no-detail envelope. This was
#   observed repeatedly across reporting-prohibition patch waves: governance
#   text patches alone did not prevent the violation because lane
#   composition habit (showing thoroughness inline, explaining context
#   inline) overrode the rule at write moment.
#
# Scope (narrow)
#   - Only fires on tool_name == "SendMessage".
#   - Only fires when the message body starts with
#     "MESSAGE-CLASS: <upward state class>" where the upward state classes
#     are exactly: dispatch-ack, status, scope-pressure, completion,
#     hold|blocker (per
#     .claude/skills/task-execution/references/message-classes.md
#     `## Upward Message Classes`).
#   - Downward message classes (assignment, reuse, reroute,
#     phase-transition-control) and structured payloads (shutdown_request
#     etc.) are not in scope and pass through unaffected.
#   - Empty or single-ASCII-space message body passes through unaffected
#     (canonical envelope).
#
# Recovery
#   Resend with the canonical envelope per
#   .claude/skills/task-execution/references/message-classes.md
#   `### Transport Payload`:
#     - summary parameter = canonical state token only
#       (e.g., "ack task N", "completion task N", "scope-pressure",
#       "hold|blocker", "status").
#     - message body = empty string or single ASCII space.
#     - Receiver-required detail moves to the retained carrier referenced
#       via RETAINED-OUTPUT-PATH on the assignment packet.
#
# Failure mode
#   Fail-open on any hook-internal error (malformed JSON, bash exception).
#   The hook never blocks on its own bug. Governance text and identity-layer
#   commitment remain the primary control; this hook is the final binary
#   safety net.
#
# Implementation
#   Pure bash + grep, no jq dependency. Loose substring match on the
#   JSON-encoded message body looking for upward state class MESSAGE-CLASS
#   header at the start of the message value. This is narrow enough to
#   avoid false positives on assignment/downward packets while binary
#   enough to enforce envelope discipline at transport moment.
#
# Footprint
#   Single PreToolUse matcher on "SendMessage" tool. No filesystem writes.
#   No long-running operations. Single grep pass on stdin input.

set +e  # fail-open posture

INPUT_JSON="$(cat 2>/dev/null)"
if [ -z "$INPUT_JSON" ]; then
  exit 0
fi

# Confirm tool_name == SendMessage; otherwise allow.
if ! printf '%s' "$INPUT_JSON" | grep -qE '"tool_name"[[:space:]]*:[[:space:]]*"SendMessage"'; then
  exit 0
fi

# Look for upward state-class MESSAGE-CLASS header at the start of the
# message body. In JSON-encoded form this looks like:
#   "message":"MESSAGE-CLASS: dispatch-ack\n..."
# The classes are: dispatch-ack, status, scope-pressure, completion,
# hold|blocker. (The pipe in hold|blocker is escaped in the regex with
# a backslash.)
UPWARD_HEADER_RE='"message"[[:space:]]*:[[:space:]]*"MESSAGE-CLASS:[[:space:]]*(dispatch-ack|status|scope-pressure|completion|hold\|blocker)'

if ! printf '%s' "$INPUT_JSON" | grep -qE "$UPWARD_HEADER_RE"; then
  # Canonical envelope or downward / structured payload — allow.
  exit 0
fi

# Extract detected class for the recovery message.
DETECTED_CLASS=$(printf '%s' "$INPUT_JSON" \
  | grep -oE 'MESSAGE-CLASS:[[:space:]]*(dispatch-ack|status|scope-pressure|completion|hold\|blocker)' \
  | head -1 \
  | sed -E 's/MESSAGE-CLASS:[[:space:]]*//')

if [ -z "$DETECTED_CLASS" ]; then
  DETECTED_CLASS="upward-state-class"
fi

# Emit deny decision via PreToolUse hookSpecificOutput JSON.
cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Reporting-curtain envelope violation: SendMessage upward state class '${DETECTED_CLASS}' carries MESSAGE-CLASS header plus content in the message body. Per .claude/skills/task-execution/references/message-classes.md '### Transport Payload' and .claude/reference/reporting-prohibition-law.md, upward state-class transport MUST use the canonical no-detail envelope: summary parameter carries the canonical state token only (e.g., 'ack task N' / 'completion task N' / 'scope-pressure' / 'hold|blocker' / 'status'); message body is the empty string or a single ASCII space; receiver-required detail moves to the retained carrier cited by RETAINED-OUTPUT-PATH. The agent role file IR-3 Curtained Communication (or attribute (i) for team-lead) is the identity-level commitment to this discipline. Recover by resending with canonical envelope shape; do not retry with the current malformed body."
  }
}
EOF

exit 0
