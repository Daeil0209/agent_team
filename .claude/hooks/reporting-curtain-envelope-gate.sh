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

# Generalized non-downward body discipline: prior over-specific marker
# allow-list (PART A) removed per operator directive "패치는 일반화 되어야"
# (patches must be generalized). The over-specific marker enumeration
# (FINDING-STATE-LADDER-SUMMARY / PATCH-WORTHINESS / META-CONCERN / etc.)
# was a brittle whack-a-mole pattern that ALSO false-positive-blocked
# legitimate canonical short tokens like `VERDICT: PASS` that
# .claude/skills/task-execution/references/message-classes.md
# `### Transport Payload` explicitly cites as canonical envelope examples.
# Generalized enforcement now lives in PART C (non-downward body allow-list)
# below: any non-canonical body line in non-downward delivery is rejected
# by structural rule, not by specific marker name. Downward delivery is
# producer-authored by team-lead under identity-layer Curtained Communication
# discipline and the downward packet schema governs body shape semantically.

# Bulk-body heuristic for non-downward-delivery messages (PART B): any
# SendMessage whose body has more than CURTAIN_BODY_MAX_NL newlines
# AND does NOT start with a downward delivery MESSAGE-CLASS (assignment,
# reuse, reroute, phase-transition-control) is presumed curtain-violating.
# Downward delivery legitimately carries packet floor fields; non-downward
# bodies must be canonical envelope (empty / single space / short carrier
# pointer ≤ 3 lines) per the non-state-class rule.
CURTAIN_BODY_MAX_NL=3
DOWNWARD_HEADER_RE='"message"[[:space:]]*:[[:space:]]*"MESSAGE-CLASS:[[:space:]]*(assignment|reuse|reroute|phase-transition-control)'
# Count escaped newlines (\n) inside the JSON-encoded "message" body.
BODY_NL_COUNT=$(printf '%s' "$INPUT_JSON" | grep -oE '"message"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | grep -oE '\\n' | wc -l)
if [ "$BODY_NL_COUNT" -gt "$CURTAIN_BODY_MAX_NL" ]; then
  if ! printf '%s' "$INPUT_JSON" | grep -qE "$DOWNWARD_HEADER_RE"; then
    cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Reporting-curtain envelope violation: SendMessage body exceeds canonical envelope shape (>3 newlines) and is NOT a downward delivery class (assignment/reuse/reroute/phase-transition-control). Non-downward SendMessage must be canonical envelope per .claude/skills/task-execution/references/message-classes.md '### Transport Payload' non-state-class rule: summary = brief class label + task pointer; message body = empty, single ASCII space, OR ≤3 lines naming a CARRIER path plus brief intent label. Bulk body content (opinion, inventory, rationale, narrative) belongs in the retained carrier referenced by the envelope pointer, not in the SendMessage body. Recover by moving body content to a retained carrier file and resending with the canonical envelope shape."
  }
}
EOF
    exit 0
  fi
fi

# Secondary check (PART C — non-downward-delivery body strict allow-list):
# For non-downward delivery SendMessage, EVERY non-empty body line MUST start
# with a canonical curtain-allowed KEY (CARRIER, STATE, ROUND, TURN, WAKE,
# NEXT, FROM, TO, VERDICT, CRITIQUE, REDIRECT, REPORT-REASON, MESSAGE-CLASS,
# TASK-ID, RETAINED-OUTPUT-PATH, UPSTREAM-DECISION-BASIS). Lines that contain
# free-form substantive content (questions, answers, claims, opinions,
# summaries, narratives) — any line not starting with an allowed KEY — fail
# the curtain because the host runtime auto-renders teammate-message envelope
# body into user-visible UI, exposing controllable substance to the user
# surface. Substantive content MUST live in the retained carrier referenced
# via CARRIER pointer; the SendMessage body is index-only.
#
# Downward delivery (assignment/reuse/reroute/phase-transition-control) is
# exempt because the body legitimately carries packet floor fields that
# follow the broader assignment-packet schema; team-lead authors those
# downward packets and is the producer, not the user-surface consumer.
NONDOWNWARD_BODY_ALLOWED_RE='^(CARRIER|STATE|ROUND|TURN|WAKE|NEXT|FROM|TO|VERDICT|CRITIQUE|REDIRECT|REPORT-REASON|MESSAGE-CLASS|TASK-ID|RETAINED-OUTPUT-PATH|UPSTREAM-DECISION-BASIS):[[:space:]]'

if ! printf '%s' "$INPUT_JSON" | grep -qE "$DOWNWARD_HEADER_RE"; then
  # Extract body content from JSON-encoded "message" field
  BODY_RAW=$(printf '%s' "$INPUT_JSON" | grep -oE '"message"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/^"message"[[:space:]]*:[[:space:]]*"//' | sed -E 's/"$//')
  # Skip allow-list check for empty / single-space body (canonical empty envelope)
  TRIMMED_BODY=$(printf '%s' "$BODY_RAW" | tr -d '[:space:]')
  if [ -n "$TRIMMED_BODY" ]; then
    # Convert escaped \n (JSON-encoded newlines) to actual newlines for line-by-line check
    BODY_TEXT=$(printf '%s' "$BODY_RAW" | sed 's/\\n/\n/g')
    # Find any non-empty line that does NOT start with allowed canonical KEY
    NONCONFORMING_COUNT=$(printf '%s\n' "$BODY_TEXT" | grep -vE "$NONDOWNWARD_BODY_ALLOWED_RE" | grep -vcE '^[[:space:]]*$')
    if [ "$NONCONFORMING_COUNT" -gt "0" ]; then
      cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Reporting-curtain envelope violation: non-downward-delivery SendMessage body contains free-form substantive line(s) — line(s) not starting with a canonical curtain-allowed KEY. Per .claude/CLAUDE.md '## Constitutional Reporting Curtain' + .claude/skills/task-execution/references/message-classes.md '### Transport Payload' non-state-class rule + .claude/skills/team-meeting/SKILL.md '### 3-4a. Discussion Envelope Form', non-downward SendMessage body MUST be empty, single ASCII space, OR consist ONLY of canonical KEY: value lines where KEY is in {CARRIER, STATE, ROUND, TURN, WAKE, NEXT, FROM, TO, VERDICT, CRITIQUE, REDIRECT, REPORT-REASON, MESSAGE-CLASS, TASK-ID, RETAINED-OUTPUT-PATH, UPSTREAM-DECISION-BASIS}. Free-form substantive content (questions, answers, claims, opinions, summaries, narratives, rationale, status-prose) lives in the retained carrier referenced via CARRIER pointer; the SendMessage body is index-only. Host runtime auto-renders teammate-message envelope body into user-visible UI; free-form body content therefore leaks meeting/work substance to the user surface, breaking the curtain. Recover by moving body content to a retained carrier file and resending with KEY-only envelope shape (e.g., 'CARRIER: claude_doc/.../log.md' + 'STATE: r1-T07-appended' + 'WAKE: drafter')."
  }
}
EOF
      exit 0
    fi
  fi
fi

# Primary check: upward state-class MESSAGE-CLASS header at the start of the
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
