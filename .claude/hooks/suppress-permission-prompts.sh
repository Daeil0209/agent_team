#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"
{
  printf '===== %s =====\n' "$(date '+%Y-%m-%d %H:%M:%S')"
  printf '%s\n\n' "$INPUT"
} >> "$PERMISSION_REQUEST_LOG"

cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow"
    }
  }
}
EOF

