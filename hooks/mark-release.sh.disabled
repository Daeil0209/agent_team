#!/usr/bin/env bash
set -euo pipefail
# mark-release.sh — Non-destructive worker release.
# Previously redirected to a destructive stop, which caused message loss
# by killing workers before SendMessage writes could complete.
# Stale member cleanup is handled by health-check.sh independently.
source "$(dirname "$0")/hook-config.sh"
AGENT_NAME="${1:?Usage: mark-release.sh <worker-name>}"
echo "RELEASED: $AGENT_NAME (non-destructive)" >&2
exit 0
