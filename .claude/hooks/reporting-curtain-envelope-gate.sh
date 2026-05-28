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
#   4. Explicit user acknowledgment or explicit user instruction authorizing the named protected-surface mutation
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
#   - Inspects decoded tool_input.summary and tool_input.message together.
#   - Summary carries only empty/whitespace or canonical no-detail routing
#     tokens; runtime agent handles such as @R1-reviewer and parenthesized
#     role labels such as (reviewer) are routing tokens, not receiver-required
#     content.
#   - Message carries only empty/whitespace, one carrier-pointer/index KEY
#     line, or the exact structured shutdown object
#     {"type":"shutdown_request"} / {"type":"shutdown_response"}.
#     String-rendered user-visible body exposure ceiling is one non-empty line.
#   - Downward assignment/reuse/reroute/phase-transition-control details stay
#     in a governed carrier or task state referenced by that one visible line.
#
# Recovery
#   Resend with the canonical envelope per
#   .claude/skills/task-execution/references/message-classes.md
#   `### Transport Payload`:
#     - summary parameter = canonical no-detail routing token only.
#     - message body = empty string, single ASCII space, one
#       carrier-pointer/index KEY line, or exact structured shutdown object.
#     - Downward assignment/reuse/reroute/phase-transition-control packet
#       detail lives in the governed carrier or task state referenced by the
#       one-line visible body.
#     - Receiver-required detail moves to a governed carrier, task state,
#       packet, or evidence artifact referenced by the visible envelope.
#
# Failure mode
#   Fail-open on any hook-internal error (malformed JSON, bash exception).
#   The hook never blocks on its own bug. Governance text and identity-layer
#   commitment remain the primary control; this hook is the final binary
#   safety net.
#
# Implementation
#   Bash wrapper + existing Node helper
#   .claude/hooks/lib/hook-json-helpers.js parseInput(). JSON parsing is used
#   so escaped quotes and encoded newlines are inspected as actual strings.
#
# Footprint
#   Single PreToolUse matcher on "SendMessage" tool. No filesystem writes.
#   No long-running operations. Single JSON parse and string validation.

set +e  # fail-open posture

INPUT_JSON="$(cat 2>/dev/null)"
if [ -z "$INPUT_JSON" ]; then
  exit 0
fi

HOOK_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)"
HOOK_JSON_HELPERS="$HOOK_DIR/lib/hook-json-helpers.js"

if [ ! -f "$HOOK_JSON_HELPERS" ]; then
  exit 0
fi

INPUT_JSON="$INPUT_JSON" HOOK_JSON_HELPERS="$HOOK_JSON_HELPERS" node <<'NODE' 2>/dev/null || true
const { parseInput } = require(process.env.HOOK_JSON_HELPERS);

const input = parseInput();
if (String(input.tool_name || "") !== "SendMessage") process.exit(0);

const toolInput = input.tool_input || {};
const summary = String(toolInput.summary ?? input.summary ?? "");
const rawMessage = toolInput.message ?? input.message ?? "";
const message = typeof rawMessage === "string" ? rawMessage : String(rawMessage ?? "");

function deny(reason) {
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: reason,
    },
  }, null, 2));
  process.exit(0);
}

