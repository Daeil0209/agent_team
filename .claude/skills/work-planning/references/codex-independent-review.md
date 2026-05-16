# Work-Planning Codex MCP Independent Review
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Load after `Skill(work-planning)` is active, draft planning fields exist, and route freeze needs required or risk-triggered Codex critique.
Pre-`work-planning` Codex output is not planning evidence.

## Contents
- Trigger
- Authority
- Tool Discipline
- Packet
- Review Criteria
- Handling
- Resolve Next Owner And Action

## Trigger
Required trigger evaluation:
- `ACTIVE-WORKFLOW: dev-workflow` requires team-lead to evaluate this reference.
- No material Codex review trigger records `skipped:no-material-codex-review-trigger:<basis>`.
- Codex MCP access failure records `fail-open:*`.

Risk-triggered:
- `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`
- lead-local can substitute for a configured lane
- planning target is `team-dispatch-readiness-plan`
- parallel fit affects correctness, bottleneck risk, runtime footprint, or staffing
- workflow, sequence, acceptance path, packet readiness, proof path, tool/setup, lifecycle, or parallel grouping is material
- team-lead is considering a non-destructive, non-security, non-operator-policy-choice user question instead of a default, parameter, assumption, or owner-evidence route

Skip only for light, receipt/control/status/lifecycle/clarification-only, or no-trigger consequential work.
For `ACTIVE-WORKFLOW: dev-workflow`, `skipped:*` is valid only as `skipped:no-material-codex-review-trigger:<basis>` after evaluating this section.
Codex MCP tool, auth, quota, timeout, parse, or config failure records `fail-open:*`.

## Authority
Codex MCP performs independent structural quality review.
Codex output is evidence, not authority.
Review route, owner, workflow, parallel-fit, readiness, skill-map, acceptance path, and needless-user-gate defects from the user's usable-result perspective.
Choose the lawful route with less user setup, decision burden, debugging, rework, and interpretation burden.

Codex never blocks, dispatches, validates, accepts, logs in, changes files, or replaces `SV-PLAN`/`SV-RESULT`.
`CODEX-INDEPENDENT-REVIEW-BASIS` records team-lead handling of the independent Codex MCP review trigger, adjudication, or fail-open truth; Codex output alone never satisfies it.
team-lead owns the plan, accepted revisions, rejected points, and final route.

## Tool Discipline
- Use only `mcp__codex__codex`.
- Read active project `.mcp.json` before the first call.
- Consume `.mcp.json` `codex` args as the model/effort source.
- Do not guess model, effort, verbosity, or tool shape from memory.
- Use read-only operating constraints when the tool schema permits: `sandbox: "read-only"`, `approval-policy: "never"`, `cwd: <project-root>`.
- Do not use shell `codex exec`, custom wrappers, worker lanes, login repair, package install, credential repair, or settings/hook edits inside Codex MCP review.
- Record `fail-open:<reason>` for `timeout`, `quota`, `parse_fail`, `mcp_unavailable`, `auth_error`, `tool_unavailable`, or `blocked_by_config`.
- Retry one first-use connection miss before final `fail-open`.

## Packet
Send a derived planning packet, not raw conversation.
Exclude raw prompts, secrets, credentials, hidden config values, unrelated governance text, and chain-of-thought.

Packet fields:
- `stage: WP-CONSULT`
- `request_summary`
- `user_perspective_goal`
- `draft_freeze`: `REQUEST-FIT-BASIS`, `REQUEST-BOUND-PACKET-FIELDS`, `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`, `ACTION-CLASS`, `ROUTING-SIGNAL`, `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`, `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`, `NEXT-CONSEQUENTIAL-ACTION`, `DISPATCH-BLOCKERS`
- `context_notes`
- `prior_session_invariants`
- `doctrine_read_paths`
- `user_confirmation_candidate`
- `return_to: team-lead-only`

