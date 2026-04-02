#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

mode="${HOOK_HEALTH_SELF_CHECK_MODE:-warn}"
[[ "$mode" == "off" ]] && exit 0

settings_file="$CLAUDE_ROOT/settings.json"
timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
issues=()

if [[ ! -f "$settings_file" ]]; then
  issues+=("missing settings.json: $settings_file")
else
  wired="$(node -e '
    const fs=require("fs");
    const p=process.argv[1];
    const j=JSON.parse(fs.readFileSync(p,"utf8"));
    const hooks=JSON.stringify(j.hooks||{});
    process.stdout.write(hooks);
  ' "$settings_file" 2>/dev/null || true)"
  for hook_name in $HOOK_HEALTH_REQUIRED_HOOKS; do
    [[ -f "$HOOK_DIR/$hook_name" ]] || issues+=("missing hook file: $hook_name")
    printf '%s' "$wired" | grep -q "$hook_name" || issues+=("not wired in settings.json: $hook_name")
  done
fi

if [[ ${#issues[@]} -gt 0 ]]; then
  {
    printf '%s | HOOK-HEALTH | WARN\n' "$timestamp"
    printf '%s\n' "${issues[@]}"
  } >> "$HOOK_HEALTH_LOG"
  {
    printf '[%s] HOOK-HEALTH WARN:\n' "$(date '+%Y-%m-%d %H:%M:%S')"
    printf -- '- %s\n' "${issues[@]}"
  } >> "$VIOLATION_LOG"
fi

exit 0
