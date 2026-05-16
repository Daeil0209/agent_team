#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

PARSED="$(INPUT_JSON="$INPUT" HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js" node <<'NODE'
const { encode, flattenText, joinUniqueText, firstNonEmptyString } = require(process.env.HOOK_JSON_HELPERS);
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
	    toolInput.to,
	    toolInput.target,
	    toolInput.role,
	    toolInput.lane,
	    toolInput.worker_name,
	    toolInput.workerName,
    toolInput.teammate_name,
    toolInput.teammateName,
    toolInput.target_name,
    toolInput.targetName
  );
	  process.stdout.write([toolName, description, agentName, String(input.session_id || "")].map(encode).join("\n"));
	} catch {
	  process.stdout.write("\n\n\n\n");
	}
NODE
)"

mapfile -t FIELDS <<<"$PARSED"

TOOL_NAME="$(hook_decode_base64_field "${FIELDS[0]:-}")"
DESCRIPTION="$(hook_decode_base64_field "${FIELDS[1]:-}")"
AGENT_NAME="$(hook_decode_base64_field "${FIELDS[2]:-}")"
SESSION_ID="$(hook_decode_base64_field "${FIELDS[3]:-}")"
SESSION_ID="$(recover_session_id "$SESSION_ID")"

emit_packet_warning() {
  local reason="${1:?reason required}"
  reason="${reason/BLOCKED: /}"
  printf '[%s] DISPATCH-PROOF WARN: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" >> "$VIOLATION_LOG"
}

emit_packet_deny() {
  local reason="${1:?reason required}"
  printf '[%s] DISPATCH-PROOF DENY: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$reason" >> "$VIOLATION_LOG"
  hook_emit_pretool_deny "$reason" "Dispatch packet blocked."
}

emit_channel_clarity_warning() {
  local reason="${1:?reason required}"
  emit_packet_warning "$reason"
}

dispatch_proof_note() {
  local detail="${1:?detail required}"
  local next_step="${2:?next step required}"
  printf 'dispatch packet incomplete. Detail: %s. Next: %s.' "$detail" "$next_step"
}

case "$TOOL_NAME" in
  Agent|SendMessage) ;;
  *) exit 0 ;;
esac

TARGET_LANE="$(resolve_requested_dispatch_name "$AGENT_NAME" "$DESCRIPTION")"
if [[ "$TOOL_NAME" == "Agent" ]] && [[ -n "$TARGET_LANE" && "$TARGET_LANE" != "unknown" ]] && ! dispatch_target_is_dispatchable_agent "$TARGET_LANE"; then
  # dispatch-sizing-gate owns the user-facing deny for invalid Agent targets.
  exit 0
