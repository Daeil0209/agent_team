---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-11 Synthesis; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
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
Transport-vs-report boundary is owned by `.claude/reference/reporting-prohibition-law.md` and `.claude/skills/task-execution/references/message-classes.md` `## Communication Plane Law`; synthesis consumes those owners.

## All-Required-Output Barrier
For a multi-lane, multi-shard, reviewer fan-out, proof fan-out, or validator-routed route, team-lead freezes the required output set from the active plan, dispatch record, task state, or route packet.
The required-output barrier blocks user-facing synthesis, phase result, completion claim, and shard-progress prose.
Blocking conditions include any required output that is pending, missing, unintegrated, contradictory, only screen-visible, or awaiting retained-carrier consumption.
A required output closes only through one of:
- completion-grade retained carrier consumed
- lawful owner deferral through upstream owner record
- user-accepted out-of-scope basis
- originally frozen out-of-scope basis
- `scope-pressure`
- `hold|blocker`
- failed-send or replacement truth
- user-cancel or user-redirect
Partial arrivals are synthesis queue events.
Partial arrivals open internal merge work.
Retained-carrier presence, size, and block checks during this barrier use silent success commands; line counts, byte counts, path echoes, present/verified labels, waiting prose, and idle prose stay out of user-facing output.
Explicit user status questions during this barrier route through `.claude/reference/reporting-prohibition-law.md` `## Report Shape`.
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
When an operator-directed governance audit or defect sweep returns high-recall candidates, team-lead self-verifies only candidate-map integrity, lane-local candidate-state preservation, and the proposed review target; binding filtering, final rejection, promotion, ranking, prioritization, correction-priority, removal, patch-worthiness, patch-readiness, or patch/no-patch selection opens `Skill(review-verification):<bounded-question>`.
The gate remains open without current result-verification evidence from an actually-loaded `Skill(self-verification)` run; self-verification-shaped blocks authored inside the synthesis carrier, retained outputs, or report drafts are draft artifacts only.
Full-corpus, multi-shard, defect-classifying, patch-worthiness, removal, or high-risk governance judgment requires independent verification unless the configured or assigned independent surface records unavailable, blocked, not-applicable, or `fail-open:*` basis from its owner.
Unavailable independent verification keeps claim strength conservative and records the unavailable or fail-open basis.
Independent verification routes include reviewer/validator, Codex independent review, and equivalent independent proof surfaces.
Independent verification is internal Procedure Plane work unless `.claude/reference/reporting-prohibition-law.md` grants a narrow user-report exception.
Raw lane convergence, shard counts, candidate totals, and retained-output presence are not verified synthesis.
Synthesis starts discard-first: exclude, merge, downgrade, or preserve each candidate before promotion.

## Synthesis Routing Gate
Lane-completion arrival opens silent retained-carrier consumption, synthesis, contradiction handling, reuse, cleanup, redispatch, or `Skill(self-verification)` result verification before user-facing prose.
When completion opens same-lane follow-on work, wave transition, replacement, or redispatch, evaluate reuse before cleanup or new member creation.
Cleanup before same-lane follow-on work is valid only after reuse-fit failure, dead-or-unavailable target, lane no-longer-needed basis, or active `session-closeout` teardown.
Positive synthesis requires:
- completion-grade input
- closed, lawfully owner-deferred, user-accepted as out-of-scope, originally frozen out-of-scope, or blocker-classified material surfaces
- reconciled agent outputs
- conclusions within the reconciled verified surface
- required shard or lane outputs integrated, lawfully owner-deferred, user-accepted as out-of-scope, originally frozen out-of-scope, or blocker-classified
- applicable per-claim basis for every emitted finding, pattern, ranking item, class bucket, defect group, patch recommendation, or redispatch basis
- current execution records at the same claim scope for every promotion, stamp, closure, or skill-applied claim
- protected-function preservation analysis before criticizing quality, evidence, independent review, proof, validation, Codex independent review, Final Acceptance Review (FAR) gates, protected restatements, or owner-boundary repetitions
- frozen `SEMANTIC-INTENT-BASIS` fit for every meaning-dependent synthesis claim
- frozen `TARGET-INTENT-BASIS` fit for every existing-artifact, design, governance, scope-boundary, proof-purpose, or protected-outcome synthesis claim
- current classification for every `[RETRO-APPLY]` affected prior evidence surface
Classify raw finding counts, candidate lists, shard labels, and multi-lane convergence as evidence; assign defect status, patch-worthiness, or correction priority only through current `Skill(review-verification)` defect-promotion basis.

Per-claim basis is internal synthesis evidence.
For each emitted synthesis claim, record the applicable items:
- active rule or design-intent basis
- claim ceiling
- `Skill(review-verification)` defect-promotion basis when the claim assigns defect status, correction priority, ranking, or patch-worthiness
- non-finding route basis when the claim assigns redispatch force
- `UPSTREAM-DECISION-BASIS` entries that the synthesis consumes, supersedes, passes to the next owner, or leaves open
- `SEMANTIC-INTENT-BASIS` fit when the claim depends on user, team, design, governance, or artifact meaning
- `TARGET-INTENT-BASIS` and applicable core-law axes when the claim depends on existing artifact, target design, governance, scope, proof purpose, acceptance purpose, or protected outcome
- protected-function preservation analysis when the claim criticizes protected procedure, owner boundary, evidence, review, proof, validation, Final Acceptance Review (FAR) gate, or restatement function
- Defect-promotion rejection basis when the claim promotes a candidate toward confirmed defect, patch-worthiness, priority, ranking, or correction redispatch
Failed per-claim basis routes to claim narrowing, finding reclassification, `OPEN-SURFACES` downgrade, or exclusion from the outgoing synthesis body.

