#!/usr/bin/env bash

normalize_planning_worker_name() {
  local worker_name="${1-}"
  normalize_lane_id "$worker_name"
}

reset_planning_markers_for_session() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  rm -f \
    "$LOG_DIR/.wp-loaded-${session_id}" \
    "$LOG_DIR/.sv-plan-loaded-${session_id}" \
    "$LOG_DIR/.sv-result-loaded-${session_id}"
}

reset_planning_markers_for_worker() {
  local worker_name="${1-}"
  local session_id=""
  local worker_session_ids=()

  [[ -n "$worker_name" ]] || return 0

  mapfile -t worker_session_ids < <(session_ids_for_worker_name "$worker_name")
  for session_id in "${worker_session_ids[@]}"; do
    [[ -n "$session_id" ]] || continue
    reset_planning_markers_for_session "$session_id"
  done
}

_mark_identity_in_file_locked() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  grep -qxF "$identity" "$target_file" 2>/dev/null && return 0
  printf '%s\n' "$identity" >> "$target_file"
}

_clear_identity_in_file_locked() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -v needle="$identity" '
    {
      line = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
      if (line != needle) {
        print $0
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

identity_present_in_file() {
  local target_file="${1:?target file required}"
  local identity="${2:?identity required}"

  [[ -f "$target_file" ]] || return 1
  grep -qxF "$identity" "$target_file" 2>/dev/null
}

mark_lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  reset_planning_markers_for_session "$session_id"
  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _mark_identity_in_file_locked "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

clear_lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 0

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _clear_identity_in_file_locked "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

lead_planning_required() {
  local session_id="${1-}"
  [[ -n "$session_id" ]] || return 1

  identity_present_in_file "$LEAD_PLANNING_PENDING_FILE" "$session_id"
}

mark_worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0

  reset_planning_markers_for_worker "$worker_name"
  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _mark_identity_in_file_locked "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}

clear_worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _clear_identity_in_file_locked "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}

worker_planning_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 1

  identity_present_in_file "$WORKER_PLANNING_PENDING_FILE" "$worker_name"
}

mark_worker_dispatch_ack_required() {
  local worker_name=""
  local armed_at="${2-}"
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0
  [[ -n "$armed_at" ]] || armed_at="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _upsert_worker_dispatch_ack_required_locked "$WORKER_DISPATCH_ACK_PENDING_FILE" "$worker_name" "$armed_at"
}

clear_worker_dispatch_ack_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 0

  with_lock_file "$PLANNING_DISCIPLINE_LOCK" _clear_worker_dispatch_ack_required_locked "$WORKER_DISPATCH_ACK_PENDING_FILE" "$worker_name"
}

worker_dispatch_ack_required() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 1

  if [[ ! -f "$WORKER_DISPATCH_ACK_PENDING_FILE" ]]; then
    return 1
  fi

  awk -F' \\| ' -v worker="$worker_name" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      if (NF >= 2) {
        name = trim($2)
      } else {
        name = trim($1)
      }
      if (tolower(name) == worker) {
        found = 1
        exit
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$WORKER_DISPATCH_ACK_PENDING_FILE" 2>/dev/null
}

