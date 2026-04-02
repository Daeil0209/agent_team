#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

mkdir -p "$(dirname "$HEALTH_CRON_JOB_FILE")"
: > "$HEALTH_CRON_JOB_FILE"
printf 'HEALTH CRON job cleared\n'
