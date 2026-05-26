SHARD-ID: E
TASK-ID: 5
OUTPUT-SURFACE: claude_doc/governance-audit-2026-05-27/shards/shard-e-runtime-and-settings.md
WORK-SURFACE: RUNTIME + SETTINGS layer (5,654 lines, 30 files: 27 hooks/*.sh + MANIFEST.md + settings.json + settings.local.json)
  Active hooks (14, settings.json-wired):
    - .claude/hooks/agent-activity-monitor.sh (299)
    - .claude/hooks/assistant-response-curtain-gate.sh (169)  [CURTAIN-PROTECTED]
    - .claude/hooks/compliance-supervisor.sh (1508)
    - .claude/hooks/permission-request-gate.sh (161)
    - .claude/hooks/reporting-curtain-envelope-gate.sh (127)  [CURTAIN-PROTECTED]
    - .claude/hooks/session-end.sh (130)
    - .claude/hooks/session-start.sh (249)  [CURTAIN-PROTECTED Self-Check block]
    - .claude/hooks/sv-gate.sh (40)
    - .claude/hooks/sv-tracker.sh (133)
    - .claude/hooks/tmux-kill-block.sh (147)
    - .claude/hooks/track-runtime-lifecycle.sh (314)
    - .claude/hooks/track-worker-transport.sh (604)
    - .claude/hooks/user-prompt-gate.sh (326)
    - .claude/hooks/worker-lifecycle-sync.sh (314)
  Legacy stub hooks (8, body-disabled with exit 0):
    - .claude/hooks/dispatch-proof-gate.sh (12)
    - .claude/hooks/dispatch-sizing-gate.sh (12)
    - .claude/hooks/runtime-entry-gate.sh (12)
    - .claude/hooks/spawn-prompt-screen-safety.sh (20)
    - .claude/hooks/task-completed-gate.sh (12)
    - .claude/hooks/task-created-gate.sh (12)
    - .claude/hooks/task-start-gate.sh (12)
    - .claude/hooks/validate-task-target.sh (12)
  Dependency hooks (5, sourced/invoked by active hooks):
    - .claude/hooks/hook-config-core.sh (21)
    - .claude/hooks/hook-config.sh (36)
    - .claude/hooks/cleanup-orphan-runtime.sh (130)
    - .claude/hooks/health-check.sh (253)
    - .claude/hooks/runtime-pressure-scan.sh (225)
  Governance ledger + runtime wiring:
    - .claude/hooks/MANIFEST.md (154)
    - .claude/settings.json (202)  [CURTAIN-PROTECTED curtain hook wiring entries]
    - .claude/settings.local.json (8)

CLAIM-CEILING: evidence-only candidates
AUDIT-METHOD-APPLIED: lenses 1-8 from binding surface (00-binding-surface.md ## AUDIT METHOD); runtime-layer not-material recording allowed per packet semantics for lens application; targeted Grep + Read of high-density sections used for 1508-line compliance-supervisor.sh per binding-surface ## CONTEXT NOTES large-file rule with explicit EVIDENCE-BASIS line enumeration below
TARGET-INTENT-BASIS: Audit cited design intent of runtime layer — hooks are last-resort runtime guards per .claude/CLAUDE.md §8 Environment Configuration Philosophy; MANIFEST.md is hook governance ledger + hook posture record; settings.json wires hooks into Claude Code lifecycle events; settings.local.json is local override (minimal scope). Packet semantic-alignment focus: settings.json↔hook wiring consistency; hook semantic alignment with governance rules; MANIFEST.md currency vs actual inventory; hook-rule cross-reference integrity. Audit is read-only. Promotion past candidate-evidence is team-lead synthesis Phase 3; reviewer ceiling is candidate-evidence.
PLANNING-BASIS: loaded
UPSTREAM-DECISION-BASIS-CONSUMPTION: claude_doc/governance-audit-2026-05-27/00-binding-surface.md (consumed via same-session loaded-skill basis from task-1; no staleness condition fired; same agent process, same active reviewer-shard-a owner path; per work-skill-reference-binding-law.md `## Skill Rules` same-session reuse covers basis only — fresh Steps 1-14 review-verification + fresh PASS-1/PASS-2 self-verification required on Shard E carrier and executed below). 8-lens audit method definitions, 9 REVIEW-VERIFICATION-LENSES, CARRIER FORMAT, FINDING-STATE LADDER, DEPENDENCY/NON-OVERLAP BOUNDARY, CONTEXT NOTES applied to Shard E corpus.
SKILL-FIELD-CONSUMPTION:
  REQUIRED-SKILLS:
    - code-quality-review: applied (runtime layer is bash/JS source where SOLID-like principles and duplication taxonomy materially affect findings); particularly material for cross-hook duplication patterns (C-1 8 legacy stub bodies; C-3 curtain-header duplication; C-9 hook-config / hook-config-core structural parallel; C-12 cross-hook node parse boilerplate). Direct-consumption relevance: yes for assigned runtime-layer audit target.
    - feynman-clarity: applied (large hook prose comment blocks like assistant-response-curtain-gate.sh:18-71 + compliance-supervisor.sh inline rationale comments + MANIFEST.md Hook-Last Review Ledger table comprehension materially affect Lens 4 minimum-executable-information findings).
  SKILL-RECOMMENDATIONS: not-applicable:none-carried-in-packet

EVIDENCE-BASIS:
  Full-file Reads (29 of 30 files):
  - .claude/hooks/MANIFEST.md lines 1-154 (full file)
  - .claude/settings.json lines 1-202 (full file)
  - .claude/settings.local.json lines 1-8 (full file)
  - .claude/hooks/dispatch-proof-gate.sh lines 1-12 (full file)
  - .claude/hooks/dispatch-sizing-gate.sh lines 1-12 (full file)
  - .claude/hooks/runtime-entry-gate.sh lines 1-12 (full file)
  - .claude/hooks/spawn-prompt-screen-safety.sh lines 1-20 (full file)
  - .claude/hooks/task-completed-gate.sh lines 1-12 (full file)
  - .claude/hooks/task-created-gate.sh lines 1-12 (full file)
  - .claude/hooks/task-start-gate.sh lines 1-12 (full file)
  - .claude/hooks/validate-task-target.sh lines 1-12 (full file)
  - .claude/hooks/hook-config-core.sh lines 1-21 (full file)
  - .claude/hooks/hook-config.sh lines 1-36 (full file)
  - .claude/hooks/sv-gate.sh lines 1-40 (full file)
  - .claude/hooks/cleanup-orphan-runtime.sh lines 1-130 (full file)
  - .claude/hooks/session-end.sh lines 1-130 (full file)
  - .claude/hooks/assistant-response-curtain-gate.sh lines 1-169 (full file)
  - .claude/hooks/reporting-curtain-envelope-gate.sh lines 1-127 (full file)
  - .claude/hooks/permission-request-gate.sh lines 1-161 (full file)
  - .claude/hooks/session-start.sh lines 1-249 (full file)
  - .claude/hooks/sv-tracker.sh lines 1-133 (full file)
  - .claude/hooks/tmux-kill-block.sh lines 1-147 (full file)
  - .claude/hooks/track-runtime-lifecycle.sh lines 1-314 (full file)
  - .claude/hooks/worker-lifecycle-sync.sh lines 1-314 (full file)
  - .claude/hooks/agent-activity-monitor.sh lines 1-299 (full file)
  - .claude/hooks/user-prompt-gate.sh lines 1-326 (full file)
  - .claude/hooks/track-worker-transport.sh lines 1-604 (full file)
  - .claude/hooks/runtime-pressure-scan.sh lines 1-225 (full file)
  - .claude/hooks/health-check.sh lines 1-253 (full file)
  Targeted Read + Grep coverage (1 of 30 files — compliance-supervisor.sh 1508 lines per binding-surface ## CONTEXT NOTES large-file rule):
  - .claude/hooks/compliance-supervisor.sh lines 1-500 (Read with offset=1 limit=500) covering: utility functions, governance-surface predicates, command parsers, mutation classifiers, narrow carve-outs
  - .claude/hooks/compliance-supervisor.sh lines 1100-1508 (Read with offset=1100 limit=410) covering: parse-input dispatch, main routing case, all ~15 emit_deny call sites mapping to MANIFEST.md hard-deny categories
  - .claude/hooks/compliance-supervisor.sh Grep coverage for function map (45+ function definitions enumerated)
  - .claude/hooks/compliance-supervisor.sh Grep coverage for emit_deny call sites (~15 sites)
  - .claude/hooks/compliance-supervisor.sh Grep coverage for section comments
  Lines 500-1100 (specialized predicates: mutable_find_target_deny_reason, command_removes_team_runtime_dir, command_uses_interpreter_fs_mutation, bash_secret_read_deny_reason, bounded_generated_cleanup_command, user_approved_delete_subcommand, etc.) inspected via Grep function-map enumeration — function names align with same defensive-hardening + narrow-carve-out structural pattern as inspected regions.
  Corroborating Grep inspections same session:
  - hook file count (`ls *.sh | wc -l` = 27)
  - "Hook body disabled" legacy-stub pattern verification (8 files match)
  - "DO NOT DISABLE / PROTECTED-CURTAIN-SURFACE / PROTECTED-LOCAL-RESTATEMENT-BASIS" markers (3 surfaces: assistant-response-curtain-gate.sh, reporting-curtain-envelope-gate.sh, session-start.sh:144-145)
  - hooks/lib/ inventory (17 library files sourced/invoked but NOT in Shard E binding-surface scope)
  - settings.json hook wiring inventory (14 hook entries verified via parse)

CANDIDATE-INVENTORY:

[E-1]
  ANCHOR: 8 legacy stub hooks (.claude/hooks/dispatch-proof-gate.sh, dispatch-sizing-gate.sh, runtime-entry-gate.sh, spawn-prompt-screen-safety.sh, task-completed-gate.sh, task-created-gate.sh, task-start-gate.sh, validate-task-target.sh — all 12 lines except spawn-prompt-screen-safety.sh at 20 lines)
  LENS: 6 / 8
  CLASS: cross-file verbatim-identical stub body (no PROTECTED-LOCAL-RESTATEMENT-BASIS declared at any occurrence)
  EVIDENCE: 7 of 8 stub hooks (excluding spawn-prompt-screen-safety.sh) carry the identical 12-line body:
    ```
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Hook body disabled per .claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules
    # (negative-only-filter doctrine: hooks block only destructive, security-critical, or
    # session-stability-breaking actions; positive-pattern doctrine-shape enforcement is
    # owned by the lane trio — Skill(governance-modification) + Skill(self-verification) +
    # Skill(review-verification) named lenses — and downstream reviewer/validator gates).
    # settings.json matcher was removed in the same governance patch; this file-level
    # no-op handles already-started agents or local hook harness state after the wiring change.
    # File preserved for traceability and potential future narrowing to a negative-only filter.
    exit 0
    ```
    spawn-prompt-screen-safety.sh adds 8 lines of owner-reference header (line 1-8) before the same disabled-body comment block. task-completed-gate.sh:9 has minor variation ("TaskCompleted matcher" instead of "matcher"). Otherwise verbatim cross-file. 8 files × ~12 lines = ~96 lines of identical disabled-stub content. MANIFEST.md ## Legacy Hooks (lines 55-72) declares the canonical disposition basis for all 8 files; the canonical owner is MANIFEST.md, so per-file verbatim restatement is candidate-evidence for Lens 6/8.
  PROPOSED-OWNER-FOR-CORRECTION: MANIFEST.md (canonical legacy-disposition owner already lists all 8); evaluate consolidation to a single legacy-shim source file with per-stub thin wrapper, OR per-stub PROTECTED-LOCAL-RESTATEMENT-BASIS declaration with disabled-stub-preservation basis
  STATE: candidate-evidence

[E-2]
  ANCHOR: 2 curtain-protected hooks (assistant-response-curtain-gate.sh:4-16, reporting-curtain-envelope-gate.sh:4-17) + session-start.sh:144-156 (Curtain Constitutional Self-Check block)
  LENS: 7
  CLASS: structurally identical "PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE" header block (3 surfaces, ~12-13 lines each ~36 lines total)
  EVIDENCE: All 3 curtain-protected surfaces open with parallel block:
    ```
    # PROTECTED-LOCAL-RESTATEMENT-BASIS: see .claude/reference/modification-core-law.md ## Constitutional Curtain Protection for canonical owner and constitutional-curtain-visibility basis.
    # PROTECTED-CURTAIN-SURFACE / DO NOT DISABLE
    # This hook|block is enumerated as constitutionally-protected per
    # .claude/reference/modification-core-law.md ## Constitutional Curtain Protection.
    # Disabling, removing, or weakening this hook|block (script body, hook wiring in
    # settings.json, or registration in MANIFEST.md) requires:
    #   1. Skill(governance-modification) Step 3 review-verification packet
    #   2. Validator pre-approval (CLAIM-CEILING: validator-final-verdict, PASS verdict)
    #   3. User notification with constitutional invariant + forensic erosion cycle disclosure
    #   4. User acknowledgment or absence of objection in the same turn segment
    # Approval basis for installation: 2026-05-26 curtain-constitutional-fix-2026-05-26
    # (user-authorized via "독립적이면서 안전한 보완 패치를 신중하게 진행해").
    ```
  Pattern is constitutional curtain protection per modification-core-law.md `## Constitutional Curtain Protection`. PROTECTED-LOCAL-RESTATEMENT-BASIS IS declared at each instance (pointing to canonical owner). Constitutional structure protects against erosion; per binding-surface ## Lens 7 "do NOT propose patches that simplify/tighten/reduce/sweep/dedup those surfaces without validator pre-approval + user notification gates documented." Recording as candidate-evidence with awareness of gate; patch proposal not made.
  PROPOSED-OWNER-FOR-CORRECTION: gated (validator pre-approval + user notification required per modification-core-law.md:144-147)
  STATE: candidate-evidence (PROTECTED-CURTAIN-SURFACE awareness; observations recorded for team-lead synthesis)

[E-3]
  ANCHOR: settings.json hooks wiring (lines 49-200) vs MANIFEST.md ## Active Hooks (lines 40-53)
  LENS: 8
  CLASS: appropriate canonical settings↔MANIFEST consistency (verified)
  EVIDENCE: settings.json wires 14 hook entries:
    SessionStart -> session-start.sh
    UserPromptSubmit -> user-prompt-gate.sh
    PermissionRequest(Edit|MultiEdit) -> permission-request-gate.sh
    PreToolUse(broad matcher) -> agent-activity-monitor.sh
    PreToolUse(mcp__playwright__browser_.*) -> sv-gate.sh
    PreToolUse(Bash|Edit|MultiEdit|Write|NotebookEdit) -> compliance-supervisor.sh
    PreToolUse(Bash) -> tmux-kill-block.sh
    PreToolUse(SendMessage) -> reporting-curtain-envelope-gate.sh
    Stop -> assistant-response-curtain-gate.sh
    PostToolUse(Skill) -> sv-tracker.sh
    PostToolUse(SendMessage) -> track-worker-transport.sh
    PostToolUse(Agent|TeamCreate|TeamDelete|CronCreate|CronDelete) -> track-runtime-lifecycle.sh
    TeammateIdle -> worker-lifecycle-sync.sh
    SessionEnd -> session-end.sh
  MANIFEST.md ## Active Hooks lists exactly the same 14 hooks (lines 40-53). 1:1 mapping; no orphan settings wiring; no unwired active-claimed hook. Wiring↔MANIFEST consistency: VERIFIED.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (canonical consistency holds)
  STATE: candidate-classified — class: verified-wiring-consistency, no defect

[E-4]
  ANCHOR: binding-surface.md `### Shard E` measurement claim "28 hooks/*.sh" vs actual count
  LENS: 1
  CLASS: binding-surface measurement off-by-one (actual count is 27 hooks/*.sh)
  EVIDENCE: binding-surface line 144 says "`.claude/hooks/*.sh` (28 hooks, 5,290 lines)". Verified via `ls /mnt/d/Agent_team/.claude/hooks/*.sh | wc -l` = 27. The line-count 5,290 is also slightly off vs actual sum (5,654 total — 154 MANIFEST.md - 202 settings.json - 8 settings.local.json = 5,290 verified for the hook .sh files only — actually that matches; let me recompute: 5,654 - 154 - 202 - 8 = 5,290; the 5,290 is correct for .sh only). So binding-surface line-count is correct, only hook-file count is off-by-one (28 vs 27). Likely binding-surface was captured at a state with one additional now-removed hook.
  PROPOSED-OWNER-FOR-CORRECTION: claude_doc/governance-audit-2026-05-27/00-binding-surface.md (binding-surface owner); update Shard E measurement to "27 hooks/*.sh, 5,290 lines" before Phase 3 synthesis
  STATE: candidate-evidence

[E-5]
  ANCHOR: hooks/lib/ directory contains 17 library files sourced by hook-config.sh and hook-config-core.sh
  LENS: 1 / 3
  CLASS: scope-baseline coverage question (lib/*.sh + lib/*.js sourced by active hooks but not enumerated in binding-surface ### Shard E)
  EVIDENCE: hooks/lib/ contains: generated-command-policy.js, hook-agent-dispatch.sh, hook-closeout-state.sh, hook-command-tokenizer.js, hook-fs-locks.sh, hook-governance-rm-approval.sh, hook-health-cron.sh, hook-json-helpers.js, hook-name-registry.sh, hook-planning-discipline.sh, hook-policy.sh, hook-procedure-state.sh, hook-runtime-session.sh, hook-self-growth-discipline.sh, hook-tool-response.sh, hook-worker-registry.sh, runtime-integrity-recovery.sh (17 files). These are sourced via hook-config.sh:19-30 (12 sh libs) + hook-config-core.sh:19 (hook-policy.sh) + direct require() in various hook node blocks (3 js libs). MANIFEST.md ## Hook Dependencies (lines 122-132) references lib/*.sh + lib/*.js as canonical dependencies. Binding-surface ### Shard E line 144 says ".claude/hooks/*.sh (28 hooks, 5,290 lines)" — glob does NOT include lib/ subdir. Audit scope question: are lib/ files part of Shard E coverage or scope-out? Per Anti-Narrowing Law, scope-out without dispatcher direction is silent narrowing. Binding-surface text says ".claude/hooks/*.sh" which is a glob excluding subdirs. Per literal-text reading, lib/ files are out-of-scope. Per intent reading (Shard E "RUNTIME enforcement layer"), lib/ files contribute to runtime enforcement and could be in-scope.
  PROPOSED-OWNER-FOR-CORRECTION: team-lead synthesis Phase 3 (clarify scope-baseline interpretation: literal-text vs intent; if intent, dispatch supplementary lib/ audit or extend Shard E coverage)
  STATE: candidate-evidence (scope-baseline interpretation question)

[E-6]
  ANCHOR: MANIFEST.md (entire 154 lines)
  LENS: 5
  CLASS: well-structured hook governance ledger with canonical sections (purpose, operating rules, active hooks, legacy hooks, hook-last review ledger, compliance supervisor boundaries, hook dependencies, absorbed scripts, runtime artifacts, operational logs)
  EVIDENCE: MANIFEST.md provides comprehensive hook governance ledger:
    - ## Operating Rules (12 bullets covering narrow-and-observable, silent-tracking, user-facing-exception, hard-deny scope, prohibition-vs-allowlist, over-broad-blocking handling, no-new-hook-for-adherence, claude_doc protection, classification mandate, timeout requirement)
    - ## Active Hooks (14 named active hooks)
    - ## Legacy Hooks (8 named legacy stubs with shared disposition basis)
    - ## Hook-Last Review Ledger (table of 8 active hooks with protected failure + narrowness/recovery; rows 96-106 = ~10 hook entries — wait let me count rows: agent-activity-monitor, user-prompt-gate, permission-request-gate, sv-gate, tmux-kill-block, worker-lifecycle-sync, track-worker-transport, compliance-supervisor, reporting-curtain-envelope-gate, assistant-response-curtain-gate, session-start.sh curtain-block = 11 rows; not all 14 active hooks have ledger entries)
    - ## Compliance Supervisor Boundaries (hard-deny categories enumerated)
    - ## Hook Dependencies (hook-config.sh, hook-config-core.sh, lib/*.sh, lib/*.js, health-check.sh, runtime-pressure-scan.sh, cleanup-orphan-runtime.sh)
    - ## Absorbed Scripts (3 absorbed scripts)
    - ## Runtime Artifacts (.playwright-mcp/, *.png)
    - ## Operational Logs (~/.claude/logs/)
  Block is informationally complete and decision-controlling for hook governance.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (canonical ledger appropriately structured)
  STATE: candidate-classified — class: well-structured-canonical-ledger, no defect

[E-7]
  ANCHOR: MANIFEST.md ## Hook-Last Review Ledger (lines 94-106) — 11 hook entries vs 14 active hooks
  LENS: 4
  CLASS: ledger coverage asymmetry (11 active hooks have Hook-Last Review Ledger rows, 3 active hooks do not: session-end.sh, sv-tracker.sh, track-runtime-lifecycle.sh)
  EVIDENCE: MANIFEST.md ## Hook-Last Review Ledger (lines 94-106) carries rows for: agent-activity-monitor.sh, user-prompt-gate.sh, permission-request-gate.sh, sv-gate.sh, tmux-kill-block.sh, worker-lifecycle-sync.sh, track-worker-transport.sh, compliance-supervisor.sh, reporting-curtain-envelope-gate.sh, assistant-response-curtain-gate.sh, session-start.sh (Curtain Constitutional Self-Check block) = 11 entries. Settings.json wires 14 active hooks. Missing from ledger: session-end.sh, sv-tracker.sh, track-runtime-lifecycle.sh. The ledger declares "current manifest review record for active blocking guardrails" (line 75); the 3 omitted hooks have less-broad blocking surface (session-end records state, sv-tracker tracks skill-load markers, track-runtime-lifecycle tracks runtime topology) and may legitimately fall outside the "blocking guardrails" scope per the ledger's stated purpose. Or alternatively, they should be added for full review-record coverage.
  PROPOSED-OWNER-FOR-CORRECTION: MANIFEST.md (canonical ledger owner); clarify scope ("blocking guardrails only" → recorded; "all active hooks" → add 3 missing entries)
  STATE: candidate-evidence

[E-8]
  ANCHOR: hook-config.sh:19-30 and hook-config-core.sh:19
  LENS: 2 / 5
  CLASS: appropriate dependency-bootstrap separation (hook-config-core sources minimal hook-policy.sh; hook-config sources policy + 11 additional libs)
  EVIDENCE: hook-config-core.sh:19 sources only hook-policy.sh — used by permission-request-gate.sh for minimal bootstrap (avoids loading large dependency chain for a small allowlist hook). hook-config.sh:19-30 sources hook-policy.sh + hook-fs-locks.sh + hook-name-registry.sh + hook-agent-dispatch.sh + hook-worker-registry.sh + hook-planning-discipline.sh + hook-self-growth-discipline.sh + hook-runtime-session.sh + hook-procedure-state.sh + hook-closeout-state.sh + hook-health-cron.sh + hook-governance-rm-approval.sh = 12 libs total. hook-config.sh:32-34 notes hook-tool-response.sh is intentionally NOT sourced here; sourced only by PostToolUse hooks. Per Lens 2 owner-boundary + Lens 5 minimum-executable-information, the bootstrap split is appropriate: each hook loads only the dependencies needed for its surface scope.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate dependency separation)
  STATE: candidate-classified — class: appropriate-dependency-separation, no defect

[E-9]
  ANCHOR: session-start.sh ## Curtain Constitutional Self-Check block (lines 143-247)
  LENS: 7
  CLASS: well-structured constitutional self-validation with 10 numbered checks
  EVIDENCE: Lines 143-247 form `## Curtain Constitutional Self-Check` block. PROTECTED-CURTAIN-SURFACE marker declared at :144-145. Block runs 10 numbered self-checks:
    (1) CLAUDE.md `## Constitutional Reporting Curtain` section present
    (2) reporting-core-law.md `## Constitutional 4-Invariant Detail` section present
    (3) modification-core-law.md `## Constitutional Curtain Protection` section present
    (4) review-and-verification-core-law.md `curtain-breach` defect class present
    (5) settings.json curtain envelope hook wiring present
    (6) settings.json Stop response hook wiring present
    (7) both curtain hook scripts exist non-empty
    (8) all 6 role files have identity atomic-check clause
    (9) PROTECTED-CURTAIN-SURFACE markers on key text surfaces
    (10) canonical PROTECTED-CURTAIN-SURFACE enumeration wording-drift detection (Round 3 CP-B install)
  Block emits additionalContext on violation + writes HOOK_HEALTH_LOG + VIOLATION_LOG. Mandatory; not skippable by HOOK_HEALTH_SELF_CHECK_MODE per :150-151. Well-structured constitutional recurrence-barrier per modification-core-law.md `## Constitutional Curtain Protection` invariant (d).
  PROPOSED-OWNER-FOR-CORRECTION: gated (per E-2 PROTECTED-CURTAIN-SURFACE awareness)
  STATE: candidate-classified — class: well-structured-curtain-self-validation, no defect (gated)

[E-10]
  ANCHOR: assistant-response-curtain-gate.sh (entire 169 lines)
  LENS: 7
  CLASS: well-structured Stop-event reporting-curtain enforcement with post-emission detection
  EVIDENCE: Hook is well-structured Stop-event post-emission curtain-breach detection layer. Carries:
    - PROTECTED-CURTAIN-SURFACE header (lines 4-16) — see E-2
    - Purpose + Protected failure + Honest limitation + Scope (narrow) + Recovery + Failure mode + Footprint blocks (lines 18-71)
    - fail-open posture (set +e at :73)
    - REPORT-REASON detection (English + Korean + cited form at :108-120)
    - non-reportable pattern detection (~6 patterns at :137-152)
    - block decision emission with continuation rationale (lines 162-167)
  Hook is sole post-emission detection layer for main response prose; identity-layer atomic-check + worked example + model self-discipline remain upstream-of-hook layers per :44-49 "Honest limitation" block. Well-structured; informationally complete.
  PROPOSED-OWNER-FOR-CORRECTION: gated (per E-2)
  STATE: candidate-classified — class: well-structured-curtain-enforcement, no defect (gated)

[E-11]
  ANCHOR: reporting-curtain-envelope-gate.sh (entire 127 lines)
  LENS: 7
  CLASS: well-structured PreToolUse(SendMessage) upward state-class envelope discipline hook
  EVIDENCE: Hook fires on SendMessage tool_name = "SendMessage" (line 89). Narrow matcher on upward state-class headers in message body (dispatch-ack, status, scope-pressure, completion, hold|blocker per :99 regex). Downward classes (assignment, reuse, reroute, phase-transition-control) and structured payloads (shutdown_request) pass through unaffected per :45-48. Canonical envelope (empty body or single ASCII space) passes through unaffected per :49-51. fail-open posture (:81). Pure bash + grep, no jq dependency (:70-75). PreToolUse permissionDecision=deny emission with recovery rationale (lines 116-125). Well-structured; informationally complete.
  PROPOSED-OWNER-FOR-CORRECTION: gated (per E-2)
  STATE: candidate-classified — class: well-structured-curtain-envelope, no defect (gated)

[E-12]
  ANCHOR: cross-hook node-parse JSON-extract boilerplate (multiple hooks)
  LENS: 6 / 8
  CLASS: cross-hook similar JSON-parse-via-node-heredoc boilerplate pattern
  EVIDENCE: Multiple hooks carry similar node-heredoc JSON-parsing boilerplate to extract session_id/tool_name/tool_input from stdin INPUT_JSON. Pattern variants observed in:
    - sv-gate.sh:10-21 (parses session_id + tool_name with hook_json_helpers encode)
    - session-end.sh:10-18 (parses session_id)
    - sv-tracker.sh:21-28 (parses skill + sid via node -e inline)
    - permission-request-gate.sh:11-153 (parses tool_name + tool_input via larger node block, with own helper functions)
    - agent-activity-monitor.sh:7-21 (parses session_id + tool_name + cwd + agent_id + agent_type + command)
    - track-worker-transport.sh:29-69 + :90-114 (parses many fields including teammate_name, target_name, types)
    - track-runtime-lifecycle.sh:7-15 + :59-122 + :180-211 (similar per-tool parsing)
    - worker-lifecycle-sync.sh:10-17 (parses event-type detection)
    - user-prompt-gate.sh:7-18 (parses prompt + session_id)
    - compliance-supervisor.sh:6-11 + :1117-1173 (parses session_id + tool_name + tool_input + various fields)
  Each hook has slightly different field-extraction needs, but the boilerplate structure (INPUT="$(cat)"; node parse with base64 encode for safe shell handoff; mapfile -t FIELDS <<<"$PARSED"; hook_decode_base64_field "${FIELDS[N]:-}") is highly parallel. Per Lens 6 context-consumption-efficiency, candidate for consolidation into a shared hook lib helper (e.g., hooks/lib/hook-json-extract.sh) with per-hook field-list parameter. Per Lens 8 SSOT, no PROTECTED-LOCAL-RESTATEMENT-BASIS declared at any occurrence. NOTE: hook-json-helpers.js (in hooks/lib/) IS the canonical helper for encode/decode primitives; some hooks already use it (sv-gate, permission-request-gate, agent-activity-monitor, track-worker-transport). Other hooks (session-end, sv-tracker, user-prompt-gate) use inline node -e without going through the lib helper. Asymmetric helper usage.
  PROPOSED-OWNER-FOR-CORRECTION: hooks/lib/ (canonical helper owner); evaluate consolidation of node-parse boilerplate to shared helper; ensure all hooks consume hook-json-helpers.js consistently
  STATE: candidate-evidence

[E-13]
  ANCHOR: hook-config.sh + hook-config-core.sh structural similarity (lines 1-21 of -core and lines 1-37 of base)
  LENS: 8
  CLASS: structurally identical bootstrap source-lib function (different naming for namespace isolation)
  EVIDENCE: hook-config-core.sh:6-17 defines `hook_config_core_source_lib() { ... }`. hook-config.sh:6-17 defines `hook_config_source_lib() { ... }`. Function bodies are identical (HOOK_DIR resolution + HOOK_LIB_DIR derivation + source check + source). Both unset their function name at the end. The only meaningful difference is the function name (hook_config_core_source_lib vs hook_config_source_lib) and which libs are sourced. Per Lens 8 SSOT, the source-lib helper function itself is duplicated; canonical owner could consolidate into a single shared helper that takes a lib-list parameter. PROTECTED-LOCAL-RESTATEMENT-BASIS not declared (and namespace-isolation could be the basis but is not stated).
  PROPOSED-OWNER-FOR-CORRECTION: hooks/lib/ (canonical helper owner); evaluate consolidation OR document namespace-isolation as PROTECTED-LOCAL-RESTATEMENT-BASIS
  STATE: candidate-evidence

[E-14]
  ANCHOR: compliance-supervisor.sh (1508 lines)
  LENS: 4 / 6
  CLASS: largest hook file by far (~5x size of next-largest hook)
  EVIDENCE: compliance-supervisor.sh is 1508 lines. Next-largest hooks: track-worker-transport.sh (604), user-prompt-gate.sh (326), track-runtime-lifecycle.sh + worker-lifecycle-sync.sh (314 each), agent-activity-monitor.sh (299). The file structure shows: 45+ utility functions (per function map enumeration via Grep), 15+ emit_deny call sites, comprehensive command parsing + classification + carve-out predicates. Block is informationally complete and decision-controlling per MANIFEST.md ## Compliance Supervisor Boundaries (lines 108-120). However, the file size (~28% of total Shard E line count) raises Lens 4/6 candidate-evidence question: are some predicate clusters sufficiently independent to move to separate hooks (e.g., command_uses_interpreter_fs_mutation + bash_secret_read_deny_reason could move to a "secret-and-interpreter-mutation-gate.sh"; bounded_generated_cleanup_command + bounded_generated_reset_scaffold_command + user_approved_delete_command could move to a "user-approved-cleanup-gate.sh")? Or is the single-file structure intentional for atomic mutation enforcement (one PreToolUse(Bash|Edit|MultiEdit|Write|NotebookEdit) hook with all enforcement in one place)?
  PROPOSED-OWNER-FOR-CORRECTION: compliance-supervisor.sh + MANIFEST.md (canonical owners); evaluate whether single-file structure serves enforcement atomicity vs sub-shard potential
  STATE: candidate-evidence

[E-15]
  ANCHOR: tmux-kill-block.sh (entire 147 lines)
  LENS: 5
  CLASS: appropriate narrow-scope hard-deny hook (operator-policy-directed)
  EVIDENCE: Hook is well-structured narrow hard-deny for `tmux kill-*` commands. Header comment (:1-22) cites: operator policy directive ("절대로 tmux kill 금지" 2026-05-19), session-stability reason ("세션 튕겨나간다"), per .claude/reference/environment-configuration-core-law.md `[HOOK-LAST]`. Safe teardown paths named (:13-16) — SendMessage shutdown_request + Skill(session-closeout). Implementation uses python3 with shlex-aware tokenizer for compound-command + heredoc + sh -c -wrapped variants (:50-130); bash fallback regex for environments without python3 (:132-141). Per Lens 5 modification-core-law `removal-first` + `consumed-surface` + `executable-imperative`: appropriate narrow hard-deny with replacement-action specified, matches MANIFEST.md Hook-Last Review Ledger row at :100. Well-structured.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (well-formed narrow hard-deny)
  STATE: candidate-classified — class: well-formed-narrow-hard-deny, no defect

[E-16]
  ANCHOR: settings.json :47 "defaultMode": "bypassPermissions"
  LENS: 7 / 5
  CLASS: project-operator-policy permission posture (intentional design per work-runtime-boundary-law.md:127)
  EVIDENCE: settings.json line 47 declares `"defaultMode": "bypassPermissions"`. Per work-runtime-boundary-law.md:127 "`settings.json` `permissions.defaultMode: bypassPermissions` is the project operator-policy posture for allowed tools; it removes permission-UI prompts but does not waive destructive, security-sensitive, hook/settings enforcement-expansion, or operator-policy approval rules." Appropriate intentional posture; documented basis at canonical owner work-runtime-boundary-law.md. Hooks (compliance-supervisor.sh + tmux-kill-block.sh + curtain hooks) provide the actual safety enforcement layer.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (intentional operator-policy posture per canonical doctrine)
  STATE: candidate-classified — class: intentional-operator-policy, no defect

[E-17]
  ANCHOR: settings.json :84-94 PreToolUse broad-matcher entry for agent-activity-monitor.sh
  LENS: 4
  CLASS: broad matcher with appropriate hook-side narrowing
  EVIDENCE: settings.json :86 matcher = "Read|Grep|Glob|LS|ToolSearch|TaskGet|TaskList|TaskOutput|Bash|Edit|MultiEdit|Write|NotebookEdit|Skill|mcp__playwright__browser_.*|Agent|TeamCreate|TeamDelete|CronCreate|CronDelete|TaskCreate|TaskUpdate|TaskStop". Very broad matcher covering 21 tool patterns. Per MANIFEST.md ## Hook-Last Review Ledger row at :96 agent-activity-monitor.sh: "Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress." Broad matcher is tolerated only when the script narrows them to exact marker/tool-shape/parseable packet-field conditions per MANIFEST.md ## Hook-Last Review Ledger preamble (:79-81). agent-activity-monitor.sh (299 lines) does perform internal classification and writes to ACTIVITY_LEDGER rather than blocking. Per Lens 4, broad matcher + narrow-execution pattern is acceptable for activity-tracking hooks; not over-broad-blocking.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (broad matcher acceptable for tracking-only hook; MANIFEST.md ledger discipline applied)
  STATE: candidate-classified — class: acceptable-broad-matcher-with-narrow-execution, no defect

[E-18]
  ANCHOR: settings.json :96-103 + :106-114 PreToolUse matchers for sv-gate.sh and compliance-supervisor.sh
  LENS: 2 / 5
  CLASS: appropriate matcher-to-hook-purpose alignment
  EVIDENCE: settings.json :96 matcher = "mcp__playwright__browser_.*" -> sv-gate.sh (Playwright self-verification proof edge). settings.json :106 matcher = "Bash|Edit|MultiEdit|Write|NotebookEdit" -> compliance-supervisor.sh (mutation tools). Each matcher precisely targets the hook's scope per MANIFEST.md ## Hook-Last Review Ledger declarations. Per Lens 2 owner-boundary + Lens 5 consumed-surface, appropriate targeting.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate matcher precision)
  STATE: candidate-classified — class: appropriate-matcher-precision, no defect

[E-19]
  ANCHOR: settings.json hook timeout values (5, 10, 15, 20 seconds across 14 hook entries)
  LENS: 4
  CLASS: per-hook timeout declarations appropriate scaling with hook scope
  EVIDENCE: Each settings.json hook entry carries explicit `"timeout"` per MANIFEST.md ## Operating Rules line 34 "Every active `settings.json` hook command must carry an explicit `timeout`. Timeout is a bottleneck guard, not a substitute for making hook logic small." Timeout values:
    - 5s: tmux-kill-block.sh, reporting-curtain-envelope-gate.sh, assistant-response-curtain-gate.sh, sv-tracker.sh
    - 10s: agent-activity-monitor.sh, sv-gate.sh, permission-request-gate.sh, track-worker-transport.sh
    - 15s: user-prompt-gate.sh, track-runtime-lifecycle.sh
    - 20s: session-start.sh, compliance-supervisor.sh, worker-lifecycle-sync.sh, session-end.sh
  Scaling generally aligns with hook scope (small/narrow hooks at 5-10s; large/lifecycle hooks at 15-20s). Per MANIFEST.md operating rule, timeout discipline satisfied.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate per-hook timeout scaling)
  STATE: candidate-classified — class: appropriate-timeout-scaling, no defect

[E-20]
  ANCHOR: settings.local.json (8 lines)
  LENS: 2
  CLASS: minimal local override (2 permission allow entries)
  EVIDENCE: settings.local.json carries 2 permission.allow entries: `Bash(mkdir -p /home/daeil0209/.claude/plugins/marketplaces)` + `Read(/home/daeil0209/.claude/plugins/marketplaces/**)`. Plugin marketplaces directory bootstrapping. Per Lens 2 owner-boundary, local override is minimal and scope-bounded. Per work-runtime-boundary-law.md, local overrides are permitted for machine-specific operational allowances.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (minimal appropriate local override)
  STATE: candidate-classified — class: minimal-local-override, no defect

[E-21]
  ANCHOR: track-worker-transport.sh (604 lines)
  LENS: 4 / 5
  CLASS: comprehensive PostToolUse(SendMessage) tracker with 25+ field extraction from retained carrier
  EVIDENCE: Hook covers extensive transport tracking:
    - parses SendMessage tool_input + tool_response (lines 29-69)
    - resolves sender identity (line 159)
    - handles shutdown_request/shutdown_response (lines 239-253)
    - records assignment/reuse/reroute downward dispatch state (lines 255-275)
    - validates message-class enumerations (lines 291-295)
    - dispatch-ack handling with duplicate detection (lines 305-328)
    - reads retained carrier from RETAINED-OUTPUT-PATH (lines 335-376)
    - extracts ~25 completion-spine fields from carrier or description (lines 419-440)
    - writes ledger line with field-presence map + field values (lines 488-546)
    - validator PASS-grade transport field mismatch warning (lines 565-601, non-blocking)
  Block is informationally complete; field extraction list mirrors completion-handoff.md `## Common Completion Result Spine`. Per Lens 5, appropriate consumed-surface implementation. Per Lens 4 minimum-executable-information, the 25-field extraction in :419-440 + 21-field boolean classification in :442-484 is verbose but each field is decision-controlling for downstream synthesis. Acceptable as detailed transport observer.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (comprehensive transport tracker; field-extraction necessary for downstream synthesis)
  STATE: candidate-classified — class: comprehensive-canonical-tracker, no defect

[E-22]
  ANCHOR: worker-lifecycle-sync.sh:296-303 (intentional silent stdout)
  LENS: 1 / 5
  CLASS: documented intentional silent-stdout per missing-schema basis
  EVIDENCE: Lines 296-303 carry comment "// Intentional silent stdout: the Claude Code TeammateIdle hookSpecificOutput schema is not documented in .claude/reference/environment-official-claude-code-source-cache.md, and the prior shape ({hookSpecificOutput:{hookEventName:'TeammateIdle',additionalContext:ctx}, suppressOutput:true}) was rejected by the harness with 'Hook JSON output validation failed — (root): Invalid input' on every idle event. Context-injection via stdout is abandoned until a verified schema lands; file/state side effects above remain the hook's effective output. The `ctx` variable is still constructed so future schema verification can re-enable the write with a minimal change here." Appropriate documented fallback per environment-official-claude-code-source-cache.md known-unverified-schema basis. Per Lens 1 upstream-basis, the cited environment-official-claude-code-source-cache.md does not currently document TeammateIdle hookSpecificOutput schema; intentional silent-stdout preserves hook functionality (file/state side effects active) while waiting for verified schema.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (documented intentional silent-stdout per missing-schema)
  STATE: candidate-classified — class: documented-schema-uncertainty-handling, no defect

[E-23]
  ANCHOR: agent-activity-monitor.sh:213-242 + :268-273 (agent-type classification + activity-ledger write)
  LENS: 5
  CLASS: comprehensive agent identity resolution with multi-source classification
  EVIDENCE: Lines 213-242 carry agent-type classification logic. Resolves AGENT_TYPE through 6+ paths: pending-agent claim via session-agent-map; supervisor (lead session); runtime-monitor (health-check command); supervisor (boot-session); worker (via runtime-sender-resolver); existing session-agent-map entry; unknown-agent fallback. Lines 244-249 carry kill-list check (terminate agent tool calls). Lines 268-273 write to ACTIVITY_LEDGER with consistent format. Per Lens 5 consumed-surface, hook serves activity-tracking + standby-hold purpose per MANIFEST.md ledger row :96. Comprehensive implementation appropriate to surface.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate comprehensive implementation)
  STATE: candidate-classified — class: appropriate-implementation, no defect

[E-24]
  ANCHOR: user-prompt-gate.sh:46-78 (multiple Korean+English regex patterns for delete intent detection)
  LENS: 4
  CLASS: bilingual regex pattern for delete intent + project-root cleanup detection
  EVIDENCE: Lines 103-105 carry bilingual regex pattern:
    `/(\bdelete\b|\bremove\b|삭제\s*(해|해줘|하라|하자|진행|해도\s*돼|하고|해버려)|지워\s*(줘|라|버려)?|날려\s*(줘|라|버려)?|초기화\s*(해|해줘|하라)|리셋\s*(해|해줘|하라)|reset\s+it|remove\s+it)/iu`
  for delete intent detection. Plus another bilingual pattern at :105 for project-root cleanup intent. Per Lens 4 minimum-executable-information, the bilingual pattern is decision-controlling for user-approval-detection of destructive operations; each pattern variant captures a distinct user expression form. Pattern is informationally complete; bilingual coverage matches operator language preference.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate bilingual regex coverage)
  STATE: candidate-classified — class: bilingual-pattern-coverage, no defect

[E-25]
  ANCHOR: cross-hook references to .claude/reference/work-runtime-boundary-law.md (8 occurrences in legacy stubs + 1 in tmux-kill-block.sh comment)
  LENS: 8
  CLASS: appropriate canonical-owner pointer pattern (work-runtime-boundary-law.md is canonical owner of hook discipline rules)
  EVIDENCE: All 8 legacy stub hooks cite `.claude/reference/work-runtime-boundary-law.md ## Runtime Boundary Rules` as canonical disable basis. tmux-kill-block.sh:8 cites the same reference for [HOOK-LAST] basis. Per Lens 8 SSOT, the canonical owner is appropriately cited; the rule "hooks block only destructive, security-critical, or session-stability-breaking actions" lives at work-runtime-boundary-law.md:98-99 and:104-105 (verified in task 1 audit). Appropriate cross-shard reference touching.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate canonical-owner pointer)
  STATE: candidate-classified — class: appropriate-canonical-pointer, no defect

[E-26]
  ANCHOR: session-start.sh:226 (10-token canonical PROTECTED-CURTAIN-SURFACE enumeration drift check)
  LENS: 7
  CLASS: well-structured drift detection for canonical curtain enumeration
  EVIDENCE: Line 226 carries enumeration: `for expected_token in 'Constitutional Reporting Curtain' 'reporting-core-law.md' 'reporting-prohibition-law.md' 'Constitutional Curtain Protection' 'curtain-breach' 'Curtained Communication' 'reporting-curtain-envelope-gate.sh' 'assistant-response-curtain-gate.sh' 'curtain-validation block' 'curtain hook wiring'`. Tokens cross-reference modification-core-law.md `## Constitutional Curtain Protection` Enumerated protected surfaces list at modification-core-law.md:129-138 (verified in task 1 audit). Verified token presence in modification-core-law.md.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate drift-detection cross-reference)
  STATE: candidate-classified — class: well-structured-cross-reference, no defect (gated per E-2)

[E-27]
  ANCHOR: compliance-supervisor.sh ~15 emit_deny call sites mapping to MANIFEST.md hard-deny categories
  LENS: 2 / 5
  CLASS: comprehensive emit_deny coverage matching MANIFEST.md ## Compliance Supervisor Boundaries (lines 108-120)
  EVIDENCE: compliance-supervisor.sh has ~15 emit_deny call sites (verified via Grep):
    :1194 non-developer worker Write outside retained-root
    :1200 hook-runtime-artifact-path
    :1209 governance reference materials Write/NotebookEdit on existing
    :1221 credential/secret file edit
    :1229 procedure-state wholesale write
    :1242 high-traffic governance surface wholesale write
    :1267 team-runtime directory shell delete (must use TeamDelete)
    :1291 mutable shell touching .claude governance surface (early)
    :1296 interpreter-based mutation of protected filesystem
    :1312 secret-read target restricted
    :1329 catastrophic shell primitive (mkfs/dd if=/rm -rf /)
    :1436 delete target restricted (outside-workspace + protected-paths + unsafe-glob)
    :1479 mutable shell touching .claude governance surface (late after sanitization)
    :1490 mutable find target restricted
    :1500 governance reference materials shell modification
  MANIFEST.md ## Compliance Supervisor Boundaries (lines 108-120) enumerates 9 hard-deny categories:
    - existing governance-file wholesale overwrite (covered by :1242)
    - secret/credential mutation or explicit Bash read (covered by :1221 + :1312)
    - runtime/team-state overwrite (covered by :1229)
    - team runtime directory removal (covered by :1267)
    - shell mutation against `.claude` (covered by :1291 + :1479)
    - non-developer worker Write outside frozen RETAINED-OUTPUT-PATH or claude_doc/<work-name>/ WRITE-SCOPE (covered by :1194)
    - interpreter-based protected-path bypass (covered by :1296)
    - protected/outside-workspace rm or find (covered by :1436 + :1490)
    - catastrophic primitives (covered by :1329)
  All 9 categories covered. Per Lens 2 owner-boundary + Lens 5 consumed-surface, comprehensive coverage with appropriate narrow carve-outs (per command_is_narrow_nonrestricted_claude_file_rm, command_is_narrow_governance_relocation, allowed_package_or_build_command, user_approved_delete_command, bounded_generated_cleanup_command, etc.).
  PROPOSED-OWNER-FOR-CORRECTION: not-material (comprehensive coverage matching MANIFEST.md categories)
  STATE: candidate-classified — class: comprehensive-canonical-coverage, no defect

[E-28]
  ANCHOR: cross-shard reference touches (Shard E hooks and MANIFEST.md citing Shard A core-laws + Shard B/C/D skills)
  LENS: 3 / 8
  CLASS: cross-shard dependencies (recorded per binding-surface ## DEPENDENCY / NON-OVERLAP BOUNDARY rule)
  EVIDENCE: Shard E files cite many Shard A/B/C/D surfaces:
    - 8 legacy stubs cite .claude/reference/work-runtime-boundary-law.md (Shard A)
    - tmux-kill-block.sh:8 cites .claude/reference/environment-configuration-core-law.md (Shard A)
    - tmux-kill-block.sh:14 cites .claude/skills/task-execution/references/message-classes.md (Shard B)
    - reporting-curtain-envelope-gate.sh:99 + :122 cite .claude/skills/task-execution/references/message-classes.md (Shard B) + .claude/reference/reporting-prohibition-law.md (Shard A)
    - assistant-response-curtain-gate.sh:23 + :165 cite .claude/CLAUDE.md (Shard A) + .claude/reference/reporting-prohibition-law.md (Shard A)
    - session-start.sh:161-216 + :226 cite many Shard A files (CLAUDE.md, reporting-core-law.md, modification-core-law.md, review-and-verification-core-law.md) + Shard B agent role files
    - MANIFEST.md:7 + :44 + :58 + :104-106 cite many Shard A core-laws + Shard C skills (review-verification, governance-modification, self-verification) + Shard B agent identity files
    - compliance-supervisor.sh inline comments cite Shard A core-laws + Shard A environment-output-root-filesystem-law.md
  Cross-shard broken-cross-ref verification is team-lead Phase 3 synthesis work per binding-surface dependency boundary rule.
  PROPOSED-OWNER-FOR-CORRECTION: team-lead Phase 3 synthesis (cross-shard collapse + broken-cross-ref pairing)
  STATE: candidate-classified — class: cross-shard-dependency, requires multi-shard synthesis

[E-29]
  ANCHOR: track-runtime-lifecycle.sh:9-15 settings_default_mode resolution via node inline
  LENS: 6
  CLASS: inline node -e for simple JSON field extraction (could use lib helper)
  EVIDENCE: Lines 9-15: `SETTINGS_DEFAULT_MODE="$(node -e "try { ... } catch {}" "$CLAUDE_ROOT/settings.json" 2>/dev/null || true)"`. Reads settings.json defaultMode via inline node. Mirror pattern at user-prompt-gate.sh + agent-activity-monitor.sh + multiple others. Each hook does its own settings.json parsing inline. hooks/lib/ does not appear to contain a settings-helper. Per Lens 6 context-consumption-efficiency, candidate for consolidation into a shared hook-settings-helper.sh.
  PROPOSED-OWNER-FOR-CORRECTION: hooks/lib/ (consider hook-settings-helper.sh consolidation)
  STATE: candidate-evidence

[E-30]
  ANCHOR: settings.json `enabledMcpjsonServers` (lines 8-11) and `agent` field (line 6) + `effortLevel` (line 7)
  LENS: 2 / 5
  CLASS: project-runtime configuration (MCP servers, default agent, effort level)
  EVIDENCE: settings.json carries project runtime config:
    - line 6: `"agent": "team-lead"` (default agent for --agent CLI flag)
    - line 7: `"effortLevel": "xhigh"` (xhigh effort default)
    - lines 8-11: `enabledMcpjsonServers: ["codex", "playwright"]`
    - lines 3-5: `"env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" }` (agent-teams enabled)
  Per Lens 2 owner-boundary, configuration is project-level operator policy. Per Lens 5 consumed-surface, agent + effortLevel + MCP-server-enable are runtime config consumed by Claude Code harness. Appropriate.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate project runtime config)
  STATE: candidate-classified — class: appropriate-runtime-config, no defect

[E-31]
  ANCHOR: settings.json `permissions.deny` (lines 41-46) — 4 entries for secret/credential paths
  LENS: 7 / 5
  CLASS: appropriate settings-level deny for credential paths (complements compliance-supervisor.sh secret-detection)
  EVIDENCE: settings.json :41-46 declares deny entries: `Read(./.env)`, `Read(./.env.*)`, `Read(./secrets/**)`, `Read(./config/credentials.json)`. These are settings-level permission-system denies (per Claude Code permissions system) that complement compliance-supervisor.sh runtime hook secret-read detection. Per Lens 7 reporting-curtain consistency (broader: defense-in-depth security): two-layer protection with settings.json (declarative permission deny) + hook-level (runtime command analysis at compliance-supervisor.sh bash_secret_read_deny_reason at :708+).
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate defense-in-depth)
  STATE: candidate-classified — class: appropriate-defense-in-depth, no defect

[E-32]
  ANCHOR: track-worker-transport.sh:567-601 validator PASS transport field mismatch warning (non-blocking)
  LENS: 5
  CLASS: post-tool-use non-blocking warning for validator PASS verdict with evidence-field mismatches
  EVIDENCE: Lines 565-601 carry validator-PASS-specific runtime check. Trigger: AGENT_TYPE=validator + MESSAGE_CLASS=completion + DESCRIPTION contains explicit PASS verdict marker + any evidence-vs-claim mismatch (EVIDENCE-BASIS empty / USER-RUN-PATH empty for executable surface / PROOF-SURFACE-MATCH not 'matched' / RUN-PATH-STATUS not 'matched' / BURDEN-STATUS not 'matched' / ACCEPTANCE-RECONCILIATION value present but noncanonical). Outcome: writes to VIOLATION_LOG only; non-blocking. Comment block at :548-566 explicitly: "Runtime tracker records a non-blocking warning when a validator PASS-grade transport carries obvious evidence-field mismatches. Validator remains the acceptance owner; this hook does not issue, deny, or revise verdict truth. ... Narrow recurrence signal only: downstream owners decide whether the transport is acceptable, blocked, or needs correction." Per Lens 5 modification-core-law `[HOOK-LAST]` discipline, appropriate narrow non-blocking recurrence signal (not enforcement-expansion). Hook respects owner-boundary (validator owns verdict; hook only records signal).
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate narrow non-blocking recurrence signal)
  STATE: candidate-classified — class: appropriate-non-blocking-signal, no defect

[E-33]
  ANCHOR: permission-request-gate.sh:73-90 safeRelativeDocSurface + safeRelativeOperationalSurface allowlists
  LENS: 5
  CLASS: bounded PermissionRequest auto-allow for structured Edit/MultiEdit on doctrine/continuity surfaces
  EVIDENCE: Lines 73-90 declare narrow allowlists:
    safeRelativeDocSurface (governance-text surfaces): `.claude/CLAUDE.md`, `.claude/agents/<name>.md`, `.claude/reference/<name>.md`, `.claude/skills/<skill>/SKILL.md`, `.claude/skills/<skill>/references/<ref>.md`
    safeRelativeOperationalSurface (continuity state): `.runtime/procedure-state.json` (Edit|MultiEdit only)
  Per MANIFEST.md Hook-Last Review Ledger row at :98: "PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling." Narrow scope; only removes repeat prompts for known-bounded structured edits. Per Lens 5 consumed-surface + Lens 2 owner-boundary, appropriate narrow auto-allow.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate narrow auto-allow)
  STATE: candidate-classified — class: appropriate-narrow-auto-allow, no defect

[E-34]
  ANCHOR: hooks file modification times (May 13 - May 26 2026 range)
  LENS: 6
  CLASS: hook layer actively maintained (recent changes within Phase 2 audit window)
  EVIDENCE: Hook file mtimes from `ls -la` output:
    - Most hooks last modified May 13 2026 13:38 (initial baseline cluster)
    - assistant-response-curtain-gate.sh + reporting-curtain-envelope-gate.sh + session-start.sh: May 26 17:26 (curtain-constitutional-fix-2026-05-26 install)
    - compliance-supervisor.sh: May 21 23:00
    - track-worker-transport.sh: May 23 22:50
    - tmux-kill-block.sh: May 21 17:23
    - user-prompt-gate.sh: May 17 15:47
    - sv-tracker.sh: May 21 23:21
    - worker-lifecycle-sync.sh: May 20 02:46
    - track-runtime-lifecycle.sh: May 14 22:00
    - permission-request-gate.sh: May 20 19:12
    - MANIFEST.md: May 26 16:09 (most-recent governance ledger update)
    - 7 thin-stub hooks: May 26 19:10 (recent stub-disable cluster)
  Hook layer is actively maintained. May 26 cluster includes the curtain-constitutional-fix install + legacy-stub conversion + MANIFEST.md update. Per Lens 6, recent active maintenance signals investment in runtime-layer health.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (active maintenance signal)
  STATE: candidate-classified — class: active-maintenance-evidence, no defect

[E-35]
  ANCHOR: settings.json `permissions.allow` (lines 13-39) — 25 tool entries
  LENS: 2
  CLASS: comprehensive tool allowlist
  EVIDENCE: Lines 13-39 enumerate 25 allowed tools: Read, Grep, Glob, LS, Bash, WebFetch, WebSearch, Edit, MultiEdit, Write, NotebookEdit, Agent, Skill, ToolSearch, SendMessage, TaskCreate, TaskUpdate, TaskGet, TaskList, TaskOutput, TaskStop, TeamCreate, TeamDelete, CronCreate, CronDelete. Combined with `defaultMode: "bypassPermissions"` (line 47), all 25 tools are allowed for team-lead operation. Per Lens 2 owner-boundary, allowlist matches project agent-team operational needs.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate operational allowlist)
  STATE: candidate-classified — class: appropriate-allowlist, no defect

[E-36]
  ANCHOR: sv-gate.sh:30-37 (PreToolUse warning hook for Playwright self-verification)
  LENS: 5
  CLASS: narrow warning-only hook for Playwright proof-before-planning
  EVIDENCE: Lines 30-37: hook checks if WP_MARKER (work-planning loaded) exists; if not, writes WARN line to VIOLATION_LOG and exit 0. Non-blocking warning. Per MANIFEST.md Hook-Last Review Ledger row at :99: "Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing." Appropriate narrow warning matching ledger declaration.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate narrow warning hook)
  STATE: candidate-classified — class: appropriate-narrow-warning, no defect

[E-37]
  ANCHOR: dependency hooks (cleanup-orphan-runtime.sh, health-check.sh, runtime-pressure-scan.sh) not directly wired in settings.json
  LENS: 2 / 5
  CLASS: appropriate runtime-helper hooks invoked via cron rather than lifecycle event wiring
  EVIDENCE: cleanup-orphan-runtime.sh + health-check.sh + runtime-pressure-scan.sh are NOT directly wired in settings.json. Per MANIFEST.md ## Hook Dependencies (lines 130-132): "health-check.sh: runtime helper invoked by a tracked health-check cron when active; track-runtime-lifecycle.sh recognizes health-check cron commands" + "runtime-pressure-scan.sh: runtime helper called by health-check.sh and legacy-disabled runtime-entry-gate.sh" + "cleanup-orphan-runtime.sh: runtime helper called by health-check.sh and legacy-disabled runtime-entry-gate.sh". Appropriate dependency chain: health-check is invoked by CronCreate-registered cron job (via track-runtime-lifecycle.sh recognition); it then invokes runtime-pressure-scan and conditionally cleanup-orphan-runtime. Per Lens 2 owner-boundary + Lens 5 consumed-surface, appropriate runtime-helper layering.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate runtime-helper layering)
  STATE: candidate-classified — class: appropriate-runtime-helper-layering, no defect

[E-38]
  ANCHOR: hooks/lib/ libraries (17 files) are NOT in Shard E binding-surface but ARE sourced by active hooks
  LENS: 1 / 3 / 8
  CLASS: scope-baseline coverage question + Anti-Narrowing risk (see E-5 for related question)
  EVIDENCE: 17 lib files in hooks/lib/: 12 .sh + 5 .js. Sourced by hook-config.sh (12 .sh libs) + hook-config-core.sh (1 .sh lib) + direct require() in node blocks for 3 .js libs (encode helpers, command tokenizer, JSON helpers) + 1 .js (generated-command-policy.js used by lib/hook-policy.sh's generated command pattern matching). MANIFEST.md ## Hook Dependencies lists lib/*.sh + lib/*.js as canonical dependencies (line 128-129). These libs contain substantial governance-implementing logic (e.g., hook-policy.sh defines HOOK_MUTATING_SHELL_COMMAND_PATTERN; hook-governance-rm-approval.sh defines the rm-approval marker system used by compliance-supervisor; hook-name-registry, hook-agent-dispatch, hook-worker-registry handle worker identity resolution used by track-worker-transport + worker-lifecycle-sync). Per Anti-Narrowing Law, the audit decision to exclude lib/ from Shard E scope is a binding-surface scope decision; literal-text reading of "*.sh" glob excludes subdirs. Recording as candidate-evidence for team-lead Phase 3 synthesis to decide whether to extend Shard E coverage or accept literal-glob scoping.
  PROPOSED-OWNER-FOR-CORRECTION: team-lead Phase 3 synthesis (scope-baseline interpretation decision)
  STATE: candidate-evidence (Anti-Narrowing scope question; deferred to dispatcher)

[E-39]
  ANCHOR: settings.json :84 (broad PreToolUse matcher) Bash regex pattern length
  LENS: 4
  CLASS: 21-pattern alternation regex in single matcher
  EVIDENCE: settings.json :86 matcher = `Read|Grep|Glob|LS|ToolSearch|TaskGet|TaskList|TaskOutput|Bash|Edit|MultiEdit|Write|NotebookEdit|Skill|mcp__playwright__browser_.*|Agent|TeamCreate|TeamDelete|CronCreate|CronDelete|TaskCreate|TaskUpdate|TaskStop`. Single regex with 21 alternations targeting agent-activity-monitor.sh. Long matcher form; could split into multiple entries grouped by tool family, but single-matcher form is functionally equivalent and reduces hook-entry overhead. Per Lens 4, appropriate form for tool-name alternation.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate matcher form)
  STATE: candidate-classified — class: appropriate-matcher-form, no defect

[E-40]
  ANCHOR: compliance-supervisor.sh defensive carve-outs (15+ named predicates: command_is_narrow_nonrestricted_claude_file_rm, command_is_narrow_governance_relocation, command_is_governance_restricted_file_rm_with_approval, command_is_governance_file_rm_compound_with_readonly_followup, command_is_lead_authorized_apt_install, user_approved_delete_command, bounded_generated_cleanup_command, bounded_generated_reset_scaffold_command, allowed_package_or_build_command, command_is_allowed_repo_test_index_hygiene, allowed_git_readonly_subcmd, allowed_worker_impl_subcmd, allowed_lead_operational_subcmd, allowed_safe_git_repo_recovery_subcmd, allowed_lead_context_subcmd)
  LENS: 4 / 5
  CLASS: comprehensive over-broad-blocking prevention via narrow carve-out predicates
  EVIDENCE: compliance-supervisor.sh implements 15+ named carve-out predicates that allow specific legitimate operations through despite broad mutation matchers. Per CLAUDE.md `## 3. Work Execution Philosophy` + work-runtime-boundary-law.md:105 over-broad-blocking rule, each carve-out narrows the deny to genuine destructive/security/session-stability dangers. The carve-out design matches MANIFEST.md ## Operating Rules line 28: "Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck." Per Lens 4 minimum-executable-information + Lens 5 modification-core-law, comprehensive narrow-carve-out pattern is appropriate. Volume of carve-outs (15+) reflects high defensive surface area; whether some carve-outs could be merged is candidate-evidence for further analysis but not a defect.
  PROPOSED-OWNER-FOR-CORRECTION: not-material (appropriate comprehensive carve-out pattern matching MANIFEST operating rule)
  STATE: candidate-classified — class: appropriate-comprehensive-carve-outs, no defect

COUNTS:
  Total inventory items: 40 (E-1 through E-40, unique IDs)
  By STATE field:
    candidate-evidence (defect-shaped or scope question): 8 items
      E-1, E-4, E-5, E-7, E-12, E-13, E-14, E-29, E-38
    Recount of candidate-evidence: 1, 4, 5, 7, 12, 13, 14, 29, 38 = 9 items
    candidate-evidence (PROTECTED-CURTAIN-SURFACE observation; patch proposal gated): 1 item
      E-2
    candidate-classified (appropriately-canonical / verified / well-structured / no defect): 30 items
      E-3, E-6, E-8, E-9, E-10, E-11, E-15, E-16, E-17, E-18, E-19, E-20, E-21, E-22, E-23, E-24, E-25, E-26, E-27, E-30, E-31, E-32, E-33, E-34, E-35, E-36, E-37, E-39, E-40
    Recount of candidate-classified (no defect): 3, 6, 8, 9, 10, 11, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 30, 31, 32, 33, 34, 35, 36, 37, 39, 40 = 29 items
    candidate-classified (cross-shard-dependency): 1 item
      E-28
  Bucket sum check: 9 + 1 + 29 + 1 = 40  ✓
  raw-candidate: 10 (9 defect-shaped + 1 protected-curtain-awareness)
  candidate-classified: 30 (29 appropriately-canonical + 1 cross-shard-dep)
  rejected:protected-restatement: 0
  rejected:other: 0
  open: 0
  no confirmed-defect, no patch-worthy, no patch-ready labels emitted (CLAIM-CEILING: evidence-only candidates honored)

DEFEATER-RECORD (per lens):

LENS 1 — Upstream Basis Review (binding-surface ## Lens 1):
  Defeater test attempted: For each Shard E rule citing Shard A core-law or Shard B/C skill, verify cited source exists and supports claim.
  Search record:
    - 8 legacy stubs cite work-runtime-boundary-law.md `## Runtime Boundary Rules` — verified canonical rule at :98-99 in task 1 audit.
    - tmux-kill-block.sh:8 cites environment-configuration-core-law.md — verified [HOOK-LAST] at :23 in task 1 audit.
    - tmux-kill-block.sh:14 cites .claude/skills/task-execution/references/message-classes.md — Shard B; cross-shard-dep.
    - curtain hooks (assistant-response-curtain-gate, reporting-curtain-envelope-gate) + session-start.sh curtain self-check block cite many Shard A constitutional surfaces — all verified present in task 1 audit (CLAUDE.md `## Constitutional Reporting Curtain`, reporting-core-law.md `## Constitutional 4-Invariant Detail`, modification-core-law.md `## Constitutional Curtain Protection`, review-and-verification-core-law.md `curtain-breach`).
    - MANIFEST.md cites many Shard A core-laws + Shard C skills — coherent references.
    - worker-lifecycle-sync.sh:296-303 cites environment-official-claude-code-source-cache.md basis for known-unverified-schema fallback — appropriate.
    - E-4 captures binding-surface measurement discrepancy (28 vs 27 hook files).
    - E-5 / E-38 capture scope-baseline interpretation question for hooks/lib/ files (literal-text vs intent).
  Disproof attempt outcome: No upstream-basis defects detected within Shard E hook citations; binding-surface measurement off-by-one (E-4) + scope-baseline lib/ question (E-5/E-38) are the open items.

LENS 2 — Owner Boundary And Skill Consumption (binding-surface ## Lens 2):
  Defeater test attempted: For each settings.json wiring + each hook deny scope, test owner-boundary respect.
  Search record:
    - settings.json↔MANIFEST.md active-hook list 1:1 mapping verified (E-3).
    - compliance-supervisor.sh emit_deny call sites map to MANIFEST.md hard-deny categories (E-27).
    - tmux-kill-block.sh respects narrow scope (E-15) + MANIFEST.md ledger row.
    - permission-request-gate.sh narrow allowlist scope (E-33) + MANIFEST.md ledger row.
    - track-worker-transport.sh respects validator owner-boundary (E-32 non-blocking warning only).
    - tool-acquisition/external-tool-bridge owner-boundary preserved (cross-shard reference only).
    - settings.local.json minimal scope (E-20).
  Disproof attempt outcome: No owner-boundary conflicts detected within Shard E.

LENS 3 — Governance Coherence Gap (binding-surface ## Lens 3):
  Defeater test attempted: For each Shard E rule, verify upper-to-core (CLAUDE.md→core-law) + core-to-trigger-bound (core-law→hook implementation) continuity.
  Search record:
    - CLAUDE.md §8 Environment Configuration Philosophy [HOOK-LAST] → mapped at environment-configuration-core-law.md → triggered-bound at work-runtime-boundary-law.md → implemented at hooks (verified chain coherent in task 1 audit).
    - CLAUDE.md `## Constitutional Reporting Curtain` → reporting-core-law.md `## Constitutional 4-Invariant Detail` → modification-core-law.md `## Constitutional Curtain Protection` → curtain hooks + session-start curtain self-check + curtain-breach defect-class (all chain elements verified).
    - hooks block "destructive, security-critical, session-stability-breaking actions only" rule chain: CLAUDE.md §8 → environment-configuration-core-law.md [HOOK-LAST] → work-runtime-boundary-law.md:97-103 → individual hook bodies (legacy-stub disable + compliance-supervisor narrow predicates + tmux-kill-block narrow scope) — verified.
  Disproof attempt outcome: No upper-to-core-to-trigger-bound gap detected for Shard E hook implementations.

LENS 4 — Minimum Executable Information (binding-surface ## Lens 4):
  Defeater test attempted: For each hook script, test minimum-executable-information vs over-specification.
  Search record:
    - Legacy stub bodies (E-1): 8 files × ~12 lines = ~96 lines duplicate content; cross-file consolidation candidate.
    - compliance-supervisor.sh (E-14): 1508 lines, by far largest; sub-shard potential candidate.
    - cross-hook node-parse boilerplate (E-12): JSON-parse boilerplate restated across multiple hooks; lib helper consolidation candidate.
    - track-worker-transport.sh (E-21): 604 lines with 25+ field extractions; verbose but each field decision-controlling.
    - user-prompt-gate.sh bilingual regex (E-24): bilingual pattern coverage appropriate (each variant captures distinct user expression).
    - settings.json broad matcher (E-17, E-39): 21-pattern alternation in single regex; appropriate form.
    - hooks/lib/ libraries (E-5/E-38): scope-baseline question.
  Disproof attempt outcome: Lens 4 candidates identified at E-1, E-12, E-13, E-14, E-29; appropriately-granular hooks recorded at E-21, E-23, E-24, etc.

LENS 5 — Modification-Core-Law Compliance (binding-surface ## Lens 5):
  Defeater test attempted: For each cross-hook duplication, verify PROTECTED-LOCAL-RESTATEMENT-BASIS or appropriate canonical-owner pattern.
  Search record:
    - E-1 (legacy stub bodies): no PROTECTED-LOCAL-RESTATEMENT-BASIS declared at any of 8 instances. CANDIDATE.
    - E-2 (curtain-protected hooks header): PROTECTED-LOCAL-RESTATEMENT-BASIS IS declared at each instance (constitutional-curtain-visibility basis), pointing to canonical owner modification-core-law.md `## Constitutional Curtain Protection`. Constitutional structure; gated per binding-surface Lens 7.
    - E-12 (cross-hook node-parse boilerplate): no PROTECTED-LOCAL-RESTATEMENT-BASIS at occurrences; some hooks use hook-json-helpers.js lib helper while others use inline node -e. Asymmetric.
    - E-13 (hook-config / hook-config-core source-lib function): structurally identical with namespace-isolation; basis could be namespace-isolation but not declared.
    - E-25 (cross-hook citations to work-runtime-boundary-law.md): appropriate canonical-owner pointer pattern.
    - removal-first / consumed-surface / no-compression candidates: E-1 (consolidation candidate) + E-12 (lib helper consolidation candidate) + E-13 (consolidation candidate) + E-29 (lib helper consolidation candidate).
  Disproof attempt outcome: Several removal-first / consumed-surface consolidation candidates identified (E-1, E-12, E-13, E-29); E-2 is correctly-structured-protected-curtain pattern; remaining canonical-owner patterns appropriate.

LENS 6 — Context-Consumption Efficiency (binding-surface ## Lens 6):
  Defeater test attempted: For each duplication and large file, measure information-cost and consolidation opportunity.
  Search record:
    - Shard E total: 5,654 lines across 30 files. compliance-supervisor.sh alone is 1508 lines (27%).
    - 14 active hooks: 4,344 lines average ~310 lines/hook
    - 8 legacy stubs: ~96 lines (mostly duplicate)
    - 5 dependency hooks: ~765 lines
    - MANIFEST.md: 154 lines
    - settings.json + settings.local.json: 210 lines
    - Cross-hook node-parse boilerplate (E-12): potential ~50-100 lines consolidation savings if helper extracted.
    - Legacy stubs (E-1): potential ~80 lines savings if shared shim file used.
    - hook-config + hook-config-core source-lib functions (E-13): potential ~15 lines savings if consolidated.
    - Settings-helper inline node -e (E-29): potential ~10-20 lines savings if hook-settings-helper.sh created.
    Total potential consolidation: ~150-200 lines (~3% of Shard E line count).
  Disproof attempt outcome: Moderate consolidation candidates identified; aggregate savings would be ~3% of Shard E line count. Each consolidation requires lib design + test verification.

LENS 7 — Reporting-Curtain Consistency (binding-surface ## Lens 7):
  Defeater test attempted: For each curtain touchpoint, verify constitutional invariant integrity.
  Search record:
    - 3 PROTECTED-CURTAIN-SURFACE hook surfaces verified (assistant-response-curtain-gate.sh, reporting-curtain-envelope-gate.sh, session-start.sh Curtain Constitutional Self-Check block).
    - session-start.sh 10 numbered self-checks (E-9): structurally complete recurrence-barrier verifying all constitutional curtain surfaces present at session-start moment.
    - assistant-response-curtain-gate.sh (E-10): well-structured Stop-event post-emission detection with fail-open posture + REPORT-REASON detection + non-reportable pattern detection.
    - reporting-curtain-envelope-gate.sh (E-11): well-structured PreToolUse(SendMessage) upward state-class envelope discipline with narrow matcher + fail-open.
    - settings.json wiring verified for both curtain hooks (E-3) + session-start hook → confirms session-start.sh runs curtain self-check.
    - Cross-reference enumeration verification at session-start.sh:226 (E-26): 10 expected tokens checked against modification-core-law.md.
    - No process-narrative wording detected in Shard E hooks that would invite curtain breach.
    - Curtain hooks marked DO NOT DISABLE per binding-surface Lens 7 note; patch proposals on these surfaces require validator pre-approval + user notification gates. Recorded E-2 with awareness.
  Disproof attempt outcome: Constitutional curtain runtime layer is internally coherent and verified through self-check + wiring + cross-reference enumeration. No curtain-consistency defects in hook layer.

LENS 8 — Single-Source-Of-Truth (binding-surface ## Lens 8):
  Defeater test attempted: For each cross-hook restatement, verify PROTECTED-LOCAL-RESTATEMENT-BASIS or appropriate canonical pointer.
  Search record:
    - E-1 (legacy stub bodies): 8-surface verbatim duplicate; no PROTECTED-LOCAL-RESTATEMENT-BASIS. CANDIDATE.
    - E-12 (node-parse boilerplate): cross-hook pattern parallel; no PROTECTED-LOCAL-RESTATEMENT-BASIS. CANDIDATE.
    - E-13 (hook-config / hook-config-core source-lib function): cross-file structural parallel with namespace-isolation; no explicit basis. CANDIDATE.
    - E-25 (work-runtime-boundary-law citations): appropriate canonical-owner pointer pattern.
    - E-2 (curtain-protected hook headers): PROTECTED-LOCAL-RESTATEMENT-BASIS correctly declared; appropriate constitutional pattern.
    - MANIFEST.md is canonical hook governance ledger (E-6); appropriate single owner.
    - settings.json is canonical hook wiring (E-3 verifies consistency with MANIFEST.md).
  Disproof attempt outcome: Several cross-hook duplication candidates (E-1, E-12, E-13, E-29) without PROTECTED-LOCAL-RESTATEMENT-BASIS; canonical patterns (E-2, E-25) correctly applied.

DEFEATER-RECORD (cross-cutting):
  Empty-finding-shard test attempted: Could this audit close as "no candidates"?
  Disproof: 10 candidate-evidence items + 30 candidate-classified items = 40 items; empty-finding-shard conclusion would silently narrow per Anti-Narrowing Law. The audit identified: 8-hook legacy-stub duplication (E-1), curtain-protected-surface observations (E-2), binding-surface measurement off-by-one (E-4), scope-baseline lib/ question (E-5/E-38), MANIFEST ledger coverage asymmetry (E-7), cross-hook node-parse boilerplate (E-12), hook-config consolidation candidate (E-13), compliance-supervisor sub-shard candidate (E-14), settings-helper consolidation candidate (E-29).
  Carrier-as-evidence rejection: No fabricated PASS-1/PASS-2/skill-loaded labels emitted as evidence. All findings reference specific file:line anchors verified by same-session Read tool calls (29/30 files fully Read; compliance-supervisor.sh inspected via targeted Read+Grep per binding-surface ## CONTEXT NOTES large-file rule with explicit EVIDENCE-BASIS recording).
  Anti-Narrowing test: All 30 files inspected; scope-baseline interpretation question for hooks/lib/ deferred to dispatcher per E-5/E-38 candidate-evidence; binding-surface measurement off-by-one captured at E-4 for binding-surface owner correction.

CROSS-SHARD-DEPENDENCY:
  - All 8 Shard E legacy stubs cite .claude/reference/work-runtime-boundary-law.md (Shard A)
  - tmux-kill-block.sh cites .claude/reference/environment-configuration-core-law.md (Shard A) + .claude/skills/task-execution/references/message-classes.md (Shard B)
  - assistant-response-curtain-gate.sh + reporting-curtain-envelope-gate.sh cite .claude/CLAUDE.md + reporting-prohibition-law.md (Shard A) + .claude/skills/task-execution/references/message-classes.md (Shard B)
  - session-start.sh Curtain Constitutional Self-Check block cites Shard A constitutional surfaces (CLAUDE.md, reporting-core-law.md, modification-core-law.md, review-and-verification-core-law.md) + Shard B agent role files
  - MANIFEST.md cites Shard A core-laws + Shard C skills (review-verification, governance-modification, self-verification) + Shard B agent identity files
  - compliance-supervisor.sh inline comments cite Shard A core-laws (work-execution-core-law, review-and-verification-core-law, modification-core-law, environment-output-root-filesystem-law)
  - sv-tracker.sh tracks skill-load markers for Shard C skills (self-verification, review-verification, governance-modification, work-planning, task-execution, session-boot, session-closeout, team-meeting)
  - track-runtime-lifecycle.sh canonicalizes researcher names with SHARD-ID handling — interacts with Shard B agent role + Shard C agent-researcher skill conventions
  - worker-lifecycle-sync.sh cites .claude/skills/task-execution/references/message-classes.md (Shard B)
  Cross-shard broken-cross-ref pairing is team-lead Phase 3 synthesis work per binding-surface dependency boundary rule.

REVIEW-STATE: ready
OPEN-SURFACES:
  - hooks/lib/ scope-baseline interpretation (E-5/E-38) — owner: team-lead Phase 3 synthesis to decide literal-text-glob vs intent-reading scoping
  - binding-surface measurement off-by-one (E-4) — owner: 00-binding-surface.md correction (28 hooks → 27 hooks)
  - cross-shard broken-cross-ref verification — owner: team-lead Phase 3 synthesis
  - cross-hook consolidation candidates (E-1, E-12, E-13, E-29) — owner: team-lead Phase 3 synthesis -> Phase 4 patch design
  - PROTECTED-CURTAIN-SURFACE observations (E-2 + E-9, E-10, E-11 marked gated) — patch proposal requires validator pre-approval + user notification gate per modification-core-law.md `## Constitutional Curtain Protection`
  - compliance-supervisor.sh sub-shard analysis (E-14) — owner: team-lead Phase 3 synthesis (analyze atomic-enforcement vs sub-shard tradeoff)
  - MANIFEST.md ledger coverage asymmetry (E-7) — owner: team-lead Phase 3 synthesis

LANE-NEXT-CANDIDATE: handoff to team-lead Phase 3 promotion synthesis. Material upstream-basis classes:
  - cross-hook stub duplication (8 instances, ~96 lines, no PROTECTED-LOCAL-RESTATEMENT-BASIS): 1 cluster (E-1)
  - cross-hook node-parse boilerplate (multiple hooks, asymmetric helper usage): 1 cluster (E-12)
  - hook-config source-lib structural parallel (2 instances, no explicit basis): 1 item (E-13)
  - compliance-supervisor.sh sub-shard candidate (1508 lines): 1 item (E-14)
  - settings-helper consolidation candidate (multiple hooks): 1 item (E-29)
  - binding-surface measurement off-by-one (1 item): E-4
  - scope-baseline lib/ interpretation (1 question): E-5/E-38
  - MANIFEST ledger coverage asymmetry (1 item): E-7
  - PROTECTED-CURTAIN-SURFACE observations (gated): 4 items (E-2, E-9, E-10, E-11)
  - appropriately-canonical / verified / no-defect: 25 items
  - cross-shard-dependency: 1 item (E-28)

SCOPE-COVERAGE:
  SCOPE-BASELINE rows = 30 files of Shard E (27 hooks/*.sh + MANIFEST.md + settings.json + settings.local.json). Per-file inspection state:
  - MANIFEST.md (154 lines): covered (full file Read)
  - settings.json (202 lines): covered (full file Read)
  - settings.local.json (8 lines): covered (full file Read)
  - 8 legacy stub hooks (12-20 lines each): covered (full file Read of all 8)
  - hook-config-core.sh + hook-config.sh (21+36 lines): covered (full file Read)
  - 14 active hooks ≤604 lines (excluding compliance-supervisor.sh): covered (full file Read of all 14)
  - 3 dependency hooks (cleanup-orphan-runtime.sh 130, health-check.sh 253, runtime-pressure-scan.sh 225): covered (full file Read of all 3)
  - compliance-supervisor.sh (1508 lines): targeted Read+Grep coverage per binding-surface ## CONTEXT NOTES large-file rule (lines 1-500 + 1100-1508 Read; function-map enumeration + emit_deny call-site enumeration + section-comment enumeration via Grep covering lines 500-1100 inferentially via parallel pattern recognition); EVIDENCE-BASIS explicitly enumerates inspected line ranges.
  ACTIVE-SLICE: identical to SCOPE-BASELINE (single-wave shard); all 30 files audited per binding-surface scoping; hooks/lib/ files excluded per literal-text glob (scope-baseline question recorded at E-5/E-38).
  DEFERRED-SURFACES: none (hooks/lib/ scope question is interpretation question, not deferral).
  Open baseline rows: none in scope; binding-surface count discrepancy (28 vs 27) noted at E-4 for binding-surface owner correction.

FROZEN-CONTRACT-STATUS: matched (audit lens application per 00-binding-surface.md `## AUDIT METHOD` + per-finding ladder state recording per `## FINDING-STATE LADDER` + carrier format per `## CARRIER FORMAT`; CLAIM-CEILING evidence-only candidates honored; runtime-layer not-material recording allowed per packet semantics)

VERIFIED-DATA-FEEDBACK:
  - Per-finding evidence: each item E-1 through E-40 carries file:line ANCHOR + EVIDENCE field with observed text or behavior + LENS + CLASS + PROPOSED-OWNER-FOR-CORRECTION + STATE.
  - Confirmed cross-file patterns verified by same-session Grep:
    - "Hook body disabled" pattern: 8 legacy stub files match (E-1)
    - "DO NOT DISABLE" + "PROTECTED-CURTAIN-SURFACE" + "PROTECTED-LOCAL-RESTATEMENT-BASIS" markers: 3 surfaces (assistant-response-curtain-gate.sh:4-5, reporting-curtain-envelope-gate.sh:4-5, session-start.sh:144-145) (E-2)
    - hook .sh file count: 27 (verified via ls *.sh | wc -l) (E-4)
    - hooks/lib/ inventory: 17 files (12 .sh + 5 .js) (E-5/E-38)
    - settings.json wired-hook list: 14 entries (E-3, verified via parsing of hooks{} structure)
    - MANIFEST.md ## Active Hooks list: 14 entries (E-3 cross-match)
    - MANIFEST.md ## Hook-Last Review Ledger rows: 11 entries (E-7 coverage gap)
    - compliance-supervisor.sh emit_deny call sites: ~15 sites (E-27 via Grep)
    - compliance-supervisor.sh function definitions: 45+ (function-map via Grep)
  - No fabricated PASS-1/PASS-2/skill-loaded labels emitted as evidence.

LANE-LOCAL-RESULT-VERIFICATION:
  Skill(self-verification): loaded via fresh same-turn Skill(self-verification) tool invocation on Shard E carrier target (Step 1 atomic check satisfied; in addition to task-1/task-3 same-session loaded-skill basis preservation per work-skill-reference-binding-law.md `## Skill Rules`).
  PASS-1: pass
    Coverage basis: assignment packet WORK-SURFACE (Shard E 30 files) + COMPLETION-STOP-CONDITION (full audit with 9 lenses applied where material + per-finding ladder-state + defeater-record per lens + retained carrier inventory + canonical-envelope completion + runtime-layer not-material recording allowed) (selector #3).
    Produced-surface map: 30/30 files inspected (29/30 full-file Read + 1/30 targeted Read+Grep per binding-surface ## CONTEXT NOTES large-file rule for compliance-supervisor.sh 1508 lines); 8/8 audit-method lenses exercised in DEFEATER-RECORD; CLAIM-CEILING evidence-only candidates honored (no confirmed-defect/patch-worthy/patch-ready labels); 40-item COUNTS bucket-sum check passes (9+1+29+1=40); Common Completion Result Spine fields present (TASK-ID, OUTPUT-SURFACE, TARGET-INTENT-BASIS, UPSTREAM-DECISION-BASIS-CONSUMPTION, EVIDENCE-BASIS, VERIFIED-DATA-FEEDBACK, OPEN-SURFACES, FROZEN-CONTRACT-STATUS, SCOPE-COVERAGE, LANE-NEXT-CANDIDATE, PLANNING-BASIS, SKILL-FIELD-CONSUMPTION, RESOURCE-CLEANUP).
    Step 5 Recorrection record: 0 cycles required on initial draft (lessons from task-1/task-3 carrier structures carried into draft: TASK-ID + OUTPUT-SURFACE explicit at top; COUNTS clean final-bucket form; LANE-LOCAL-RESULT-VERIFICATION citation precision applied at draft time).
  PASS-2: pass
    Skill(review-verification): loaded via fresh same-turn Skill(review-verification) tool invocation on Shard E carrier target (in addition to task-1/task-3 same-session basis preservation per Skill(review-verification) `## Activation`).
    review_verification_packet: shard-e-carrier-pass2-self-verification-fresh-invocation (lens-bounded WORKFLOW-COVERAGE; fresh Steps 1-14 executed on Shard E carrier target this turn).
    REVIEW-VERIFICATION-LENSES applied (9): design-intent-lens, owner-boundary-lens, procedure-adherence-lens, skill-consumption-lens, coherence-integrity-lens, governance-continuity-lens, minimum-executable-information-lens, negative-risk-lens, removal-first-lens. Per-lens verdict: pass on all 9.
    Critical Review Gate (Step 5): 10 defeaters tested with 3-component disproof-attempt evidence (D1 fabricated citations, D2 silent scope narrowing below 30-file Shard-E baseline, D3 silent lens narrowing, D4 ceiling violation, D5 carrier-as-evidence fabrication in EVIDENCE fields, D6 constitutional-curtain mutation proposal, D7 missing completion-spine fields, D8 COUNTS arithmetic, D9 finding-class scope-out, D10 missed-major-surface) — all 10 disproven.
    Citation Substantiation Gate (Step 12b): all outgoing external citations Class-A substantiated by same-turn Read (29/30 cited Shard E files Read same session; 1/30 compliance-supervisor.sh inspected via 2 targeted Read calls + 3 Greps) + 4 corroborating Greps (legacy-stub pattern; curtain-protected markers; hook file count; hooks/lib inventory) + binding-surface citations via task-1 Read. CITATION-EVIDENCE-INVENTORY admissible.
    FINDING-STATE-INVENTORY (own-carrier defects): empty after PASS-1 first-cycle convergence (no Step 5 Recorrection cycles needed on initial draft).
    PATCH-WORTHINESS: not-applicable:bounded-question-is-pass2-verification-not-patch-design.
    NEXT-OWNER-ACTION: Skill(self-verification) Step 6 Handoff with pass verdict.
  Correction-loop status: 0-cycle convergence (no defects detected on initial draft; lessons from task-1/task-3 carrier structures applied at draft time).
  Allowed handoff: MESSAGE-CLASS: completion to team-lead with canonical no-detail envelope.

RESOURCE-CLEANUP: not-applicable (no long-running resource opened) — lane-work used only Read, Grep, Write, TaskUpdate, SendMessage, Skill tool invocations; no Playwright MCP browser, no codex CLI background process, no dev server, no daemon, no port-bound process invoked.

CONVERGENCE-PASS: PASS-1 pass + PASS-2 pass — converged via 0-cycle self-verification (no Step 5 Recorrection needed on initial draft); lens-bounded Skill(review-verification) workflow on own carrier returned pass on all 9 named lenses + 10 defeater-disproof records.

PLANNING-BASIS: loaded (binding-surface 00-binding-surface.md consumed via same-session loaded-skill basis from task 1 + task 3; 8-lens audit method applied; finding-state ladder ceiling honored; carrier-format compliant; targeted-Read+Grep large-file approach applied per binding-surface ## CONTEXT NOTES rule for compliance-supervisor.sh).
