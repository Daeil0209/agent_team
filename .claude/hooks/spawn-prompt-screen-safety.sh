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