fi
TARGET_LANE="$(resolve_agent_id "$TARGET_LANE")"
CURRENT_PHASE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "CURRENT-PHASE" 2>/dev/null || true)"
WORK_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "WORK-SURFACE" 2>/dev/null || true)"
MESSAGE_CLASS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "MESSAGE-CLASS" 2>/dev/null || true)"
REQUIRED_SKILLS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REQUIRED-SKILLS" 2>/dev/null || true)"
TASK_ID_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-ID" 2>/dev/null || true)"
ACCEPTANCE_RISK_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACCEPTANCE-RISK" 2>/dev/null || true)"
REVIEW_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-OWNER" 2>/dev/null || true)"
PROOF_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-OWNER" 2>/dev/null || true)"
ACCEPTANCE_OWNER_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACCEPTANCE-OWNER" 2>/dev/null || true)"
ACTIVE_WORKFLOW_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACTIVE-WORKFLOW" 2>/dev/null || true)"
TASK_CLASS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TASK-CLASS" 2>/dev/null || true)"
REVIEW_TARGET_TYPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-TARGET-TYPE" 2>/dev/null || true)"
REVIEW_TARGET_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-TARGET" 2>/dev/null || true)"
REVIEW_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "REVIEW-SCOPE" 2>/dev/null || true)"
PREREQ_STATE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PREREQ-STATE" 2>/dev/null || true)"
EVIDENCE_BASIS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "EVIDENCE-BASIS" 2>/dev/null || true)"
ACCEPTANCE_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ACCEPTANCE-SURFACE" 2>/dev/null || true)"
PRIOR_ANALYSIS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PRIOR-ANALYSIS" 2>/dev/null || true)"
PROOF_TARGET_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-TARGET" 2>/dev/null || true)"
ENV_BASIS_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "ENV-BASIS" 2>/dev/null || true)"
SCENARIO_SCOPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "SCENARIO-SCOPE" 2>/dev/null || true)"
PROOF_EXPECTATION_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-EXPECTATION" 2>/dev/null || true)"
PROOF_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "PROOF-SURFACE" 2>/dev/null || true)"
USER_SURFACE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "USER-SURFACE" 2>/dev/null || true)"
USER_SURFACE_PROOF_PATH_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "USER-SURFACE-PROOF-PATH" 2>/dev/null || true)"
TOOL_REQUIREMENT_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-REQUIREMENT" 2>/dev/null || true)"
TOOL_DISCOVERY_GOAL_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-DISCOVERY-GOAL" 2>/dev/null || true)"
TOOL_DISCOVERY_BOUNDARY_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-DISCOVERY-BOUNDARY" 2>/dev/null || true)"
TOOL_VERIFICATION_STANDARD_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-VERIFICATION-STANDARD" 2>/dev/null || true)"
TOOL_CLEANUP_EXPECTATION_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "TOOL-CLEANUP-EXPECTATION" 2>/dev/null || true)"
VALIDATION_TARGET_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "VALIDATION-TARGET" 2>/dev/null || true)"
VALIDATION_TARGET_TYPE_RAW="$(dispatch_field_raw_value "$DESCRIPTION" "VALIDATION-TARGET-TYPE" 2>/dev/null || true)"
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

infer_sendmessage_assignment_lane() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1
  [[ "$TARGET_LANE" == "unknown" ]] || return 1

  local text="${1-}"

  if field_present "$REVIEW_TARGET_TYPE_RAW" || field_present "$REVIEW_TARGET_RAW" || field_present "$REVIEW_SCOPE_RAW" || field_present "$PREREQ_STATE_RAW" || field_present "$ACCEPTANCE_SURFACE_RAW" || field_present "$PRIOR_ANALYSIS_RAW"; then
    printf 'reviewer'
    return 0
  fi

  if field_present "$VALIDATION_TARGET_TYPE_RAW" || field_present "$VALIDATION_TARGET_RAW" || field_present "$EXPECTATION_SOURCES_RAW" || field_present "$REVIEW_STATE_RAW" || field_present "$TEST_STATE_RAW" || field_present "$VALIDATION_SURFACE_RAW" || field_present "$DECISION_SURFACE_RAW"; then
    printf 'validator'
    return 0
  fi

  if field_present "$PROOF_TARGET_RAW" || field_present "$PROOF_EXPECTATION_RAW" || field_present "$PROOF_SURFACE_RAW" || field_present "$ENV_BASIS_RAW" || field_present "$SCENARIO_SCOPE_RAW"; then
    printf 'tester'
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(reviewer|review|audit|inspect)\b|검토|리뷰|감사'; then
    printf 'reviewer'
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(tester|test|proof|retest)\b|테스트|재테스트|증명'; then
    printf 'tester'
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(validator|validate|validation|acceptance|revalidate)\b|검증|재검증|억셉턴스|벨리데이터'; then
    printf 'validator'
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(developer|implement|fix|patch|correct)\b|구현|수정|패치|보완'; then
    printf 'developer'
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(researcher|research)\b|조사|리서치'; then
    printf 'researcher'
    return 0
  fi

  return 1
}

