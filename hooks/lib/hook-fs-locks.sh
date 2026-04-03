#!/usr/bin/env bash

with_lock_file() {
  local lock_file="${1:?lock file required}"
  shift

  mkdir -p "$(dirname "$lock_file")"

  (
    flock -x 9
    "$@"
  ) 9>>"$lock_file"
}

make_atomic_temp_file() {
  local target_file="${1:?target file required}"
  mkdir -p "$(dirname "$target_file")"
  mktemp "$(dirname "$target_file")/.tmp.$(basename "$target_file").XXXXXX"
}

atomic_replace_file() {
  local source_file="${1:?source file required}"
  local target_file="${2:?target file required}"
  mkdir -p "$(dirname "$target_file")"
  mv -f "$source_file" "$target_file"
}

append_line_locked() {
  local lock_file="${1:?lock file required}"
  local target_file="${2:?target file required}"
  local line="${3-}"

  with_lock_file "$lock_file" _append_line_locked_impl "$target_file" "$line"
}

_append_line_locked_impl() {
  local target_file="${1:?target file required}"
  local line="${2-}"

  mkdir -p "$(dirname "$target_file")"
  printf '%s\n' "$line" >> "$target_file"
}
