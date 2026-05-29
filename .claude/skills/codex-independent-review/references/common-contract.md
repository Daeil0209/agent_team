# Configured Independent Review: Common Contract
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/codex-independent-review/SKILL.md
SOURCE-RULES: "Configured independent-review common contract; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use this reference before every configured Codex MCP review call.

## Common Contract
Use configured independent review only through the active owner path.
The calling owner supplies the target, governing basis, evidence surfaces, and claim or decision being checked.
Codex reviews against the supplied user goal, target intent, live doctrine, governing owner references, decisive evidence, and target-specific acceptance or convergence criteria.
Codex output is independent review evidence only.
team-lead owns every accepted revision, rejected point, unresolved gap, convergence record, final route, and user-facing claim.
Target-specific owner references may add stricter packet, review, proof, convergence, or acceptance duties.
Target-specific duties must not weaken this Common Contract.

Do not use configured independent review as:
- a substitute for `work-planning`
- a substitute for `task-execution`
- a substitute for `reviewer`, `tester`, or `validator`
- a substitute for `Skill(self-verification)` produced work-product outbound convergence
- a user-facing report
- a blocker by itself
- a dispatch, validation, final acceptance, login, file mutation, credential repair, or settings/hook edit owner

## Tool Discipline
- Use only `mcp__codex__codex`.
- Read active project `.mcp.json` before the first call.
- Consume `.mcp.json` `codex` args as the model/effort source.
- Do not guess model, effort, verbosity, or tool shape from memory.
- Use read-only operating constraints when the tool schema permits: `sandbox: "read-only"`, `approval-policy: "never"`, `cwd: <project-root>`.
- Do not use shell `codex exec`, custom wrappers, worker lanes, login repair, package install, credential repair, or settings/hook edits inside Codex MCP review.
- Record `fail-open:<reason>` for `timeout`, `quota`, `parse_fail`, `mcp_unavailable`, `auth_error`, `tool_unavailable`, or `blocked_by_config`.
- Retry one first-use connection miss before final `fail-open`.

## Packet Contract
Send a derived configured-review packet, not raw conversation.
Exclude raw prompts, secrets, credentials, hidden config values, unrelated governance text, and chain-of-thought.

Every configured-review packet carries:
- `stage`: `WP-CONSULT`, `ARTIFACT-CONVERGENCE`, `REVIEW-CONVERGENCE`, `FINAL-ACCEPTANCE`, or `OWNER-DEFINED:<owning-reference>`
- `review_target`: planning freeze, artifact path, review surface, final evidence packet, or owner-defined target
- `user_perspective_goal`
- `target_intent_basis`
- `governing_basis`: live doctrine and owner references Codex must read
- `evidence_surfaces`: exact paths, packets, retained evidence, screenshots, logs, or records that bound the review
- `claim_or_decision`: the route, convergence, acceptance, correction, or completion claim being checked
- `excluded_scope`
- `target_specific_criteria`
- `return_to: team-lead-only`

Use empty strings, arrays, or objects for unknown non-material fields.
Do not use `null`.
`governing_basis` must include `.claude/CLAUDE.md` plus owner paths needed for doctrine-specific judgment.
Codex must read canonical files directly before doctrine judgment.
A team-lead paraphrase is context only, not doctrine.
Owner references may add fields but must not omit the common packet fields above.
The first independent pass for a target excludes team-lead findings, verdict, and suggested fixes unless the owning reference explicitly defines a later correction or reconciliation pass.

## Common Review Axes
For every stage, Codex reviews:
- request and user-outcome fit
- target intent and protected function
- owner boundary and next-owner/action truth
- workflow, sequence, phase, and procedure-order fit
- evidence sufficiency and evidence overreach
- proof path and acceptance-surface fit
- stale artifact, stale proof, stale carry-forward, and cross-surface conflict risk
- required specialist-skill or methodology trigger gaps
- parallel-fit, staffing, runtime-footprint, and bottleneck risk when material
- needless-user-gate and avoidable-user-burden risk
- Feynman clarity for plans, designs, specifications, reports, governance, implementation-binding artifacts, and receiver-facing outputs
- benchmark, image-evidence, operator-naive comprehension, and rendered-surface gaps when the owning reference makes those axes material
- negative risk from the user's usable-result perspective

Target-specific owner references add their own criteria.
Codex reports wording, typo, or style issues only when they change meaning, user burden, proof, acceptance, downstream execution, or receiver comprehension.
Codex must not generate user questions for owner-decidable defaults.
Codex must not flag missing agent-specific skills.
Parameterizable uncertainty is not a blocker.

## Point Schema
Codex returns JSON only.
Valid point types:
- `MISSING_FIELD`
- `OWNER_MISMATCH`
- `WORKFLOW_MISCLASS`
- `PROCEDURE_ORDER_GAP`
- `PARALLEL_GAP`
- `ACCEPTANCE_ERROR`
- `EVIDENCE_GAP`
- `STALE_SURFACE_GAP`
- `SKILL_GAP`
- `CARRY_FORWARD_CONFLICT`
- `CONFIRMATION_BEST_CHOICE`
- `NEEDLESS_USER_GATE`
- `USER_PERSPECTIVE_GAP`
- `USER_CONVENIENCE_GAP`
- `FEYNMAN_CLARITY_GAP`
- `VISUAL_BENCHMARK_GAP`
- `IMAGE_EVIDENCE_GAP`
- `OPERATOR_NAIVE_COMPREHENSION_GAP`
- `TARGET_INTENT_GAP`
- `NEGATIVE_RISK`
- `OWNER_DEFINED_GAP`
- `OBSERVATION`

Point fields:
- `id`
- `type`
- `severity`
- `target_surface`
- `field` when the target is `WP-CONSULT` or another fielded record
- `governing_basis`
- `evidence`
- `observation`
- `user_or_owner_effect`
- `suggested_owner_action`

`severity` is `high`, `medium`, or `low`.
Target-specific references may narrow valid point effects through their convergence or acceptance records.

## Handling
1. Parse JSON.
2. Retry once on parse failure with a JSON-only reminder.
3. Record malformed point count and reason, preserve readable partial observations when possible, and drop only unreadable malformed points.
4. Retry one first-use connection miss before final fail-open.
5. Record `fail-open:<reason>` after exhausted MCP/tool/auth/quota/timeout/parse failure or when all returned points are malformed.

Every valid point returned by a successful configured independent review requires team-lead adjudication before the owning basis is complete.
- Accept only by changing the affected planning field, artifact, correction basis, blocker basis, convergence record, or acceptance record.
- Reject only by citing doctrine, user instruction, artifact evidence, proof evidence, acceptance evidence, or frozen request basis.
- Defer only when the owning reference allows deferral and names owner, phase, and acceptance impact.
- Generic "noted" rationale is invalid.
- Unadjudicated valid points leave the owning path incomplete.
