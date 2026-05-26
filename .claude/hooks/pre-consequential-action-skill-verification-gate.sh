#!/usr/bin/env bash
# pre-consequential-action-skill-verification-gate.sh
#
# PROTECTED-LOCAL-RESTATEMENT-BASIS: see .claude/reference/modification-core-law.md ## Constitutional Curtain Protection for canonical owner and constitutional-curtain-visibility basis; this hook is the runtime enforcement layer for the essence-discipline patch wave per team-meeting `team-lead-essence-discipline` r2 4/4 critic consent (carrier: claude_doc/governance-audit-2026-05-27/meetings/team-lead-essence-discipline/draft-r2.md).
# PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE
# Disabling, removing, or weakening this hook (script body, hook wiring in
# settings.json, or registration in MANIFEST.md) requires:
#   1. Skill(governance-modification) Step 3 review-verification packet
#   2. Validator pre-approval (CLAIM-CEILING: validator-final-verdict, PASS verdict)
#   3. User notification with constitutional invariant + forensic erosion cycle disclosure
#   4. User acknowledgment or absence of objection in the same turn segment
# Approval basis for installation: team-meeting team-lead-essence-discipline r2 4/4 critic CONSENT
# (developer T14+T18 / researcher T15+T19 / reviewer-shard-a T16 / reviewer-shard-b T17) +
# operator directive "ANTI-PASSIVE-WAIT 즉시 실행" + "patches must be generalized"
#
# Active hook: PreToolUse
#
# Purpose
#   Enforce structural verification-evidence-presence at the runtime composition
#   moment for consequential team-lead actions. This hook is the structural
#   complement to the identity-layer Curtained Communication attribute, the
#   Essence-Evidence Law in work-execution-core-law, and the Skill load /
#   review-verification packet citation rules in work-skill-reference-binding-law.
#   Together they make verification-evidence-presence independent of
#   composition-habit erosion: identity primes intent at spawn moment;
#   work-execution-core-law records the rule; this hook enforces presence at
#   emission moment.
#
# Protected failure (from team-meeting r2 RC inventory)
#   - RC-B Self-rule blind spot: team-lead writes/supervises a rule then
#     violates it in own emission (F-S4 curtain self-violation pattern).
#   - RC-G Surface-pattern matching to essence: team-lead substitutes
#     text-addition for actual essence-resolution (F-S1 surface-trigger-
#     proposal pattern; F-S6 coverage-survey deficit pattern).
#   - RC-A Essence-test absence: team-lead emits consequential governance
#     proposal without independent essence-evidence (covered by Essence-
#     Evidence Law in work-execution-core-law; hook enforces presence at
#     emission moment).
#   - RC-D Role-separation gap (partial): team-lead self-executes work that
#     belongs to a frozen independent owner (F-S2 premature-dispatch +
#     F-S3 self-test patterns); hook enforces DISPATCH-AUTHORIZATION-BASIS
#     presence on assignment-grade SendMessage.
#
# Scope (narrow, deterministic)
#   - Only fires on PreToolUse with tool_name in the consequential-action set.
#   - Consequential-action set: Edit / MultiEdit / Write on .claude/* (governance
#     mutation); SendMessage with MESSAGE-CLASS: assignment / reuse / reroute
#     (assignment-grade lane dispatch); Bash invocation matching test/proof/
#     validation execution pattern when not in carve-out (architectural enablement
#     detection per Pattern A negative-scope boundary).
#   - Empty / single-space message body passes through unaffected.
#   - Non-consequential tools (Read / Grep / Glob / WebSearch / WebFetch / TaskList
#     / TaskGet / TaskOutput / etc.) pass through.
#   - Pattern A codex CLI carve-out: Bash containing `codex` subcommand passes
#     through (lead-internal aid per concurrent-patterns.md Pattern A).
#   - Read-equivalent Bash carve-out: Bash containing only ls / grep / cat / find
#     / stat / wc / head / tail / sed -n (read-only) without execution-side-effect
#     passes through.
#   - Version/help Bash carve-out: Bash with --version / --help / -V / -h
#     passes through (non-execution diagnostic invocations).
#
# Check (deterministic, no heuristics)
#   For governance mutation (Edit/MultiEdit/Write on .claude/*):
#     - Active Skill(governance-modification) load evidence in same-session
#       transcript (deterministic transcript regex check for the literal Skill
#       tool invocation).
#     - Block-on-missing per anti-fabrication rule (carrier-prose claim of
#       "Skill loaded" without same-session tool-call invocation fails).
#
#   For assignment-grade SendMessage (MESSAGE-CLASS: assignment / reuse / reroute):
#     - DISPATCH-AUTHORIZATION-BASIS field present in message body.
#     - Block-on-missing per assignment-packet.md DISPATCH-AUTHORIZATION-BASIS
#       rule (missing/unverifiable/non-traceable routes to packet-correction).
#
#   For Bash test/proof/validation pattern (architectural enablement detection):
#     - Detect command-name match: pytest / jest / playwright / vitest /
#       cypress / mocha / curl-non-readonly / wget / nodemon / npm-test /
#       pnpm-test / yarn-test / go-test / cargo-test / rspec / phpunit.
#     - Apply carve-out (codex / read-equivalent / --version / --help).
#     - On match without carve-out: block with routing recommendation
#       (route to tester / validator lane per §6 Judgment Philosophy +
#       Pattern A negative-scope boundary).
#
# Failure mode
#   Fail-open on any hook-internal error (malformed JSON, bash exception).
#   The hook never blocks on its own bug. Governance text and identity-layer
#   commitment remain the primary control; this hook is the final binary
#   safety net for the structural enforcement of essence-discipline rules.
#
# Implementation
#   Pure bash + grep, no jq dependency. Transcript inspection is limited to
#   stdin-supplied PreToolUse input (Claude Code may include conversation
#   transcript context); pattern-match is conservative (false-positive favored
#   over false-negative — better to allow than to block legitimate work).
#
# Footprint
#   Single PreToolUse matcher with conditional branching on tool_name.
#   No filesystem writes. No long-running operations.
#   Pure grep/sed pattern matching on stdin input.

