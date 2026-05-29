#!/usr/bin/env bash
# spawn-prompt-screen-safety.sh
#
# Owner reference: .claude/skills/task-execution/references/message-classes.md
# Team Member Startup Recognition owns the screen-safety rule.
#
# Stage: PreToolUse on Agent.
# Behavior: deny only direct startup-leak primes named by the owner rule.

set -euo pipefail

# PROTECTED-LOCAL-RESTATEMENT-BASIS: disabled-stub-preservation — per-stub file retained individually (not consolidated to a single shared shim) for per-file Git history traceability and independent future-narrowing path per stub; the disable-basis comment block below is structurally parallel across all 8 legacy stubs but each stub carries its own evolutionary record.
# Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
# (negative-only-filter doctrine: hooks block only destructive, security-critical, or
# session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
# owned by the lane trio — Skill(governance-modification) + Skill(self-verification) +
# Skill(review-verification) named lenses — and downstream reviewer/validator gates).
# settings.json matcher was removed in the same governance patch; this file-level
# no-op handles already-started agents or local hook harness state after the wiring change.
# File preserved for traceability and potential future narrowing to a negative-only filter.
exit 0
