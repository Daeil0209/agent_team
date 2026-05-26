#!/usr/bin/env bash
# assistant-response-curtain-gate.sh
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
# Approval basis for installation: 2026-05-26 curtain-constitutional-fix-2026-05-26
# (user-authorized via "독립적이면서 안전한 보완 패치를 신중하게 진행해").
#
# Active hook: Stop event
#
# Purpose
#   Enforce the reporting-prohibition default-suppress rule at runtime on the
#   assistant's main turn-ending response prose. This hook is the structural
#   complement to the constitutional curtain layer at top doctrine (CLAUDE.md
#   ## Constitutional Reporting Curtain), the mapped 4-invariant detail at
#   reporting-core-law.md ## Constitutional 4-Invariant Detail, the identity-
#   layer Curtained Communication attribute atomic-check (team-lead attribute
#   (i); lane role IR-3), the SendMessage envelope hook (reporting-curtain-
#   envelope-gate.sh), and the session-start curtain self-validation block.
#   Together they make reporting-prohibition independent of governance-text
#   patch erosion cycles documented in claude_doc/curtain-constitutional-fix-
#   2026-05-26/forensic-report.md.
#
# Protected failure
#   Main assistant response prose leakage on controllable renderable surfaces
#   without REPORT-REASON declaration. Past 3+ patch waves documented in
#   forensic-report.md show that governance-text-only protection erodes via
#   subsequent "Consolidate / Tighten / Reduce / Sweep" commits. The main
#   response prose surface has no PreAssistantResponse hook in current Claude
#   Code architecture; the Stop hook is the closest post-hoc detection layer.
#
# Honest limitation
#   This hook fires AFTER the visible response is composed; it cannot un-emit
#   prose already shown to the user. Its role is:
#     (i)   detection signal
#     (ii)  force-continuation via {"decision":"block","reason":...} so the
#           model receives the breach reason and applies self-correction in
#           subsequent turns within the session
#     (iii) audit trail entry (when wired through health/violation log paths)
#   First-leak prevention requires identity-layer atomic-check + worked example
#   + model self-discipline (the upstream-of-hook layers).
#
# Scope (narrow)
#   - Only fires on Claude Code Stop event.
#   - Reads assistant transcript JSON (last turn's response content).
#   - Allows when response body is empty or whitespace-only.
#   - Allows when response leads with valid REPORT-REASON declaration.
#   - Blocks ONLY when (a) response contains confirmed non-reportable patterns
#     AND (b) no valid REPORT-REASON declaration is present at the top.
#
# Recovery
#   Continue the active Procedure Plane action; resume with corrective emission
#   shape next turn (empty body or REPORT-REASON-declared narrow exception per
#   .claude/reference/reporting-prohibition-law.md ## Report Shape).
#
# Failure mode
#   Fail-open on any hook-internal error. The hook never blocks on its own bug.
#   Governance text + identity-layer atomic-check + model self-discipline
#   remain the primary control; this hook is the post-emission detection net.
#
# Footprint
#   Single Stop hook entry. No filesystem writes. No long-running operations.
#   Single grep/regex pass on stdin input.

set +e  # fail-open posture

INPUT_JSON="$(cat 2>/dev/null)"
if [ -z "$INPUT_JSON" ]; then
  exit 0
fi

