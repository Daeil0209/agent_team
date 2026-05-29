# dev-workflow: Review Convergence Review
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use only inside active `dev-workflow` when reviewer-owned review materially determines Phase 4/5 advancement, validator ingress, redispatch, or completion truth.

PROTECTED-LOCAL-RESTATEMENT-BASIS: reviewer-grade-class review-procedure body — this file owns Phase 4/5 reviewer-grade convergence; `artifact-convergence-review.md` owns Phase 1/2 artifact convergence. Both files carry parallel Authority + Packet + Blind-Dual-Review + Reconciliation + Convergence + Stop structures because each phase-trigger consumes its own file in isolation; the parallel structure is intentional defense-in-depth, not duplication.

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
Configured independent-review adapter for reviewer-grade independent review lives at `.claude/skills/codex-independent-review/SKILL.md`.
Codex output is independent reviewer-grade evidence, not review verdict authority.
team-lead owns reconciliation and workflow cursor truth.
The configured reviewer lane owns its result.
Producer owns correction.
Tester and validator authority remain unchanged.
Material correction consumes `Skill(review-verification)` named lenses (owner-boundary, coherence-integrity, skill-consumption, negative-risk) per the lens-consumption pattern owned by `.claude/skills/dev-workflow/SKILL.md` `## Workflow Core Law` 4.

Configured independent-review authority boundary is owned by `.claude/skills/codex-independent-review/SKILL.md`; this reference consumes that boundary for review-convergence review.
Review-convergence consumes `Skill(review-verification)`; reviewer, validator, and Codex review packets carry applicable named lenses as review criteria when their output controls advancement, redispatch, or completion truth.

## Trigger
Run when all are true:
- active workflow is `dev-workflow`
- configured reviewer lane review is required or returned
- review result affects Phase 4/5 advancement, validator ingress, redispatch, or completion truth
- reviewer packet fields, review target, review scope, evidence basis, acceptance surface, and doctrine paths can be identified

Default surfaces:
- Phase 4 review before tester/validator closure
- Phase 5 quick-check after blocking or high-risk fix
- cross-surface coherence review after parallel production
- governance, proof, report, or design-implementation review that determines acceptance or redispatch

Do not run for receipt/status/phase-context-only messages, typo-only/cosmetic-only review, already-adjudicated findings without material artifact change, or light answer-only work.
If the trigger applies, codex CLI unavailability or unreadable paths are fail-open, not non-trigger.

## Packet
Use codex CLI background invocation, context-limit/privacy, canonical-read, and fail-open discipline from `.claude/skills/codex-independent-review/references/concurrent-patterns.md` (Sub-command Enumeration + Context Limit + Failure Mode Handling + Lifecycle + RESOURCE-CLEANUP).
Every packet includes:
- `.claude/CLAUDE.md`
- `.claude/skills/codex-independent-review/references/concurrent-patterns.md`
- `.claude/skills/review-verification/SKILL.md`
- `.claude/agents/reviewer.md`
- `.claude/skills/agent-reviewer/SKILL.md`
- `.claude/skills/agent-reviewer/references/reviewer-lane-detail.md`
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
1. Start the configured reviewer lane through `task-execution`.
2. Start codex CLI background-invocation independent review from the same frozen reviewer packet fields without waiting for reviewer handoff.
3. Reviewer and Codex packets name the applicable `Skill(review-verification)` lenses.
4. First Codex packet excludes configured reviewer lane findings, reviewer verdict, team-lead verdict, and suggested fixes.
5. team-lead must not use Codex findings to rewrite the configured reviewer lane packet for the same pass.
6. After both outputs exist, team-lead reconciles both point-by-point.

Codex axes derive from artifact, user outcome, downstream consumers, evidence burden, reviewer doctrine, and phase gate.
Codex axes include user-perspective checks.
Codex axes include avoidable-user-burden checks.
Operator-facing rendered UI axes consume `Skill(visual-composition)` for operator-naive comprehension and record `clear`, `partially-clear`, or `unclear` per AC-supporting element.
Operator-facing rendered UI axes consume `.claude/skills/dev-workflow/references/phase-surfaces.md` `Rendered Image Evidence Rule` for image-inspection coverage.
Cite-path-only acceptance remains a procedural failure under that rule.
Novel or composite UI axes consume `Skill(benchmark-simulation)` and check that benchmark characteristics are reflected in the rendered surface.
Plan, design, specification, report, governance, and implementation-binding review surfaces require Feynman clarity.