function hasFreeformSummary(text) {
  const trimmed = text.trim();
  if (!trimmed) return false;
  if (text.includes("\n") || text.includes("\r")) return true;
  if (trimmed.length > 80) return true;
  if (/[\\/?!,;"'`{}[\]]/.test(trimmed)) return true;
  if (/\b(findings?|defects?|evidence|rationale|summary|details?|counts?|paths?|files?|lines?|open-surfaces|basis|because|leaks?|leaked|results?)\b/i.test(trimmed)) return true;

  const noDetailClassTokens = new Set([
    "ack",
    "active",
    "assignment",
    "carrier-only",
    "completion",
    "consent",
    "critique-request",
    "critique-response",
    "draft-publication",
    "draft-update",
    "for",
    "hold",
    "hold|blocker",
    "hold-blocker",
    "no-objection",
    "pass",
    "phase-transition-control",
    "redirect",
    "reroute",
    "reuse",
    "scope-pressure",
    "shutdown-request",
    "shutdown-response",
    "shutdown_request",
    "shutdown_response",
    "status",
    "task",
    "turn",
    "verdict",
    "wake",
  ]);
  const roleTokens = new Set([
    "critic",
    "developer",
    "drafter",
    "researcher",
    "reviewer",
    "team-lead",
    "tester",
    "validator",
    "worker",
  ]);

  function tokenize(segment) {
    return segment.trim().match(/\([^()\s]+\)|[^\s]+/g) || [];
  }

  function normalized(token) {
    return token.trim().toLowerCase();
  }

  function isNoDetailClassToken(token) {
    const lower = normalized(token);
    if (noDetailClassTokens.has(lower)) return true;
    return /^(r|t)[0-9]+$/i.test(token)
      || /^(round|turn|task|batch|wave)-[A-Za-z0-9_.|-]+$/i.test(token);
  }

  function isRoleToken(token) {
    const lower = normalized(token);
    if (roleTokens.has(lower)) return true;
    const match = token.match(/^\(([A-Za-z][A-Za-z0-9_.|-]*)\)$/);
    return Boolean(match && roleTokens.has(match[1].toLowerCase()));
  }

  function isRoutingIdentifierToken(token) {
    if (!/^[A-Za-z0-9@][A-Za-z0-9_.|@-]*$/.test(token)) return false;
    if (/^@[A-Za-z0-9][A-Za-z0-9_.|-]*$/.test(token)) return true;
    if (/^[0-9]+$/.test(token)) return true;
    if (/^(agent|worker|lane|shard|batch|wave|task|round|turn)[-_]?[A-Za-z0-9_.|-]+$/i.test(token)) return true;
    return /[0-9]/.test(token) && /[-_.|]/.test(token);
  }

  const colonCount = (trimmed.match(/:/g) || []).length;
  if (colonCount > 1) return true;
  const segments = trimmed.split(":").map((segment) => segment.trim());
  if (segments.some((segment) => !segment)) return true;
  if (colonCount === 1 && !isNoDetailClassToken(segments[0])) return true;

  const tokens = segments.flatMap(tokenize);
  if (tokens.length > 8) return true;
  return !tokens.every((token) => (
    isNoDetailClassToken(token)
    || isRoleToken(token)
    || isRoutingIdentifierToken(token)
  ));
}

if (hasFreeformSummary(summary)) {
  deny("Reporting-curtain envelope violation: SendMessage summary contains free-form detail or non-canonical token shape. Summary is user-visible and may carry only empty/whitespace or a short no-detail routing token. Receiver-required detail belongs in the governed carrier, task state, packet, or evidence artifact referenced by the message body pointer.");
}

function isStructuredShutdownPayload(value) {
  if (!value || typeof value !== "object" || Array.isArray(value)) return false;
  const keys = Object.keys(value);
  return keys.length === 1
    && keys[0] === "type"
    && (value.type === "shutdown_request" || value.type === "shutdown_response");
}

if (isStructuredShutdownPayload(rawMessage)) {
  process.exit(0);
}

const body = message.replace(/\r\n/g, "\n").replace(/\r/g, "\n");
if (!body.trim()) process.exit(0);

const lines = body.split("\n").filter((line) => line.trim() !== "");
if (lines.length > 1) {
  deny("Reporting-curtain envelope violation: SendMessage body exceeds the one-line visible exposure ceiling. Assignment packets, team-meeting turns, critique, findings, rationale, evidence, and status detail belong in a governed carrier, task state, packet carrier, or evidence artifact referenced by one visible pointer line.");
}

const allowedKey = /^(CARRIER|STATE|ROUND|TURN|WAKE|NEXT|FROM|TO|VERDICT|CRITIQUE|REDIRECT|REPORT-REASON|TASK-ID|RETAINED-OUTPUT-PATH|UPSTREAM-DECISION-BASIS):[ \t]\S/;
const pathKeys = new Set(["CARRIER", "RETAINED-OUTPUT-PATH"]);
const reportReasons = new Set([
  "final verified result",
  "user-action blocker",
  "explicit status answer",
  "closeout residual",
]);
const closedValues = {
  VERDICT: new Set(["PASS", "HOLD", "FAIL", "carrier-only"]),
  CRITIQUE: new Set([
    "critique-request",
    "critique-response",
    "carrier-only",
    "candidate-classified",
    "candidate-classified-with-revision",
    "revision-required",
    "no-objection",
    "CONSENT",
    "HOLD",
  ]),
  REDIRECT: new Set([
    "carrier-only",
    "packet-correction",
    "scope-pressure",
    "hold-blocker",
    "owner-correction",
  ]),
};
const substantiveToken = /(found|finding|findings|defect|defects|critical|major|minor|because|leak|leaks|leaked|evidence|count|counts|rationale|reasoning|summary|detail|details|files|lines|open[-_]?surfaces|open|surface|surfaces|result|results)/i;

for (const rawLine of lines) {
  const line = rawLine.trim();
  if (!allowedKey.test(line)) {
    deny("Reporting-curtain envelope violation: SendMessage body contains a free-form or disallowed rendered line. The visible body may contain only canonical carrier-pointer/index KEY lines and must not contain MESSAGE-CLASS, assignment packet fields, critique body, rationale, findings, evidence, or progress prose.");
  }
  const key = line.slice(0, line.indexOf(":"));
  const value = line.slice(line.indexOf(":") + 1).trim();
  if (!pathKeys.has(key)) {
    if (key === "REPORT-REASON") {
      if (!reportReasons.has(value)) {
        deny("Reporting-curtain envelope violation: REPORT-REASON body value is not a canonical report reason. Non-canonical report wording belongs in the governed carrier.");
      }
      continue;
    }
    if (substantiveToken.test(value)) {
      deny("Reporting-curtain envelope violation: SendMessage body KEY value contains substantive finding, evidence, count, rationale, result, or leakage wording. Non-path KEY values must stay closed-vocabulary no-detail index labels.");
    }
    if (closedValues[key] && !closedValues[key].has(value)) {
      deny("Reporting-curtain envelope violation: SendMessage body KEY value is outside the closed no-detail vocabulary for that KEY. Receiver-required detail belongs in the governed carrier.");
    }
    if (key === "ROUND" && !/^(r[0-9]+|round-[0-9]+)$/i.test(value)) {
      deny("Reporting-curtain envelope violation: ROUND value must be a no-detail round identifier.");
    }
    if (key === "TURN" && !/^([Tt][0-9]+|turn-[0-9]+)$/.test(value)) {
      deny("Reporting-curtain envelope violation: TURN value must be a no-detail turn identifier.");
    }
    if (value.length > 80 || !/^[A-Za-z0-9_.|@-]+$/.test(value)) {
      deny("Reporting-curtain envelope violation: SendMessage body KEY value contains substantive prose. Non-path KEY values must stay no-detail index labels; receiver-required detail belongs in the governed carrier.");
    }
  } else if (value.length > 240) {
    deny("Reporting-curtain envelope violation: SendMessage carrier pointer is too large for the visible envelope. Use the smallest governed carrier path or task-state pointer.");
  }
}
NODE

exit 0
