#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

REASON="${1:-explicit-closeout-intent}"
SOURCE="${2:-manual-helper}"
PHASE="${3:-intent_marked}"
SESSION_ID="${4:-}"
set_closeout_intent "$REASON" "$SOURCE" "$PHASE" "$SESSION_ID"
printf 'CLOSEOUT INTENT recorded: %s | source=%s | phase=%s\n' "$REASON" "$SOURCE" "$PHASE"
