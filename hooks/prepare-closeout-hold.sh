#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

HOLD_REASON="${1:-governance-hold}"
SESSION_ID="${2:-}"

prepare_closeout_hold_state "$HOLD_REASON" "$SESSION_ID"

printf 'CLOSEOUT HOLD prepared: %s\n' "$HOLD_REASON"
