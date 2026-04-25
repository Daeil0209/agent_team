#!/usr/bin/env bash
# Health cron rotation state machine — split from hook-runtime-state.sh
# Sourced via hook-config.sh, do not execute directly.

health_cron_rotation_is_active() {
  local expected_session_id="${1-}"
  local expected_target_job_id="${2-}"
  local active_value=""

  active_value="$(get_health_cron_rotation_state_field active "$expected_session_id" "$expected_target_job_id")"
  [[ "$active_value" == "true" ]]
}

get_health_cron_rotation_state_field() {
  local field="${1:?field required}"
  local expected_session_id="${2-}"
  local expected_target_job_id="${3-}"
  local default_value="${4-}"

  FIELD="$field" \
  EXPECTED_SESSION_ID="$expected_session_id" \
  EXPECTED_TARGET_JOB_ID="$expected_target_job_id" \
  DEFAULT_VALUE="$default_value" \
  ROTATION_STATE_FILE="$HEALTH_CRON_ROTATION_STATE_FILE" \
  ROTATION_TTL_SECONDS="$HEALTH_CRON_ROTATION_TTL_SECONDS" \
  node <<'NODE'
const fs = require("fs");

try {
  const raw = fs.readFileSync(process.env.ROTATION_STATE_FILE || "", "utf8").trim();
  if (!raw) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const state = JSON.parse(raw);
  if (state.active !== true) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const expectedSessionId = process.env.EXPECTED_SESSION_ID || "";
  const stateSessionId = String(state.sessionId || "");
  if (expectedSessionId && (!stateSessionId || stateSessionId !== expectedSessionId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const expectedTargetJobId = process.env.EXPECTED_TARGET_JOB_ID || "";
  const stateTargetJobId = String(state.targetJobId || "");
  if (expectedTargetJobId && (!stateTargetJobId || stateTargetJobId !== expectedTargetJobId)) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }

  const ttlSeconds = Number(process.env.ROTATION_TTL_SECONDS || 0);
  if (ttlSeconds > 0) {
    const updatedAt = Date.parse(String(state.updatedAt || state.requestedAt || ""));
    if (!Number.isFinite(updatedAt) || updatedAt <= 0 || (Date.now() - updatedAt) > ttlSeconds * 1000) {
      process.stdout.write(process.env.DEFAULT_VALUE || "");
      process.exit(0);
    }
  }

  const field = process.env.FIELD || "";
  const value = state[field];
  if (value === undefined || value === null || value === "") {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
  } else {
    process.stdout.write(String(value));
  }
} catch {
  process.stdout.write(process.env.DEFAULT_VALUE || "");
}
NODE
}

set_health_cron_rotation_intent() {
  local reason="${1-}"
  local source="${2:-manual-helper}"
  local phase="${3:-rotation_requested}"
  local session_id="${4:-}"
  local target_job_id="${5:-}"
  local replacement_job_id="${6:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  if [[ -z "$target_job_id" ]]; then
    target_job_id="$(current_health_cron_job_id)"
  fi
  [[ -n "$target_job_id" ]] || return 1

  _write_health_cron_rotation_state "true" "$session_id" "$source" "${reason:-explicit-health-cron-rotation}" "$phase" "$target_job_id" "$replacement_job_id"
}

advance_health_cron_rotation_phase() {
  local phase="${1:?phase required}"
  local session_id="${2:-}"
  local target_job_id="${3:-}"
  local replacement_job_id="${4:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi
  if [[ -n "$target_job_id" ]]; then
    if ! health_cron_rotation_is_active "$session_id" "$target_job_id"; then
      return 0
    fi
  elif ! health_cron_rotation_is_active "$session_id"; then
    return 0
  fi

  _write_health_cron_rotation_state "true" "$session_id" "" "" "$phase" "$target_job_id" "$replacement_job_id"
}

clear_health_cron_rotation_intent() {
  local reason="${1:-health-cron-rotation-cleared}"
  local session_id="${2:-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(current_runtime_session_id)"
  fi

  _write_health_cron_rotation_state "false" "$session_id" "clear-helper" "$reason" "inactive" "" ""
}

_write_health_cron_rotation_state() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local target_job_id="${6-}"
  local replacement_job_id="${7-}"

  with_lock_file "$HEALTH_CRON_ROTATION_STATE_LOCK" _write_health_cron_rotation_state_impl "$active" "$session_id" "$source" "$reason" "$phase" "$target_job_id" "$replacement_job_id"
}

_write_health_cron_rotation_state_impl() {
  local active="${1:?active required}"
  local session_id="${2-}"
  local source="${3-}"
  local reason="${4-}"
  local phase="${5-}"
  local target_job_id="${6-}"
  local replacement_job_id="${7-}"
  local event_ts=""

  event_ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  mkdir -p "$(dirname "$HEALTH_CRON_ROTATION_STATE_FILE")"

  STATE_ACTIVE="$active" \
  STATE_SESSION_ID="$session_id" \
  STATE_SOURCE="$source" \
  STATE_REASON="$reason" \
  STATE_PHASE="$phase" \
  STATE_TARGET_JOB_ID="$target_job_id" \
  STATE_REPLACEMENT_JOB_ID="$replacement_job_id" \
  EVENT_TS="$event_ts" \
  ROTATION_STATE_FILE="$HEALTH_CRON_ROTATION_STATE_FILE" \
  node <<'NODE'
const fs = require("fs");
const path = process.env.ROTATION_STATE_FILE || "";
const now = process.env.EVENT_TS || new Date().toISOString();
const active = process.env.STATE_ACTIVE === "true";

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) {
    previous = JSON.parse(raw);
  }
} catch {}

const sessionId = process.env.STATE_SESSION_ID || previous.sessionId || "";
const source = process.env.STATE_SOURCE || previous.source || (active ? "manual-helper" : "");
const reason = process.env.STATE_REASON || previous.reason || "";
const phase = process.env.STATE_PHASE || (active ? previous.phase || "rotation_requested" : "inactive");
const targetJobId = process.env.STATE_TARGET_JOB_ID || previous.targetJobId || "";
const replacementJobId = process.env.STATE_REPLACEMENT_JOB_ID || previous.replacementJobId || "";

const next = active
  ? {
      active: true,
      sessionId,
      source,
      reason: reason || "explicit-health-cron-rotation",
      phase,
      targetJobId,
      replacementJobId,
      requestedAt: previous.active ? previous.requestedAt || now : now,
      updatedAt: now,
      clearedAt: ""
    }
  : {
      active: false,
      sessionId,
      source,
      reason,
      phase: "inactive",
      targetJobId: "",
      replacementJobId: "",
      requestedAt: "",
      updatedAt: now,
      clearedAt: now,
      lastActiveSessionId: previous.sessionId || sessionId || "",
      lastActiveSource: previous.source || "",
      lastActiveReason: previous.reason || "",
      lastActivePhase: previous.phase || "",
      lastActiveTargetJobId: previous.targetJobId || "",
      lastReplacementJobId: previous.replacementJobId || "",
      lastActiveRequestedAt: previous.requestedAt || ""
    };

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}