Use empty strings, arrays, or objects for unknown non-material fields.
Do not use `null`.
`doctrine_read_paths` must include `.claude/CLAUDE.md` plus owner paths needed for doctrine-specific judgment.
Codex must read canonical files directly before doctrine judgment.
Add `.claude/skills/feynman-clarity/SKILL.md` when the deliverable is a plan, design, report, governance/document artifact, specification, or user-facing delivery path.
Add `.claude/skills/benchmark-simulation/SKILL.md` when external visual benchmark, methodology benchmark, verification-method benchmark, or capability-growth benchmark materially affects the planning basis.
Populate `user_confirmation_candidate` only to challenge a proposed user question.

## Review Criteria
Codex returns JSON only.
Valid point types:
- `MISSING_FIELD`
- `OWNER_MISMATCH`
- `WORKFLOW_MISCLASS`
- `PARALLEL_GAP`
- `ACCEPTANCE_ERROR`
- `SKILL_GAP`
- `CARRY_FORWARD_CONFLICT`
- `CONFIRMATION_BEST_CHOICE`
- `NEEDLESS_USER_GATE`
- `USER_PERSPECTIVE_GAP`
- `USER_CONVENIENCE_GAP`
- `FEYNMAN_CLARITY_GAP`
- `VISUAL_BENCHMARK_GAP` (Phase 2 design produces novel/composite operator-facing rendered UI yet `benchmark-simulation` invocation, visual-reference packet, or extracted visual characteristics are missing from planning fields)
- `IMAGE_EVIDENCE_GAP` (planning produces user-facing rendered surface yet the proof/acceptance path lacks per-AC image capture + multimodal `Read` inspection mandate)
- `OPERATOR_NAIVE_COMPREHENSION_GAP` (planning produces user-facing rendered surface yet comprehension audit at first-time-user perspective is absent from review/proof/acceptance basis)
- `OBSERVATION`

Point fields: `id`, `type`, `severity`, `field`, `observation`, `suggested_fix`.
`severity` is `high`, `medium`, or `low`.
`SKILL_GAP` covers methodology or specialist recommendations only.
Codex must not flag missing agent-specific skills.
`FEYNMAN_CLARITY_GAP` never gives Codex ownership.
Parameterizable uncertainty is not a blocker.

## Handling
1. Parse JSON.
2. Retry once on parse failure with a JSON-only reminder.
3. Drop malformed points.
4. Retry one first-use connection miss before final fail-open.
5. Record `fail-open:<reason>` after exhausted MCP/tool/auth/quota/timeout/parse failure.

Every valid point returned by a successful Codex MCP review requires team-lead adjudication before the planning basis is complete.
- Accept only by changing the affected planning field or blocker basis.
- Reject only by citing doctrine, user instruction, evidence, or frozen request basis.
- Generic "noted" rationale is invalid.
- Unadjudicated valid points leave `work-planning` incomplete.

Freeze one:
- `CODEX-INDEPENDENT-REVIEW-BASIS: skipped:<basis>`
- `CODEX-INDEPENDENT-REVIEW-BASIS: triggered:accepted=<n>;rejected=<n>;dropped=<n>`
- `CODEX-INDEPENDENT-REVIEW-BASIS: fail-open:<reason>`

Post-route-freeze Codex MCP independent-review expansion requires a separate governance change with measured benefit, authority/footprint review, and owner path.

## Resolve Next Owner And Action
- Accepted Codex points update the affected planning field or blocker basis.
- Rejected Codex points record cited doctrine, user instruction, evidence, or frozen request basis.
- Exhausted Codex review attempt records `CODEX-INDEPENDENT-REVIEW-BASIS: fail-open:<reason>`.
- No-trigger Codex review path records `CODEX-INDEPENDENT-REVIEW-BASIS: skipped:<basis>`.
- Unadjudicated valid points keep `work-planning` open.
- Post-route-freeze Codex review expansion opens the owning governance change path.
