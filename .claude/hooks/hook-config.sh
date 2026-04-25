#!/usr/bin/env bash

HOOK_DIR="${HOOK_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
HOOK_LIB_DIR="${HOOK_LIB_DIR:-$HOOK_DIR/lib}"

hook_config_source_lib() {
  local lib_name="${1:?library name required}"
  local lib_path="$HOOK_LIB_DIR/$lib_name"

  if [[ ! -f "$lib_path" ]]; then
    printf 'hook-config: missing library %s\n' "$lib_path" >&2
    return 1
  fi

  # shellcheck source=/dev/null
  source "$lib_path"
}

hook_config_source_lib hook-policy.sh
hook_config_source_lib hook-fs-locks.sh
hook_config_source_lib hook-name-registry.sh
hook_config_source_lib hook-agent-dispatch.sh
hook_config_source_lib hook-worker-registry.sh
hook_config_source_lib hook-planning-discipline.sh
hook_config_source_lib hook-self-growth-discipline.sh
hook_config_source_lib hook-runtime-session.sh
hook_config_source_lib hook-procedure-state.sh
hook_config_source_lib hook-closeout-state.sh
hook_config_source_lib hook-health-cron.sh
hook_config_source_lib hook-governance-rm-approval.sh

# hook-tool-response.sh (defines tool_response_succeeded) is intentionally NOT sourced here.
# It is only needed by PostToolUse hooks, which source it directly. If a new hook requires
# tool_response_succeeded, add: hook_config_source_lib hook-tool-response.sh to that hook file.

unset -f hook_config_source_lib
