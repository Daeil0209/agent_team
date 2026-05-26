#!/usr/bin/env bash
set -euo pipefail

# Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
# (negative-only-filter doctrine: hooks block only destructive, security-critical, or
# session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
# owned by the lane trio — Skill(governance-modification) + Skill(self-verification) + Skill(review-verification)
# named lenses — and downstream reviewer/validator independent gates).
# settings.json TaskCompleted matcher was removed; this file-level no-op handles
# already-started agents or local hook harness state that still attempts to fire the hook. File preserved for
# traceability and potential future narrowing to a negative-only filter.
exit 0