plain_sendmessage_assignment_intent() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1
  [[ -z "$MESSAGE_CLASS_NORM" ]] || return 1
  [[ -n "$AGENT_NAME" || ( -n "$TARGET_LANE" && "$TARGET_LANE" != "unknown" ) ]] || return 1

  local text="${1-}"

  if printf '%s' "$text" | grep -qiE '\b(assign|assignment|reroute|reuse|work on|take over)\b'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(handle|start|begin|continue|resume)\b.*\b(current|implementation|artifact|surface|deliverable|packet|evidence|acceptance|proof|change|task|work|review|test|validation|fix|patch)\b'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(current|implementation|artifact|surface|deliverable|packet|evidence|acceptance|proof|change|task|work|review|test|validation|fix|patch)\b.*\b(handle|start|begin|continue|resume)\b'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(please|pls|kindly)\b.*\b(review|test|validate|verify|prove|implement|fix|patch|research|audit|inspect|analyze|revalidate|retest|correct)\b'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qiE '\b(review|test|validate|verify|prove|implement|fix|patch|research|audit|inspect|analyze|revalidate|retest|correct)\b.*\b(current|implementation|artifact|surface|deliverable|packet|evidence|acceptance|proof|change|task|work)\b'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qE '(검토|리뷰|테스트|검증|구현|수정|패치|보완|조사|분석|감사|재검증|재테스트)[[:space:]]*(해|해주세요|해줘|하라|해라|진행|실시|수행|착수)'; then
    return 0
  fi

  if printf '%s' "$text" | grep -qE '(현재|구현물|산출물|작업|업무|태스크|표면|증거|억셉턴스|수정사항|변경사항).*(검토|리뷰|테스트|검증|구현|수정|패치|보완|조사|분석|감사|처리|진행|시작|계속|재검증|재테스트)[[:space:]]*(해|해주세요|해줘|하라|해라|실시|수행|착수|맡아|담당)'; then
    return 0
  fi

  return 1
}

browser_tool_basis_present() {
  field_present "$TOOL_REQUIREMENT_RAW" && return 0

  field_present "$TOOL_DISCOVERY_GOAL_RAW" &&
    field_present "$TOOL_DISCOVERY_BOUNDARY_RAW" &&
    field_present "$TOOL_VERIFICATION_STANDARD_RAW" &&
    field_present "$TOOL_CLEANUP_EXPECTATION_RAW"
}

proof_surface_is_executable() {
  case "$PROOF_SURFACE_TOKEN" in
    browserui|cli|runtime|server|app|api)
      return 0
      ;;
  esac

  return 1
}

task_tracking_context_present() {
  printf '%s' "$DESCRIPTION" | grep -qiE '(task[ -]?tracking|taskcreate|task-created|assigned[ -]?id|task-id[[:space:]]+(required|active))'
}

normalize_dispatch_enum_token() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]_-'
}

join_notes() {
  local joined=""
  local note=""

  for note in "$@"; do
    [[ -n "$note" ]] || continue
    if [[ -n "$joined" ]]; then
      joined="${joined}; ${note}"
    else
      joined="$note"
    fi
  done

  printf '%s' "$joined"
}

missing_field_format_notes() {
  local raw_desc="${1-}"
  shift || true
  local field_name=""
  local hint=""
  local -a hints=()

  for field_name in "$@"; do
    hint="$(dispatch_field_format_hint "$raw_desc" "$field_name" 2>/dev/null || true)"
    [[ -n "$hint" ]] && hints+=("$hint")
  done

  join_notes "${hints[@]}"
}

PROOF_SURFACE_TOKEN="$(normalize_dispatch_enum_token "$PROOF_SURFACE_RAW")"
VALIDATION_SURFACE_TOKEN="$(normalize_dispatch_enum_token "$VALIDATION_SURFACE_RAW")"

