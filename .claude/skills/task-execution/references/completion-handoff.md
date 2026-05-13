---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Completion And Handoff
## Contents
- Common Completion Result Spine
- Common Lane Handoff Law
- Resolve Next Owner And Action

## Common Completion Result Spine
Every completion-grade report using `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` must include:
- `TASK-ID` when task tracking is active
- `OUTPUT-SURFACE`
- `TARGET-INTENT-BASIS`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `FROZEN-CONTRACT-STATUS`
- `LANE-NEXT-CANDIDATE`
- `PLANNING-BASIS: loaded`
- `CONVERGENCE-PASS`
- `RESOURCE-CLEANUP`
- `REQUESTED-LIFECYCLE`
- `PRODUCER-SELF-REVIEW-PASS` — defeater lenses applied, disconfirming checks attempted, defects found and fixed by the producer in-pass, final-pass convergence (last pass found no producer-owned defect, or remaining items routed to `OPEN-SURFACES` / `scope-pressure` / `hold|blocker`). Producer self-review is defect-seeking review, not self-approval.
- `LANE-LOCAL-SV-RESULT` — `self-verification` mode, verified surface, verification basis, claim strength, allowed next action. Verifies producer execution truth only.

Team-lead accepts completion-grade messages that carry both blocks; messages missing either return to the producer via packet-correction.

Lane handoff reports lane-local convergence only and claims no team-lead `SV-RESULT`.
Team-lead synthesizes only completion-grade handoffs, then runs `SV-RESULT` on the exact synthesized outgoing claim before user-facing consequential reporting, completion claim, or redispatch.

For team-agent runtime, the report is completion-grade only when delivered to `team-lead` by `SendMessage` with the required `MESSAGE-CLASS`.
Plain-text agent output is production evidence only until carried through that channel.
When the assigned output is a synthesis, audit, evidence pack, generated artifact, or project-output surface, the handoff cites the retained path under `projects/<project-folder>/...`.
When artifacts, logs, screenshots, traces, reports, or datasets support `EVIDENCE-BASIS`, the handoff must cite a retained project-owned path. When the cited evidence includes screenshot or full-page image files for user-facing rendered surfaces, the producing lane opens each image directly via the multimodal `Read` tool and confirms the rendered surface matches the claimed verdict; the receiving lane (reviewer/validator/team-lead synthesis) opens the same image files independently before accepting the claim.
`/tmp`, shell scrollback, transient pane output, and deleted scratch files are execution context only, not retained evidence.
Conversation-only output is valid only when the packet names conversation as the output surface.

