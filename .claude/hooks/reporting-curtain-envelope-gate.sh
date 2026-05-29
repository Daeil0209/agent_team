#!/usr/bin/env bash
# reporting-curtain-envelope-gate.sh
#
# PROTECTED-LOCAL-RESTATEMENT-BASIS: see .claude/reference/modification-core-law.md ## Constitutional Curtain Protection for canonical owner and constitutional-curtain-visibility basis.
# PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE
# This hook is enumerated as constitutionally-protected per
# .claude/reference/modification-core-law.md ## Constitutional Curtain Protection.
# Disabling, removing, or weakening this hook (script body, hook wiring in
# settings.json) requires:
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
#   message payload instead of the canonical no-detail envelope. This was
#   observed repeatedly across reporting-prohibition patch waves: governance
#   text patches alone did not prevent the violation because lane
#   composition habit (showing thoroughness inline, explaining context
#   inline) overrode the rule at write moment.
#
# Scope (narrow)
#   - Only fires on tool_name == "SendMessage".
#   - Inspects decoded non-body rendered field and message payload together.
#   - The non-body rendered field carries only empty/whitespace. Any non-empty
#     value is a rendered report attempt and is denied.
#   - Message must be a structured no-detail object. String messages are denied
#     because Claude Code requires summary for string message payloads, and
#     summary is prohibited by the reporting curtain.
#   - Message carries only a structured carrier pointer, structured state signal,
#     structured no-detail index pointer, or the exact structured shutdown object
#     {"type":"shutdown_request"} / {"type":"shutdown_response"}.
#   - Downward assignment/reuse/reroute/phase-transition-control details stay
#     in a governed carrier referenced by that one visible line.
#
# Recovery
#   Resend with the canonical envelope per
#   .claude/skills/task-execution/references/message-classes.md
#   `### Transport Payload`:
#     - non-body rendered field = empty/whitespace only.
#     - message payload = structured carrier pointer, structured state signal,
#       structured no-detail index pointer, or exact structured shutdown object.
#     - Downward assignment/reuse/reroute/phase-transition-control packet
#       detail lives in the governed carrier referenced by the one-line
#       visible body.
#     - Receiver-required detail moves to a governed carrier, packet, or
#       evidence artifact referenced by the visible envelope.
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
#   No long-running operations. Single JSON parse and structured-payload validation.

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
const nonBodyRenderedField = String(toolInput.summary ?? input.summary ?? "");
const rawMessage = toolInput.message ?? input.message ?? "";

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

if (nonBodyRenderedField.trim()) {
  deny("Reporting-curtain envelope violation: SendMessage non-body rendered field must be empty/whitespace. Receiver-required detail belongs in the governed carrier, packet, or evidence artifact referenced by the structured message pointer.");
}

const pathKeys = new Set(["CARRIER", "RETAINED-OUTPUT-PATH"]);
const allowedKeys = new Set(["CARRIER", "STATE", "ROUND", "TURN", "WAKE", "NEXT", "FROM", "TO", "VERDICT", "CRITIQUE", "REDIRECT", "REPORT-REASON", "RETAINED-OUTPUT-PATH", "UPSTREAM-DECISION-BASIS"]);
const stateClasses = new Set(["ack", "dispatch-ack", "status", "completion", "scope-pressure", "hold|blocker"]);
const carrierClasses = new Set(["assignment", "reuse", "reroute", "phase-transition-control", "critique-request", "critique-response", "verdict", "redirect", "peer-note", "correction"]);
const reportReasons = new Set(["final verified result", "user-action blocker", "explicit status answer", "closeout residual"]);
const closedValues = {
  VERDICT: new Set(["PASS", "HOLD", "FAIL", "carrier-only"]),
  CRITIQUE: new Set(["critique-request", "critique-response", "carrier-only", "candidate-classified", "candidate-classified-with-revision", "revision-required", "no-objection", "CONSENT", "HOLD"]),
  REDIRECT: new Set(["carrier-only", "packet-correction", "scope-pressure", "hold-blocker", "owner-correction"]),
};
const substantiveToken = /(found|finding|findings|defect|defects|critical|major|minor|because|leak|leaks|leaked|evidence|count|counts|rationale|reasoning|summary|detail|details|files|lines|open[-_]?surfaces|open|surface|surfaces|result|results)/i;

