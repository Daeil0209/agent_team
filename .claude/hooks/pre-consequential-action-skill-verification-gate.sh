#!/usr/bin/env bash
# pre-consequential-action-skill-verification-gate.sh
#
# GOVERNANCE-RUNTIME-GUARD-SURFACE / DO NOT DISABLE WITHOUT REVIEW
# This hook is not an enumerated constitutional curtain protected surface.
# Disabling, removing, or weakening this hook (script body, hook wiring in
# settings.json) requires Skill(governance-modification)
# mutation readiness, current review-verification basis, and self-verification
# convergence. Constitutional curtain gates apply only if the change also mutates
# an enumerated protected curtain surface in .claude/reference/modification-core-law.md.
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
#   - RC-D Role-separation gap (advisory): team-lead self-executes work that
#     belongs to a frozen independent owner (F-S2 premature-dispatch +
#     F-S3 self-test patterns); assignment packet-quality evidence now lives in
#     governed carriers under one-line rendered-envelope transport,
#     so this hook keeps no active assignment-body detector.
#
# Scope (narrow, deterministic)
#   - Only fires on PreToolUse with tool_name in the consequential-action set.
#   - Consequential-action set: Edit / MultiEdit / Write on .claude/* (governance
#     mutation); Bash invocation matching test/proof/
#     validation execution pattern when not in carve-out (architectural enablement
#     detection per concurrent-patterns.md Team-Lead Variant negative-scope boundary).
#   - Empty / single-space message body passes through unaffected.
#   - Non-consequential read/search tools pass through.
#   - Codex CLI carve-out: Bash containing `codex` subcommand passes
#     through (lead-internal aid per concurrent-patterns.md Codex CLI Background Usage).
#   - Read-equivalent Bash carve-out: Bash containing only ls / grep / cat / find
#     / stat / wc / head / tail / sed -n (read-only) without execution-side-effect
#     passes through.
#   - Version/help Bash carve-out: Bash with --version / --help / -V / -h
#     passes through (non-execution diagnostic invocations).
#
# Check (deterministic, no heuristics)
#   For governance mutation (Edit/MultiEdit/Write on .claude/*):
#     - Branch 1 is advisory-only because PreToolUse input does not provide
#       reliable same-session Skill evidence.
#     - Branch 1 cannot be cited as runtime proof of Skill(governance-modification)
#       compliance; governance-mutation compliance remains owned by doctrine,
#       Skill(governance-modification), review-verification, self-verification,
#       and existing mutation guards.
#     - Active deny requires a separate state-backed evidence design.
#
#   For assignment-grade SendMessage:
#     - Rendered envelope transport carries only a no-detail summary token plus
#       one carrier pointer line.
#     - DISPATCH-AUTHORIZATION-BASIS and packet-quality fields live in the
#       governed assignment packet or retained carrier.
#     - Missing/unverifiable/non-traceable basis routes through task-execution
#       packet preflight, receiving-owner packet correction, and
#       review/self-verification path, not this rendered-envelope hook.
#
#   For Bash test/proof/validation pattern (architectural enablement detection):
#     - Detect command-name match: pytest / jest / playwright / vitest /
#       cypress / mocha / curl-non-readonly / wget / nodemon / npm-test /
#       pnpm-test / yarn-test / go-test / cargo-test / rspec / phpunit.
#     - Apply carve-out (codex / read-equivalent / --version / --help).
#     - On match without carve-out: ADVISORY-ONLY (no deny emit; routing
#       recommendation surfaced via comment block) pending actor-discrimination
#       integration per Branch 3 documentation at lines 158-180; structural-
#       detection scaffold preserved (route to tester / validator lane per
#       §6 Judgment Philosophy + concurrent-patterns.md Team-Lead Variant
#       negative-scope boundary when integration completes).
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
# Advisory target: same-session Skill(governance-modification) tool-call evidence
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
# This branch remains advisory-only. Blocking activation requires a separate
# approved governance patch that adds skill-evidence state-file integration and
# proves it cannot false-positive self-block legitimate governance mutation.
# ============================================================================
# (intentionally advisory-only; no deny emit)

# ============================================================================
# Branch 2: Assignment-grade SendMessage packet-quality
# Check: intentionally no runtime body inspection under one-line rendered-envelope transport.
# STATUS: ADVISORY-ONLY. Hook-Last reserves active deny for destructive,
# security-critical, or session-stability-breaking dangers. Packet-field
# absence is recoverable procedure quality, so this hook must not deny it.
# ============================================================================
if [ "$TOOL_NAME" = "SendMessage" ]; then
  # No stdout: task-execution preflight and the receiving owner inspect the
  # governed packet carrier for DISPATCH-AUTHORIZATION-BASIS.
  :
fi

# ============================================================================
# Branch 3: Bash test/proof/validation pattern detection
# STATUS: ADVISORY-ONLY pending actor-discrimination integration.
# Rationale (per codex independent review Point 2): PreToolUse
# hook input does NOT include agent-identity / session-discriminator, so
# this hook fires identically for team-lead Bash invocations AND for
# tester/validator lane Bash invocations. Active-deny on tester running
# pytest as part of its assigned proof execution would block legitimate
# §6 independent-specialist-lane proof work — a positive-function
# regression. Until session/agent discriminator is available (proper
# enforcement requires Claude Code PreToolUse schema exposing agent
# identity or session role), this branch is advisory-only to preserve
# positive function while keeping the structural-detection scaffold.
# Active essence-discipline enforcement on RC-D/RC-I role-separation
# remains via task-execution packet preflight, receiving-owner packet
# correction, and concurrent-patterns.md Team-Lead Variant negative-scope
# boundary discipline.
# Coverage gap (per codex Point 3): `npm run test` and similar wrapper
# invocations not in original pattern set; if branch is later promoted
# from advisory to active, expand patterns to include `(npm|pnpm|yarn)
# [[:space:]]+(run[[:space:]]+)?test` and similar wrapper shapes.
# ============================================================================
# (intentionally advisory-only; no deny emit until actor-discriminator integration)

# Default: allow
exit 0
