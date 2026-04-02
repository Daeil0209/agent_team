#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

AGENT_NAME="${1:?Usage: mark-standby.sh <worker-name>}"
mkdir -p "$(dirname "$STANDBY_FILE")"
touch "$STANDBY_FILE"

if ! grep -qxF "$AGENT_NAME" "$STANDBY_FILE" 2>/dev/null; then
  printf '%s\n' "$AGENT_NAME" >> "$STANDBY_FILE"
fi

printf 'STANDBY recorded: %s\n' "$AGENT_NAME"
