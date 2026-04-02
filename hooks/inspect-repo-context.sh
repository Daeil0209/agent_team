#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-${PWD:-$(pwd)}}"
REPO_ROOT="$(git -C "$TARGET" rev-parse --show-toplevel 2>/dev/null || true)"

if [[ -z "$REPO_ROOT" ]]; then
  printf 'REPO_CONTEXT: NOT_A_REPO\n'
  printf 'SEED: %s\n' "$TARGET"
  exit 0
fi

LOCAL_HEADS="$(
  git -C "$REPO_ROOT" for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null || true
)"
REMOTE_HEADS="$(
  git -C "$REPO_ROOT" for-each-ref --format='%(refname:short)' refs/remotes 2>/dev/null || true
)"

printf 'REPO_CONTEXT: OK\n'
printf 'REPO_ROOT: %s\n' "$REPO_ROOT"
printf 'LOCAL_HEADS: %s\n' "$(printf '%s' "$LOCAL_HEADS" | paste -sd ',' -)"
printf 'REMOTE_HEADS: %s\n' "$(printf '%s' "$REMOTE_HEADS" | paste -sd ',' -)"
