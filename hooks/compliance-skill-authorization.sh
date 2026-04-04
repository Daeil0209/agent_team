#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"
INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["text", "message", "content", "summary", "body", "value"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) {
      return preferred;
    }
    return Object.values(value).flatMap(flattenText);
  }
  return [];
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolInput = input.tool_input || {};
  const fields = [
    String(input.tool_name || ""),
    String(input.session_id || ""),
    String(input.agent_id || ""),
    String(input.agent_type || ""),
    String(toolInput.skill || ""),
    String(toolInput.to || toolInput.recipient || ""),
    flattenText(toolInput.summary).join("\n"),
    flattenText(toolInput.message || toolInput.content).join("\n")
  ];
  process.stdout.write(fields.map((field) => Buffer.from(field, "utf8").toString("base64")).join("\n"));
} catch {
  process.stdout.write("\n\n\n\n\n\n\n");
}
NODE
)"
mapfile -t FIELDS <<<"$PARSED"

decode_field() {
  local encoded="${1-}"
  if [[ -z "$encoded" ]]; then
    printf ''
    return 0
  fi
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
SESSION_ID="$(decode_field "${FIELDS[1]:-}")"
AGENT_ID="$(decode_field "${FIELDS[2]:-}")"
AGENT_TYPE="$(decode_field "${FIELDS[3]:-}")"
RAW_SKILL_ID="$(decode_field "${FIELDS[4]:-}")"
MESSAGE_TO="$(decode_field "${FIELDS[5]:-}")"
MESSAGE_SUMMARY="$(decode_field "${FIELDS[6]:-}")"
MESSAGE_BODY="$(decode_field "${FIELDS[7]:-}")"

resolve_sender_role() {
  local sender_role=""

  if [[ -z "$AGENT_ID" ]]; then
    printf 'team-lead'
    return 0
  fi

  sender_role="$AGENT_TYPE"
  if [[ -z "$sender_role" ]] && [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MAP" ]]; then
    sender_role="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  fi
  if [[ -z "$sender_role" ]]; then
    sender_role="$(resolve_agent_id "$AGENT_ID")"
  fi

  printf '%s' "${sender_role:-unknown}"
}

resolve_sender_lane() {
  if [[ -z "$AGENT_ID" ]]; then
    printf ''
    return 0
  fi
  canonicalize_runtime_lane_id "$AGENT_ID"
}

effective_auth_session() {
  local session_id="${1:-unknown}"
  local runtime_session_id=""

  runtime_session_id="$(current_runtime_session_id)"
  if [[ -n "$runtime_session_id" ]]; then
    printf '%s' "$runtime_session_id"
    return 0
  fi

  printf '%s' "${session_id:-unknown}"
}

log_skill_auth_issue() {
  local code="${1:?code required}"
  local message="${2:?message required}"
  printf '[%s] SKILL-AUTH %s: %s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$code" \
    "$message" >> "$VIOLATION_LOG"
}

extract_skill_packets() {
  local marker="${1:?marker required}"
  local text="${2-}"

  AUTH_MARKER="$marker" AUTH_TEXT="$text" node <<'NODE'
const marker = process.env.AUTH_MARKER || "";
const text = process.env.AUTH_TEXT || "";
const encode = (value) => Buffer.from(String(value || ""), "utf8").toString("base64");
const cleanValue = (value) => String(value || "").trim();
const cleanSkill = (value) =>
  String(value || "")
    .trim()
    .replace(/^[`"'()[\]{}]+|[`"'()[\]{}]+$/g, "");

const out = [];

for (const rawLine of text.split(/\r?\n/)) {
  const line = rawLine.trim();
  if (!line.startsWith(marker)) continue;

  const rest = line.slice(marker.length).trim();
  const fields = {};

  for (const rawSegment of rest.split(";")) {
    const segment = rawSegment.trim();
    const idx = segment.indexOf("=");
    if (idx === -1) continue;
    const key = segment.slice(0, idx).trim().toLowerCase();
    const value = segment.slice(idx + 1).trim();
    if (key) {
      fields[key] = value;
    }
  }

  const lane = cleanValue(fields.lane || fields.target || fields.to);
  const surface = cleanValue(fields.surface || fields.scope || fields.blocked_surface || fields.blocked);
  const rawSkills = cleanValue(fields.skills || fields.skill);
  if (!lane || !surface || !rawSkills) continue;

  for (const rawSkill of rawSkills.split(",")) {
    const skill = cleanSkill(rawSkill);
    if (!skill) continue;
    out.push([encode(lane), encode(surface), encode(skill)].join("\t"));
  }
}

process.stdout.write(out.join("\n"));
NODE
}

ledger_has_lane_skill_session() {
  local file="${1:?file required}"
  local lane="${2:?lane required}"
  local skill="${3:?skill required}"
  local session="${4:-unknown}"

  [[ -f "$file" ]] || return 1
  awk -F' \\| ' -v lane="$lane" -v skill="$skill" -v session="$session" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      entry_lane = trim($2)
      entry_skill = trim($4)
      entry_session = trim($7)
      if (entry_lane == lane && entry_skill == skill && entry_session == session) {
        found = 1
      }
    }
    END {
      exit found ? 0 : 1
    }
  ' "$file"
}

append_skill_authorization() {
  local lane="${1:?lane required}"
  local role="${2:?role required}"
  local skill="${3:?skill required}"
  local surface="${4:?surface required}"
  local approver="${5:?approver required}"
  local session="${6:-unknown}"

  session="$(effective_auth_session "$session")"

  with_lock_file "$SKILL_AUTH_LOCK" _append_skill_authorization_locked "$lane" "$role" "$skill" "$surface" "$approver" "$session"
}

_append_skill_authorization_locked() {
  local lane="${1:?lane required}"
  local role="${2:?role required}"
  local skill="${3:?skill required}"
  local surface="${4:?surface required}"
  local approver="${5:?approver required}"
  local session="${6:-unknown}"

  mkdir -p "$(dirname "$SPECIALIST_SKILL_AUTH_LEDGER")"
  touch "$SPECIALIST_SKILL_AUTH_LEDGER"
  if ledger_has_lane_skill_session "$SPECIALIST_SKILL_AUTH_LEDGER" "$lane" "$skill" "$session"; then
    return 1
  fi

  printf '%s | %s | %s | %s | %s | %s | %s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$(sanitize_ledger_field "$lane")" \
    "$(sanitize_ledger_field "$role")" \
    "$(sanitize_ledger_field "$skill")" \
    "$(sanitize_ledger_field "$surface")" \
    "$(sanitize_ledger_field "$approver")" \
    "$(sanitize_ledger_field "${session:-unknown}")" >> "$SPECIALIST_SKILL_AUTH_LEDGER"
}



consume_skill_authorization_for_lane() {
  local lane="${1:?lane required}"
  local skill="${2:?skill required}"
  local session="${3:-unknown}"

  session="$(effective_auth_session "$session")"

  with_lock_file "$SKILL_AUTH_LOCK" _consume_skill_authorization_locked "$lane" "$skill" "$session"
}


_consume_skill_authorization_locked() {
  local lane="${1:?lane required}"
  local skill="${2:?skill required}"
  local session="${3:-unknown}"
  local target_file="$SPECIALIST_SKILL_AUTH_LEDGER"
  local temp_file=""
  local matched="0"

  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -F' \\| ' -v lane="$lane" -v skill="$skill" -v session="$session" '
    function trim(value) {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      return value
    }
    {
      entry_lane = trim($2)
      entry_skill = trim($4)
      entry_session = trim($7)
      if (!consumed && entry_lane == lane && entry_skill == skill && entry_session == session) {
        consumed = 1
        next
      }
      print $0
    }
    END {
      if (consumed) {
        print "consumed" > "/dev/stderr"
      }
    }
  ' "$target_file" > "$temp_file" 2> "${temp_file}.status"

  atomic_replace_file "$temp_file" "$target_file"
  if [[ -s "${temp_file}.status" ]] && grep -q '^consumed$' "${temp_file}.status" 2>/dev/null; then
    matched="1"
  fi
  rm -f "${temp_file}.status"

  [[ "$matched" == "1" ]]
}


record_skill_authorizations() {
  local approver_role="${1:?approver role required}"
  local expected_target_role="${2:?target role required}"
  local marker="${3:?marker required}"
  local combined_text=""
  local extracted=""
  local target_lane=""
  local target_role=""
  local target_surface=""
  local normalized_skill=""
  local lane_encoded=""
  local surface_encoded=""
  local skill_encoded=""
  local message_target_lane=""

  combined_text="${MESSAGE_SUMMARY}"$'\n'"${MESSAGE_BODY}"
  extracted="$(extract_skill_packets "$marker" "$combined_text")"
  [[ -n "$extracted" ]] || return 0

  message_target_lane="$(canonicalize_runtime_lane_id "$MESSAGE_TO")"

  while IFS=$'\t' read -r lane_encoded surface_encoded skill_encoded; do
    [[ -n "${lane_encoded:-}" ]] || continue
    target_lane="$(canonicalize_runtime_lane_id "$(decode_field "$lane_encoded")")"
    target_surface="$(normalize_surface_id "$(decode_field "$surface_encoded")")"
    normalized_skill="$(normalize_skill_id "$(decode_field "$skill_encoded")")"
    [[ -n "$target_lane" ]] || continue
    [[ -n "$target_surface" ]] || continue
    [[ -n "$normalized_skill" ]] || continue

    target_role="$(resolve_agent_id "$target_lane")"
    if [[ "$target_role" != "$expected_target_role" ]]; then
      log_skill_auth_issue "PACKET-TARGET" "invalid target role for ${marker%:}: lane=${target_lane} expected=${expected_target_role} actual=${target_role} session=${SESSION_ID:-unknown}"
      continue
    fi
    if [[ -n "$message_target_lane" && "$message_target_lane" != "$target_lane" ]]; then
      log_skill_auth_issue "RECIPIENT-MISMATCH" "message recipient ${message_target_lane} did not match packet lane ${target_lane} for skill=${normalized_skill} session=${SESSION_ID:-unknown}"
      continue
    fi
    if ! skill_requires_explicit_approval "$normalized_skill"; then
      log_skill_auth_issue "PACKET-SKILL" "ignored non-active or non-specialist skill packet: lane=${target_lane} skill=${normalized_skill} session=${SESSION_ID:-unknown}"
      continue
    fi
    if ! append_skill_authorization "$target_lane" "$expected_target_role" "$normalized_skill" "$target_surface" "$approver_role" "${SESSION_ID:-unknown}"; then
      log_skill_auth_issue "DUPLICATE" "outstanding specialist authorization already exists for lane=${target_lane} skill=${normalized_skill} session=${SESSION_ID:-unknown}; narrow or consume the existing blocked surface first"
    fi
  done <<< "$extracted"
}


case "$TOOL_NAME" in
  SendMessage)
    SENDER_ROLE="$(resolve_sender_role)"
    SENDER_LANE="$(resolve_sender_lane)"
    TARGET_ROLE="$(resolve_agent_id "$MESSAGE_TO")"

    case "$SENDER_ROLE" in
      team-lead)
        if [[ "$TARGET_ROLE" == "$SPECIALIST_SKILL_OWNER_ROLE" ]]; then
          record_skill_authorizations "team-lead" "$SPECIALIST_SKILL_OWNER_ROLE" "SKILL-AUTH:"
        fi
        ;;
    esac
    exit 0
    ;;
  Skill)
    :
    ;;
  *)
    exit 0
    ;;
