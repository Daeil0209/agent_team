#!/usr/bin/env bash

# PROTECTED-LOCAL-RESTATEMENT-BASIS: bootstrap-isolation — the `hook_config_core_source_lib` function body below is structurally parallel to `hook_config_source_lib` in `hook-config.sh`; the namespace separation (`hook_config_core_*` vs `hook_config_*`) is intentional because this file sources only `hook-policy.sh` for the minimal-bootstrap path consumed by `permission-request-gate.sh` (whose dependency chain is intentionally narrower than the full 12-lib chain in `hook-config.sh`). The structural split preserves dependency-minimization for the permission-request-gate.sh bootstrap path; consolidation to a single shared source-lib function would couple permission-request-gate.sh's bootstrap to the full lib chain (a regression).

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
