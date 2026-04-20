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

emit_deny() {
  local reason="${1:?reason required}"
  DENY_REASON="$reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Dispatch proof contract blocked the assignment."
  }
}));
NODE
}

dispatch_proof_block() {
  local detail="${1:?detail required}"
  local next_step="${2:?next step required}"
  printf 'BLOCKED: dispatch packet incomplete. Detail: %s. Next: %s.' "$detail" "$next_step"
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
ACTIVE_WORKFLOW_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACTIVE-WORKFLOW" 2>/dev/null || true)"
TASK_CLASS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-CLASS" 2>/dev/null || true)"
PROOF_TARGET_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-TARGET" 2>/dev/null || true)"
ENV_BASIS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ENV-BASIS" 2>/dev/null || true)"
SCENARIO_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "SCENARIO-SCOPE" 2>/dev/null || true)"
PROOF_EXPECTATION_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-EXPECTATION" 2>/dev/null || true)"
PROOF_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-SURFACE" 2>/dev/null || true)"
TOOL_REQUIREMENT_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-REQUIREMENT" 2>/dev/null || true)"
VALIDATION_TARGET_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "VALIDATION-TARGET" 2>/dev/null || true)"
EXPECTATION_SOURCES_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "EXPECTATION-SOURCES" 2>/dev/null || true)"
REVIEW_STATE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-STATE" 2>/dev/null || true)"
TEST_STATE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TEST-STATE" 2>/dev/null || true)"
DECISION_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "DECISION-SURFACE" 2>/dev/null || true)"
VALIDATION_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "VALIDATION-SURFACE" 2>/dev/null || true)"
USER_RUN_PATH_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "USER-RUN-PATH" 2>/dev/null || true)"
BURDEN_CONTRACT_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "BURDEN-CONTRACT" 2>/dev/null || true)"
TASK_CLASS_NORM="$(normalize_dispatch_text "$TASK_CLASS_RAW")"
CHANGE_BOUNDARY_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "CHANGE-BOUNDARY" 2>/dev/null || true)"
WRITE_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "WRITE-SCOPE" 2>/dev/null || true)"

CURRENT_PHASE_NORM="$(normalize_dispatch_text "$CURRENT_PHASE_RAW")"
WORK_SURFACE_NORM="$(normalize_dispatch_text "$WORK_SURFACE_RAW")"
MESSAGE_CLASS_NORM="$(normalize_dispatch_text "$MESSAGE_CLASS_RAW")"
REQUIRED_SKILLS_NORM="$(normalize_dispatch_text "$REQUIRED_SKILLS_RAW")"
ACCEPTANCE_RISK_NORM="$(normalize_dispatch_text "$ACCEPTANCE_RISK_RAW")"
REVIEW_OWNER_NORM="$(normalize_dispatch_text "$REVIEW_OWNER_RAW")"
PROOF_OWNER_NORM="$(normalize_dispatch_text "$PROOF_OWNER_RAW")"
ACCEPTANCE_OWNER_NORM="$(normalize_dispatch_text "$ACCEPTANCE_OWNER_RAW")"
ACTIVE_WORKFLOW_NORM="$(normalize_dispatch_text "$ACTIVE_WORKFLOW_RAW")"
PROOF_SURFACE_NORM="$(normalize_dispatch_text "$PROOF_SURFACE_RAW")"
VALIDATION_SURFACE_NORM="$(normalize_dispatch_text "$VALIDATION_SURFACE_RAW")"

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

field_present() {
  local value="${1-}"
  [[ -n "$(printf '%s' "$value" | tr -d '[:space:]')" ]]
}

tester_or_validator_needs_delivery_contract() {
  [[ "$TARGET_LANE" == "tester" || "$TARGET_LANE" == "validator" ]] || return 1

  if [[ "$ACTIVE_WORKFLOW_NORM" == "devworkflow" || "$ACTIVE_WORKFLOW_NORM" == "dev-workflow" ]]; then
    return 0
  fi

  if [[ "$PROOF_SURFACE_NORM" == "browserui" || "$PROOF_SURFACE_NORM" == "cli" || "$VALIDATION_SURFACE_NORM" == "browserui" || "$VALIDATION_SURFACE_NORM" == "cli" ]]; then
    return 0
  fi

  if developer_dispatch_needs_acceptance_chain "$DESCRIPTION"; then
    return 0
  fi

  if printf '%s' "$DESCRIPTION" | grep -qiE '(double[-[:space:]]*click|start[._-]?bat|start[._-]?sh|launcher|launch/start path|delivery experience|user-readiness|interaction coverage)'; then
    return 0
  fi

  return 1
}