esac

if [[ "$SPECIALIST_SKILL_ENFORCEMENT_MODE" == "off" ]]; then
  exit 0
fi

CALLER_ROLE="$(resolve_sender_role)"
CALLER_LANE="$(resolve_sender_lane)"
SKILL_ID="$(normalize_skill_id "$RAW_SKILL_ID")"

ROLE_LOCAL_OWNER_ROLE="$(role_local_skill_owner_role "$SKILL_ID" 2>/dev/null || true)"
if [[ -n "$ROLE_LOCAL_OWNER_ROLE" ]]; then
  if [[ "$CALLER_ROLE" != "$ROLE_LOCAL_OWNER_ROLE" ]]; then
    log_skill_auth_issue "ROLE-LOCAL-DENY" "non-owner attempted role-local skill: caller=${CALLER_ROLE} lane=${CALLER_LANE:-unknown} skill=${SKILL_ID} owner=${ROLE_LOCAL_OWNER_ROLE} session=${SESSION_ID:-unknown}"

    CALLER_ROLE="$CALLER_ROLE" SKILL_ID="$SKILL_ID" OWNER_ROLE="$ROLE_LOCAL_OWNER_ROLE" node <<'NODE'
const caller = process.env.CALLER_ROLE || "unknown";
const skill = process.env.SKILL_ID || "role-local-skill";
const owner = process.env.OWNER_ROLE || "worker";
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: `${owner}-local skill '${skill}' must stay inside the ${owner} lane. ${caller} should route the work through ${owner} so that the lane packet, evidence state, and authority boundary remain explicit.`
  }
}));
NODE
    exit 0
  fi

  exit 0
