---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# task-execution: Completion
## Contents
- Common Completion Result Spine
- Common Lane Completion Law
- Resolve Next Owner And Action

## Common Completion Result Spine
This spine names content that the producing lane must provide to team-lead through a retained carrier.
`completion` is Communication Plane transport, not a user report.
For team-agent runtime, the screen-rendered `SendMessage` header/preview is one state signal, not the completion spine.
The state signal is `completion task <TASK-ID>` when task tracking is active, otherwise `completion`.
The `SendMessage` message/body slots are blank or whitespace-only.
The retained carrier is part of Communication Plane payload and carries the completion spine for team-lead synthesis.

Required completion payload fields for every completion-grade `MESSAGE-CLASS: completion`:
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
- `PRODUCER-SELF-REVIEW-PASS` records:
  - defeater lenses applied
  - disconfirming checks attempted
  - defects found and fixed by the producer in-pass
  - final-pass convergence: last pass found no producer-owned defect, or remaining items routed to `OPEN-SURFACES` / `scope-pressure` / `hold|blocker`.
  - Producer self-review is defect-seeking review, not self-approval.
- `LANE-LOCAL-SV-RESULT` — `self-verification` mode, verified surface, verification basis, claim strength, allowed next action. Verifies producer execution truth only.

Producers sending `completion` write the receiver-required completion payload to the retained carrier and send only the host-visible header/preview state signal through `SendMessage`.
Inline completion payload or report text in the `SendMessage` message/body slots is malformed screen-rendered transport.
After the state signal is sent, the producing lane immediately closes the same assigned task row with `TaskUpdate(status: completed)` when task tracking is active.
That task-state mutation is internal runtime closure; it is not user reporting and carries no completion narrative.

Team-lead accepts completion-grade transport only when the assignment, task state, or retained-carrier registry silently verifies a retained carrier that contains both required blocks; missing retained carrier or missing block returns to the producer through correction only when the producer still has an open executable task, otherwise routes to self-growth cleanup.

Lane completion transports lane-local convergence only and claims no team-lead `SV-RESULT`.
Team-lead synthesizes only completion-grade lane outputs, then runs `SV-RESULT` on the exact synthesized outgoing claim before user-facing consequential reporting, completion claim, or redispatch.

For team-agent runtime, the transport is completion-grade only when delivered to `team-lead` by `SendMessage` with the required `MESSAGE-CLASS`.
Plain-text agent output is production evidence only until carried through that channel.
When the assigned output is a synthesis, audit, evidence pack, generated artifact, or project-output surface, the completion cites the frozen `RETAINED-OUTPUT-PATH` under the canonical output root from `.claude/reference/output-root-and-filesystem-law.md` (default `claude_doc/<work-name>/`).
When artifacts, logs, screenshots, traces, reports, or datasets support `EVIDENCE-BASIS`, the completion must cite a retained path inside the frozen output root. When the cited evidence includes screenshot or full-page image files for user-facing rendered surfaces, the producing lane opens each image directly via the multimodal `Read` tool and confirms the rendered surface matches the claimed verdict; the receiving lane (reviewer/validator/team-lead synthesis) opens the same image files independently before accepting the claim.
`/tmp`, shell scrollback, transient pane output, and deleted scratch files are execution context only, not retained evidence.
Conversation-only output is valid only when the packet names conversation as the output surface.