`TARGET-INTENT-BASIS` names the governance, program, report, document, review, proof, or validation purpose that controlled the work.
Use `INFERENCE` only when reconstructed safely from request, plan, design, Structural Contract, cited artifact, or frozen scope without inventing scope, closure rows, disposition paths, consumer/recompute paths, source authority, display-only basis, or acceptance oracle.
Use concrete task, artifact, expectation, evidence, and next-owner wording.
Common finding basis:
- Evidence-only observations stay as anchors or `OPEN-SURFACES`.
- Raw finding counts, repeated labels, multi-lane convergence, and candidate lists are evidence only; they are not severity, priority, patch-worthiness, or confirmed-defect proof.
- Researcher outputs supply evidence and candidate classifications only unless a downstream review owner reclassifies them through this basis.
- A patchable finding states `TARGET-INTENT-BASIS`, evidence class when material, protected function, user-outcome impact, `patch-worthiness`, regression risk, and the tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue` classifications.
- A governance, process, analysis, critique, review, or validation finding whose truth depends on user/team/design meaning also states `SEMANTIC-INTENT-BASIS`; without it the finding stays evidence-only or `OPEN-SURFACES`.
- Quality, evidence, independent review, proof, validation, Codex independent review, and FAR gates are protected functions; deletion, non-enforcement, hook silence, runtime omission, cost, latency, repetition, or ceremony is evidence only until the common finding basis proves `confirmed-defect`.
- Only `patch-worthiness: must-fix|narrow-fix` with proof that correction will not remove a stronger protected function is patch-dispatch basis; `observe|no-patch` stays retained context.
- Common finding-class taxonomy (used by reviewer, review-verification, and validator-input findings): `confirmed-defect` (live evidence proves design-intent conflict, negative operating effect, causal path, correction owner, and no stronger protected-function loss from correction), `risk-hypothesis` (plausible risk lacks enough proof for patch dispatch), `design-tradeoff` (intentional protection with a cost), `duplication` (repeated meaning without protected local-restatement basis after proving correction will not remove a stronger protected function), `protected-restatement` (repeated meaning needed for isolated owner readability), `non-issue` (evidence disproves the concern), `unverified` (evidence basis incomplete).

`RESOURCE-CLEANUP` reports whether long-running spawned resources opened during lane work were closed at handoff. Long-running resources include Playwright MCP browser sessions, dev servers, daemons, dev-runners, and other port-bound or session-bound processes. Transient short-lived invocations (one-off linter, single-pass test harness, fixture file already removed) are not long-running resources for this field.
- `RESOURCE-CLEANUP: complete` requires explicit enumeration of every long-running resource actually killed (server PID + port, daemon PID, or dev-runner PID) plus a post-cleanup verification that ports and resources are released.
- `RESOURCE-CLEANUP: not-applicable (no long-running resource opened)` is allowed only when the lane invoked no long-running spawn; transient invocations report `not-applicable` truthfully.
- Leaving any long-running spawned process at handoff is a `RESOURCE-CLEANUP` defect; team-lead rejects completion-grade reports that misuse `not-applicable` to cover an unkilled long-running resource or a bare `complete` without enumeration and post-cleanup probe.

Lane docs require bounded additions only when they preserve this common result spine.
Handoff names selected non-lane-core skills, material direct references applied or blocked, material tool/proof capability used or blocked, and work-surface basis.
If a material specialist skill, direct reference, or decisive tool was omitted, unavailable, or only named without shaping the work, the gap stays in `OPEN-SURFACES` or routes through `scope-pressure` / `hold|blocker` instead of completion-ready wording.
Team-lead reviews that basis against the handed-off work and sends correction to the owning lane when direction drifts.
When material, `EVIDENCE-BASIS` names the Evidence-Quality Matrix rows supporting the handoff claim.
`FROZEN-CONTRACT-STATUS` must be one of `matched`, `partial`, `drifted`, `blocked`, `not-assessable`, or `not-applicable:<basis>`. It compares the lane's evidence against the frozen assigned contract, not just the changed artifact or executed route.
When material, `FROZEN-CONTRACT-STATUS` names the Receiver-Surface Contract, Consumption Chain, or Boundary Register basis that the lane matched, narrowed, or left open.
The common end closure contract reconciles the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md` against this result spine.
Each material start-contract axis closes through matched evidence, upstream defer basis, `not-applicable:<basis>`, or an `OPEN-SURFACES` item.
Use `matched` only when the supporting spine fields or lane-specific status fields show the axis outcome.
When the user-ready delivery chain is material, `matched` requires traceable continuity from instruction through concept/detail, implementation or production surface, verification evidence, and final receiver path.
Working features with disconnected information, hidden assumptions, orphaned components, or implausible receiver flow are not closed-result evidence.
`REQUESTED-LIFECYCLE` is the producer's request.
Lifecycle debt clears only through explicit lifecycle control.
Team-lead executes explicit lifecycle control on each completion-grade handoff in the same turn.
Production-lane agents (developer/researcher) on a surface still inside the active validation chain (review → test → validate) hold `standby` or `hold-for-validation` until the chain converges to ACCEPT.
FAR/HOLD keeps the producing lane available until correction routing is resolved.
Correction dispatch follows `OPEN-SURFACES`, `LANE-NEXT-CANDIDATE`, or the validator correction packet.
Re-dispatch the producer for producer-owned correction.
Issue `shutdown_request` only when validation ACCEPT is recorded for the producer's surface, the surface is proven out of the frozen plan, or closeout owns the path.
Send `reuse` for agents picked up for the next assignment in the active route.
Wait for confirmed termination evidence on shutdowns.
Standby and reuse continue at lane.
Team-lead can allow one narrow same-surface follow-on before lifecycle control only when all conditions hold:
- prior completion already made a non-reuse requested lifecycle explicit
- next dispatch targets a distinct concrete agent
- unresolved lifecycle debt stays visible