Codex reviews missed negative space, evidence overreach, owner-action gaps, stale proof/artifact authority, user-surface weakness, and needless-user-gate risk.
Codex must not generate user questions for owner-decidable defaults.

## Reconciliation
Classify each material point (`material point` = configured reviewer lane finding or codex valid output point per `.claude/skills/codex-independent-review/references/concurrent-patterns.md` Authority + Transport Boundary):
- `COMMON`
- `CLAUDE-ONLY`
- `CODEX-ONLY`
- `CONFLICT`
- `NO-ACTION`

Each material point must be accepted, rejected with evidence, lawfully owner-deferred with cited authority, or kept open as `HOLD` / `OPEN-SURFACES` with owner and phase.
Accepted material findings become correction requirements.
Rejected Codex and configured reviewer lane points require governing doctrine, artifact evidence, or frozen request basis.
Rubber-stamp acceptance or unexplained rejection is a convergence defect.

After each correction, rerun configured reviewer lane and codex CLI background-invocation independent review as a new blind dual-review pass.
Prior reviewer output, Codex output, reconciliation, landing confirmation, spot-check, or relay cannot carry forward.
Continue only while convergence value remains material.
Stop or `HOLD` when the same disagreement repeats without new evidence, required access is unavailable outside fail-open, or another pass would repeat an adjudicated dispute.
For material review surfaces, lawful fail-open requires configured reviewer lane synthesis, fallback review basis, and conservative `Skill(self-verification)` convergence.
Fail-open cannot claim Codex concurrence or bypass reviewer, tester, validator, stale-artifact classification, or claim narrowing.

## Convergence
Review convergence requires:
- no accepted high/major/blocking review issue remains on the active surface
- every configured reviewer lane and Codex point is accepted, rejected with evidence, lawfully owner-deferred with cited authority, or kept open with owner, phase, and reason
- Codex-only and reviewer-lane-only material points are adjudicated
- any remaining low/minor issue has owner, phase, and acceptance impact
- tester and validator ingress surfaces remain truthful
- no stale artifact or proof result is used as current evidence

Exact wording can differ.
Material conclusion must match.
If disagreement remains, close only by `resolved-divergence` grounded in doctrine and evidence.
Codex disagreement is evidence, not veto.
`Skill(self-verification)` runs convergence on phase/stage-end synthesis before user-facing reporting, completion claim, phase advancement, or out-of-loop synthesis-triggered redispatch.
In-phase correction dispatch, tester continuation, or validator ingress stays inside the active Phase 4/5 loop.
team-lead executes the output-record next owner/action without user-facing review/proceed prompts.
The exception is explicit approval after cited owner procedures and applicable `Skill(team-meeting)` continuation are exhausted, or a verified user-owned blocker.

## Same-Boundary Loop
Use the same-boundary common fields in `.claude/skills/dev-workflow/references/artifact-convergence-review.md` `## Same-Boundary Loop`.
Review-convergence adds review target or named stale downstream surface under repair.
Do not reopen `work-planning` between passes while the common fields and review-convergence added field remain unchanged.
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
Use the shared `INDEPENDENT-REVIEW-CONVERGENCE-RECORD` schema in `.claude/skills/dev-workflow/references/artifact-convergence-review.md` Output Record. Review-convergence additions:
- review target identity and configured reviewer lane state: `ready|hold|blocked`
- whether `Skill(self-verification)` convergence covered the synthesized claim

## Resolve Next Owner And Action
- Accepted material findings open correction requirements.
- Resolved review convergence opens the output-record next owner/action.
- Missing or false continuation values make the result discussion-only and reopen the review convergence route.
- Lawful `fail-open` opens configured reviewer lane synthesis plus conservative `Skill(self-verification)` convergence.
- Stale artifact or proof result opens stale-surface correction before advancement.
- Boundary-changing review result reopens `work-planning`.
- Repeated unresolved disagreement opens `HOLD`.