`TARGET-INTENT-BASIS` names the governance, program, report, document, review, proof, or validation purpose that controlled the work.
Use `INFERENCE` only when reconstructed safely from request, plan, design, Structural Contract, cited artifact, or frozen scope without inventing scope, closure rows, disposition paths, consumer/recompute paths, source authority, display-only basis, or acceptance oracle.
Use concrete task, artifact, expectation, evidence, and next-owner wording.
Common finding basis:
- Evidence-only observations stay as anchors or `OPEN-SURFACES`.
- Raw finding counts, repeated or similar labels, same words on different classification axes, multi-lane convergence, and candidate lists are evidence only; they are not conflict, severity, priority, patch-worthiness, or confirmed-defect proof.
- Researcher outputs supply evidence and candidate classifications only unless a downstream review owner reclassifies them through this basis.
- A patchable finding states `TARGET-INTENT-BASIS`, evidence class when material, protected function, user-outcome impact, `patch-worthiness`, regression risk, and the tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue` classifications.
- A governance, process, analysis, critique, review, or validation finding whose truth depends on user/team/design meaning also states `SEMANTIC-INTENT-BASIS`; without it the finding stays evidence-only or `OPEN-SURFACES`.
- Quality, evidence, independent review, proof, validation, Codex independent review, and FAR gates are protected functions; deletion, non-enforcement, hook silence, runtime omission, cost, latency, repetition, or ceremony is evidence only until the common finding basis proves `confirmed-defect`.
- Only `patch-worthiness: must-fix|narrow-fix` with proof that correction will not remove a stronger protected function is patch-dispatch basis; `observe|no-patch` stays retained context.
- Common finding-class taxonomy is shared by reviewer, review-verification, and validator-input findings:
  - `confirmed-defect`: live evidence proves design-intent conflict, negative operating effect, causal path, correction owner, and no stronger protected-function loss from correction.
  - `risk-hypothesis`: plausible risk lacks enough proof for patch dispatch.
  - `design-tradeoff`: intentional protection with a cost.
  - `duplication`: repeated meaning without protected local-restatement basis, after proving correction will not remove a stronger protected function.
  - `protected-restatement`: repeated meaning with a named owner and direct-consumption or isolation-safety basis.
  - `non-issue`: evidence disproves the concern.
  - `unverified`: evidence basis incomplete.

`RESOURCE-CLEANUP` records whether long-running spawned resources opened during lane work were closed at completion.
Long-running resources include Playwright MCP browser sessions, dev servers, daemons, dev-runners, and other port-bound or session-bound processes.
Transient short-lived invocations are not long-running resources for this field.
Examples of transient invocations are one-off linter, single-pass test harness, and fixture file already removed.
- `RESOURCE-CLEANUP: complete` requires explicit enumeration of every long-running resource actually killed (server PID + port, daemon PID, or dev-runner PID) plus a post-cleanup verification that ports and resources are released.
- `RESOURCE-CLEANUP: not-applicable (no long-running resource opened)` is allowed only when the lane invoked no long-running spawn; transient invocations record `not-applicable` truthfully.
- Leaving any long-running spawned process at completion is a `RESOURCE-CLEANUP` defect; team-lead rejects completion-grade transports that misuse `not-applicable` to cover an unkilled long-running resource or a bare `complete` without enumeration and post-cleanup probe.

Lane docs require bounded additions only when they preserve this common result spine.
Completion names selected methodology or capability skills, material direct references applied or blocked, material tool/proof capability used or blocked, and work-surface basis.
If a material specialist skill, direct reference, or decisive tool was omitted, unavailable, or only named without shaping the work, the gap stays in `OPEN-SURFACES` or routes through `scope-pressure` / `hold|blocker` instead of completion-ready transport.
Team-lead reviews that basis against the completed work and sends correction to the owning lane when direction drifts.
When material, `EVIDENCE-BASIS` names the Evidence-Quality Matrix rows supporting the completion claim.
`FROZEN-CONTRACT-STATUS` must be one of `matched`, `partial`, `drifted`, `blocked`, `not-assessable`, or `not-applicable:<basis>`. It compares the lane's evidence against the frozen assigned contract, not just the changed artifact or executed route.
When material, `FROZEN-CONTRACT-STATUS` names the Receiver-Surface Contract, Consumption Chain, or Boundary Register basis that the lane matched, narrowed, or left open.
The common end closure contract reconciles the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md` against this result spine.
Each material start-contract axis closes through matched evidence, upstream defer basis, `not-applicable:<basis>`, or an `OPEN-SURFACES` item.
Use `matched` only when the supporting spine fields or lane-specific status fields show the axis outcome.
When the user-ready delivery chain is material, `matched` requires traceable continuity from instruction through concept/detail, implementation or production surface, verification evidence, and final receiver path.
Working features with disconnected information, hidden assumptions, orphaned components, or implausible receiver flow are not closed-result evidence.
The completion transport closes the assignment execution block and records `STANDBY`.
Team-lead consumes the retained carrier for synthesis, routing, validation, correction, reuse, shutdown, or closeout.
Correction dispatch follows `OPEN-SURFACES`, `LANE-NEXT-CANDIDATE`, or the validator correction packet.
Re-dispatch the producer for producer-owned correction.
Reuse sends another assignment-grade packet.
Shutdown sends `shutdown_request` when validation ACCEPT is recorded, the surface is out of the frozen plan, or closeout owns the path.
Wait for confirmed termination evidence on shutdowns.

