#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" node <<'NODE'
const encode = (value) => Buffer.from(String(value ?? ""), "utf8").toString("base64");
const flattenText = (value) => {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenText);
  if (typeof value === "object") {
    const preferredKeys = ["description", "summary", "prompt", "task", "assignment", "message", "content", "instructions", "goal", "brief", "context", "request", "note", "notes"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) return preferred;
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
};
const joinUniqueText = (chunks) => {
  const seen = new Set();
  return chunks
    .map((chunk) => String(chunk || "").trim())
    .filter(Boolean)
    .filter((chunk) => {
      if (seen.has(chunk)) return false;
      seen.add(chunk);
      return true;
    })
    .join("\n");
};
const firstNonEmptyString = (...values) => {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
};
try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
	  const description = joinUniqueText(flattenText(toolInput));
	  const agentName = firstNonEmptyString(
	    toolInput.name,
	    toolInput.subagent_type,
	    toolInput.subagentType,
	    toolInput.agent_type,
	    toolInput.agentType,
	    toolInput.agent_name,
	    toolInput.agentName,
	    toolInput.role,
	    toolInput.lane,
	    toolInput.worker_name,
	    toolInput.workerName,
    toolInput.teammate_name,
    toolInput.teammateName,
    toolInput.target_name,
    toolInput.targetName
  );
  process.stdout.write([toolName, description, agentName].map(encode).join("\n"));
} catch {
  process.stdout.write("\n\n\n");
}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

decode_field() {
  local encoded="${1-}"
  [[ -z "$encoded" ]] && { printf ''; return 0; }
  printf '%s' "$encoded" | base64 -d
}

TOOL_NAME="$(decode_field "${FIELDS[0]:-}")"
DESCRIPTION="$(decode_field "${FIELDS[1]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[2]:-}")"

emit_packet_warning() {
  local reason="${1:?reason required}"
  reason="${reason/BLOCKED: /}"
  printf '[%s] DISPATCH-PROOF WARN: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" >> "$VIOLATION_LOG"
}

[[ "$TOOL_NAME" == "Agent" ]] || exit 0

TARGET_LANE="$(resolve_requested_dispatch_name "$AGENT_NAME" "$DESCRIPTION")"
if [[ -n "$TARGET_LANE" && "$TARGET_LANE" != "unknown" ]] && ! dispatch_target_is_dispatchable_agent "$TARGET_LANE"; then
  # dispatch-sizing-gate owns the user-facing deny for invalid Agent targets.
  exit 0
fi
TARGET_LANE="$(resolve_agent_id "$TARGET_LANE")"
CURRENT_PHASE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "CURRENT-PHASE" 2>/dev/null || true)"
WORK_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "WORK-SURFACE" 2>/dev/null || true)"
MESSAGE_CLASS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "MESSAGE-CLASS" 2>/dev/null || true)"
REQUIRED_SKILLS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REQUIRED-SKILLS" 2>/dev/null || true)"
ACCEPTANCE_RISK_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACCEPTANCE-RISK" 2>/dev/null || true)"
REVIEW_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-OWNER" 2>/dev/null || true)"
PROOF_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-OWNER" 2>/dev/null || true)"
ACCEPTANCE_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACCEPTANCE-OWNER" 2>/dev/null || true)"

CURRENT_PHASE_NORM="$(normalize_dispatch_text "$CURRENT_PHASE_RAW")"
WORK_SURFACE_NORM="$(normalize_dispatch_text "$WORK_SURFACE_RAW")"
MESSAGE_CLASS_NORM="$(normalize_dispatch_text "$MESSAGE_CLASS_RAW")"
REQUIRED_SKILLS_NORM="$(normalize_dispatch_text "$REQUIRED_SKILLS_RAW")"
ACCEPTANCE_RISK_NORM="$(normalize_dispatch_text "$ACCEPTANCE_RISK_RAW")"
REVIEW_OWNER_NORM="$(normalize_dispatch_text "$REVIEW_OWNER_RAW")"
PROOF_OWNER_NORM="$(normalize_dispatch_text "$PROOF_OWNER_RAW")"
ACCEPTANCE_OWNER_NORM="$(normalize_dispatch_text "$ACCEPTANCE_OWNER_RAW")"