set +e  # fail-open posture

INPUT_JSON="$(cat 2>/dev/null)"
if [ -z "$INPUT_JSON" ]; then
  exit 0
fi

# Extract tool_name
TOOL_NAME=$(printf '%s' "$INPUT_JSON" | grep -oE '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/^"tool_name"[[:space:]]*:[[:space:]]*"//' | sed -E 's/"$//')

if [ -z "$TOOL_NAME" ]; then
  exit 0
fi

# ============================================================================
# Branch 1: Governance mutation — Edit / MultiEdit / Write on .claude/*
# Check: same-session Skill(governance-modification) tool-call evidence
# STATUS: ADVISORY-ONLY pending Skill-evidence tracking integration.
# Rationale: PreToolUse hook input does NOT include conversation transcript;
# direct transcript scan is infeasible from PreToolUse. Proper enforcement
# requires sv-tracker.sh-style PostToolUse Skill load state file + this hook
# reading that state file. Until that integration is added, this branch is
# advisory-only (no block) to avoid false-positive self-blocking.
# Active enforcement remains via:
# - existing compliance-supervisor.sh hook (broader governance-mutation guard)
# - Skill(governance-modification) discipline + carrier-citation rule per
#   .claude/reference/work-skill-reference-binding-law.md ## Skill Rules
# - identity-layer team-lead Operating Philosophy commitment
# This branch will activate as blocking once skill-evidence state file
# integration is added (separate follow-on patch).
# ============================================================================
# (intentionally advisory-only; no deny emit)

