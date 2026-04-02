#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

JOB_ID="${1:?Usage: mark-health-cron-job.sh <cron-job-id>}"
mkdir -p "$(dirname "$HEALTH_CRON_JOB_FILE")"
printf '%s\n' "$JOB_ID" > "$HEALTH_CRON_JOB_FILE"
printf 'HEALTH CRON job recorded: %s\n' "$JOB_ID"
