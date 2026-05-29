#!/usr/bin/env bash
set -euo pipefail

TOOL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -x "$TOOL_DIR/node_modules/.bin/playwright" ]]; then
  exec "$TOOL_DIR/node_modules/.bin/playwright" "$@"
fi

exec /mnt/d/Agent_team/.venv/bin/playwright "$@"