User-surface proof or user-surface acceptance claims on an executed surface require the completion-grade transport to keep the exercised method explicit.
The method record covers:
- `USER-RUN-PATH` and `RUN-PATH-STATUS` when the deliverable is executable user-facing
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`
- `OPERATOR-NAIVE-COMPREHENSION-AUDIT` for any completion whose surface includes rendered UI.
  Report a first-time-user walkthrough verdict per AC-supporting surface element (labels, controls, data displays, charts, gauges that bear acceptance weight).
  Each verdict is `clear`, `partially-clear:<reason>`, or `unclear:<reason>`.
  Items rated `unclear` block PASS or route to `OPEN-SURFACES` with the responsible owner.
  Minor non-AC labels appear as a single `routine: clear` summary unless a defect is observed.
- `IMAGE-INSPECTION-RECORD` for any completion whose surface includes rendered UI.
  List each screenshot or full-page image cited in support of an AC verdict, FAR claim, or visual-conformance assertion.
  Cite the design-stated expectation each image proves.
  State the per-image visual verdict after opening the image directly via the multimodal `Read` tool.
  Each verdict is `matches-expectation`, `deviates:<concrete deviation>`, or `inconclusive:<reason>`.
  `matches-expectation` requires direct inspection of the frozen visual expectations. Default rendered-UI axes are font size, spacing, ratio, alignment, color, label clarity, and glyph rendering; consume `.claude/skills/dev-workflow/references/final-acceptance-review.md` only when the active route is `dev-workflow`.
  `matches-expectation` proves only the captured visual state.
  Dynamic behavior still requires the relevant Evidence-Quality Matrix row plus executed user action and retained postcondition evidence.
  Cite-path-only or capture-without-open on AC-supporting evidence is procedural failure.
  Deviation entries block PASS or route to `OPEN-SURFACES`.
  Routine baseline captures that neither support a verdict nor evidence a defect cite path-only without per-image verdict.

Report decisive user-surface work with the concrete proof method and execution evidence actually used.
Completion-grade transport requires requested content, functions, format, user-facing path, reader/operator burden, `CORE-WORKFLOW-CLOSURE` coverage, and acceptance surface to be matched, verified, frozen-narrowed, or frozen-deferred.
Anchoring on the implemented subset instead of the frozen `CORE-WORKFLOW-CLOSURE` coverage is procedural failure.
Executable completion-grade transport requires the exact operator launch artifact plus invocation evidence, stop/cleanup path, clean re-launch basis, access URL/port when applicable, and project-artifact hygiene status.
`ACTIVE-SLICE` evidence becomes phase, MVP, release, or workflow completion only after reconciliation against `SCOPE-BASELINE`.
Missing, placeholder-only, unimplemented, or unproven baseline items remain `OPEN-SURFACES`.

## Common Lane Completion Law
- Every agent completion is upward Communication Plane transport, not a user report and not a replacement for the frozen global plan.
- The `SendMessage` render transports only one state signal; lane-local execution truth travels in the retained carrier.
- Do not repeat the state signal across header/preview/body.
- Do not inline files-read counts, findings counts, per-class totals, excerpts, evidence summaries, operational notes, path-substitution rationale, completion narrative, or retained-output contents in the `SendMessage` render.
- Transport only lane-local execution truth in the retained carrier: the surface actually examined or changed, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane/action recommendation.
- Verdict or `PASS` language remains scoped to the transported lane evidence; wider acceptance, route closure, and broader user-surface proof require team-lead synthesis and the owning acceptance route.
- Completion exposes quality-relevant open surfaces clearly enough that the downstream owner can act without rediscovery.
- `LANE-NEXT-CANDIDATE` narrows the plausible next owner/action enough for team-lead to choose redispatch, verification, acceptance, correction, blocker-clear, or `HOLD` without lane-local rediscovery; routing freeze and independent-owner preservation remain team-lead-owned.
- Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain routes to `scope-pressure` or `hold|blocker`.
- Pending required procedure state routes to `MESSAGE-CLASS: hold|blocker`.

## Resolve Next Owner And Action
- Converged completion-grade output opens team-lead synthesis.
- Open surfaces route to corrected lane packet, proof owner, validation owner, cleanup owner, or `work-planning` when boundary axes move.
- Missing common result spine opens same-lane completion correction.
- Missing user-surface proof opens tester or proof-owner routing.
- Missing final acceptance basis opens validator routing.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain opens `scope-pressure` or `hold|blocker`.