tester_or_validator_needs_delivery_contract() {
  [[ "$TARGET_LANE" == "tester" || "$TARGET_LANE" == "validator" ]] || return 1

  if [[ "$ACTIVE_WORKFLOW_NORM" == "devworkflow" || "$ACTIVE_WORKFLOW_NORM" == "dev-workflow" ]]; then
    return 0
  fi

  if [[ "$PROOF_SURFACE_TOKEN" == "browserui" || "$PROOF_SURFACE_TOKEN" == "cli" || "$VALIDATION_SURFACE_TOKEN" == "browserui" || "$VALIDATION_SURFACE_TOKEN" == "cli" ]]; then
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
      TASK-ID) field_present "$TASK_ID_RAW" || missing+=("$field_name") ;;
      REVIEW-TARGET-TYPE) field_present "$REVIEW_TARGET_TYPE_RAW" || missing+=("$field_name") ;;
      REVIEW-TARGET) field_present "$REVIEW_TARGET_RAW" || missing+=("$field_name") ;;
      REVIEW-SCOPE) field_present "$REVIEW_SCOPE_RAW" || missing+=("$field_name") ;;
      PREREQ-STATE) field_present "$PREREQ_STATE_RAW" || missing+=("$field_name") ;;
      EVIDENCE-BASIS) field_present "$EVIDENCE_BASIS_RAW" || missing+=("$field_name") ;;
      ACCEPTANCE-RISK) field_present "$ACCEPTANCE_RISK_RAW" || missing+=("$field_name") ;;
      ACCEPTANCE-SURFACE) field_present "$ACCEPTANCE_SURFACE_RAW" || missing+=("$field_name") ;;
      PRIOR-ANALYSIS) field_present "$PRIOR_ANALYSIS_RAW" || missing+=("$field_name") ;;
      PROOF-TARGET) field_present "$PROOF_TARGET_RAW" || missing+=("$field_name") ;;
      ENV-BASIS) field_present "$ENV_BASIS_RAW" || missing+=("$field_name") ;;
      SCENARIO-SCOPE) field_present "$SCENARIO_SCOPE_RAW" || missing+=("$field_name") ;;
      PROOF-EXPECTATION) field_present "$PROOF_EXPECTATION_RAW" || missing+=("$field_name") ;;
      PROOF-SURFACE) field_present "$PROOF_SURFACE_RAW" || missing+=("$field_name") ;;
      USER-SURFACE) field_present "$USER_SURFACE_RAW" || missing+=("$field_name") ;;
      USER-SURFACE-PROOF-PATH) field_present "$USER_SURFACE_PROOF_PATH_RAW" || missing+=("$field_name") ;;
      TOOL-REQUIREMENT) field_present "$TOOL_REQUIREMENT_RAW" || missing+=("$field_name") ;;
      TOOL-DISCOVERY-GOAL) field_present "$TOOL_DISCOVERY_GOAL_RAW" || missing+=("$field_name") ;;
      TOOL-DISCOVERY-BOUNDARY) field_present "$TOOL_DISCOVERY_BOUNDARY_RAW" || missing+=("$field_name") ;;
      TOOL-VERIFICATION-STANDARD) field_present "$TOOL_VERIFICATION_STANDARD_RAW" || missing+=("$field_name") ;;
      TOOL-CLEANUP-EXPECTATION) field_present "$TOOL_CLEANUP_EXPECTATION_RAW" || missing+=("$field_name") ;;
      VALIDATION-TARGET-TYPE) field_present "$VALIDATION_TARGET_TYPE_RAW" || missing+=("$field_name") ;;
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

assignment_packet_requests_screen_polluting_completion() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 1

  local text_norm=""
  text_norm="$(printf '%s' "$DESCRIPTION" | tr '[:upper:]' '[:lower:]')"

  printf '%s' "$text_norm" | grep -Eq 'final[[:space:]-]+upward[[:space:]-]+message|upward[[:space:]-]+message[[:space:]]+to[[:space:]]+team-lead' || return 1
  printf '%s' "$text_norm" | grep -Eq 'count|counts|files-with-findings|files-clean|per-axis|finding[s]?[[:space:]-]+count|read[[:space:]-]+count|excerpt|summary|next-action|starting|will[[:space:]]+read|will[[:space:]]+write|retained[[:space:]-]+output[[:space:]-]+contents'
}

