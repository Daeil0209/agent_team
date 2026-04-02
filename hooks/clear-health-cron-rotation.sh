#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

REASON="${1:-health-cron-rotation-cleared}"
SESSION_ID="${2:-}"

clear_health_cron_rotation_intent "$REASON" "$SESSION_ID"
printf 'HEALTH CRON rotation cleared: %s\n' "$REASON"
