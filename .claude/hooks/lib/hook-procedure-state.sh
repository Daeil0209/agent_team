#!/usr/bin/env bash
# Workspace-local procedure state and continuity helpers.
# Sourced via hook-config.sh, do not execute directly.

procedure_state_file_path() {
  printf '%s' "$PROCEDURE_STATE_FILE"
}

procedure_state_target_exact() {
  local target_paths="${1-}"
  local expected_path=""
  local target_path=""
  local canonical_target=""
  local saw_target=1

  [[ -n "$target_paths" ]] || return 1

  expected_path="$(realpath -m "$PROCEDURE_STATE_FILE" 2>/dev/null || printf '%s' "$PROCEDURE_STATE_FILE")"

  while IFS= read -r target_path; do
    [[ -n "$target_path" ]] || continue
    saw_target=0
    if [[ "$target_path" = /* ]]; then
      canonical_target="$(realpath -m "$target_path" 2>/dev/null || printf '%s' "$target_path")"
    else
      canonical_target="$(realpath -m "$(resolve_project_root)/$target_path" 2>/dev/null || printf '%s/%s' "$(resolve_project_root)" "$target_path")"
    fi
    [[ "$canonical_target" == "$expected_path" ]] || return 1
  done <<< "$target_paths"

  return "$saw_target"
}

procedure_state_edit_target_allowed() {
  local tool_name="${1-}"
  local target_paths="${2-}"

  case "$tool_name" in
    Edit|Update|MultiEdit) ;;
    *) return 1 ;;
  esac

  procedure_state_target_exact "$target_paths"
}

ensure_procedure_state_surfaces() {
  mkdir -p "$(dirname "$PROCEDURE_STATE_FILE")"
}


get_procedure_state_field() {
  local field="${1:?field required}"
  local default_value="${2-}"

  FIELD="$field" DEFAULT_VALUE="$default_value" PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" node <<'NODE'
const fs = require("fs");

try {
  const raw = fs.readFileSync(process.env.PROCEDURE_STATE_FILE || "", "utf8").trim();
  if (!raw) {
    process.stdout.write(process.env.DEFAULT_VALUE || "");
    process.exit(0);
  }
  const state = JSON.parse(raw);
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

update_procedure_state_fields() {
  local session_id="${1-}"
  local update_lines=""

  shift || true
  if [[ -z "$session_id" ]]; then
    session_id="$(recover_session_id)"
  fi

  while [[ $# -gt 1 ]]; do
    update_lines+="${1}=${2}"$'\n'
    shift 2
  done

  with_lock_file "$PROCEDURE_STATE_LOCK" _update_procedure_state_fields_impl "$session_id" "$update_lines"
}

mark_procedure_startup_ready() {
  local session_id="${1-}"

  if [[ -z "$session_id" ]]; then
    session_id="$(recover_session_id)"
  fi

  [[ -n "$session_id" ]] || return 0

  update_procedure_state_fields \
    "$session_id" \
    startupState "ready"
}

_update_procedure_state_fields_impl() {
  local session_id="${1-}"
  local update_lines="${2-}"
  local workspace_root=""
  local runtime_session_id=""

  ensure_procedure_state_surfaces
  workspace_root="$(resolve_project_root)"
  runtime_session_id="$(current_runtime_session_id)"

  SESSION_ID="$session_id" \
  UPDATE_LINES="$update_lines" \
  WORKSPACE_ROOT="$workspace_root" \
  RUNTIME_SESSION_ID="$runtime_session_id" \
  PROCEDURE_STATE_FILE="$PROCEDURE_STATE_FILE" \
  PROCEDURE_STATE_MIGRATION_PHASE="$PROCEDURE_STATE_MIGRATION_PHASE" \
  node <<'NODE'
const fs = require("fs");

const path = process.env.PROCEDURE_STATE_FILE || "";
const sessionId = process.env.SESSION_ID || "";
const updateLines = String(process.env.UPDATE_LINES || "")
  .split(/\n/)
  .filter(Boolean);

let previous = {};
try {
  const raw = fs.readFileSync(path, "utf8").trim();
  if (raw) previous = JSON.parse(raw);
} catch {}

const updates = {};
for (const line of updateLines) {
  const idx = line.indexOf("=");
  if (idx <= 0) continue;
  updates[line.slice(0, idx)] = line.slice(idx + 1);
}

const next = {
  ...previous,
  workspaceRoot: process.env.WORKSPACE_ROOT || previous.workspaceRoot || "",
  sessionId: sessionId || previous.sessionId || "",
  runtimeSessionId: process.env.RUNTIME_SESSION_ID || "",
  procedureAuthority: "workspace-local",
  migrationPhase: process.env.PROCEDURE_STATE_MIGRATION_PHASE || previous.migrationPhase || "",
  projectContinuityFile: "",
  globalContinuityFile: "",
  lastUpdated: new Date().toISOString(),
  ...updates
};

fs.writeFileSync(path, `${JSON.stringify(next, null, 2)}\n`);
NODE
}

refresh_procedure_state_sensors() {
  local session_id="${1-}"

  update_procedure_state_fields \
    "$session_id" \
    projectContinuityState "not-required" \
    globalContinuityState "not-required" \
    continuityMirrorStatus "not-required" \
    continuityReadPath ""
}

record_permission_provenance() {
  local session_id="${1-}"
  local resolved_mode="${2-}"
  local permission_basis="${3-}"
  local permission_source="${4-}"
  local raw_mode="${5-}"
  local agent_name="${6-}"

  update_procedure_state_fields \
    "$session_id" \
    lastResolvedMode "$resolved_mode" \
    lastPermissionBasis "$permission_basis" \
    lastPermissionSource "$permission_source" \
    lastRawMode "$raw_mode" \
    lastAgentDispatchName "$agent_name"
}

record_team_runtime_state() {
  local session_id="${1-}"
  local runtime_state="${2:-inactive}"
  local evidence="${3:-none}"

  update_procedure_state_fields \
    "$session_id" \
    teamRuntimeState "$runtime_state" \
    teamExistenceEvidence "$evidence"
}

reset_team_state_channel() {
  local session_id="${1-}"

  update_procedure_state_fields \
    "$session_id" \
    teamRuntimeState "inactive" \
    teamExistenceEvidence "none" \
    teamDispatchState "none" \
    teamDispatchEvidence "none" \
    lastDispatchWorker "" \
    lastPendingWorker "" \
    lastClaimedWorker "" \
    lastDispatchAt "" \
    lastPendingSince "" \
    lastClaimedAt ""
}

record_team_dispatch_state() {
  local session_id="${1-}"
  local dispatch_state="${2:-none}"
  local dispatch_worker="${3-}"
  local pending_worker="${4-}"
  local claimed_worker="${5-}"
  local evidence="${6:-none}"
  local dispatch_at="${7-}"
  local pending_since="${8-}"
  local claimed_at="${9-}"

  update_procedure_state_fields \
    "$session_id" \
    teamDispatchState "$dispatch_state" \
    teamDispatchEvidence "$evidence" \
    lastDispatchWorker "$dispatch_worker" \
    lastPendingWorker "$pending_worker" \
    lastClaimedWorker "$claimed_worker" \
    lastDispatchAt "$dispatch_at" \
    lastPendingSince "$pending_since" \
    lastClaimedAt "$claimed_at"
}

clear_team_dispatch_state() {
  local session_id="${1-}"

  record_team_dispatch_state "$session_id" "none" "" "" "" "none"
}

mark_team_dispatch_pending() {
  local session_id="${1-}"
  local worker_name="${2-}"
  local evidence="${3:-agent-dispatch}"
  local previous_claimed=""
  local previous_claimed_at=""
  local dispatch_at=""

  [[ -n "$worker_name" ]] || return 0
  previous_claimed="$(get_procedure_state_field "lastClaimedWorker" "")"
  previous_claimed_at="$(get_procedure_state_field "lastClaimedAt" "")"
  dispatch_at="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  record_team_dispatch_state "$session_id" "pending" "$worker_name" "$worker_name" "$previous_claimed" "$evidence" "$dispatch_at" "$dispatch_at" "$previous_claimed_at"
}

mark_team_dispatch_claimed() {
  local session_id="${1-}"
  local worker_name="${2-}"
  local evidence="${3:-worker-activity}"
  local dispatch_at=""
  local claimed_at=""

  [[ -n "$worker_name" ]] || return 0
  dispatch_at="$(get_procedure_state_field "lastDispatchAt" "")"
  claimed_at="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  [[ -n "$dispatch_at" ]] || dispatch_at="$claimed_at"
  record_team_dispatch_state "$session_id" "claimed" "$worker_name" "" "$worker_name" "$evidence" "$dispatch_at" "" "$claimed_at"
}

clear_stale_team_state_for_new_session() {
  local session_id="${1-}"
  local previous_boot_session_id=""
  local previous_session_id=""
  local previous_runtime_session_id=""
  local current_runtime_id=""

  [[ -n "$session_id" ]] || return 0

  previous_boot_session_id="$(get_procedure_state_field "bootSessionId" "")"
  previous_session_id="$(get_procedure_state_field "sessionId" "")"
  previous_runtime_session_id="$(get_procedure_state_field "runtimeSessionId" "")"
  current_runtime_id="$(current_runtime_session_id)"

  if [[ -n "$current_runtime_id" && -n "$previous_runtime_session_id" && "$current_runtime_id" == "$previous_runtime_session_id" ]]; then
    return 0
  fi

  if [[ -n "$previous_boot_session_id" && "$previous_boot_session_id" != "$session_id" ]]; then
    reset_team_state_channel "$session_id"
    return 0
  fi

  if [[ -z "$previous_boot_session_id" && -n "$previous_session_id" && "$previous_session_id" != "$session_id" ]]; then
    reset_team_state_channel "$session_id"
  fi
}
