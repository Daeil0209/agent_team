---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-6 Synthesis; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# team-lead: Synthesis Consume

## Purpose
Use this reference when team-lead synthesizes lane outputs or decides redispatch after completion.

## Consume When
- A lane sends `MESSAGE-CLASS: completion`.
- Multiple lane outputs must be reconciled.
- A strengthened synthesis or redispatch might be reported.
- Final Acceptance Review (FAR) `FINAL-REJECT` has occurred and the next synthesis consumes correction evidence.

## Screen Boundary
Transport-vs-report boundary is owned by `.claude/reference/reporting-user-reporting-law.md` and `.claude/skills/task-execution/references/message-classes.md` `## Communication Plane Law`; synthesis consumes those owners.

## All-Required-Output Barrier
For a multi-lane, multi-shard, reviewer fan-out, proof fan-out, or validator-routed route, team-lead freezes the required output set from the active plan, dispatch record, task state, or route packet.
The required-output barrier blocks user-facing synthesis, phase result, completion claim, and shard-progress prose.
Blocking conditions include any required output that is pending, missing, unintegrated, contradictory, only screen-visible, or awaiting retained-carrier consumption.
A required output closes only through one of:
- completion-grade retained carrier consumed
- explicit owner deferral
- cited out-of-scope basis
- `scope-pressure`
- `hold|blocker`
- failed-send or replacement truth
- user-cancel or user-redirect
Partial arrivals are synthesis queue events.
Partial arrivals open internal merge work, not report text.
Retained-carrier presence, size, and block checks during this barrier use silent success commands; do not emit line counts, byte counts, path echoes, present/verified labels, waiting prose, or idle prose.
Explicit user status questions during this barrier route through `.claude/reference/reporting-user-reporting-law.md` `## Report Shape`.
The barrier owner supplies the current required-output waiting condition as status context.
Internal synthesis materials enter the status answer only when the user requests the exact field.

## Required Output
Record:
- required output set and per-output closure state
- synthesized lane message identities
- accepted evidence anchors
- open surfaces
- contradictions
- frozen delivery contract comparison
- next executable owner/action or `HOLD`
- `Skill(self-verification)` result-verification status when synthesis controls `Skill(review-verification)`, `Skill(governance-modification)`, reporting, or redispatch
- applicable per-claim basis when synthesis emits findings, patterns, rankings, defect labels, patch recommendations, or redispatch basis

## Verification Gate
Before team-lead uses lane-produced, multi-source, or synthesized analysis for `Skill(review-verification)`, `Skill(governance-modification)`, redispatch, mutation, or user-facing report, team-lead loads `Skill(self-verification)` and verifies that exact analysis result plus proposed next owner/action.
When multi-lane candidate analysis will open `Skill(review-verification)`, team-lead first synthesizes the evidence-only candidate map, then loads `Skill(self-verification)` to verify that synthesized map and proposed review target/next owner.
The gate remains open without current result-verification evidence from an actually-loaded `Skill(self-verification)` run; self-verification-shaped blocks authored inside the synthesis carrier, retained outputs, or report drafts do not satisfy the gate.
Full-corpus, multi-shard, defect-classifying, patch-worthiness, removal, or high-risk governance judgment requires independent verification unless the configured or assigned independent surface records unavailable, blocked, not-applicable, or `fail-open:*` basis from its owner.
Do not silently downgrade the gate; unavailable independent verification keeps claim strength conservative and records the unavailable or fail-open basis.
Independent verification routes include reviewer/validator, Codex independent review, and equivalent independent proof surfaces.
Independent verification is internal Procedure Plane work unless `.claude/reference/reporting-user-reporting-law.md` admits a user report.
Raw lane convergence, shard counts, candidate totals, and retained-output presence are not verified synthesis.
Synthesis starts discard-first: exclude, merge, downgrade, or preserve each candidate before promotion.

## Stop
Stop before user-facing prose on lane-completion arrival; arrival opens silent retained-carrier consumption, synthesis, contradiction handling, reuse, cleanup, redispatch, or `Skill(self-verification)` result verification.
When completion opens same-lane follow-on work, wave transition, replacement, or redispatch, evaluate reuse before cleanup or new member creation.
Cleanup before same-lane follow-on work is valid only after reuse-fit failure, dead-or-unavailable target, lane no-longer-needed basis, or active `session-closeout` teardown.
Stop positive synthesis when:
- the input is not completion-grade
- material open surfaces remain
- agent outputs conflict
- the conclusion outruns the reconciled verified surface
- required shard or lane outputs are missing, late, pending, unintegrated, contradictory, only screen-visible, or not explicitly deferred/out-of-scope
- any emitted finding, pattern, ranking item, class bucket, defect group, patch recommendation, or redispatch basis lacks applicable per-claim basis
- quality, evidence, independent review, proof, validation, Codex independent review, Final Acceptance Review (FAR) gates, protected restatements, or owner-boundary repetitions are criticized without protected-function preservation analysis
- a meaning-dependent synthesis claim uses literal wording or target-purpose evidence while omitting or contradicting the frozen `SEMANTIC-INTENT-BASIS`
- `[RETRO-APPLY]` affected prior evidence remains stale or unclassified
Classify raw finding counts, candidate lists, shard labels, and multi-lane convergence as evidence; assign defect status, patch-worthiness, or correction priority only through current `Skill(review-verification)` defect-promotion basis.

