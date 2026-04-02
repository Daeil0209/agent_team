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
    const preferredKeys = ["text", "message", "content", "summary", "body", "value", "description", "title", "note", "notes"];
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key]));
    if (preferred.length) return preferred;
    return Object.values(value).flatMap(flattenText);
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
const collectAgentDispatchText = (toolInput) => joinUniqueText([
  ...flattenText(toolInput.description),
  ...flattenText(toolInput.summary),
  ...flattenText(toolInput.prompt),
  ...flattenText(toolInput.task),
  ...flattenText(toolInput.assignment),
  ...flattenText(toolInput.message),
  ...flattenText(toolInput.content),
  ...flattenText(toolInput.instructions),
  ...flattenText(toolInput.goal),
  ...flattenText(toolInput.brief),
  ...flattenText(toolInput.context),
  ...flattenText(toolInput.request),
  ...flattenText(toolInput.note),
  ...flattenText(toolInput.notes),
]);

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "Agent");
  const t = input.tool_input || {};
  let description = String(t.description || "");
  let runInBackground = String(t.run_in_background || false);
  let mode = t.mode || "";
  let targetName = String(t.name || "");
  if (toolName === "Agent") {
    description = collectAgentDispatchText(t);
    targetName = firstNonEmptyString(
      t.name,
      t.agent_name,
      t.agentName,
      t.subagent_type,
      t.subagentType,
      t.role,
      t.lane,
      t.worker_name,
      t.workerName,
      t.teammate_name,
      t.teammateName,
      t.target_name,
      t.targetName
    );
  }
  if (toolName === "SendMessage") {
    targetName = String(t.to || t.recipient || targetName || "");
    description = joinUniqueText(
      flattenText(t.summary).concat(flattenText(t.message || t.content))
    );
    runInBackground = "false";
    mode = "";
  }
  const fields = [
    toolName,
    description,
    runInBackground,
    mode,
    targetName,
    String(input.session_id || ""),
    String(input.agent_id || ""),
    String(input.agent_type || "")
  ];
  process.stdout.write(fields.map(encode).join("\n"));
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
DESCRIPTION="$(decode_field "${FIELDS[1]:-}")"
RUN_IN_BACKGROUND="$(decode_field "${FIELDS[2]:-}")"
MODE="$(decode_field "${FIELDS[3]:-}")"
AGENT_NAME="$(decode_field "${FIELDS[4]:-}")"
SESSION_ID="$(decode_field "${FIELDS[5]:-}")"
AGENT_ID="$(decode_field "${FIELDS[6]:-}")"
SENDER_AGENT_TYPE="$(decode_field "${FIELDS[7]:-}")"

TIMESTAMP="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
NAME_FALLBACK="$(printf '%s' "$DESCRIPTION" | sed -n 's/^\([a-zA-Z0-9_-]*\):.*/\1/p')"
if [[ -z "$AGENT_NAME" ]]; then
  AGENT_NAME="$(resolve_requested_dispatch_name "" "$DESCRIPTION")"
fi
if [[ -z "$AGENT_NAME" ]]; then
  AGENT_NAME="$NAME_FALLBACK"
fi
RESOLVED_ID="$(resolve_agent_id "$AGENT_NAME")"
if [[ "$RESOLVED_ID" == "unknown" && "$(normalize_lane_id "$AGENT_NAME")" == "team-lead" ]]; then
  RESOLVED_ID="team-lead"
fi
if [[ "$RESOLVED_ID" == "unknown" && -n "$NAME_FALLBACK" && "$NAME_FALLBACK" != "$AGENT_NAME" ]]; then
  RESOLVED_ID="$(resolve_agent_id "$NAME_FALLBACK")"
fi
CATEGORY="$(get_agent_category "$RESOLVED_ID")"

case "$RUN_IN_BACKGROUND" in
  true|True|TRUE|1) RUN_IN_BACKGROUND="true" ;;
  false|False|FALSE|0|"") RUN_IN_BACKGROUND="false" ;;
  *) RUN_IN_BACKGROUND="false" ;;
esac

