#!/usr/bin/env bash

HOOK_DIR="${HOOK_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
HOOK_LIB_DIR="${HOOK_LIB_DIR:-$HOOK_DIR/lib}"

hook_config_core_source_lib() {
  local lib_name="${1:?library name required}"
  local lib_path="$HOOK_LIB_DIR/$lib_name"

  if [[ ! -f "$lib_path" ]]; then
    printf 'hook-config-core: missing library %s\n' "$lib_path" >&2
    return 1
  fi

  # shellcheck source=/dev/null
  source "$lib_path"
}

hook_config_core_source_lib hook-policy.sh

unset -f hook_config_core_source_lib