fi

if [[ "$SPECIALIST_SKILL_ENFORCEMENT_MODE" == "autonomous" ]]; then
  # Autonomous mode: all specialist skills freely loadable by any role.
  # Role-local enforcement (above) still applies.
  exit 0
fi

if ! skill_requires_explicit_approval "$SKILL_ID"; then
  exit 0
fi

if [[ "$CALLER_ROLE" != "$SPECIALIST_SKILL_OWNER_ROLE" ]]; then
  log_skill_auth_issue "DENY" "non-owner attempted specialist skill: caller=${CALLER_ROLE} lane=${CALLER_LANE:-unknown} skill=${SKILL_ID} session=${SESSION_ID:-unknown}"

  CALLER_ROLE="$CALLER_ROLE" SKILL_ID="$SKILL_ID" OWNER_ROLE="$SPECIALIST_SKILL_OWNER_ROLE" node <<'NODE'
const caller = process.env.CALLER_ROLE || "unknown";
const skill = process.env.SKILL_ID || "specialist-skill";
const owner = process.env.OWNER_ROLE || "developer";
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: `${owner}-exclusive specialist skill '${skill}' belongs to ${owner}. ${caller} should route the need through ${owner} instead of loading the specialist skill directly.`
  }
}));
NODE
  exit 0