# ── Pre-dispatch: safe dead-member cleanup ───────────────────────────
# Removes only members whose tmux panes are confirmed unreachable.
# Uses RUNTIME_TMUX_SOCKET_NAME for correct socket targeting.
# Includes 10s grace period for newly registered members.
# Also cleans up inbox files of removed dead members.
# NOTE: orphan pane kill is intentionally NOT done here — health-check.sh
# handles it periodically without the dispatch-time race condition.
if [[ -z "$AGENT_ID" ]]; then
  for _team_cfg in "$HOME/.claude/teams"/*/config.json; do
    [[ -f "$_team_cfg" ]] || continue
    _team_dir="$(dirname "$_team_cfg")"
    node -e "
      const fs = require('fs'), {execSync} = require('child_process');
      try {
        const cfg = JSON.parse(fs.readFileSync('${_team_cfg}', 'utf8'));
        const before = (cfg.members || []).length;
        const sock = process.env.RUNTIME_TMUX_SOCKET_NAME || '';
        const sockFlag = sock ? '-L ' + sock + ' ' : '';
        const now = Date.now();
        const GRACE_MS = 10000;
        const removed = [];
        cfg.members = (cfg.members || []).filter(m => {
          if (m.name === 'team-lead') return true;
          if (!m.tmuxPaneId) return true;
          if (m.joinedAt && (now - m.joinedAt) < GRACE_MS) return true;
          try {
            execSync('tmux ' + sockFlag + 'display-message -t \"' + m.tmuxPaneId + '\" -p \"\"', {stdio:'ignore', timeout: 2000});
            return true;
          } catch(e) {
            removed.push(m.name || '');
            return false;
          }
        });
        if (removed.length > 0) {
          fs.writeFileSync('${_team_cfg}', JSON.stringify(cfg, null, 2) + '\n');
          removed.forEach(name => {
            if (!name) return;
            try { fs.unlinkSync('${_team_dir}/inboxes/' + name + '.json'); } catch(e) {}
          });
        }
      } catch(e) {}
    " 2>/dev/null || true
  done
fi

deny_dispatch() {
  local log_code="${1:?log code required}"
  local deny_reason="${2:?deny reason required}"

  printf '[%s] PACKET-ADVISORY %s: %s | %s\n' \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$log_code" \
    "${DESCRIPTION:0:240}" \
    "${deny_reason:0:300}" >> "$VIOLATION_LOG"
}

resolve_sender_role() {
  local sender_role=""

  sender_role="$SENDER_AGENT_TYPE"
  if [[ -z "$sender_role" ]] && [[ -n "$SESSION_ID" ]] && [[ -f "$SESSION_AGENT_MAP" ]]; then
    sender_role="$(awk -v sid="$SESSION_ID" '$1 == sid {print $2; exit}' "$SESSION_AGENT_MAP" 2>/dev/null || true)"
  fi
  if [[ -z "$sender_role" ]] && [[ -n "$AGENT_ID" ]]; then
    sender_role="$(resolve_agent_id "$AGENT_ID")"
  fi
  if [[ -z "$sender_role" ]] && session_is_runtime_owner "$SESSION_ID"; then
    sender_role="team-lead"
  fi
  if [[ -z "$sender_role" ]] && [[ -z "$AGENT_ID" ]]; then
    sender_role="team-lead"
  fi

  printf '%s' "${sender_role:-unknown}"
}

dispatch_target_requires_acceptance_packet() {
  local target_id="${1:-}"

  case "$target_id" in
    developer|int-op|sw-spec|biz-sys|ui-ux|edu-spec|eng-spec|math-spec|doc-auto)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

dispatch_is_worker_lane() {
  local target_id="${1:-}"

  case "$target_id" in
    researcher|developer|reviewer|tester|validator)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

dispatch_is_managed_lane() {
  local target_id="${1:-}"

  case "$target_id" in
    researcher|developer|reviewer|tester|validator)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

dispatch_is_governing_lane() {
  local target_id="${1:-}"

  case "$target_id" in
    team-lead)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

dispatch_is_governance_patch_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1

  if [[ "$desc" == *"task-class: governance-patch"* ]]; then
    return 0
  fi

  if printf '%s' "$desc" | grep -Eq '(\.claude/|claude\.md|settings\.json|team setup|global doctrine|governance|self-growth|update/upgrade|change sequence|runtime policy)' \
    && printf '%s' "$desc" | grep -Eq '(patch|update|upgrade|harden|modify|rewrite|refactor|compress|compression|optimi[sz]|dedup|trim|re-home|migrate|normalize)'; then
    return 0
  fi

  return 1
}

dispatch_is_governance_optimization_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1
  if [[ "$desc" == *"patch-class: follow-on-optimization"* ]]; then
    return 0
  fi
  printf '%s' "$desc" | grep -Eq '(optimi[sz]|compress|compression|dedup|trim|rewrite|refactor|normalize|follow-on optimization)'
}

dispatch_is_high_traffic_governance_surface_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1
  printf '%s' "$desc" | grep -Eq 'owner-surface:[^;]*(claude\.md|agents/team-lead\.md|skills/team-governance-sequences/skill\.md|skills/team-session-sequences/skill\.md|hooks/|settings\.json)'
}

dispatch_has_session_turnover_resume_cues() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1
  printf '%s' "$desc" | grep -Eq '(fresh session|session reset|pause-return|pause return|previous session|prior session|inherited notes|remembered review|partial draft intent|continue previous|continue where .* left off|left off in (the )?(previous|prior) session|carry[ -]?over (continuity|notes|review|state|packet)|resume(d|ing)? (the )?(previous|prior) session|resum(e|ing) from continuity|resum(e|ing) from inherited notes|resum(e|ing) work from (the )?(previous|prior) session)'
}

dispatch_is_self_growth_execution_request() {
  [[ "$RESOLVED_ID" == "developer" ]] || return 1
  dispatch_field_value_matches "$DESCRIPTION" "task-class" "governance-patch" || return 1
  dispatch_field_value_matches "$DESCRIPTION" "sequence" "self-growth" || return 1
}

dispatch_is_solution_sensitive_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1

  if [[ "$desc" == *"task-class: solution-development"* ]]; then
    return 0
  fi

  if [[ "$desc" == *"problem-class: structural"* || "$desc" == *"problem-class: systemic"* ]]; then
    return 0
  fi

  if [[ "$desc" == *"task-class: governance-patch"* ]]; then
    if [[ "$desc" != *"problem-class:"* && "$desc" != *"root-cause-basis:"* && "$desc" != *"solution-pass:"* \
      && "$desc" != *"alternative-review:"* && "$desc" != *"selected-scope:"* && "$desc" != *"competing-hypotheses:"* ]]; then
      return 1
    fi
  fi

  if printf '%s' "$desc" | grep -Eq '(root cause|root-cause|systemic|structural|recurr|architecture|architectural|redesign|remediation|hardening|solution|proposal|approach|fix type|corrective|counterexample|alternative)' \
    && printf '%s' "$desc" | grep -Eq '(derive|design|recommend|propose|fix|solve|remediate|decide|choose|evaluate|review|validate|investigate|analy[sz]e)'; then
    return 0
  fi

  return 1
}

dispatch_has_structural_cues() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1
  printf '%s' "$desc" | grep -Eq '(recurr|systemic|structural|architecture|architectural|hardening|protocol|doctrine|recurrence|class of issue)'
}

dispatch_is_benchmark_sensitive_research_request() {
  local desc=""
  desc="$(normalize_dispatch_text "${1-}")"

  [[ -n "$desc" ]] || return 1

  if [[ "$desc" == *"benchmark-mode:"* || "$desc" == *"benchmark-basis:"* || "$desc" == *"benchmark-surface:"* || "$desc" == *"benchmark-axis:"* ]]; then
    return 0
  fi

  printf '%s' "$desc" | grep -Eq '(benchmark|baseline|before/after|before-after|compare|comparison|comparative|fairness|leaner path|incumbent|promotion gate|competitiveness|ownership contest|simpler path)'
}

enforce_solution_development_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""
  local structural_or_systemic="false"
  local root_cause_basis_unknown="false"
  local structural_cues_present="false"

  [[ "$RESOLVED_ID" == "developer" ]] || return 0

  if ! dispatch_is_solution_sensitive_request "$DESCRIPTION"; then
    return 0
  fi

  if dispatch_has_structural_cues "$DESCRIPTION"; then
    structural_cues_present="true"
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "info-loss-review" "done"; then
    missing+=("INFO-LOSS-REVIEW: done")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "source-meaning-inventory" "explicit"; then
    missing+=("SOURCE-MEANING-INVENTORY: explicit")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "destination-owner-map" "explicit"; then
    missing+=("DESTINATION-OWNER-MAP: explicit")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "change-boundary"; then
    missing+=("CHANGE-BOUNDARY: <bounded intended delta>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "verify-basis"; then
    missing+=("VERIFY-BASIS: <review or verification basis>")
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "problem-class" "instance|structural|systemic"; then
    missing+=("PROBLEM-CLASS: instance|structural|systemic")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "root-cause-basis" "confirmed|supported|hypothesis|unknown"; then
    missing+=("ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "solution-pass" "1|2|3"; then
    missing+=("SOLUTION-PASS: 1|2|3")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "decision-basis"; then
    missing+=("DECISION-BASIS: <why this path was selected>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "rejected-options"; then
    missing+=("REJECTED-OPTIONS: <alternatives considered and rejected>")
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "solution-pass" "2|3"; then
    if ! dispatch_field_present "$DESCRIPTION" "pass-delta"; then
      missing+=("PASS-DELTA: <what improved after the challenge pass>")
    fi
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "problem-class" "structural|systemic"; then
    structural_or_systemic="true"
    if ! dispatch_field_value_matches "$DESCRIPTION" "solution-pass" "2|3"; then
      missing+=("SOLUTION-PASS: 2|3")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "alternative-review" "done"; then
      missing+=("ALTERNATIVE-REVIEW: done")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "selected-scope" "class-fix|system-fix|staged-class-fix"; then
      missing+=("SELECTED-SCOPE: class-fix|system-fix|staged-class-fix")
    fi
  fi

  if [[ "$structural_cues_present" == "true" ]] && dispatch_field_value_matches "$DESCRIPTION" "problem-class" "instance"; then
    missing+=("PROBLEM-CLASS: structural|systemic")
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "root-cause-basis" "hypothesis|unknown"; then
    root_cause_basis_unknown="true"
    if ! dispatch_field_present "$DESCRIPTION" "competing-hypotheses"; then
      missing+=("COMPETING-HYPOTHESES: <plausible alternatives>")
    fi
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "selected-scope" "staged-class-fix"; then
    if ! dispatch_field_present "$DESCRIPTION" "follow-up-owner"; then
      missing+=("FOLLOW-UP-OWNER: <owner of the next hardening pass>")
    fi
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Consequential solution work must not stop at the first plausible draft. Treat bounded additions, deletions, rewrites, migrations, and workbook- or artifact-derived program work as modifications with loss risk too. Keep the preservation and solution-development packet explicit and force at least one challenge pass before execution or final recommendation. Include: ${missing_text}."
  if [[ "$structural_or_systemic" == "true" ]]; then
    deny_reason="${deny_reason} Structural or systemic problems require multi-pass solution development aimed at the recurrence path, not an instance-only shortcut."
  fi
  if [[ "$structural_cues_present" == "true" ]]; then
    deny_reason="${deny_reason} Descriptions that already indicate recurrence, architecture, doctrine, or hardening cannot be relabeled as a mere instance fix to escape the stronger gate."
  fi
  if [[ "$root_cause_basis_unknown" == "true" ]]; then
    deny_reason="${deny_reason} When root-cause confidence is not confirmed, competing hypotheses must stay explicit."
  fi
  deny_dispatch "A-SOLUTION-DEVELOPMENT BLOCKED" "$deny_reason"
}

enforce_governance_patch_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""

  if [[ "$RESOLVED_ID" != "developer" ]]; then
    return 0
  fi

  if ! dispatch_is_governance_patch_request "$DESCRIPTION"; then
    return 0
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "task-class" "governance-patch"; then
    missing+=("TASK-CLASS: governance-patch")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "sequence" "change|self-growth|update-upgrade"; then
    missing+=("SEQUENCE: change|self-growth|update-upgrade")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "patch-class" "hardening|structural-normalization|migration-rehome|config-owner-standardization|skill-up|new-skill|follow-on-optimization"; then
    missing+=("PATCH-CLASS: hardening|structural-normalization|migration-rehome|config-owner-standardization|skill-up|new-skill|follow-on-optimization")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "owner-surface"; then
    missing+=("OWNER-SURFACE: <owner files>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "baseline-class" "preserved-asset|improvement-target|stability-anchor"; then
    missing+=("BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "info-loss-review" "done"; then
    missing+=("INFO-LOSS-REVIEW: done")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "balance-review" "local-context-checked"; then
    missing+=("BALANCE-REVIEW: local-context-checked")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "related-doc-review" "adjacent-owner-surfaces-checked"; then
    missing+=("RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "patch-review" "pre-exec-done|done|approved"; then
    missing+=("PATCH-REVIEW: pre-exec-done")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "modification-proposal" "explicit"; then
    missing+=("MODIFICATION-PROPOSAL: explicit")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "source-meaning-inventory" "explicit"; then
    missing+=("SOURCE-MEANING-INVENTORY: explicit")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "destination-owner-map" "explicit"; then
    missing+=("DESTINATION-OWNER-MAP: explicit")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "change-boundary"; then
    missing+=("CHANGE-BOUNDARY: <bounded intended delta>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "verify-basis"; then
    missing+=("VERIFY-BASIS: <review or verification basis>")
  fi

  if dispatch_is_governance_optimization_request "$DESCRIPTION"; then
    if ! dispatch_field_value_matches "$DESCRIPTION" "optimization-order" "post-change-only"; then
      missing+=("OPTIMIZATION-ORDER: post-change-only")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "optimization-guard" "zero-loss"; then
      missing+=("OPTIMIZATION-GUARD: zero-loss")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "protected-meaning" "checked"; then
      missing+=("PROTECTED-MEANING: checked")
    fi
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Governance-sensitive modification dispatch is blocked until the sequence is explicit: information-loss review first, local-context balance review second, related-doc review third, bounded modification fourth, optimization only afterward. Treat additions, deletions, rewrites, migrations, compressions, and optimizations as the same loss-risk class; none may bypass the preservation packet. Do not let team-lead apply habitual shortcut edits to doctrine, hooks, settings, agents, or skills. Include: ${missing_text}."
  deny_dispatch "A-GOVERNANCE-PROCEDURE BLOCKED" "$deny_reason"
}

enforce_high_traffic_governance_resume_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""
  local high_traffic_surface="false"
  local session_turnover_resume="false"

  [[ "$RESOLVED_ID" == "developer" ]] || return 0
  dispatch_is_governance_patch_request "$DESCRIPTION" || return 0
  dispatch_is_governance_optimization_request "$DESCRIPTION" || return 0

  if dispatch_is_high_traffic_governance_surface_request "$DESCRIPTION"; then
    high_traffic_surface="true"
  fi
  if dispatch_has_session_turnover_resume_cues "$DESCRIPTION"; then
    session_turnover_resume="true"
  fi

  if [[ "$high_traffic_surface" != "true" && "$session_turnover_resume" != "true" ]]; then
    return 0
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "session-revalidation" "current-session-repo"; then
    missing+=("SESSION-REVALIDATION: current-session-repo")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "baseline-anchor" "captured"; then
    missing+=("BASELINE-ANCHOR: captured")
  fi
  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="High-traffic governance modification or session-turnover resume is blocked until the current session revalidates repository state and refreshes its baseline anchor. Remembered review from a prior session is continuity only, not edit authorization. Include: ${missing_text}."
  deny_dispatch "A-GOVERNANCE-RESUME BLOCKED" "$deny_reason"
}

enforce_research_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""
  local benchmark_sensitive="false"

  [[ "$RESOLVED_ID" == "researcher" ]] || return 0

  if [[ "$TOOL_NAME" == "SendMessage" ]]; then
    dispatch_field_value_matches "$DESCRIPTION" "message-class" "assignment" || return 0
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "research-mode" "bounded|deep|sharded"; then
    missing+=("RESEARCH-MODE: bounded|deep|sharded")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "decision-target"; then
    missing+=("DECISION-TARGET: <blocked decision or consumer surface>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "question-boundary"; then
    missing+=("QUESTION-BOUNDARY: <bounded question>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "source-family" "repo|runtime|web|mixed"; then
    missing+=("SOURCE-FAMILY: repo|runtime|web|mixed")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "downstream-consumer"; then
    missing+=("DOWNSTREAM-CONSUMER: <consumer or merge owner>")
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "research-mode" "sharded"; then
    if ! dispatch_field_present "$DESCRIPTION" "shard-id"; then
      missing+=("SHARD-ID: <shard id>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "shard-boundary"; then
      missing+=("SHARD-BOUNDARY: <non-overlap boundary>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "merge-owner"; then
      missing+=("MERGE-OWNER: <owner>")
    fi
  fi

  if dispatch_is_benchmark_sensitive_research_request "$DESCRIPTION"; then
    benchmark_sensitive="true"
    if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-mode" "light|full"; then
      missing+=("BENCHMARK-MODE: light|full")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "benchmark-basis"; then
      missing+=("BENCHMARK-BASIS: <baseline or incumbent path>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "benchmark-surface"; then
      missing+=("BENCHMARK-SURFACE: <what is being compared>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "benchmark-axis"; then
      missing+=("BENCHMARK-AXIS: <comparison axes>")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-provenance" "repo-observed|authoritative-external|mixed|simulator-only"; then
      missing+=("BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "cross-check-status" "repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed"; then
      missing+=("CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "hallucination-guard" "cite-or-hold"; then
      missing+=("HALLUCINATION-GUARD: cite-or-hold")
    fi
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Consequential researcher dispatch requires an explicit evidence packet. Do not let the lane shrink broad or contradiction-sensitive work into a shallow habit pass. Include: ${missing_text}."
  if [[ "$benchmark_sensitive" == "true" ]]; then
    deny_reason="${deny_reason} Comparative research also requires an explicit benchmark-light frame so baseline, fairness, provenance, cross-check state, and comparison axes stay visible instead of being improvised from habit."
  fi
  deny_dispatch "A-RESEARCH-DISPATCH BLOCKED" "$deny_reason"
}

enforce_review_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""

  [[ "$RESOLVED_ID" == "reviewer" ]] || return 0

  if [[ "$TOOL_NAME" == "SendMessage" ]]; then
    dispatch_field_value_matches "$DESCRIPTION" "message-class" "assignment" || return 0
  fi

  if ! dispatch_field_present "$DESCRIPTION" "review-target"; then
    missing+=("REVIEW-TARGET: <artifact or claim surface>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "prereq-state" "complete|partial|missing"; then
    missing+=("PREREQ-STATE: complete|partial|missing")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "evidence-basis"; then
    missing+=("EVIDENCE-BASIS: <proof or artifact basis>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "acceptance-surface"; then
    missing+=("ACCEPTANCE-SURFACE: <decision surface>")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Reviewer dispatch requires an explicit review packet. Missing prerequisites must stay visible instead of turning into a soft clean read. Include: ${missing_text}."
  deny_dispatch "A-REVIEW-DISPATCH BLOCKED" "$deny_reason"
}

enforce_test_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""

  [[ "$RESOLVED_ID" == "tester" ]] || return 0

  if [[ "$TOOL_NAME" == "SendMessage" ]]; then
    dispatch_field_value_matches "$DESCRIPTION" "message-class" "assignment" || return 0
  fi

  if ! dispatch_field_present "$DESCRIPTION" "proof-target"; then
    missing+=("PROOF-TARGET: <claim or artifact under test>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "env-basis"; then
    missing+=("ENV-BASIS: <environment or setup basis>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "scenario-scope"; then
    missing+=("SCENARIO-SCOPE: <scope actually exercised>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "proof-expectation"; then
    missing+=("PROOF-EXPECTATION: <what execution should prove or disprove>")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Tester dispatch requires an explicit proof packet. Do not let the test lane silently narrow environment or scenario scope into a convenience smoke check. Include: ${missing_text}."
  deny_dispatch "A-TEST-DISPATCH BLOCKED" "$deny_reason"
}

enforce_validation_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""

  [[ "$RESOLVED_ID" == "validator" ]] || return 0

  if [[ "$TOOL_NAME" == "SendMessage" ]]; then
    dispatch_field_value_matches "$DESCRIPTION" "message-class" "assignment" || return 0
  fi

  if ! dispatch_field_present "$DESCRIPTION" "validation-target"; then
    missing+=("VALIDATION-TARGET: <delivery or decision surface>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "expectation-sources"; then
    missing+=("EXPECTATION-SOURCES: <authoritative comparison sources>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "review-state" "ready|hold|blocked"; then
    missing+=("REVIEW-STATE: ready|hold|blocked")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "test-state" "ready|hold|blocked|not-needed"; then
    missing+=("TEST-STATE: ready|hold|blocked|not-needed")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "decision-surface"; then
    missing+=("DECISION-SURFACE: <pass/hold/fail surface>")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Validator dispatch requires an explicit arbitration packet. Do not let unresolved upstream review or proof gaps disappear behind a convenient final verdict. Include: ${missing_text}."
  deny_dispatch "A-VALIDATION-DISPATCH BLOCKED" "$deny_reason"
}

enforce_self_growth_coordination_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""
  local requires_full_benchmark="false"

  if ! dispatch_is_self_growth_execution_request; then
    return 0
  fi

  if ! dispatch_field_present "$DESCRIPTION" "capability-signal"; then
    missing+=("CAPABILITY-SIGNAL: <why this self-growth topic exists>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "inspect-lanes"; then
    missing+=("INSPECT-LANES: <lanes that inspected the topic>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "owner-routing" "existing-owner|single-fit|competitive-bid"; then
    missing+=("OWNER-ROUTING: existing-owner|single-fit|competitive-bid")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "balance-guard" "average-capability-protected"; then
    missing+=("BALANCE-GUARD: average-capability-protected")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-mode" "light|full"; then
    missing+=("BENCHMARK-MODE: light|full")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "benchmark-basis"; then
    missing+=("BENCHMARK-BASIS: <baseline or simpler-path basis>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "benchmark-surface"; then
    missing+=("BENCHMARK-SURFACE: <what is being compared>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-provenance" "repo-observed|authoritative-external|mixed|simulator-only"; then
    missing+=("BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "cross-check-status" "repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed"; then
    missing+=("CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "hallucination-guard" "cite-or-hold"; then
    missing+=("HALLUCINATION-GUARD: cite-or-hold")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "modification-proposal" "explicit"; then
    missing+=("MODIFICATION-PROPOSAL: explicit")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "change-boundary"; then
    missing+=("CHANGE-BOUNDARY: <bounded intended delta>")
  fi
  if dispatch_field_value_matches "$DESCRIPTION" "benchmark-provenance" "simulator-only"; then
    missing+=("SELF-GROWTH-READINESS: upgrade benchmark provenance beyond simulator-only before edit authorization")
  fi
  if dispatch_field_value_matches "$DESCRIPTION" "cross-check-status" "simulator-unconfirmed"; then
    missing+=("SELF-GROWTH-READINESS: upgrade cross-check status beyond simulator-unconfirmed before edit authorization")
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "patch-class" "skill-up|new-skill"; then
    requires_full_benchmark="true"
    if ! dispatch_field_value_matches "$DESCRIPTION" "growth-path" "existing-skill-expansion|new-skill-introduction|agent-charter-hardening|path-scoped-governance-rule|role-routing-correction"; then
      missing+=("GROWTH-PATH: existing-skill-expansion|new-skill-introduction|agent-charter-hardening|path-scoped-governance-rule|role-routing-correction")
    fi
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "patch-class" "new-skill"; then
    if ! dispatch_field_value_matches "$DESCRIPTION" "skill-category" "repeatable-procedure|specialist-judgment-surface|integration-environment-bridge|governance-quality-hardening"; then
      missing+=("SKILL-CATEGORY: repeatable-procedure|specialist-judgment-surface|integration-environment-bridge|governance-quality-hardening")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "reuse-pattern"; then
      missing+=("REUSE-PATTERN: <expected reuse pattern>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "overlap-result"; then
      missing+=("OVERLAP-RESULT: <existing-owner overlap result>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "chosen-owner"; then
      missing+=("CHOSEN-OWNER: <chosen owner>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "expansion-insufficiency"; then
      missing+=("EXPANSION-INSUFFICIENCY: <why existing skill expansion was insufficient>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "first-adoption-path"; then
      missing+=("FIRST-ADOPTION-PATH: <first adoption path>")
    fi
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "owner-routing" "competitive-bid"; then
    requires_full_benchmark="true"
    if ! dispatch_field_present "$DESCRIPTION" "bid-candidates"; then
      missing+=("BID-CANDIDATES: <candidate owners>")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "bid-basis"; then
      missing+=("BID-BASIS: ownership-fit|overlap-cost|throughput-effect|evidence-quality|rollback-path")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "adjudication-basis"; then
      missing+=("ADJUDICATION-BASIS: durable-ownership-fit|acceptance-reliability|coordination-cost|neighbor-regression-risk|long-run-cumulative-team-benefit")
    fi
  fi

  if [[ "$requires_full_benchmark" == "true" ]]; then
    if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-mode" "full"; then
      missing+=("BENCHMARK-MODE: full")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-skill" "bench-sim"; then
      missing+=("BENCHMARK-SKILL: bench-sim")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "benchmark-baseline"; then
      missing+=("BENCHMARK-BASELINE: <before path or incumbent owner>")
    fi
    if ! dispatch_field_pipe_list_matches "$DESCRIPTION" "benchmark-axis" "fairness|promotion-gate|competitiveness|average-capability"; then
      missing+=("BENCHMARK-AXIS: fairness|promotion-gate|competitiveness|average-capability")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "benchmark-evidence" "simulator-only|repo-local|live-task|mixed"; then
      missing+=("BENCHMARK-EVIDENCE: simulator-only|repo-local|live-task|mixed")
    fi
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Self-growth execution requires an explicit coordination packet before ownership hardens into edits. Keep the preparation order explicit: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization. Include: ${missing_text}."
  deny_dispatch "A-SELF-GROWTH-COORDINATION BLOCKED" "$deny_reason"
}


enforce_execution_acceptance_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""
  local meaningful_risk="false"

  if ! dispatch_target_requires_acceptance_packet "$RESOLVED_ID"; then
    return 0
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "task-class" "governance-patch|manifest-sync|solution-development"; then
    return 0
  fi

  if [[ "$TOOL_NAME" == "SendMessage" ]] && dispatch_field_value_matches "$DESCRIPTION" "message-class" "control|reroute|reuse|standby|release"; then
    return 0
  fi

  if ! dispatch_field_value_matches "$DESCRIPTION" "plan-state" "ready|approved|updated|revalidated"; then
    missing+=("PLAN-STATE: ready|approved|updated|revalidated")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "plan-step"; then
    missing+=("PLAN-STEP: <active plan step>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "acceptance-risk" "low|meaningful|high|critical"; then
    missing+=("ACCEPTANCE-RISK: low|meaningful|high|critical")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "review-owner" "reviewer"; then
    missing+=("REVIEW-OWNER: reviewer")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "proof-owner" "tester|not-needed"; then
    missing+=("PROOF-OWNER: tester|not-needed")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "acceptance-owner" "reviewer|validator"; then
    missing+=("ACCEPTANCE-OWNER: reviewer|validator")
  fi

  if dispatch_field_value_matches "$DESCRIPTION" "acceptance-risk" "meaningful|high|critical"; then
    meaningful_risk="true"
    if ! dispatch_field_value_matches "$DESCRIPTION" "proof-owner" "tester"; then
      missing+=("PROOF-OWNER: tester")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "acceptance-owner" "validator"; then
      missing+=("ACCEPTANCE-OWNER: validator")
    fi
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Implementation dispatch requires an explicit plan and acceptance-staffing packet. Do not let team-lead silently self-certify implementation work or compress the designed review/proof/validation procedure into a convenience path. Include: ${missing_text}."
  if [[ "$meaningful_risk" == "true" ]]; then
    deny_reason="${deny_reason} Meaningful acceptance risk requires reviewer, tester, and validator lanes to stay explicit."
  fi
  deny_dispatch "A-ACCEPTANCE-GATE BLOCKED" "$deny_reason"
}


SENDER_ROLE="$(resolve_sender_role)"
WORKER_PEER_PACKET_ACTIVE="false"

sender_is_control_lane() {
  case "$SENDER_ROLE" in
    team-lead)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

sender_is_reporting_lane() {
  case "$SENDER_ROLE" in
    developer|researcher|reviewer|tester|validator)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

peer_packet_contains_reserved_control_fields() {
  local reserved_fields=(
    "message-class"
    "task-class"
    "sequence"
    "patch-class"
    "owner-surface"
    "baseline-class"
    "review-target"
    "prereq-state"
    "acceptance-surface"
    "proof-target"
    "env-basis"
    "scenario-scope"
    "proof-expectation"
    "validation-target"
    "expectation-sources"
    "review-state"
    "test-state"
    "decision-surface"
    "plan-state"
    "plan-step"
    "acceptance-risk"
    "review-owner"
    "proof-owner"
    "acceptance-owner"
    "requested-governing-action"
    "delegated-scope"
    "delegated-actions"
  )
  local field=""

  for field in "${reserved_fields[@]}"; do
    if dispatch_field_present "$DESCRIPTION" "$field"; then
      printf '%s' "$field"
      return 0
    fi
  done

  return 1
}

enforce_governing_control_message_packet() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 0
  dispatch_is_managed_lane "$RESOLVED_ID" || return 0
  sender_is_control_lane || return 0

  local missing=()
  local missing_text=""

  if ! dispatch_field_value_matches "$DESCRIPTION" "message-class" "assignment|control|reroute|reuse|standby|release|shutdown"; then
    missing+=("MESSAGE-CLASS: assignment|control|reroute|reuse|standby|release|shutdown")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "message-priority" "normal|high|critical"; then
    missing+=("MESSAGE-PRIORITY: normal|high|critical")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "work-surface"; then
    missing+=("WORK-SURFACE: <bounded active surface>")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_dispatch "A-CONTROL-MESSAGE BLOCKED" "Downward control or assignment through SendMessage must keep direction and urgency explicit. Governing-lane messages to managed lanes require a control packet naming class, priority, and active surface. Include: ${missing_text}."
}

enforce_upward_report_message_packet() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 0
  dispatch_is_governing_lane "$RESOLVED_ID" || return 0
  sender_is_reporting_lane || return 0

  local missing=()
  local missing_text=""

  if ! dispatch_field_value_matches "$DESCRIPTION" "message-class" "blocker|handoff|completion|hold|scope-pressure|status"; then
    missing+=("MESSAGE-CLASS: blocker|handoff|completion|hold|scope-pressure|status")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "message-priority" "normal|high|critical"; then
    missing+=("MESSAGE-PRIORITY: normal|high|critical")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "work-surface"; then
    missing+=("WORK-SURFACE: <current surface>")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "requested-governing-action"; then
    missing+=("REQUESTED-GOVERNING-ACTION: <decision needed or none>")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_dispatch "A-UPWARD-REPORT BLOCKED" "Upward worker reporting must keep direction and urgency explicit. Report packets to the governing lane must say whether the message is a blocker, handoff, completion, hold, scope-pressure, or status update, plus the priority, active surface, and requested governing action. Include: ${missing_text}."
}

enforce_worker_message_routing() {
  [[ "$TOOL_NAME" == "SendMessage" ]] || return 0
  dispatch_is_worker_lane "$RESOLVED_ID" || return 0

  local missing=()
  local missing_text=""
  local reserved_field=""

  case "$SENDER_ROLE" in
    developer|researcher|reviewer|tester|validator)
      ;;
    *)
      return 0
      ;;
  esac

  if dispatch_field_value_matches "$DESCRIPTION" "peer-mode" "bounded-advice|challenge"; then
    if ! dispatch_field_value_matches "$DESCRIPTION" "message-priority" "normal|high|critical"; then
      missing+=("MESSAGE-PRIORITY: normal|high|critical")
    fi
    if ! dispatch_field_present "$DESCRIPTION" "surface-boundary"; then
      missing+=("SURFACE-BOUNDARY: <local issue>")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "no-ownership-change" "true"; then
      missing+=("NO-OWNERSHIP-CHANGE: true")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "no-acceptance-change" "true"; then
      missing+=("NO-ACCEPTANCE-CHANGE: true")
    fi
    if ! dispatch_field_value_matches "$DESCRIPTION" "escalate-if-unresolved" "true"; then
      missing+=("ESCALATE-IF-UNRESOLVED: true")
    fi

    if reserved_field="$(peer_packet_contains_reserved_control_fields)"; then
      deny_dispatch "A-WORKER-PEER-CONTROL BLOCKED" "Bounded worker-to-worker advice or challenge must not smuggle owner-routing, acceptance, delegated-control, or full assignment packets. Remove the reserved control field \`${reserved_field}\` and escalate through the governing lane if ownership, acceptance, or task control must change."
    fi

    if [[ ${#missing[@]} -eq 0 ]]; then
      WORKER_PEER_PACKET_ACTIVE="true"
      return 0
    fi

    printf -v missing_text '%s; ' "${missing[@]}"
    missing_text="${missing_text%; }"
    deny_dispatch "A-WORKER-PEER-PACKET BLOCKED" "Bounded worker-to-worker advice or challenge must stay local and escalation-ready. Include: ${missing_text}."
  fi

  deny_dispatch "A-WORKER-ROUTING BLOCKED" "Workers must report blockers, handoffs, and scope corrections to the governing lane (`team-lead`) rather than sending new scope or control instructions directly to peer workers. Peer-to-peer messages are allowed only as explicit bounded advice or challenge packets."
}

enforce_manifest_sync_dispatch_packet() {
  local missing=()
  local missing_text=""
  local deny_reason=""

  if ! dispatch_field_value_matches "$DESCRIPTION" "task-class" "manifest-sync"; then
    missing+=("TASK-CLASS: manifest-sync")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "manifest-unique" "[0-9][0-9]*"; then
    missing+=("MANIFEST-UNIQUE: <count>")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "overlap-review" "done|complete|approved|yes"; then
    missing+=("OVERLAP-REVIEW: done")
  fi
  if ! dispatch_field_value_matches "$DESCRIPTION" "pre-exec-review" "done|complete|approved|yes"; then
    missing+=("PRE-EXEC-REVIEW: done")
  fi
  if ! dispatch_field_present "$DESCRIPTION" "write-scope"; then
    missing+=("WRITE-SCOPE: <unique target set>")
  fi
  if dispatch_field_present "$DESCRIPTION" "shard-id" && ! dispatch_field_value_matches "$DESCRIPTION" "shard-set" "disjoint"; then
    missing+=("SHARD-SET: disjoint")
  fi

  if [[ ${#missing[@]} -eq 0 ]]; then
    return 0
  fi

  printf -v missing_text '%s; ' "${missing[@]}"
  missing_text="${missing_text%; }"
  deny_reason="Manifest-sync developer dispatch is blocked until pre-execution review is explicit. Collapse duplicates, report the final unique write set, and include: ${missing_text}. Deterministic copy or overwrite propagation is single-writer by default; shard only after non-overlap is explicit."
  printf '[%s] MANIFEST-SYNC BLOCKED: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${DESCRIPTION:0:240}" >> "$VIOLATION_LOG"
  DENY_REASON="$deny_reason" node <<'NODE'
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: process.env.DENY_REASON || "Manifest-sync developer dispatch requires explicit pre-execution review."
  }
}));
NODE
  exit 0
}

if [[ "$RESOLVED_ID" == "unknown" ]]; then
  printf '[%s] DISPATCH WARNING: Unknown agent ID from description: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${DESCRIPTION:0:200}" >> "$VIOLATION_LOG"
fi

if [[ "$RUN_IN_BACKGROUND" == "true" ]]; then
  NEEDS_MODE="$(check_agent_property "$RESOLVED_ID" "requires_mode_auto")"
  if [[ "$NEEDS_MODE" == "true" && "$MODE" != "auto" ]]; then
    printf '[%s] S-06 BLOCKED: Background %s without mode:auto: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$RESOLVED_ID" "${DESCRIPTION:0:200}" >> "$VIOLATION_LOG"
    cat <<EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[S-06] Background implementation agent must have mode:auto. Agent: ${RESOLVED_ID}. Add mode:\\\"auto\\\" to enable file write access."}}
EOF
    exit 0
  fi
fi

# ── Protocol message early-exit ──────────────────────────────────────
# Lifecycle protocol messages (shutdown_request, shutdown_response,
# plan_approval_request, plan_approval_response) are message-first
# control surfaces, not governed assignment packets. Skip the full
# enforcement cascade for these.
if [[ "$TOOL_NAME" == "SendMessage" ]]; then
  _proto_desc=""
  _proto_desc="$(normalize_dispatch_text "$DESCRIPTION")"
  if printf '%s' "$_proto_desc" | grep -Eq '(shutdown_request|shutdown_response|plan_approval_request|plan_approval_response)'; then
    printf '%s | %s | PROTOCOL | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$RESOLVED_ID" "${DESCRIPTION:0:120}" >> "$DISPATCH_LEDGER"
    exit 0
  fi
fi



if [[ "$RESOLVED_ID" == "developer" ]] && dispatch_is_manifest_sync_request "$DESCRIPTION"; then
  enforce_manifest_sync_dispatch_packet
fi

enforce_governing_control_message_packet

enforce_upward_report_message_packet

enforce_worker_message_routing

if [[ "$WORKER_PEER_PACKET_ACTIVE" != "true" ]]; then
  enforce_solution_development_dispatch_packet

  enforce_governance_patch_dispatch_packet

  enforce_high_traffic_governance_resume_packet

  enforce_self_growth_coordination_dispatch_packet

  enforce_execution_acceptance_dispatch_packet

  enforce_research_dispatch_packet

  enforce_review_dispatch_packet

  enforce_test_dispatch_packet

  enforce_validation_dispatch_packet
fi

NEEDS_PLAN="$(check_agent_property "$RESOLVED_ID" "requires_plan")"
if [[ "$NEEDS_PLAN" == "true" ]]; then
  printf '[%s] S-07 ADVISORY: %s dispatched (requires execution plan): %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$RESOLVED_ID" "${DESCRIPTION:0:200}" >> "$VIOLATION_LOG"
fi

if [[ "$RUN_IN_BACKGROUND" != "true" && "$RESOLVED_ID" != "unknown" && -n "$S31_ALLOWED_FOREGROUND_ROLES" ]]; then
  if ! printf '%s' "$RESOLVED_ID" | grep -qE "^($S31_ALLOWED_FOREGROUND_ROLES)$"; then
    printf '[%s] S-31 ADVISORY: Non-exempt agent (%s) dispatched in foreground: %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$RESOLVED_ID" "${DESCRIPTION:0:200}" >> "$VIOLATION_LOG"
  fi
fi

printf '%s | %s | %s | %s | %s\n' "$TIMESTAMP" "$RESOLVED_ID" "${DESCRIPTION%%:*}" "$RUN_IN_BACKGROUND" "$CATEGORY" >> "$DISPATCH_LEDGER"

_auto_standby_on_completion() {
  local sender_name="${1:?sender name required}"
  mkdir -p "$(dirname "$STANDBY_FILE")"
  touch "$STANDBY_FILE"
  if ! grep -qxF "$sender_name" "$STANDBY_FILE" 2>/dev/null; then
    printf '%s\n' "$sender_name" >> "$STANDBY_FILE"
  fi
}

# ── Auto-STANDBY on worker completion message ──────────────────────────────────────────────────────
if [[ "$TOOL_NAME" == "SendMessage" ]] \
  && dispatch_is_governing_lane "$RESOLVED_ID" \
  && dispatch_is_worker_lane "$SENDER_ROLE" \
  && dispatch_field_value_matches "$DESCRIPTION" "message-class" "completion"; then
  with_lock_file "$AGENT_CLAIM_LOCK" _auto_standby_on_completion "$SENDER_ROLE"
fi

append_pending_dispatch_entries() {
  local timestamp="${1:?timestamp required}"
  local agent_name="${2:?agent name required}"
  local mode_value="${3:?mode required}"

  with_lock_file "$AGENT_CLAIM_LOCK" _append_pending_dispatch_entries_locked "$timestamp" "$agent_name" "$mode_value"
}

clear_worker_lifecycle_residue() {
  local agent_name="${1-}"

  [[ -n "$agent_name" ]] || return 0
  with_lock_file "$AGENT_CLAIM_LOCK" _clear_worker_lifecycle_residue_locked "$agent_name"
}

_clear_worker_lifecycle_residue_locked() {
  local agent_name="${1:?agent name required}"
  local normalized_agent=""

  normalized_agent="$(normalize_lane_id "$agent_name")"
  [[ -n "$normalized_agent" ]] || return 0

  _remove_worker_from_state_file "$STANDBY_FILE" "$normalized_agent"
}

_remove_worker_from_state_file() {
  local target_file="${1:?target file required}"
  local normalized_agent="${2:?normalized agent required}"
  local temp_file=""

  touch "$target_file"
  temp_file="$(make_atomic_temp_file "$target_file")"

  awk -v worker="$normalized_agent" '
    {
      entry = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", entry)
      if (tolower(entry) != worker) {
        print $0
      }
    }
  ' "$target_file" > "$temp_file"

  atomic_replace_file "$temp_file" "$target_file"
}

_append_pending_dispatch_entries_locked() {
  local timestamp="${1:?timestamp required}"
  local agent_name="${2:?agent name required}"
  local mode_value="${3:?mode required}"

  printf '%s | %s | PENDING\n' "$timestamp" "$agent_name" >> "$PENDING_AGENTS_FILE"
  printf '%s | %s | %s | PENDING\n' "$timestamp" "$agent_name" "$mode_value" >> "$PENDING_AGENT_MODES_FILE"
}

clear_worker_lifecycle_residue "$AGENT_NAME"
append_pending_dispatch_entries "$TIMESTAMP" "$AGENT_NAME" "${MODE:-default}"

if [[ ! -s "$HEALTH_CRON_FLAG" ]]; then
  printf '1\n' > "$HEALTH_CRON_FLAG"
  printf '[%s] HEALTH-CRON: first agent dispatched\n' "$(date '+%Y-%m-%d %H:%M:%S')" >> "$VIOLATION_LOG"
fi

exit 0
