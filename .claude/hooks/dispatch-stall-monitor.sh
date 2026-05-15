#!/usr/bin/env bash
# dispatch-stall-monitor.sh
#
# Purpose: Detect `assignment-sent-no-ack` and `dispatch-ack-no-start` stalls
# at runtime and surface advisory to the team-lead transcript on every
# subsequent tool call. Per `[HOOK-LAST]`: advisory only, never deny.
#
# Doctrinal anchor: runtime-state-detail.md `## Stall-Without-Progress Rule`.
# The rule already mandates same-turn follow-up; this hook enforces visibility
# so a passive "waiting" loop cannot silently bypass the mandate.
#
# Trigger: PostToolUse on common team-lead read/inspection tools.
# Output: stderr advisory (visible in team-lead context) when stall conditions
# exceed thresholds. Exits 0 always (advisory-class).
#
# Conditions:
# 1. assignment-sent-no-ack:
#    teamDispatchState == "pending"
#    AND lastClaimedWorker is empty
#    AND (now - lastDispatchAt) > NO_ACK_THRESHOLD_SECONDS
# 2. dispatch-ack-no-start:
#    teamDispatchState == "claimed"
#    AND lastClaimedWorker is non-empty
#    AND no agent-start side-effect within START_THRESHOLD_SECONDS of lastClaimedAt

set -uo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-/mnt/d/Agent_team}"
PROC_STATE="${PROJECT_DIR}/.runtime/procedure-state.json"

# Thresholds — short enough to surface within a few team-lead turns,
# long enough to avoid spurious noise during normal dispatch latency.
NO_ACK_THRESHOLD_SECONDS=120     # 2 min: assignment sent but no claim
START_THRESHOLD_SECONDS=180      # 3 min: claimed but no start evidence

# Bail if state file absent (boot incomplete or no active dispatch)
[[ -r "$PROC_STATE" ]] || exit 0

# Need jq for safe JSON parsing
command -v jq >/dev/null 2>&1 || exit 0

team_state=$(jq -r '.teamDispatchState // ""' "$PROC_STATE" 2>/dev/null)
last_dispatch_worker=$(jq -r '.lastDispatchWorker // ""' "$PROC_STATE" 2>/dev/null)
last_claimed_worker=$(jq -r '.lastClaimedWorker // ""' "$PROC_STATE" 2>/dev/null)
last_dispatch_at=$(jq -r '.lastDispatchAt // ""' "$PROC_STATE" 2>/dev/null)
last_claimed_at=$(jq -r '.lastClaimedAt // ""' "$PROC_STATE" 2>/dev/null)

[[ -n "$team_state" ]] || exit 0

now_epoch=$(date -u +%s)

epoch_of() {
  local iso="$1"
  [[ -n "$iso" ]] || { echo 0; return; }
  date -u -d "$iso" +%s 2>/dev/null || echo 0
}

# Condition 1: assignment-sent-no-ack
if [[ "$team_state" == "pending" && -z "$last_claimed_worker" && -n "$last_dispatch_at" ]]; then
  dispatch_epoch=$(epoch_of "$last_dispatch_at")
  if [[ "$dispatch_epoch" -gt 0 ]]; then
    elapsed=$((now_epoch - dispatch_epoch))
    if [[ "$elapsed" -gt "$NO_ACK_THRESHOLD_SECONDS" ]]; then
      printf '[%s] STALL-WITHOUT-PROGRESS ADVISORY: assignment-sent-no-ack | worker=%s elapsed=%ds | runtime-state-detail.md Stall-Without-Progress Rule mandates same-turn receipt follow-up via SendMessage; passive waiting is a monitoring defect.\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$last_dispatch_worker" "$elapsed" >&2
    fi
  fi
fi

# Condition 2: dispatch-ack-no-start (claimed but no recent activity)
if [[ "$team_state" == "claimed" && -n "$last_claimed_worker" && -n "$last_claimed_at" ]]; then
  claimed_epoch=$(epoch_of "$last_claimed_at")
  if [[ "$claimed_epoch" -gt 0 ]]; then
    elapsed=$((now_epoch - claimed_epoch))
    if [[ "$elapsed" -gt "$START_THRESHOLD_SECONDS" ]]; then
      printf '[%s] STALL-WITHOUT-PROGRESS ADVISORY: dispatch-ack-no-start | worker=%s elapsed=%ds | runtime-state-detail.md Stall-Without-Progress Rule mandates same-turn execution follow-up; verify agent-start evidence or send replacement.\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$last_claimed_worker" "$elapsed" >&2
    fi
  fi
fi

exit 0
