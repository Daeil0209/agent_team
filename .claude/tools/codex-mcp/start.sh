#!/usr/bin/env bash
set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-/mnt/d/Agent_team}"
exec codex mcp-server "$@"