if [[ "$TOOL_NAME" == "SendMessage" ]] \
  && [[ -z "$MESSAGE_CLASS_NORM" ]] \
  && [[ -z "$WORK_SURFACE_RAW" ]] \
  && [[ -z "$CURRENT_PHASE_RAW" ]] \
  && [[ -z "$TASK_ID_RAW" ]] \
  && [[ -z "$REQUIRED_SKILLS_RAW" ]]; then
  if plain_sendmessage_assignment_intent "$DESCRIPTION"; then
    target_label="$TARGET_LANE"
    if [[ -z "$target_label" || "$target_label" == "unknown" ]]; then
      target_label="${AGENT_NAME:-target}"
    fi
    emit_channel_clarity_warning "$(dispatch_proof_note "free-form SendMessage reads as assignment-grade lane work for ${target_label} without the assignment packet floor" "send a structured assignment packet with MESSAGE-CLASS, WORK-SURFACE, CURRENT-PHASE, REQUIRED-SKILLS, and lane-specific fields; use MESSAGE-CLASS: status or phase-transition-control for non-assignment channel traffic; use structured shutdown_request for cleanup")"
    exit 0
  fi
  exit 0
fi

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
  if assignment_packet_requests_screen_polluting_completion; then
    emit_packet_deny "BLOCKED: assignment packet requests screen-polluting final upward message detail. Completion counts, excerpts, plans, retained-output contents, and future-action prose must stay in retained-output; the upward completion transport is the completion pointer envelope only."
    exit 0
  fi

  if [[ "$TOOL_NAME" == "SendMessage" && "$TARGET_LANE" == "unknown" ]]; then
    inferred_lane="$(infer_sendmessage_assignment_lane "$DESCRIPTION" || true)"
    if [[ -n "$inferred_lane" ]]; then
      TARGET_LANE="$inferred_lane"
    else
      target_label="${AGENT_NAME:-target}"
      emit_channel_clarity_warning "$(dispatch_proof_note "assignment-grade SendMessage targets ${target_label}, but dispatch-proof cannot resolve the target lane contract" "make the target lane evident in the packet or route target-resolution repair through task-execution")"
      exit 0
    fi
  fi

  packet_warning_needed="false"
  if [[ -z "$MESSAGE_CLASS_RAW" ]]; then
    packet_warning_needed="true"
  fi
  if [[ -z "$REQUIRED_SKILLS_RAW" ]]; then
    packet_warning_needed="true"
  fi
  if [[ -z "$WORK_SURFACE_NORM" || -z "$CURRENT_PHASE_NORM" ]]; then
    packet_warning_needed="true"
  fi
  if task_tracking_context_present && [[ -z "$TASK_ID_RAW" ]]; then
    packet_warning_needed="true"
  fi
  if [[ "$packet_warning_needed" == "true" ]]; then
    emit_packet_warning "Dispatch packet has incomplete clean fields. Add MESSAGE-CLASS, REQUIRED-SKILLS (additional methodology or capability skills or []), WORK-SURFACE, CURRENT-PHASE, and TASK-ID when task tracking is active. task-execution corrects the packet before send; if a deficient packet is delivered, the agent holds on decisive missing-field ambiguity."
  fi
fi

