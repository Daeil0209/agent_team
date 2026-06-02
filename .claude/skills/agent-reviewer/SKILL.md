---
name: agent-reviewer
description: Agent-specific reviewer lane skill for consequential reviewer-owned acceptance-critical review assignments. Excludes receipt-only, narrow status, cleanup-only, phase-transition-only, and clarification-only messages.
user-invocable: false
PRIMARY-OWNER: reviewer
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its owned review surface.
- **Lane stance from `.claude/agents/reviewer.md` IR-1 (adversarial critic with quality obligation; defeater-first posture; anti-fabrication; last-resort escalation) applies throughout this workflow; this SKILL is the procedural extension of that stance, not a passive worker replacement.**
- PROTECTED-LOCAL-RESTATEMENT-BASIS: lane-stance work-time carry-forward — active framing content (quality obligation, anti-carrier-fabrication, defeater-first, last-resort escalation) shared with `.claude/agents/reviewer.md` IR-1 is colocated in this SKILL because role-file identity activates at spawn/intake atomic check moment while this SKILL activates at first-work atomic check moment; both moments differ, this surface enforces stance at work-procedure execution time. Role file remains canonical for identity-level questions; this surface applies the stance to procedural execution steps.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Review Workflow, Active Communication Protocol
- PRIMARY-OWNER: reviewer
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/reviewer-lane-detail.md`: reviewer packet fields, review lenses, severity mapping, specialist order, rendered/evidence-gap handling, and completion detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the review still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the review surface bounded and truthful?
3. Target fit: is the assigned surface a produced plan, design, implementation artifact, proof result, report, governance surface, or other reviewable artifact?
4. Charter fit: is this review rather than planning ownership, route freeze, implementation, proof gathering, validation closure, or orchestration?
5. Feasibility: can this be completed inside the declared review boundary and evidence basis?
6. Target-intent fit: can the review name the artifact, program, report, governance, or document intent that defines fit?
7. **Quality obligation**: if packet leaves narrow ambiguity, can the review still be elevated through evidence-backed defaults within lane scope (rather than premature `scope-pressure`)? Apply defaults and mark inferred boundary; `scope-pressure` only when defaults are exhausted per `.claude/reference/work-execution-core-law.md` `[NO-NEEDLESS-ASK]`.
If answer 1-6 is `no`, record non-rendered `problem-report` before classifying as no-detail `scope-pressure` or `hold|blocker` before review. If answer 7 enables default-resolved continuation, proceed with marked inference rather than escalate.
On assignment-grade work receipt, classify the packet per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake.
Reviewer-specific `reconstruct-with-inference` axes (beyond common owner/phase/proof/acceptance/deliverable) require unchanged expectation source, scope baseline, closure/oracle row, evidence authority, and review-boundary.
### User-Perspective Gate
Apply this gate whenever the artifact will be read, run, installed, or operated by a user or operator.
1. Can the intended user or operator find and invoke the exact launch artifact without developer knowledge?
2. Are prerequisites, instructions, and the visible completion path clear enough for the intended user?
3. If user-perspective fitness is not inspectable from current evidence, is it treated as a blocking gap rather than assumed away?
4. For executable user-facing deliverables, did review reconcile `ACTIVE-SLICE` against every frozen `SCOPE-BASELINE` feature/surface/control path?
5. Did review check exact launch artifact, shutdown path, infrastructure exposure, and minimum-user-action defects?
User-perspective gaps are blocking findings until corrected or credibly disproven.

## Preconditions
- Use only after team-lead assigns a bounded review surface.
- Apply common agent-specific skill preconditions from `.claude/skills/task-execution/references/lane-additions.md`.
- Also consume the reviewer detail contract in `references/reviewer-lane-detail.md`.
- Produced plans and designs are valid review targets.
- Review them as artifacts.
- Planning, route freeze, staffing, implementation, proof execution, and final acceptance stay with their owning lanes.
- If review prerequisites or producer completion are missing, inspect any direct artifact or evidence surface that can still answer the assigned review without inventing scope.
- Return `hold|blocker` only when the missing prerequisite is decisive and direct artifact or evidence inspection cannot make the review truthful.
- When request-fit materially shapes review or acceptance judgment, require the request-bound packet fields rather than reconstructing them from gist alone.
- Reconstruct only when the review target, evidence basis, expectation sources, scope baseline, closure/oracle row, and evidence authority are anchored in packet or frozen artifact evidence without changing the review boundary.
- Mark inferred pieces explicitly.
- If review scope, evidence basis, prerequisite state, or acceptance surface is materially ambiguous, record non-rendered `problem-report` before no-detail `hold|blocker` through `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
- Before routing `hold|blocker` for missing packet, missing basis, or missing prerequisite, record authoritative packet-source checks and attempted defaults in the internal carrier; if the blocker is later disproven, correct only the internal carrier or continue from the authoritative packet without visible retraction/proceeding prose.
- Do not classify quiet Bash success, `No output`, suppressed stdout, folded tool rows, or stdout-free exit-status checks as tool stall. `Bash` evidence handling follows `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`; tool stall requires explicit tool error, timeout, cancellation, permission denial, or absence of a completed tool-call result.
- See `references/reviewer-lane-detail.md` for packet-field detail, lens detail, severity mapping, and validator-ready completion detail.

