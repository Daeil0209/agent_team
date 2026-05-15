# dev-workflow: Review Convergence Review
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Use only inside active `dev-workflow` when reviewer-owned review materially determines Phase 4/5 advancement, validator ingress, redispatch, or completion truth.

## Contents
- Authority
- Trigger
- Packet
- Blind Dual Review
- Reconciliation
- Convergence
- Same-Boundary Loop
- Output Record
- Resolve Next Owner And Action

## Authority
Codex MCP performs reviewer-grade independent review.
Codex output is evidence, not authority.
team-lead owns reconciliation and workflow cursor truth.
Claude reviewer owns the configured reviewer lane result.
Producer owns correction.
Tester and validator authority remain unchanged.

Codex never replaces reviewer, tester, validator, `work-planning`, `task-execution`, `SV-PLAN`, or `SV-RESULT`.
Codex never dispatches, mutates, proves, validates, accepts, issues final `PASS/HOLD/FAIL`, repairs tools, changes MCP/settings/hooks, or asks the user directly.

## Trigger
Run when all are true:
- active workflow is `dev-workflow`
- Claude reviewer review is required or returned
- review result affects Phase 4/5 advancement, validator ingress, redispatch, or completion truth
- reviewer packet fields, review target, review scope, evidence basis, acceptance surface, and doctrine paths can be identified

Default surfaces:
- Phase 4 review before tester/validator closure
- Phase 5 quick-check after blocking or high-risk fix
- cross-surface coherence review after parallel production
- governance, proof, report, or design-implementation review that determines acceptance or redispatch

Do not run for receipt/status/control-only messages, typo-only/cosmetic-only review, already-adjudicated findings without material artifact change, or light answer-only work.
If the trigger applies, MCP unavailability or unreadable paths are fail-open, not non-trigger.

## Packet
Use Codex tool, privacy, canonical-read, stabilization, and fail-open discipline from `.claude/skills/work-planning/references/codex-independent-review.md`.
Every packet includes:
- `.claude/CLAUDE.md`
- `.claude/agents/reviewer.md`
- `.claude/skills/reviewer/SKILL.md`
- `.claude/skills/reviewer/references/reviewer-lane-detail.md`
- `.claude/skills/dev-workflow/SKILL.md`
- `.claude/skills/dev-workflow/references/phase-gates.md`
- `.claude/skills/dev-workflow/references/gap-iteration.md`
- `.claude/skills/feynman-clarity/SKILL.md` when Feynman clarity applies
- target artifacts, producer handoff, reviewer output after blind pass, and packet-required specialist skill paths

Codex must read canonical paths directly where permitted.
A team-lead paraphrase is not doctrine.
Missing required path records `fail-open:blocked_by_config`.
Missing decisive reviewer-facing fields are not guessed.

## Blind Dual Review
1. Start Claude reviewer through `task-execution`.
2. Start Codex MCP independent review from the same frozen reviewer packet fields without waiting for reviewer handoff.
3. First Codex packet excludes Claude reviewer findings, reviewer verdict, team-lead verdict, and suggested fixes.
4. team-lead must not use Codex findings to rewrite the Claude reviewer packet for the same pass.
5. After both outputs exist, team-lead reconciles both point-by-point.

Codex axes derive from artifact, user outcome, downstream consumers, evidence burden, reviewer doctrine, and phase gate.
Codex axes include user-perspective checks.
Codex axes include avoidable-user-burden checks.
Operator-facing rendered UI axes include operator-naive comprehension.
Operator-naive comprehension records a `clear`, `partially-clear`, or `unclear` verdict for each AC-supporting element.
Operator-facing rendered UI axes include image-inspection coverage.
Image-inspection coverage opens every cited screenshot or full-page capture supporting an AC verdict or finding through multimodal `Read`.
Image-inspection coverage matches each opened image against the design-stated expectation.
Cite-path-only acceptance is a procedural failure.
Novel or composite UI axes include visual benchmark consumption.
Visual benchmark consumption checks that `benchmark-simulation` characteristics are reflected in the rendered surface.
Plan, design, specification, report, governance, and implementation-binding review surfaces require Feynman clarity.