# This hook guards proof or acceptance packet gaps.
# task-execution remains packet owner.
# task-execution repairs packet gaps before dispatch.
# A receiving lane holds when a bad packet already arrived.
# Hooks remain last-resort runtime guards.
if [[ "$is_assignment_dispatch" == "true" ]]; then
  if [[ "$TARGET_LANE" == "reviewer" ]]; then
    reviewer_required_fields="MESSAGE-CLASS WORK-SURFACE CURRENT-PHASE REQUIRED-SKILLS REVIEW-TARGET-TYPE REVIEW-TARGET REVIEW-SCOPE PREREQ-STATE EVIDENCE-BASIS ACCEPTANCE-RISK ACCEPTANCE-SURFACE PRIOR-ANALYSIS"
    reviewer_missing_fields="$(lane_packet_missing_fields $reviewer_required_fields)"
    if [[ -n "$reviewer_missing_fields" ]]; then
      reviewer_format_notes="$(missing_field_format_notes "$DESCRIPTION" $reviewer_missing_fields)"
      reviewer_detail="reviewer dispatch is missing required review contract fields (${reviewer_missing_fields})"
      reviewer_next_step="repair the packet in task-execution, then retry dispatch; if an already-delivered packet still reaches reviewer, reviewer holds on decisive missing-field ambiguity"
      if [[ -n "$reviewer_format_notes" ]]; then
        reviewer_detail="${reviewer_detail}. Format note: ${reviewer_format_notes}"
        reviewer_next_step="repair field shape in task-execution as same-line KEY: value entries, then retry dispatch; if ambiguity remains after delivery, reviewer holds"
      fi
      emit_channel_clarity_warning "$(dispatch_proof_note "$reviewer_detail" "$reviewer_next_step")"
      exit 0
    fi
  fi

  if [[ "$TARGET_LANE" == "tester" ]]; then
    tester_required_fields="MESSAGE-CLASS WORK-SURFACE CURRENT-PHASE REQUIRED-SKILLS PROOF-TARGET PROOF-EXPECTATION PROOF-SURFACE ENV-BASIS SCENARIO-SCOPE"
    if [[ "$PROOF_SURFACE_TOKEN" == "browserui" ]]; then
      tester_required_fields+=" USER-SURFACE USER-SURFACE-PROOF-PATH"
    fi
    if tester_or_validator_needs_delivery_contract; then
      tester_required_fields+=" USER-RUN-PATH BURDEN-CONTRACT"
    fi
    tester_missing_fields="$(lane_packet_missing_fields $tester_required_fields)"
    if [[ -n "$tester_missing_fields" ]]; then
      tester_format_notes="$(missing_field_format_notes "$DESCRIPTION" $tester_missing_fields)"
      tester_detail="tester dispatch is missing required proof contract fields (${tester_missing_fields})"
      tester_next_step="repair the packet in task-execution, then retry dispatch; if an already-delivered packet still reaches the lane, the lane holds on decisive missing-field ambiguity"
      if [[ -n "$tester_format_notes" ]]; then
        tester_detail="${tester_detail}. Format note: ${tester_format_notes}"
        tester_next_step="repair field shape in task-execution as same-line KEY: value entries, then retry dispatch; if ambiguity remains after delivery, the lane holds"
      fi
      emit_channel_clarity_warning "$(dispatch_proof_note "$tester_detail" "$tester_next_step")"
      exit 0
    fi
    if [[ "$PROOF_SURFACE_TOKEN" == "browserui" ]] && ! browser_tool_basis_present; then
      tester_detail="tester dispatch is missing browser-ui tool basis (add TOOL-REQUIREMENT, or add the complete TOOL-DISCOVERY-GOAL, TOOL-DISCOVERY-BOUNDARY, TOOL-VERIFICATION-STANDARD, TOOL-CLEANUP-EXPECTATION bundle)"
      tester_next_step="repair the packet with the exact frozen tool or bounded discovery/setup contract, then retry dispatch; if proof still cannot be performed after delivery, the lane holds"
      emit_channel_clarity_warning "$(dispatch_proof_note "$tester_detail" "$tester_next_step")"
      exit 0
    fi
  fi

  if [[ "$TARGET_LANE" == "validator" ]]; then
    validator_required_fields="MESSAGE-CLASS WORK-SURFACE CURRENT-PHASE REQUIRED-SKILLS VALIDATION-TARGET-TYPE VALIDATION-TARGET EXPECTATION-SOURCES REVIEW-STATE TEST-STATE VALIDATION-SURFACE"
    if [[ "$VALIDATION_SURFACE_TOKEN" == "browserui" ]]; then
      validator_required_fields+=" USER-SURFACE USER-SURFACE-PROOF-PATH"
    fi
    if tester_or_validator_needs_delivery_contract; then
      validator_required_fields+=" USER-RUN-PATH BURDEN-CONTRACT"
    fi
    validator_missing_fields="$(lane_packet_missing_fields $validator_required_fields)"
    if [[ -n "$validator_missing_fields" ]]; then
      validator_format_notes="$(missing_field_format_notes "$DESCRIPTION" $validator_missing_fields)"
      validator_detail="validator dispatch is missing required acceptance contract fields (${validator_missing_fields})"
      validator_next_step="repair the packet in task-execution, then retry dispatch; if an already-delivered packet still reaches validator, validator holds on decisive missing-field ambiguity"
      if [[ -n "$validator_format_notes" ]]; then
        validator_detail="${validator_detail}. Format note: ${validator_format_notes}"
        validator_next_step="repair field shape in task-execution as same-line KEY: value entries, then retry dispatch; if ambiguity remains after delivery, validator holds"
      fi
      emit_channel_clarity_warning "$(dispatch_proof_note "$validator_detail" "$validator_next_step")"
      exit 0
    fi
    if [[ "$VALIDATION_SURFACE_TOKEN" == "browserui" ]] && ! browser_tool_basis_present; then
      validator_detail="validator dispatch is missing browser-ui tool basis (add TOOL-REQUIREMENT, or add the complete TOOL-DISCOVERY-GOAL, TOOL-DISCOVERY-BOUNDARY, TOOL-VERIFICATION-STANDARD, TOOL-CLEANUP-EXPECTATION bundle)"
      validator_next_step="repair the packet with the exact frozen tool or bounded discovery/setup contract, then retry dispatch; if validation still cannot be performed after delivery, validator holds"
      emit_channel_clarity_warning "$(dispatch_proof_note "$validator_detail" "$validator_next_step")"
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
      emit_packet_warning "Developer dispatch acceptance ownership is unresolved. Add REVIEW-OWNER, PROOF-OWNER, and ACCEPTANCE-OWNER, or cite explicit not-applicable bases allowed by the frozen acceptance risk; agent must HOLD if review, proof, or final acceptance ownership remains ambiguous."
    fi
  fi

  # Warning: governance-patch guardrail check
  if [[ "$TASK_CLASS_NORM" == "governance-patch" || "$TASK_CLASS_NORM" == "governancepatch" ]]; then
    gov_warning_needed="false"
    if [[ -z "$CHANGE_BOUNDARY_RAW" ]]; then
      gov_warning_needed="true"
    fi
    if [[ -z "$WRITE_SCOPE_RAW" ]]; then
      gov_warning_needed="true"
    fi
    if [[ "$gov_warning_needed" == "true" ]]; then
      emit_packet_warning "Governance-patch dispatch missing CHANGE-BOUNDARY or WRITE-SCOPE. These are minimum guardrails only; developer governance patches must also satisfy the semantic owner docs, including full developer production basis and material PRIOR-ANALYSIS evidence."
    fi
    # Migration warning: detect move/migrate/re-home without meaning inventory
    if [[ -n "$CHANGE_BOUNDARY_RAW" ]] && printf '%s' "$CHANGE_BOUNDARY_RAW" | grep -qiE '(move|migrate|re-home|transfer|relocate)'; then
      if ! printf '%s' "$CHANGE_BOUNDARY_RAW" | grep -qiE '(source.?meaning|meaning.?inventory|cross.?reference)'; then
        emit_packet_warning "Governance-patch migration signal lacks source-meaning inventory or cross-reference list in CHANGE-BOUNDARY."
      fi
    fi
  fi
fi

exit 0
