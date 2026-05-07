# Work-Planning Codex Advisory
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Load after `Skill(work-planning)` is active, draft planning fields exist, and route freeze needs required or risk-triggered Codex critique.
Pre-`work-planning` Codex output is not planning evidence.

## Trigger
Required trigger evaluation:
- `ACTIVE-WORKFLOW: dev-workflow` requires team-lead to evaluate this reference. It does not require a successful Codex call when no material advisory trigger applies or advisory access records `fail-open:*`.

Risk-triggered:
- `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`
- lead-local can substitute for a configured lane
- planning target is `team-dispatch-readiness-plan`
- parallel fit affects correctness, bottleneck risk, runtime footprint, or staffing
- workflow, sequence, acceptance path, packet readiness, proof path, tool/setup, lifecycle, or parallel grouping is material
- team-lead is considering a non-destructive, non-security, non-policy user question instead of a default, parameter, assumption, or owner-evidence route

Skip only for light, receipt/control/status/lifecycle/clarification-only, or no-trigger consequential work.
For `ACTIVE-WORKFLOW: dev-workflow`, `skipped:*` is valid only as `skipped:no-material-advisory-trigger:<basis>` after evaluating this section; advisory tool, auth, quota, timeout, parse, or config failure records `fail-open:*`.

## Authority
Codex is advisory-only structural review.
Review route, owner, workflow, parallel-fit, readiness, skill-map, acceptance path, and needless-user-gate defects from the user's usable-result perspective.
Prefer the lawful route with less user setup, decision burden, debugging, rework, and interpretation burden.

Codex never blocks, dispatches, validates, accepts, logs in, changes files, or replaces `SV-PLAN`/`SV-RESULT`.
`CODEX-ADVISORY-BASIS` is the team-lead trigger, adjudication, or fail-open record; Codex output alone never satisfies it.
team-lead owns the plan, accepted revisions, rejected points, and final route.

## Tool Discipline
- Use only `mcp__codex__codex`.
- Read active project `.mcp.json` before the first call.
- Consume `.mcp.json` `codex` args as the model/effort source.
- Do not guess model, effort, verbosity, or tool shape from memory.
- Use read-only operating constraints when the tool schema permits: `sandbox: "read-only"`, `approval-policy: "never"`, `cwd: <project-root>`.
- Do not use shell `codex exec`, custom wrappers, worker lanes, login repair, package install, credential repair, or settings/hook edits inside advisory.
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
- `OBSERVATION`

Point fields: `id`, `type`, `severity`, `field`, `observation`, `suggested_fix`.
`severity` is `high`, `medium`, or `low`.
`SKILL_GAP` covers non-lane-core methodology or specialist recommendations only.
Codex must not flag missing lane-core skills.
`FEYNMAN_CLARITY_GAP` never gives Codex ownership.
Parameterizable uncertainty is not a blocker.

## Handling
1. Parse JSON.
2. Retry once on parse failure with a JSON-only reminder.
3. Drop malformed points.
4. Retry one first-use connection miss before final fail-open.
5. Record `fail-open:<reason>` after exhausted MCP/tool/auth/quota/timeout/parse failure.

Every valid point returned by a successful advisory requires team-lead adjudication before the planning basis is complete.
- Accept only by changing the affected planning field or blocker basis.
- Reject only by citing doctrine, user instruction, evidence, or frozen request basis.
- Generic "noted" rationale is invalid.
- Unadjudicated valid points leave `work-planning` incomplete.

Freeze one:
- `CODEX-ADVISORY-BASIS: skipped:<basis>`
- `CODEX-ADVISORY-BASIS: triggered:accepted=<n>;rejected=<n>;dropped=<n>`
- `CODEX-ADVISORY-BASIS: fail-open:<reason>`

Post-route-freeze Codex expansion requires a separate governance change with measured benefit, authority/footprint review, and owner path.