function isStructuredShutdownPayload(value) {
  if (!value || typeof value !== "object" || Array.isArray(value)) return false;
  const keys = Object.keys(value);
  return keys.length === 1
    && keys[0] === "type"
    && (value.type === "shutdown_request" || value.type === "shutdown_response");
}

function requireNoExtraKeys(value, allowed) {
  for (const key of Object.keys(value)) {
    if (!allowed.has(key)) {
      deny("Reporting-curtain envelope violation: SendMessage structured payload contains an unsupported field. Receiver-required detail belongs in the governed carrier.");
    }
  }
}

function checkKeyValue(key, value) {
  if (!allowedKeys.has(key)) {
    deny("Reporting-curtain envelope violation: SendMessage structured payload contains a free-form or disallowed key. Use only canonical carrier-pointer/index keys and keep receiver-required detail in the governed carrier.");
  }
  if (pathKeys.has(key)) {
    if (!value || value.length > 240) {
      deny("Reporting-curtain envelope violation: SendMessage carrier pointer is missing or too large for the visible envelope. Use the smallest governed carrier path.");
    }
    return;
  }
  if (key === "REPORT-REASON") {
    if (!reportReasons.has(value)) {
      deny("Reporting-curtain envelope violation: REPORT-REASON value is not a canonical report reason. Non-canonical report wording belongs in the governed carrier.");
    }
    return;
  }
  if (substantiveToken.test(value)) {
    deny("Reporting-curtain envelope violation: SendMessage structured KEY value contains substantive finding, evidence, count, rationale, result, or leakage wording. Non-path KEY values must stay closed-vocabulary no-detail index labels.");
  }
  if (closedValues[key] && !closedValues[key].has(value)) {
    deny("Reporting-curtain envelope violation: SendMessage structured KEY value is outside the closed no-detail vocabulary for that KEY. Receiver-required detail belongs in the governed carrier.");
  }
  if (key === "ROUND" && !/^(r[0-9]+|round-[0-9]+)$/i.test(value)) {
    deny("Reporting-curtain envelope violation: ROUND value must be a no-detail round identifier.");
  }
  if (key === "TURN" && !/^([Tt][0-9]+|turn-[0-9]+)$/.test(value)) {
    deny("Reporting-curtain envelope violation: TURN value must be a no-detail turn identifier.");
  }
  if (value.length > 80 || !/^[A-Za-z0-9_.|@-]+$/.test(value)) {
    deny("Reporting-curtain envelope violation: SendMessage structured KEY value contains substantive prose. Non-path KEY values must stay no-detail index labels; receiver-required detail belongs in the governed carrier.");
  }
}

if (isStructuredShutdownPayload(rawMessage)) {
  process.exit(0);
}

if (typeof rawMessage === "string") {
  deny("Reporting-curtain envelope violation: SendMessage message must be a structured no-detail object. String message payloads trigger Claude Code's required summary field, and summary is prohibited by the reporting curtain.");
}

if (!rawMessage || typeof rawMessage !== "object" || Array.isArray(rawMessage)) {
  deny("Reporting-curtain envelope violation: SendMessage message payload is missing or not a structured no-detail object.");
}

if (rawMessage.type === "state_signal") {
  requireNoExtraKeys(rawMessage, new Set(["type", "class"]));
  const klass = String(rawMessage.class || "").trim();
  if (!stateClasses.has(klass)) {
    deny("Reporting-curtain envelope violation: SendMessage state_signal class is not a canonical no-detail state signal.");
  }
  process.exit(0);
}

if (rawMessage.type === "carrier_pointer") {
  requireNoExtraKeys(rawMessage, new Set(["type", "class", "key", "value"]));
  const klass = String(rawMessage.class || "").trim();
  if (klass && !carrierClasses.has(klass)) {
    deny("Reporting-curtain envelope violation: SendMessage carrier_pointer class is outside the closed no-detail transport class set.");
  }
  checkKeyValue(String(rawMessage.key || "").trim(), String(rawMessage.value || "").trim());
  process.exit(0);
}

if (rawMessage.type === "index_pointer") {
  requireNoExtraKeys(rawMessage, new Set(["type", "key", "value"]));
  checkKeyValue(String(rawMessage.key || "").trim(), String(rawMessage.value || "").trim());
  process.exit(0);
}

deny("Reporting-curtain envelope violation: SendMessage structured payload type is not allowed. Use state_signal, carrier_pointer, index_pointer, shutdown_request, or shutdown_response.");
NODE

exit 0