Per-claim basis is internal synthesis evidence.
For each emitted synthesis claim, record the applicable items:
- active rule or design-intent basis
- claim ceiling
- `Skill(review-verification)` defect-promotion basis when the claim assigns defect status, correction priority, ranking, or patch-worthiness
- non-finding route basis when the claim assigns redispatch force
- `SEMANTIC-INTENT-BASIS` fit when the claim depends on user, team, design, governance, or artifact meaning
- protected-function preservation analysis when the claim criticizes protected procedure, owner boundary, evidence, review, proof, validation, Final Acceptance Review (FAR) gate, or restatement function
- Defect-promotion rejection basis when the claim promotes a candidate toward confirmed defect, patch-worthiness, priority, ranking, or correction redispatch
Failed per-claim basis routes to claim narrowing, finding reclassification, `OPEN-SURFACES` downgrade, or exclusion from the outgoing synthesis body.

## Resolve Next Owner And Action
- A stopped input route opens completion-grade input recovery.
- A stopped open-surface route opens the smallest correcting owner.
- A stopped conflict route opens owner synthesis reconciliation.
- A stopped overclaim route opens claim narrowing.
- A stopped shard-merge route opens merge-owner integration, explicit deferral, or out-of-scope classification.
- A stopped per-claim-basis route opens failed per-claim basis routing.
- A stopped finding-class route opens finding reclassification before report or redispatch.
- A stopped semantic-frame route opens packet correction, claim reclassification, or reviewer/researcher re-analysis against `SEMANTIC-INTENT-BASIS`.
- A stopped `[RETRO-APPLY]` route opens affected-surface classification.

## Allowed Inputs
Synthesis is allowed only from `MESSAGE-CLASS: completion`.
Consume the completion-handoff common spine and any lane-specific fields needed for the synthesized claim.
For candidate, finding, defect, removal, patch-worthiness, patch-readiness, or issue-count claims, also consume `SEMANTIC-INTENT-BASIS`, `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`, and current `Skill(review-verification)` defect-promotion basis when promotion beyond `candidate-classified` is claimed.

## Hard Rules
- Apply `CLAUDE.md` Communication message-class truth before synthesis.
- These message classes stop positive synthesis:
  - `hold|blocker`
  - `scope-pressure`
- These implemented artifacts prove `ACTIVE-SLICE` only within their covered surface:
  - routes
  - files
  - screens
  - sections
  - checks
- Compare implemented artifacts against the frozen delivery contract.
- Positive closure compares against the frozen request/plan delivery contract.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state.
- Full-corpus, exhaustive, or `FINAL` synthesis requires required shard outputs and inspected corpus state to be integrated, owner-deferred, or out-of-scope with cited basis.
- Team-lead synthesis preserves the finding class assigned by `Skill(review-verification)` defect-promotion path.
- Team-lead synthesis preserves the finding-state ladder state assigned by `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
- Team-lead synthesis reports raw candidate counts, confirmed-defect counts, patch-worthy counts, patch-ready counts, rejected counts, and open-candidate counts as separate values when counts are material.
- Do not promote a non-`confirmed-defect` finding class to `confirmed-defect` during synthesis.
- Do not promote researcher-only evidence to review finding, patch-worthiness, or confirmed defect without downstream review-classification basis.
- Reviewer governance defect, removal, or patch-worthiness outputs remain candidate evidence until `Skill(review-verification)` defect-promotion path records promotion basis.
- Treat these convergence patterns as packet-limited evidence:
  - multi-lane convergence from the same narrowed packet
  - Claude+Codex convergence from the same convenience-built packet
- Packet-limited evidence cannot satisfy per-claim basis by itself.
- Packet basis itself must be compared against:
  - the frozen delivery contract
  - the frozen `SEMANTIC-INTENT-BASIS` when analysis, critique, governance judgment, review, validation, or patch-worthiness depends on user/team/design meaning
- Missing frozen `DERIVED-DEFAULTS` or `REQUEST-BOUND-PACKET-FIELDS` baseline reopens the packet owner.

## Synthesis-Discipline For Validator PASS Verdicts
Team-lead synthesis of an agent PASS verdict must challenge any "testing artifact" or "would work in operator flow" framing in the agent evidence basis.
If the agent did not eliminate the execution-context delta, synthesized claim strength cannot exceed `INFERENCE/UNVERIFIED` for the affected sub-surface, regardless of the agent verdict label.
Skipping operator-environment E2E for the launch or termination path, or generalizing developer-side simulator PASS to an operator-environment claim, is itself a verification defect, not a closure event.

## Redispatch Rules
- Every non-final synthesis resolves to one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to `Skill(review-verification)`, `Skill(governance-modification)`, or a next lane, load `Skill(self-verification)` and verify the synthesized result plus proposed next owner/action before opening that owner.
- Result verification on strengthened synthesis verifies the per-claim basis actually used for every emitted synthesis claim.
- A generic self-verification label without per-claim basis verification is stale or narrower than the outgoing synthesis claim.
- If synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]`.
- Apply `.claude/skills/work-planning/references/cross-continuity.md` before consuming parallel-lane completions.
- Completion evidence of parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch loads `Skill(session-boot)` Monitoring Sequence reassessment before redispatch.
- After Final Acceptance Review (FAR) `FINAL-REJECT`, next synthesis consumes assigned-validator correction packet and team-lead-classified route before the next Final Acceptance Review (FAR) or workflow `Complete`.
