#!/usr/bin/env bash
# Advisory-only teammate idle observer.
# This hook records TeammateIdle events for monitoring and supervisor follow-up.
# It does not deny, stop, or quality-gate worker flow.
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const teammate = input.teammate_name || input.teammateName || "unknown";
  const idleReason = input.idle_reason || input.idleReason || "unknown";
  const completedTask = input.completed_task_id || input.completedTaskId || "none";
  const completedStatus = input.completed_status || input.completedStatus || "none";
  process.stdout.write(`${teammate}\n${idleReason}\n${completedTask}\n${completedStatus}\n`);
} catch {
  process.stdout.write("unknown\nunknown\nnone\nnone\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"
TEAMMATE="${FIELDS[0]:-unknown}"
IDLE_REASON="${FIELDS[1]:-unknown}"
COMPLETED_TASK="${FIELDS[2]:-none}"
COMPLETED_STATUS="${FIELDS[3]:-none}"

TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
printf '%s | TEAMMATE_IDLE | %s | reason:%s | status:%s | task:%s | mode:advisory-only\n' "$TIMESTAMP" "$TEAMMATE" "$IDLE_REASON" "$COMPLETED_STATUS" "$COMPLETED_TASK" >> "$ACTIVITY_LEDGER"

exit 0