lane_packet_missing_fields() {
  local -a missing=()
  local field_name=""

  for field_name in "$@"; do
    case "$field_name" in
      MESSAGE-CLASS) field_present "$MESSAGE_CLASS_RAW" || missing+=("$field_name") ;;
      WORK-SURFACE) field_present "$WORK_SURFACE_RAW" || missing+=("$field_name") ;;
      CURRENT-PHASE) field_present "$CURRENT_PHASE_RAW" || missing+=("$field_name") ;;
      REQUIRED-SKILLS) field_present "$REQUIRED_SKILLS_RAW" || missing+=("$field_name") ;;
      PROOF-TARGET) field_present "$PROOF_TARGET_RAW" || missing+=("$field_name") ;;
      ENV-BASIS) field_present "$ENV_BASIS_RAW" || missing+=("$field_name") ;;
      SCENARIO-SCOPE) field_present "$SCENARIO_SCOPE_RAW" || missing+=("$field_name") ;;
      PROOF-EXPECTATION) field_present "$PROOF_EXPECTATION_RAW" || missing+=("$field_name") ;;
      PROOF-SURFACE) field_present "$PROOF_SURFACE_RAW" || missing+=("$field_name") ;;
      TOOL-REQUIREMENT) field_present "$TOOL_REQUIREMENT_RAW" || missing+=("$field_name") ;;
      VALIDATION-TARGET) field_present "$VALIDATION_TARGET_RAW" || missing+=("$field_name") ;;
      EXPECTATION-SOURCES) field_present "$EXPECTATION_SOURCES_RAW" || missing+=("$field_name") ;;
      REVIEW-STATE) field_present "$REVIEW_STATE_RAW" || missing+=("$field_name") ;;
      TEST-STATE) field_present "$TEST_STATE_RAW" || missing+=("$field_name") ;;
      DECISION-SURFACE) field_present "$DECISION_SURFACE_RAW" || missing+=("$field_name") ;;
      VALIDATION-SURFACE) field_present "$VALIDATION_SURFACE_RAW" || missing+=("$field_name") ;;
      USER-RUN-PATH) field_present "$USER_RUN_PATH_RAW" || missing+=("$field_name") ;;
      BURDEN-CONTRACT) field_present "$BURDEN_CONTRACT_RAW" || missing+=("$field_name") ;;
    esac
  done

  printf '%s' "${missing[*]:-}"
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

  # Advisory: check ACTIVE-WORKFLOW presence for workflow-aware dispatch
  if [[ -z "$ACTIVE_WORKFLOW_NORM" ]]; then
    emit_packet_warning "Dispatch packet missing ACTIVE-WORKFLOW field. Add ACTIVE-WORKFLOW from work-planning Step 1 Q3 result if applicable."
  fi
fi

# This hook only reviews the team-lead's outgoing Agent dispatch packet shape.
# It warns on incomplete packet wording but does not block dispatch; workers own
# reconstruction-or-HOLD after receipt, while WP/SV and sizing gates still own
# procedural and state-safety blocks.
if [[ "$is_assignment_dispatch" == "true" ]]; then
  if [[ "$TARGET_LANE" == "tester" ]]; then
    tester_required_fields="MESSAGE-CLASS WORK-SURFACE CURRENT-PHASE REQUIRED-SKILLS PROOF-TARGET ENV-BASIS SCENARIO-SCOPE PROOF-EXPECTATION PROOF-SURFACE"
    if [[ "$PROOF_SURFACE_NORM" == "browserui" ]]; then
      tester_required_fields+=" TOOL-REQUIREMENT"
    fi
    if tester_or_validator_needs_delivery_contract; then
      tester_required_fields+=" USER-RUN-PATH BURDEN-CONTRACT"
    fi
    tester_missing_fields="$(lane_packet_missing_fields $tester_required_fields)"
    if [[ -n "$tester_missing_fields" ]]; then
      emit_deny "$(dispatch_proof_block "tester dispatch is missing required proof contract fields (${tester_missing_fields})" "add the missing fields to the packet so proof matches the promised delivery surface, then retry Agent")"
      exit 0
    fi
  fi

  if [[ "$TARGET_LANE" == "validator" ]]; then
    validator_required_fields="MESSAGE-CLASS WORK-SURFACE CURRENT-PHASE REQUIRED-SKILLS VALIDATION-TARGET EXPECTATION-SOURCES REVIEW-STATE TEST-STATE DECISION-SURFACE VALIDATION-SURFACE"
    if [[ "$VALIDATION_SURFACE_NORM" == "browserui" ]]; then
      validator_required_fields+=" TOOL-REQUIREMENT"
    fi
    if tester_or_validator_needs_delivery_contract; then
      validator_required_fields+=" USER-RUN-PATH BURDEN-CONTRACT"
    fi
    validator_missing_fields="$(lane_packet_missing_fields $validator_required_fields)"
    if [[ -n "$validator_missing_fields" ]]; then
      emit_deny "$(dispatch_proof_block "validator dispatch is missing required acceptance contract fields (${validator_missing_fields})" "add the missing fields to the packet so validation can reconcile the promised delivery surface, then retry Agent")"
      exit 0
    fi
  fi

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

  # Advisory: governance-patch guardrail check
  if [[ "$TASK_CLASS_NORM" == "governance-patch" || "$TASK_CLASS_NORM" == "governancepatch" ]]; then
    gov_warning_needed="false"
    if [[ -z "$CHANGE_BOUNDARY_RAW" ]]; then
      gov_warning_needed="true"
    fi
    if [[ -z "$WRITE_SCOPE_RAW" ]]; then
      gov_warning_needed="true"
    fi
    if [[ "$gov_warning_needed" == "true" ]]; then
      emit_packet_warning "Governance-patch dispatch missing CHANGE-BOUNDARY or WRITE-SCOPE. Both are required guardrails for bounded governance modification."
    fi
    # Migration advisory: detect move/migrate/re-home without meaning inventory
    if [[ -n "$CHANGE_BOUNDARY_RAW" ]] && printf '%s' "$CHANGE_BOUNDARY_RAW" | grep -qiE '(move|migrate|re-home|transfer|relocate)'; then
      if ! printf '%s' "$CHANGE_BOUNDARY_RAW" | grep -qiE '(source.?meaning|meaning.?inventory|cross.?reference)'; then
        emit_packet_warning "Governance-patch appears to be a migration but CHANGE-BOUNDARY may lack source-meaning inventory or cross-reference list."
      fi
    fi
  fi
fi

exit 0