When the lane claims user-surface proof or user-surface acceptance on an executed surface, the completion-grade report must also keep the exercised method explicit:
- `USER-RUN-PATH` and `RUN-PATH-STATUS` when the deliverable is executable user-facing
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`
- `OPERATOR-NAIVE-COMPREHENSION-AUDIT` for any handoff whose surface includes rendered UI.
  Report a first-time-user walkthrough verdict per AC-supporting surface element (labels, controls, data displays, charts, gauges that bear acceptance weight).
  Each verdict is `clear`, `partially-clear:<reason>`, or `unclear:<reason>`.
  Items rated `unclear` block PASS or route to `OPEN-SURFACES` with the responsible owner.
  Minor non-AC labels report as a single `routine: clear` summary unless a defect is observed.
- `IMAGE-INSPECTION-RECORD` for any handoff whose surface includes rendered UI.
  List each screenshot or full-page image cited in support of an AC verdict, FAR claim, or visual-conformance assertion.
  Cite the design-stated expectation each image proves.
  State the per-image visual verdict after opening the image directly via the multimodal `Read` tool.
  Each verdict is `matches-expectation`, `deviates:<concrete deviation>`, or `inconclusive:<reason>`.
  `matches-expectation` requires per-axis inspection of all 7 axes per `.claude/skills/dev-workflow/references/final-acceptance-review.md` §PROOF (font size, spacing, ratio, alignment, color, label clarity, glyph rendering); surface-level "visible/clean" verdict without coordinate/proportion/alignment inspection is silent-PASS defect.
  `matches-expectation` proves only the captured visual state.
  Dynamic behavior still requires the relevant Evidence-Quality Matrix row plus executed user action and retained postcondition evidence.
  Cite-path-only or capture-without-open on AC-supporting evidence is procedural failure.
  Deviation entries block PASS or route to `OPEN-SURFACES`.
  Routine baseline captures that neither support a verdict nor evidence a defect cite path-only without per-image verdict.

Report decisive user-surface work with the concrete proof method and execution evidence actually used.
Completion reporting requires requested content, functions, format, user-facing path, reader/operator burden, `CORE-WORKFLOW-CLOSURE` coverage, and acceptance surface to be matched, verified, frozen-narrowed, or frozen-deferred.
Anchoring on the implemented subset instead of the frozen `CORE-WORKFLOW-CLOSURE` coverage is procedural failure.
Executable completion reporting requires the exact operator launch artifact plus invocation evidence, stop/cleanup path, clean re-launch basis, access URL/port when applicable, and project-artifact hygiene status.
`ACTIVE-SLICE` evidence becomes phase, MVP, release, or workflow completion only after reconciliation against `SCOPE-BASELINE`.
Missing, placeholder-only, unimplemented, or unproven baseline items remain `OPEN-SURFACES`.

## Common Lane Handoff Law
- Every agent handoff is an upward lane report, not a replacement for the frozen global plan.
- Report only lane-local execution truth: the surface actually examined or changed, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane/action recommendation.
- Verdict or `PASS` language remains scoped to the reported lane evidence; wider acceptance, route closure, and broader user-surface proof require team-lead synthesis and the owning acceptance route.
- Handoff exposes quality-relevant open surfaces clearly enough that the downstream owner can act without rediscovery.
- `LANE-NEXT-CANDIDATE` narrows the plausible next owner/action enough for team-lead to choose redispatch, verification, acceptance, correction, blocker-clear, or `HOLD` without lane-local rediscovery; routing freeze and independent-owner preservation remain team-lead-owned.
- Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain routes to `scope-pressure` or `hold|blocker`.
- Pending required procedure state routes to `MESSAGE-CLASS: hold|blocker`.

## Resolve Next Owner And Action
- Converged completion-grade handoff opens team-lead synthesis.
- Open surfaces route to corrected lane packet, proof owner, validation owner, lifecycle owner, or `work-planning` when boundary axes move.
- Missing common result spine opens same-lane handoff correction.
- Missing user-surface proof opens tester or proof-owner routing.
- Missing final acceptance basis opens validator routing.
- Lifecycle debt opens lifecycle control.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain opens `scope-pressure` or `hold|blocker`.
