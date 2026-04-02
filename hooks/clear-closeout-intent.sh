#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

REASON="${1:-closeout-cleared}"
SESSION_ID="${2:-}"
clear_closeout_intent "$REASON" "$SESSION_ID"
printf 'CLOSEOUT INTENT cleared: %s\n' "$REASON"