developer_dispatch_needs_acceptance_chain() {
  local text="${1-}"

  if printf '%s' "$text" | grep -qiE '(web app|browser[-[:space:]]*ui|web[-[:space:]]*ui|browser[-[:space:]]*level|frontend|front-end|dom|ui deliverable|operator surface|user-operable|runnable operator)'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '(user-facing|end-user|operator)' && printf '%s' "$text" | grep -qiE '(executable|runnable|software|app|application|tool|cli|launcher|web.?workflow)'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '(executable|runnable|launchable)' && printf '%s' "$text" | grep -qiE '(deliverable|end-user|user|operator|cli|tool|app|application|software|launcher)'; then
    return 0
  fi

  return 1
}

is_assignment_dispatch="false"
case "$MESSAGE_CLASS_NORM" in
  assignment)
    is_assignment_dispatch="true"
    ;;
  "")
    MESSAGE_CLASS_NORM="assignment"
    is_assignment_dispatch="true"
    ;;
esac

if [[ "$is_assignment_dispatch" == "true" ]]; then
  packet_warning_needed="false"
  if [[ -z "$MESSAGE_CLASS_RAW" ]]; then
    packet_warning_needed="true"
  fi
  if [[ -z "$REQUIRED_SKILLS_NORM" ]] || ! printf '%s' "$REQUIRED_SKILLS_NORM" | grep -qi 'work-planning' || ! printf '%s' "$REQUIRED_SKILLS_NORM" | grep -qi 'self-verification'; then
    packet_warning_needed="true"
  fi
  if [[ -z "$WORK_SURFACE_NORM" || -z "$CURRENT_PHASE_NORM" ]]; then
    packet_warning_needed="true"
  fi
  if [[ "$packet_warning_needed" == "true" ]]; then
    emit_packet_warning "Dispatch packet has incomplete clean fields. Add MESSAGE-CLASS, REQUIRED-SKILLS, WORK-SURFACE, and CURRENT-PHASE if known; worker should infer safe scope or HOLD if ambiguity affects ownership, scope, proof, or acceptance."
  fi
fi

# This hook only reviews the team-lead's outgoing Agent dispatch packet shape.
# It warns on incomplete packet wording but does not block dispatch; workers own
# reconstruction-or-HOLD after receipt, while WP/SV and sizing gates still own
# procedural and state-safety blocks.
if [[ "$is_assignment_dispatch" == "true" ]]; then
  if [[ "$TARGET_LANE" == "developer" ]]; then
    acceptance_warning_needed="false"
    if developer_dispatch_needs_acceptance_chain "$DESCRIPTION"; then
      if [[ -z "$ACCEPTANCE_RISK_NORM" || "$ACCEPTANCE_RISK_NORM" == "low" ]]; then
        acceptance_warning_needed="true"
      fi
    fi
    case "$ACCEPTANCE_RISK_NORM" in
      meaningful|high|critical)
        if [[ "$REVIEW_OWNER_NORM" != "reviewer" ]]; then
          acceptance_warning_needed="true"
        fi
        if [[ "$PROOF_OWNER_NORM" != "tester" ]]; then
          acceptance_warning_needed="true"
        fi
        if [[ "$ACCEPTANCE_OWNER_NORM" != "validator" ]]; then
          acceptance_warning_needed="true"
        fi
        ;;
    esac
    if [[ "$acceptance_warning_needed" == "true" ]]; then
      emit_packet_warning "Developer dispatch may have incomplete acceptance ownership. Add acceptance chain if known; worker must HOLD if review, proof, or final acceptance ownership is ambiguous."
    fi
  fi
fi

exit 0