_upsert_worker_dispatch_ack_required_locked() {
  local target_file="${1:?target file required}"
  local worker_name="${2:?worker name required}"
  local armed_at="${3:?armed_at required}"
  local temp_file=""

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v worker="$worker_name" -v ts="$armed_at" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      if (NF >= 2) {
        row_ts = trim($1)
        row_name = trim($2)
      } else {
        row_ts = ""
        row_name = trim($1)
      }

      if (tolower(row_name) == worker) {
        found = 1
        next
      }

      if (row_ts != "") {
        printf "%s | %s\n", row_ts, row_name
      } else if (row_name != "") {
        print row_name
      }
    }
    END {
      printf "%s | %s\n", ts, worker
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

_clear_worker_dispatch_ack_required_locked() {
  local target_file="${1:?target file required}"
  local worker_name="${2:?worker name required}"
  local temp_file=""

  [[ -f "$target_file" ]] || return 0
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v worker="$worker_name" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      if (NF >= 2) {
        row_ts = trim($1)
        row_name = trim($2)
      } else {
        row_ts = ""
        row_name = trim($1)
      }

      if (tolower(row_name) == worker) {
        next
      }

      if (row_ts != "") {
        printf "%s | %s\n", row_ts, row_name
      } else if (row_name != "") {
        print row_name
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

worker_dispatch_ack_required_since() {
  local worker_name=""
  worker_name="$(normalize_planning_worker_name "${1-}")"
  [[ -n "$worker_name" ]] || return 1
  [[ -f "$WORKER_DISPATCH_ACK_PENDING_FILE" ]] || return 1

  awk -F' \\| ' -v worker="$worker_name" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      if (NF < 2) {
        next
      }
      row_ts = trim($1)
      row_name = trim($2)
      if (tolower(row_name) == worker) {
        print row_ts
        exit
      }
    }
  ' "$WORKER_DISPATCH_ACK_PENDING_FILE" 2>/dev/null
}

worker_assignment_receipt_observed_since() {
  local session_id="${1-}"
  local required_at="${2-}"

  [[ -n "$session_id" && -n "$required_at" ]] || return 1

  SESSION_ID="$session_id" REQUIRED_AT="$required_at" CLAUDE_PROJECTS_DIR="$CLAUDE_PROJECTS_DIR" node <<'NODE' >/dev/null 2>&1
const fs = require("fs");
const path = require("path");

const sessionId = String(process.env.SESSION_ID || "").trim();
const requiredAt = String(process.env.REQUIRED_AT || "").trim();
const projectsRoot = String(process.env.CLAUDE_PROJECTS_DIR || "").trim();

if (!sessionId || !requiredAt || !projectsRoot || !fs.existsSync(projectsRoot)) process.exit(1);

const targetName = `${sessionId}.jsonl`;
const stack = [projectsRoot];
let transcriptPath = null;

while (stack.length) {
  const current = stack.pop();
  let entries = [];
  try {
    entries = fs.readdirSync(current, { withFileTypes: true });
  } catch {
    continue;
  }
  for (const entry of entries) {
    const fullPath = path.join(current, entry.name);
    if (entry.isDirectory()) {
      stack.push(fullPath);
      continue;
    }
    if (entry.isFile() && entry.name === targetName) {
      transcriptPath = fullPath;
      stack.length = 0;
      break;
    }
  }
}

if (!transcriptPath) process.exit(1);

const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    return Object.values(value).flatMap(flattenText);
  }
  return [];
};

for (const line of fs.readFileSync(transcriptPath, "utf8").split(/\r?\n/)) {
  if (!line.trim()) continue;
  let row;
  try {
    row = JSON.parse(line);
  } catch {
    continue;
  }
  const timestamp = String(row?.timestamp || "").trim();
  if (!timestamp || timestamp < requiredAt) continue;
  if (String(row?.type || "") !== "user") continue;
  const text = flattenText(row?.message?.content).join("\n");
  if (!text) continue;
  if (!/<teammate-message\b/i.test(text)) continue;
  if (!/teammate_id=["']team-lead["']/i.test(text)) continue;
  if (!/(?:^|\n)\s*message-class\s*:\s*(assignment|reuse|reroute)\b/im.test(text)) continue;
  process.exit(0);
}

process.exit(1);
NODE
}

worker_dispatch_ack_success_observed_since() {
  local session_id="${1-}"
  local required_at="${2-}"

  [[ -n "$session_id" && -n "$required_at" ]] || return 1

  SESSION_ID="$session_id" REQUIRED_AT="$required_at" CLAUDE_PROJECTS_DIR="$CLAUDE_PROJECTS_DIR" node <<'NODE' >/dev/null 2>&1
const fs = require("fs");
const path = require("path");

const sessionId = String(process.env.SESSION_ID || "").trim();
const requiredAt = String(process.env.REQUIRED_AT || "").trim();
const projectsRoot = String(process.env.CLAUDE_PROJECTS_DIR || "").trim();

if (!sessionId || !requiredAt || !projectsRoot || !fs.existsSync(projectsRoot)) process.exit(1);

const targetName = `${sessionId}.jsonl`;
const stack = [projectsRoot];
let transcriptPath = null;

while (stack.length) {
  const current = stack.pop();
  let entries = [];
  try {
    entries = fs.readdirSync(current, { withFileTypes: true });
  } catch {
    continue;
  }
  for (const entry of entries) {
    const fullPath = path.join(current, entry.name);
    if (entry.isDirectory()) {
      stack.push(fullPath);
      continue;
    }
    if (entry.isFile() && entry.name === targetName) {
      transcriptPath = fullPath;
      stack.length = 0;
      break;
    }
  }
}

if (!transcriptPath) process.exit(1);

const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") return Object.values(value).flatMap(flattenText);
  return [];
};

for (const line of fs.readFileSync(transcriptPath, "utf8").split(/\r?\n/)) {
  if (!line.trim()) continue;
  let row;
  try {
    row = JSON.parse(line);
  } catch {
    continue;
  }
  const timestamp = String(row?.timestamp || "").trim();
  if (!timestamp || timestamp < requiredAt) continue;
  if (String(row?.type || "") !== "user") continue;

  const text = [
    ...flattenText(row?.message?.content),
    ...flattenText(row?.toolUseResult),
  ].join("\n");
  if (!text) continue;
  if (!/(?:^|\n)\s*message-class\s*:\s*dispatch-ack\b/i.test(text)) continue;

  const explicitSuccess = row?.toolUseResult && row.toolUseResult.success === true;
  if (explicitSuccess || /message sent to team-lead's inbox/i.test(text) || /"success"\s*:\s*true/i.test(text)) {
    process.exit(0);
  }
}

process.exit(1);
NODE
}

reconcile_worker_dispatch_ack_from_transcript() {
  local session_id="${1-}"
  local worker_name="${2-}"
  local required_at=""

  [[ -n "$session_id" && -n "$worker_name" ]] || return 1
  worker_dispatch_ack_required "$worker_name" || return 1

  required_at="$(worker_dispatch_ack_required_since "$worker_name")"
  [[ -n "$required_at" ]] || return 1
  worker_dispatch_ack_success_observed_since "$session_id" "$required_at" || return 1

  clear_worker_dispatch_ack_required "$worker_name"
  return 0
}

worker_dispatch_ack_gate_active_for_session() {
  local session_id="${1-}"
  local worker_name="${2-}"
  local required_at=""

  worker_dispatch_ack_required "$worker_name" || return 1

  required_at="$(worker_dispatch_ack_required_since "$worker_name")"
  if [[ -z "$required_at" ]]; then
    return 0
  fi

  worker_assignment_receipt_observed_since "$session_id" "$required_at"
}

_update_precheck_repeat_state_locked() {
  local session_id="${1:?session id required}"
  local tool_name="${2:?tool name required}"
  local surface_key="${3:?surface key required}"
  local reason_b64="${4:?reason required}"
  local target_file="${PRECHECK_REPEAT_STATE_FILE:?repeat state file required}"
  local temp_file=""
  local count_file=""

  mkdir -p "$(dirname "$target_file")"
  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"
  count_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' \
    -v sid="$session_id" \
    -v tool="$tool_name" \
    -v surface="$surface_key" \
    -v reason="$reason_b64" \
    -v out="$temp_file" \
    -v count_out="$count_file" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      row_sid = trim($1)
      row_tool = trim($2)
      row_surface = trim($3)
      row_reason = trim($4)
      row_count = trim($5) + 0

      if (row_sid == sid && row_tool == tool && row_surface == surface) {
        if (row_reason == reason) {
          found = 1
          next_count = row_count + 1
          printf "%s | %s | %s | %s | %d\n", sid, tool, surface, reason, next_count >> out
        }
        next
      }

      print $0 >> out
    }
    END {
      if (!found) {
        next_count = 1
        printf "%s | %s | %s | %s | %d\n", sid, tool, surface, reason, next_count >> out
      }
      print next_count >> count_out
    }
  ' "$target_file"

  atomic_replace_file "$temp_file" "$target_file"
  cat "$count_file"
  rm -f "$count_file"
}

augment_precheck_block_reason_on_repeat() {
  local session_id="${1-}"
  local tool_name="${2-}"
  local surface_key="${3-}"
  local reason="${4-}"
  local encoded_reason=""
  local repeat_count=""

  [[ -n "$reason" ]] || return 0
  [[ -n "$session_id" ]] || {
    printf '%s' "$reason"
    return 0
  }

  tool_name="${tool_name:-tool}"
  surface_key="${surface_key:-generic}"
  encoded_reason="$(printf '%s' "$reason" | base64 | tr -d '\n')"
  repeat_count="$(with_lock_file "$PRECHECK_REPEAT_STATE_LOCK" _update_precheck_repeat_state_locked "$session_id" "$tool_name" "$surface_key" "$encoded_reason")"

  if [[ "$repeat_count" =~ ^[0-9]+$ ]] && (( repeat_count >= 2 )); then
    printf '%s Repeated blocker on the same operating surface. Stop retries and HOLD until the listed preflight step is completed.' "$reason"
    return 0
  fi

  printf '%s' "$reason"
}
