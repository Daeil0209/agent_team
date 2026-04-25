#!/usr/bin/env bash
# Teammate idle observer with self-awareness mirror.
# This hook records TeammateIdle events and mirrors lifecycle decisions back to the model.
# It does not deny, stop, or quality-gate worker flow — it provides awareness, not enforcement.
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
printf '%s | TEAMMATE_IDLE | %s | reason:%s | status:%s | task:%s | mode:mirror\n' \
  "$TIMESTAMP" "$TEAMMATE" "$IDLE_REASON" "$COMPLETED_STATUS" "$COMPLETED_TASK" >> "$ACTIVITY_LEDGER"

# Mirror lifecycle event to the model — non-blocking awareness
TEAMMATE_VAR="$TEAMMATE" IDLE_REASON_VAR="$IDLE_REASON" COMPLETED_STATUS_VAR="$COMPLETED_STATUS" node <<'NODE'
const teammate = process.env.TEAMMATE_VAR || "unknown";
const reason = process.env.IDLE_REASON_VAR || "unknown";
const status = process.env.COMPLETED_STATUS_VAR || "none";
const ctx = `LIFECYCLE CHECKPOINT: Worker '${teammate}' is now idle (reason: ${reason}, status: ${status}). Make an explicit lifecycle decision NOW: (1) Acknowledge + STANDBY if follow-up probable, (2) REUSE by sending new work, (3) SHUTDOWN if topic is closed. Do not proceed to next task without deciding.`;
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "TeammateIdle",
    additionalContext: ctx
  }
}));
NODE

exit 0