# Extract assistant's last response text from the transcript.
# Claude Code Stop hook delivers the conversation context as JSON. The exact
# schema depends on harness version; we look for the most recent assistant
# message content using a tolerant approach (last "content" field).
LAST_RESPONSE="$(printf '%s' "$INPUT_JSON" | grep -oE '"text"[[:space:]]*:[[:space:]]*"[^"]*"' | tail -1 | sed -E 's/^"text"[[:space:]]*:[[:space:]]*"(.*)"$/\1/')"

# If we could not extract a response, fail-open.
if [ -z "$LAST_RESPONSE" ]; then
  exit 0
fi

# Allow when response body is empty or whitespace-only.
TRIMMED="$(printf '%s' "$LAST_RESPONSE" | tr -d '[:space:]\\n\\t')"
if [ -z "$TRIMMED" ]; then
  exit 0
fi

# Check for REPORT-REASON declaration at top of response.
# Accepted forms (case-insensitive):
#   English class names: "final verified result", "user-action blocker",
#                        "explicit status answer", "closeout residual"
#   Korean class names:  "최종 검증 결과", "사용자 행동 차단",
#                        "명시적 상태 응답", "종결 잔여"
#   Pre-Report-Gate-cited form: "REPORT-REASON: <one-of-4>"
# Top-of-response scope: first 500 chars (covers leading sentence + bullets).
LEADING_500="$(printf '%s' "$LAST_RESPONSE" | head -c 500)"

REPORT_REASON_PRESENT=0
if printf '%s' "$LEADING_500" | grep -qiE 'final verified result|user-action blocker|explicit status answer|closeout residual'; then
  REPORT_REASON_PRESENT=1
fi
if [ "$REPORT_REASON_PRESENT" = "0" ]; then
  if printf '%s' "$LEADING_500" | grep -qE '최종 검증 결과|사용자 행동 차단|명시적 상태 응답|종결 잔여'; then
    REPORT_REASON_PRESENT=1
  fi
fi
if [ "$REPORT_REASON_PRESENT" = "0" ]; then
  if printf '%s' "$LEADING_500" | grep -qiE 'REPORT-REASON[[:space:]]*:'; then
    REPORT_REASON_PRESENT=1
  fi
fi

# If REPORT-REASON declared, allow.
if [ "$REPORT_REASON_PRESENT" = "1" ]; then
  exit 0
fi

# Look for non-reportable patterns in the response.
# Patterns (case-insensitive regex, anchored where appropriate):
#   ^Step \d+ ... (process-narrative step header at start of line)
#   Skill\(...\) (loaded|complete|converged) (skill-load narration)
#   review_verification_packet | PASS-[12] | CONVERGENCE-PASS (verification packet content)
#   ^(Now|이제) (applying|continuing|... | 진행|적용|...) (process-continuation narrative)
#   ^Wave \d+ (wave status narration)
#   defeater | FINDING-STATE | PROBLEM-BASIS | CONSUMED-TARGET-SURFACE (verification content)
NON_REPORTABLE_MATCH=0

if printf '%s' "$LAST_RESPONSE" | grep -qE '(^|\n)Step [0-9]+[^a-zA-Z0-9_-]'; then
  NON_REPORTABLE_MATCH=1
fi
if [ "$NON_REPORTABLE_MATCH" = "0" ] && printf '%s' "$LAST_RESPONSE" | grep -qiE 'Skill\([^)]+\)[[:space:]]+(loaded|complete|converged|consumed)'; then
  NON_REPORTABLE_MATCH=1
fi
if [ "$NON_REPORTABLE_MATCH" = "0" ] && printf '%s' "$LAST_RESPONSE" | grep -qE 'review_verification_packet|PASS-[12]|CONVERGENCE-PASS'; then
  NON_REPORTABLE_MATCH=1
fi
if [ "$NON_REPORTABLE_MATCH" = "0" ] && printf '%s' "$LAST_RESPONSE" | grep -qiE '(^|\n)(Now|이제)[[:space:]]+(applying|continuing|checking|dispatching|verifying|monitoring|waiting|proceeding|starting|진행|적용|확인|발송|검증|모니터링|대기)'; then
  NON_REPORTABLE_MATCH=1
fi
if [ "$NON_REPORTABLE_MATCH" = "0" ] && printf '%s' "$LAST_RESPONSE" | grep -qE '(^|\n)Wave [0-9]+[^a-zA-Z0-9_-]'; then
  NON_REPORTABLE_MATCH=1
fi
if [ "$NON_REPORTABLE_MATCH" = "0" ] && printf '%s' "$LAST_RESPONSE" | grep -qE 'FINDING-STATE-INVENTORY|PROBLEM-BASIS|CONSUMED-TARGET-SURFACE|defeater'; then
  NON_REPORTABLE_MATCH=1
fi

# If no non-reportable patterns matched, allow.
if [ "$NON_REPORTABLE_MATCH" = "0" ]; then
  exit 0
fi

# Block: non-reportable patterns AND no REPORT-REASON declaration.
cat <<EOF
{
  "decision": "block",
  "reason": "Reporting-curtain breach: assistant response contains non-reportable process narrative, verification packet content, skill-load narration, or wave/dispatch narration without an explicit REPORT-REASON declaration at top. Per .claude/CLAUDE.md ## Constitutional Reporting Curtain and .claude/reference/reporting-prohibition-law.md ## Pre-Report Gate, controllable assistant-authored emission requires explicit REPORT-REASON from {final verified result | user-action blocker | explicit status answer | closeout residual}. Default emission is empty body or single ASCII space. Continue the active Procedure Plane action; resume with corrective emission shape (empty body or REPORT-REASON-declared narrow exception). This block is a force-continuation signal for in-session self-correction; the visible response already shown to the user is the post-hoc detected breach. Forensic: claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md."
}
EOF

exit 0
