#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

TARGET_JOB_ID="${1:-}"
REASON="${2:-explicit-health-cron-rotation}"
SOURCE="${3:-manual-helper}"
SESSION_ID="${4:-}"

if [[ -z "$SESSION_ID" ]]; then
  SESSION_ID="$(current_runtime_session_id)"
fi

if [[ -z "$TARGET_JOB_ID" ]]; then
  TARGET_JOB_ID="$(current_health_cron_job_id)"
fi

if [[ -z "$TARGET_JOB_ID" ]]; then
  printf 'No tracked health-check cron job is registered.\n' >&2
  exit 1
fi

if closeout_intent_is_active "$SESSION_ID"; then
  printf 'Explicit closeout intent is already active. Do not mark health-check cron rotation during closeout.\n' >&2
  exit 1
fi

set_health_cron_rotation_intent "$REASON" "$SOURCE" "rotation_requested" "$SESSION_ID" "$TARGET_JOB_ID"
printf 'HEALTH CRON rotation recorded: target=%s | reason=%s | source=%s\n' "$TARGET_JOB_ID" "$REASON" "$SOURCE"