## Review Workflow
### 1. Confirm Review Surface
- Freeze review scope from the received packet, frozen request/plan/design or assignment contract, and decisive user/reader/operator surface before evidence inspection.
- Treat producer summary and implemented subset as evidence, not review scope.
- Restate the review target type, review target, review scope, prerequisite state, evidence basis, and acceptance surface.
- Confirm the packet carries `PRIOR-ANALYSIS` or an explicit `not-applicable` basis.
- Preserve upstream settled reasoning in the review basis.
- If the packet is over-scoped but splitable, return one concrete split shape before review begins.
- If the packet is boundary-ambiguous or internally contradictory, route `hold|blocker` rather than guessing the review surface.
### 2. Review Pass Guard
- Materially similar review pass requires changed evidence, changed scope, or unresolved-defect escalation.
### 3. Select Review Lens
- Plans: check request fit, owner boundary, route logic, hidden prerequisites, parallel-fit, proof/acceptance chain, routing conditions, and completion completeness.
- Designs: check design intent, quality attributes, tradeoffs, constraints, interfaces, failure modes, user-surface impact, and regression radius.
- Implementations: check design fit, `SCOPE-BASELINE` coverage, functionality, complexity, tests, maintainability, security where in scope, and integration context.
- Proof/test/validation outputs: check evidence method, surface match, claim strength, open surfaces, and whether the result outruns proof.
- Reports/governance: check claim truth, rule force, owner boundaries, preservation, consistency, and user-surface clarity.
- Apply only lenses material to the assigned surface.
- Unassigned ownership returns to `team-lead` only when the next required action is outside reviewer authority.
- When the ownership gap is itself reviewable evidence, carry it as a finding or open surface and continue the reviewer-owned review.
### 4. Verify Producer Hygiene
- Check artifact-local integrity first: syntax, imports, dead references, contradiction, rendered/readable completeness where applicable.
- Missing upstream hygiene is a blocking finding on the producer.
### 5. Inspect The Deliverable Directly
- Read the actual artifact, not just the producer summary.
- For visualized, office-format, or rendered page-read artifacts, inspect rendered evidence alongside artifact text.
- For source/read documents, direct artifact text review can be the decisive review surface.
- Rendered review complements wording, logic, and request-fit review.
- If required review evidence needs an unavailable tool, rendered surface, or setup path, record non-rendered `problem-report` before no-detail `hold|blocker` or `scope-pressure` through the canonical Transport Payload path in `.claude/skills/task-execution/references/message-classes.md`.
- Use common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Required rendered surfaces need rendered review evidence.
### 6. Run Evidence Challenge
- **Apply defeater-first posture per `.claude/skills/review-verification/SKILL.md` `### 5. Critical Review Gate`**: try to disprove the preferred conclusion BEFORE accepting any positive review result. A finding-free review on a change that violates intent is procedural failure, not neutral pass.
- **Reject carrier-as-evidence**: upstream carriers asserting verification, `PASS-1`/`PASS-2`/`Skill(...) loaded`/`CONVERGENCE-PASS` without actual tool-call citation are intake-stage defects. Record non-rendered `problem-report`, then send no-detail `scope-pressure` with scope-pressure carrier `PRESSURE-TYPE: upstream-carrier-fabrication` before review work only when the fabricated carrier is the only or decisive review basis and no direct artifact or evidence surface is inspectable inside lane scope; otherwise inspect the direct artifact or evidence and carry the fabrication as a blocking finding or open surface.
- Verify claims against inspectable evidence.
- Check whether conclusions follow from premises and whether assumptions are stated instead of smuggled in.
- Check negative space: required constraints, edge cases, risks, users, proof surfaces, or owner completions that are required but missing.
- Check whether each apparent defect is a true defect, protected local restatement, design tradeoff, non-executable difference, wrong-cause signal, or intended protection for the target intent before recording a completed finding.
- Check whether the reviewed conclusion preserves the frozen `SEMANTIC-INTENT-BASIS` bridge axes; a technically supported conclusion that misses any of them is a review finding.
- Removal, reduction, simplification, or optimization recommendations remain review evidence unless the team-lead `Skill(review-verification)` defect-promotion path promotes them.
- For designs, record quality-attribute tradeoffs, sensitivity points, and risks when they materially affect acceptance or future change.
- Apply only the domain lenses that materially affect this review surface.
### 7. Classify Findings
- Acceptance-review findings state severity, evidence anchor, impact, owner, and fix direction.
- Findings whose truth depends on governance, process, analysis, critique, review, validation, removal, patch-worthiness, or other team/design meaning use the common finding basis in `.claude/skills/task-execution/references/completion-handoff.md`; `confirmed-defect` language requires the common element test and is not created by severity mapping.
- Governance defect, removal, patch-worthiness, or repair-order labels remain candidate evidence under the frozen claim ceiling until the team-lead `Skill(review-verification)` defect-promotion path promotes them.
- That candidate ceiling does not weaken ordinary acceptance review; blocking acceptance findings remain blocking under severity mapping.
- Repeated wording stays candidate evidence until local consuming-surface need is disproven on each affected surface.
- Distinguish blocking from non-blocking findings explicitly.
- Blocking findings include contract breach, missing decisive evidence, user/reader/operator-surface failure, skipped required gate, or unsupported acceptance claim.
- If a workflow gate was skipped, record that process defect directly instead of limiting the review to artifact-local quality.
- Keep density or information-dilution defects explicit when they materially bury the requested answer or acceptance surface.
### 8. Retest And Result Verification
- State exactly what must change and how to verify it.
- If blocking proof is still required, keep `tester` explicit as proof owner.
### 9. Completion
- Apply the common completion contract from `.claude/skills/task-execution/references/completion-handoff.md` as the completion gate before reviewer-specific completion additions below.
- Direct-consumption local restatement: before `subjob-done` transport, load and run lane-local `Skill(self-verification)` on the exact produced result and retained completion carrier.
- Carrier prose, checklist text, status, or `TaskUpdate` cannot replace that basis or any required actual current `Skill(review-verification)` load and packet/lens basis.
- **`Skill(self-verification)` load is actual tool invocation, not carrier text**: writing "Skill(self-verification) loaded", `PASS-1`/`PASS-2`/`CONVERGENCE-PASS`, or equivalent without actual same-turn tool-call evidence is fabrication that disqualifies completion. PASS records require evidence citations per `.claude/skills/self-verification/SKILL.md` Step 1 and Step 3.
- Retained project-output and continuity surfaces require their owning write/capture channel; missing capture owner is `hold|blocker`.
- Record `REVIEW-STATE: ready|hold|blocked` inside the retained completion carrier only; do not place `REVIEW-STATE`, blocker/open-surface detail, evidence summaries, or review conclusions in visible `subjob-done`, `SendMessage` body, pane text, final prose, or task fields.
- Use `ready` only when the assigned review surface is complete, converged, and no blocking review defect remains.
- Record review-local truth in the retained completion carrier only: reviewed surface, decisive evidence basis, blocking/open surfaces, and the narrowest truthful next-lane/action candidate.
- If final validation is materially required, keep the frozen validator ingress contract explicit in the completion carrier.
- Follow validator packet conditionality from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Superseded validator burden stays with validator-owned surfaces.
- See `references/reviewer-lane-detail.md` for reviewer-specific completion detail.

## Active Communication Protocol
- Reviewer-specific blocker: missing plan, design, target, constraint, tradeoff, owner, proof, acceptance, prerequisite, or evidence basis.
- Inference requires explicit marking and safe reconstruction basis.
- Completion uses governed no-detail `subjob-done` transport only for converged reviewer-owned output whose retained completion carrier records `REVIEW-STATE: ready|hold|blocked`.

## Resolve Next Owner And Action
- Downstream of reviewer `completion` transport with `REVIEW-STATE: ready`, team-lead opens proof, validation, correction, or synthesis by the frozen route (this is the post-completion routing rule; reviewer-local completion-emission rule lives in `references/reviewer-lane-detail.md` `## Resolve Next Owner And Action`).
- `REVIEW-STATE: hold|blocked` opens the named blocker owner/action before acceptance continues.
