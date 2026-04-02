#!/usr/bin/env bash
# Usage: mark-closeout-governance.sh [validation] [acceptance] [supervisor] [session-id]
# Clean closeout: mark-closeout-governance.sh not-needed not-needed not-needed
# With validation: mark-closeout-governance.sh assigned present not-needed
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

VALIDATION_STATE="${1:-not-needed}"
ACCEPTANCE_STATE="${2:-not-needed}"
SUPERVISOR_STATE="${3:-not-needed}"
SESSION_ID="${4:-}"

mark_closeout_governance_packet \
  "$VALIDATION_STATE" \
  "$ACCEPTANCE_STATE" \
  "$SUPERVISOR_STATE" \
  "$SESSION_ID"

printf 'CLOSEOUT GOVERNANCE recorded: validation=%s evidence=%s supervisor=%s\n' \
  "$VALIDATION_STATE" \
  "$ACCEPTANCE_STATE" \
  "$SUPERVISOR_STATE"