# ============================================================================
# Branch 2: Assignment-grade SendMessage — MESSAGE-CLASS: assignment/reuse/reroute
# Check: DISPATCH-AUTHORIZATION-BASIS field present
# ============================================================================
if [ "$TOOL_NAME" = "SendMessage" ]; then
  # Detect assignment-grade MESSAGE-CLASS
  ASSIGNMENT_HEADER_RE='"message"[[:space:]]*:[[:space:]]*"MESSAGE-CLASS:[[:space:]]*(assignment|reuse|reroute)'
  if printf '%s' "$INPUT_JSON" | grep -qE "$ASSIGNMENT_HEADER_RE"; then
    # Check for DISPATCH-AUTHORIZATION-BASIS presence
    if ! printf '%s' "$INPUT_JSON" | grep -qE 'DISPATCH-AUTHORIZATION-BASIS:'; then
      cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Essence-discipline violation: assignment-grade SendMessage (MESSAGE-CLASS: assignment/reuse/reroute) without DISPATCH-AUTHORIZATION-BASIS field in packet body. Per .claude/skills/task-execution/references/assignment-packet.md '## Downward Assignment Base Packet' DISPATCH-AUTHORIZATION-BASIS rule, every assignment-grade packet MUST name the active owner's decision authority (recognized open-set bases: frozen-independent-lane:<lane>, proven-user-owned-blocker:<named-constraint>, team-meeting-outcome:<meeting-id>, or other recorded owner-authorized basis). Recover by adding DISPATCH-AUTHORIZATION-BASIS line to message body before send. This gate enforces F-S2 premature-dispatch pattern closure per team-meeting team-lead-essence-discipline r2."
  }
}
EOF
      exit 0
    fi
  fi
fi

# ============================================================================
# Branch 3: Bash test/proof/validation pattern detection
# Check: command matches test-runner pattern AND not in carve-out
# Recommend: route to tester / validator lane per §6
# ============================================================================
if [ "$TOOL_NAME" = "Bash" ]; then
  # Extract command
  CMD_TEXT=$(printf '%s' "$INPUT_JSON" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/^"command"[[:space:]]*:[[:space:]]*"//' | sed -E 's/"$//')

  # Carve-out: codex Pattern A
  if printf '%s' "$CMD_TEXT" | grep -qE '(^|[^a-zA-Z_])codex[[:space:]]'; then
    exit 0
  fi

  # Carve-out: --version / --help / -V / -h
  if printf '%s' "$CMD_TEXT" | grep -qE '\-\-version|\-\-help|[[:space:]]\-V[[:space:]]|[[:space:]]\-h[[:space:]]|[[:space:]]\-V$|[[:space:]]\-h$'; then
    exit 0
  fi

  # Test/proof/validation pattern detection (architectural enablement per F-S3)
  # Split into three patterns to avoid nested-alternation parser confusion in grep -E.
  TEST_PATTERN_DIRECT='(^|[^a-zA-Z0-9_])(pytest|jest|playwright|vitest|cypress|mocha|wget|nodemon|rspec|phpunit)([[:space:]]|$)'
  TEST_PATTERN_RUNNER='(^|[^a-zA-Z0-9_])(npm|pnpm|yarn|go|cargo)[[:space:]]+test([[:space:]]|$)'
  TEST_PATTERN_CURL='(^|[^a-zA-Z0-9_])curl[[:space:]]+(-X[[:space:]]+(POST|PUT|DELETE|PATCH)|--request[[:space:]]+(POST|PUT|DELETE|PATCH))'
  if printf '%s' "$CMD_TEXT" | grep -qE "$TEST_PATTERN_DIRECT" \
     || printf '%s' "$CMD_TEXT" | grep -qE "$TEST_PATTERN_RUNNER" \
     || printf '%s' "$CMD_TEXT" | grep -qE "$TEST_PATTERN_CURL"; then
    cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Essence-discipline violation: test/proof/validation execution pattern detected in team-lead Bash invocation. Per .claude/skills/codex-independent-review/references/concurrent-patterns.md '## Pattern A — Internal Codex Aid' Negative-Scope Boundary, frozen independent owner work (tester proof execution, validator final arbitration, reviewer review production) is OUTSIDE lead-internal aid scope and MUST route to that owner via Skill(task-execution) dispatch. Detected command appears to be runtime verification/executable test/proof-execution that belongs to a frozen specialist lane. Recover by routing the proof execution to tester or validator lane via assignment-grade SendMessage (with DISPATCH-AUTHORIZATION-BASIS: frozen-independent-lane:<lane>). Carve-outs: codex CLI (Pattern A lead-internal aid), read-equivalent commands (ls/grep/cat/find without execution side-effect), --version/--help diagnostic invocations. This gate enforces F-S3 self-test pattern closure per team-meeting team-lead-essence-discipline r2."
  }
}
EOF
    exit 0
  fi
fi

# Default: allow
exit 0