## Resolve Next Owner And Action
- Non-completion-grade input opens completion-grade input recovery.
- Open material surfaces open the smallest correcting owner.
- Conflicting outputs open owner synthesis reconciliation.
- Overclaim risk opens claim narrowing.
- Missing shard merge opens merge-owner integration, lawful owner deferral, user-accepted out-of-scope classification, or originally frozen out-of-scope classification.
- Missing per-claim basis opens failed per-claim basis routing.
- Unstable finding class opens finding reclassification before report or redispatch.
- Semantic-frame mismatch opens packet correction, claim reclassification, or reviewer/researcher re-analysis against `SEMANTIC-INTENT-BASIS`.
- Stale `[RETRO-APPLY]` evidence opens affected-surface classification.

## Allowed Inputs
Synthesis is allowed only from `MESSAGE-CLASS: completion`.
Consume the completion-handoff common spine and any lane-specific fields needed for the synthesized claim.
For candidate, finding, defect, removal, patch-worthiness, patch-readiness, or issue-count claims, also consume `SEMANTIC-INTENT-BASIS`, `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`, and current `Skill(review-verification)` defect-promotion basis when promotion beyond `candidate-classified` is claimed.

## Hard Rules
- Apply `CLAUDE.md` Communication message-class truth before synthesis.
- These message classes route positive synthesis to objection handling:
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
- Whole-work synthesis enumerates every frozen requested stage and its closure state before positive closure.
- Positive closure requires each material requested stage to be closed, lawfully owner-deferred through upstream owner record, user-accepted as out-of-scope, originally frozen out-of-scope, or blocked by truthful `HOLD`.
- Stage-only completion synthesis names the completed stage and carries every remaining material downstream stage as `OPEN-SURFACES` with next owner/action.
- Remaining material downstream stages from stage-only synthesis open redispatch, correction, verification, validation, mutation, or `HOLD` in the same request chain.
- Final synthesis opens only after same-request downstream stages close, defer lawfully, exit through user-accepted out-of-scope basis, exit through originally frozen out-of-scope basis, or block by truthful `HOLD`.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state.
- Full-corpus, exhaustive, or `FINAL` synthesis requires required shard outputs and inspected corpus state to be integrated, lawfully owner-deferred, user-accepted as out-of-scope, or originally frozen out-of-scope.
- Team-lead synthesis preserves the finding class assigned by `Skill(review-verification)` defect-promotion path.
- Team-lead synthesis preserves the finding-state ladder state assigned by `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
- Team-lead synthesis reports raw candidate counts, confirmed-defect counts, patch-worthy counts, patch-ready counts, rejected counts, and open-candidate counts as separate values when counts are material.
- Team-lead synthesis preserves every non-`confirmed-defect` finding class below `confirmed-defect` during synthesis.
- Researcher-only evidence remains below review finding, patch-worthiness, or confirmed defect until downstream review-classification basis exists.
- Reviewer governance defect, removal, or patch-worthiness outputs remain candidate evidence until `Skill(review-verification)` defect-promotion path records promotion basis.
- Treat these convergence patterns as packet-limited evidence:
  - multi-lane convergence from the same narrowed packet
  - Claude+Codex convergence from the same convenience-built packet
- Packet-limited evidence requires additional per-claim basis beyond the packet-limited convergence signal.
- Packet basis itself must be compared against:
  - the frozen delivery contract
  - the frozen `SEMANTIC-INTENT-BASIS` when analysis, critique, governance judgment, review, validation, or patch-worthiness depends on user/team/design meaning
  - the frozen `TARGET-INTENT-BASIS` when existing-artifact, design, governance, scope, proof, acceptance, or protected-outcome meaning is material
- Missing frozen material `TARGET-INTENT-BASIS`, `DERIVED-DEFAULTS`, or `REQUEST-BOUND-PACKET-FIELDS` baseline reopens the packet owner.

## Synthesis-Discipline For Validator PASS Verdicts
Team-lead synthesis of an agent PASS verdict must challenge any "testing artifact" or "would work in operator flow" framing in the agent evidence basis.
Uneliminated execution-context delta caps synthesized claim strength at `INFERENCE/UNVERIFIED` for the affected sub-surface, regardless of the agent verdict label.
Skipping operator-environment E2E for the launch or termination path, or generalizing developer-side simulator PASS to an operator-environment claim, is itself a verification defect, not a closure event.

## Redispatch Rules
- Every non-final synthesis resolves to one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to `Skill(review-verification)`, `Skill(governance-modification)`, or a next lane, load `Skill(self-verification)` and verify the synthesized result plus proposed next owner/action before opening that owner.
- Redispatch, correction, validation, or mutation packets opened from synthesis carry the material `UPSTREAM-DECISION-BASIS`; missing carry-forward blocks dispatch or mutation.
- Result verification on strengthened synthesis verifies the per-claim basis actually used for every emitted synthesis claim.
- A generic self-verification label without per-claim basis verification is stale or narrower than the outgoing synthesis claim.
- If synthesis touches existing-artifact integrity or design/scope fit, apply `[DESIGN-INTENT]` and consume material `TARGET-INTENT-BASIS`.
- Apply `.claude/skills/work-planning/references/cross-continuity.md` before consuming lane completions, sibling outputs, or review convergence.
- Completion evidence of parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch loads `Skill(session-boot)` Monitoring Sequence reassessment before redispatch.
- After Final Acceptance Review (FAR) `FINAL-REJECT`, next synthesis consumes assigned-validator correction packet and team-lead-classified route before the next Final Acceptance Review (FAR) or workflow `Complete`.