Codex reviews missed negative space, evidence overreach, owner-action gaps, stale proof/artifact authority, user-surface weakness, and needless-user-gate risk.
Codex must not generate user questions for owner-decidable defaults.

## Reconciliation
Classify each material point:
- `COMMON`
- `CLAUDE-ONLY`
- `CODEX-ONLY`
- `CONFLICT`
- `NO-ACTION`

Each material point must be accepted, rejected with evidence, or deferred with owner and phase.
Accepted material findings become correction requirements.
Rejected Codex and Claude reviewer points require governing doctrine, artifact evidence, or frozen request basis.
Rubber-stamp acceptance or unexplained rejection is a convergence defect.

After each correction, rerun Claude reviewer and Codex MCP independent review as a new blind dual-review pass.
Prior reviewer output, Codex output, reconciliation, landing confirmation, spot-check, or relay cannot carry forward.
Continue only while convergence value remains material.
Stop or `HOLD` when the same disagreement repeats without new evidence, required access is unavailable outside fail-open, or another pass would repeat an adjudicated dispute.
For material review surfaces, lawful fail-open requires Claude reviewer synthesis, fallback review basis, and conservative `SV-RESULT`.
Fail-open cannot claim Codex concurrence or bypass reviewer, tester, validator, stale-artifact classification, or claim narrowing.

## Convergence
Review convergence requires:
- no accepted high/major/blocking review issue remains on the active surface
- every Claude reviewer and Codex point is accepted, rejected, or deferred with reason
- Codex-only and Claude-only material points are adjudicated
- any remaining low/minor issue has owner, phase, and acceptance impact
- tester and validator ingress surfaces remain truthful
- no stale artifact or proof result is used as current evidence

Exact wording can differ.
Material conclusion must match.
If disagreement remains, close only by `resolved-divergence` grounded in doctrine and evidence.
Codex disagreement is evidence, not veto.
`SV-RESULT` verifies phase/stage-end synthesis before user-facing reporting, completion claim, phase advancement, or out-of-loop synthesis-triggered redispatch.
In-phase correction dispatch, tester continuation, or validator ingress stays inside the active Phase 4/5 loop; team-lead executes the output-record next owner/action without user-facing review/proceed prompts unless explicit approval or a verified user-owned blocker exists.

## Same-Boundary Loop
Do not reopen `work-planning` between passes while all remain unchanged:
- `ACTIVE-WORKFLOW: dev-workflow`
- phase
- review target or named stale downstream surface under repair
- owner map
- deliverable shape
- staffing shape
- proof/acceptance chain
- user requirement and request-fit basis

Reopen `work-planning` when any boundary changes, becomes untrue, or cannot be named.

Same-review continuation packet carries:
```text
REVIEW-CONTINUATION: review-convergence
ACTIVE-WORKFLOW: dev-workflow
CONTINUATION-CLASS: bounded-review-iteration
CURRENT-PHASE: <Phase N name>
REVIEW-TARGET: <path-or-surface>
BOUNDARY-UNCHANGED: yes
```

Missing or false continuation values make the result discussion-only.
Valid continuation preserves boundary only.
It does not preserve prior reviewer, Codex, or reconciliation output as current-pass convergence.
Rerun with owner contract, record lawful fail-open, or stop on `HOLD`.

## Output Record
Use the shared `INDEPENDENT-REVIEW-CONVERGENCE-RECORD` schema in `.claude/skills/dev-workflow/references/artifact-convergence-review.md` Output Record (artifact path/phase, Codex MCP review state, accepted/rejected/deferred point counts, fallback basis, downstream/stale status, next owner/action). Review-convergence additions:
- review target identity and Claude reviewer state: `ready|hold|blocked`
- whether `SV-RESULT` covered the synthesized claim

## Resolve Next Owner And Action
- Accepted material findings open correction requirements.
- Resolved review convergence opens the output-record next owner/action.
- Missing or false continuation values make the result discussion-only and reopen the review convergence route.
- Lawful `fail-open` opens Claude reviewer synthesis plus conservative `SV-RESULT`.
- Stale artifact or proof result opens stale-surface correction before advancement.
- Boundary-changing review result reopens `work-planning`.
- Repeated unresolved disagreement opens `HOLD`.