fi

if [[ -z "$CALLER_LANE" ]]; then
  log_skill_auth_issue "MISSING-LANE" "${SPECIALIST_SKILL_OWNER_ROLE} attempted specialist skill without a stable lane id: skill=${SKILL_ID} session=${SESSION_ID:-unknown}"
  if [[ "$SPECIALIST_SKILL_ENFORCEMENT_MODE" == "warn" ]]; then
    exit 0
  fi

  SKILL_ID="$SKILL_ID" OWNER_ROLE="$SPECIALIST_SKILL_OWNER_ROLE" node <<'NODE'
const skill = process.env.SKILL_ID || "specialist-skill";
const owner = process.env.OWNER_ROLE || "developer";
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: `${owner}-exclusive specialist skill '${skill}' requires a stable ${owner} lane id so authorization can stay lane-scoped. Re-issue the request through a concrete ${owner} lane.`
  }
}));
NODE
  exit 0
fi

if consume_skill_authorization_for_lane "$CALLER_LANE" "$SKILL_ID" "${SESSION_ID:-unknown}"; then
  exit 0
fi

log_skill_auth_issue "$(printf '%s' "$SPECIALIST_SKILL_ENFORCEMENT_MODE" | tr '[:lower:]' '[:upper:]')" "${SPECIALIST_SKILL_OWNER_ROLE} lane=${CALLER_LANE} attempted specialist skill without explicit lane-scoped approval: skill=${SKILL_ID} session=${SESSION_ID:-unknown}"

if [[ "$SPECIALIST_SKILL_ENFORCEMENT_MODE" == "warn" ]]; then
  exit 0
fi

SKILL_ID="$SKILL_ID" OWNER_ROLE="$SPECIALIST_SKILL_OWNER_ROLE" CALLER_LANE="$CALLER_LANE" node <<'NODE'
const skill = process.env.SKILL_ID || "specialist-skill";
const owner = process.env.OWNER_ROLE || "developer";
const lane = process.env.CALLER_LANE || `${owner}:lane`;
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: `${owner}-exclusive specialist skill '${skill}' requires an explicit packet addressed to this ${owner} lane. team-lead should SendMessage '${`SKILL-AUTH: lane=${lane}; surface=<blocked-surface>; skill=${skill}`}'.`
  }
}));
NODE
exit 0
