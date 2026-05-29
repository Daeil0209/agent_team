---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Completion
## Contents
- Common Completion Result Spine
- Common Lane Completion Law
- Resolve Next Owner And Action

## Common Completion Result Spine
This spine names content that the producing lane must provide to team-lead through a retained carrier.
`completion` is Communication Plane transport; user-facing admission is owned by `.claude/reference/reporting-prohibition-law.md`.
For team-agent runtime, the screen-rendered `SendMessage` header/preview is one state signal, not the completion spine.
State signal text and envelope shape are owned by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
The retained carrier is part of Communication Plane payload and carries the completion spine for team-lead synthesis.

Required completion payload fields for every completion-grade `MESSAGE-CLASS: completion`:
- `OUTPUT-SURFACE`
- `TARGET-INTENT-BASIS`
- `UPSTREAM-DECISION-BASIS-CONSUMPTION`
- `EVIDENCE-BASIS`
- `VERIFIED-DATA-FEEDBACK`
- `OPEN-SURFACES`
- `FROZEN-CONTRACT-STATUS`
- `SCOPE-COVERAGE` records covered `SCOPE-BASELINE` rows, actual `ACTIVE-SLICE`, carried `DEFERRED-SURFACES`, and open baseline rows. `SCOPE-COVERAGE` is the lane-side per-completion-carrier field. The team-lead multi-wave aggregation state (`SCOPE-BASELINE union state` per `.claude/skills/work-planning/references/planning-record-fields.md`) is a distinct field owned by team-lead at synthesis time; both reference the frozen `SCOPE-BASELINE` but serve different owners and timings.
- `LANE-NEXT-CANDIDATE`
- `PLANNING-BASIS: loaded`
- `SKILL-FIELD-CONSUMPTION` records each non-empty, material, invalid, or blocked `REQUIRED-SKILLS` entry as `applied` or `blocked:<basis>` and every carried `SKILL-RECOMMENDATIONS` entry as `applied`, `not-material:<basis>`, or `blocked:<basis>`; use `not-applicable:<basis>` only when the packet carried no skill fields and no material skill was discovered during lane work
- `CONVERGENCE-PASS`
- `RESOURCE-CLEANUP`
- `LANE-LOCAL-RESULT-VERIFICATION` — loaded `Skill(self-verification)` convergence state, PASS-1 coverage basis, PASS-2 review-verification packet basis, correction-loop status, and allowed handoff or next action. Verifies producer-owned result truth at the applicable frozen claim strength, including `CLAIM-CEILING` when the packet carries one.

`VERIFIED-DATA-FEEDBACK` records every material returned fact, count, finding, state label, recommendation, or verdict input with its evidence basis and verification state.
Use `not-applicable:<basis>` only when the assignment requested no material returned data and the lane returns no material data.
Unsupported, inferred, stale, memory-only, or uninspected data is not verified feedback; place it in `OPEN-SURFACES`, `scope-pressure`, or `hold|blocker`.

`UPSTREAM-DECISION-BASIS-CONSUMPTION` records each material upstream reviewed, verified, synthesized, validated, rejected, open, blocker, or correction-ready basis consumed, superseded by current basis, blocked, or marked `not-applicable:<basis>`.
Completion without `UPSTREAM-DECISION-BASIS-CONSUMPTION` is not completion-grade when upstream decision basis affected the assignment.

Producers sending `completion` write the receiver-required completion payload to the retained carrier and send only the canonical state signal through `SendMessage` per `message-classes.md` `### Transport Payload`.
Any content added to the rendered `SendMessage` body beyond the canonical state signal is malformed screen-rendered transport.

Team-lead accepts completion-grade transport only when the assignment carrier or retained-carrier registry silently verifies a retained carrier that contains every required completion payload field, including `UPSTREAM-DECISION-BASIS-CONSUMPTION`, `VERIFIED-DATA-FEEDBACK`, and `LANE-LOCAL-RESULT-VERIFICATION`.
Completion-side details stay in retained synthesis state or the next assignment/correction carrier unless reporting law admits exact visible material.
Carrier assertions of verification or PASS-grade evidence in completion handoffs follow the anti-fabrication tool-call-evidence rule at `.claude/skills/self-verification/SKILL.md` `## Step 1` + `## Step 3` and the packet-citation rule at `.claude/skills/review-verification/SKILL.md` `### 14. Next-Owner Routing`.
Team-lead classifies carrier-asserted `PASS-1`, `PASS-2`, `CONVERGENCE-PASS`, `Skill(...) loaded`, `REVIEW-PACKET-CITATION`, or packet-consumption claims without the required actual evidence as `carrier-as-evidence-fabrication`.
Team-lead rejects completion-grade transport when `carrier-as-evidence-fabrication` is present.
Team-lead marks the assigned work non-converged when `carrier-as-evidence-fabrication` is present.
Team-lead routes distinct bounded correction to the producing lane with `INPUT-FINDINGS` naming the carrier defect.
If the retained carrier or any required completion payload field is missing, team-lead routes correction to the producer when the producer lane remains the truthful correction owner; otherwise team-lead routes `Skill(governance-modification)` cleanup.

Team-lead `Skill(self-verification)` convergence remains separate from lane completion.
Team-lead synthesizes only completion-grade lane outputs, then loads and learns `Skill(self-verification)` for convergence on the synthesized work-product surface set and outgoing claim before user-facing consequential reporting, completion claim, or redispatch.

For team-agent runtime, the transport is completion-grade only when delivered to `team-lead` by `SendMessage` with the required `MESSAGE-CLASS`.
Plain-text agent output is production evidence only until carried through that channel.
When the assigned output is a synthesis, audit, evidence pack, generated artifact, or project-output surface, the completion cites the frozen `RETAINED-OUTPUT-PATH` under the canonical output root from `.claude/reference/environment-output-root-filesystem-law.md` (default `claude_doc/<work-name>/`).
When artifacts, logs, screenshots, traces, reports, or datasets support `EVIDENCE-BASIS`, the completion must cite a retained path inside the frozen output root. When the cited evidence includes screenshot or full-page image files for user-facing rendered surfaces, the producing lane opens each image directly via the multimodal `Read` tool and confirms the rendered surface matches the claimed verdict; the receiving lane (reviewer/validator/team-lead synthesis) opens the same image files independently before accepting the claim.
`/tmp`, shell scrollback, transient pane output, and deleted scratch files are execution context only, not retained evidence.
Conversation-only output is valid only when the packet names conversation as the output surface.

`TARGET-INTENT-BASIS` names the governance, program, report, document, review, proof, or validation purpose that controlled the work.
Use `INFERENCE` only when reconstructed safely from request, plan, design, Structural Contract, cited artifact, or frozen scope without inventing scope, closure rows, disposition paths, consumer/recompute paths, source authority, display-only basis, or acceptance oracle.
Use concrete task, artifact, expectation, evidence, and next-owner wording.
Common finding basis:
- Evidence-only observations stay as anchors or `OPEN-SURFACES`.
- Finding outputs use the state ladder from `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`: `candidate-evidence`, `candidate-classified`, `confirmed-defect`, `patch-worthy`, `patch-ready`, or `rejected:<basis>`.
- Raw finding counts, repeated or similar labels, same words on different classification axes, multi-lane convergence, and candidate lists are evidence only; they are not conflict, severity, priority, patch-worthiness, or confirmed-defect proof.
- Raw candidate counts stay separate from confirmed-defect counts, patch-worthy counts, patch-ready counts, rejected counts, and open-candidate counts.
- Researcher outputs supply evidence and candidate classifications only unless a downstream review owner reclassifies them through this basis.
- Bare `CONFIRMED` is not a valid finding state; use the exact ladder state supported by evidence.
- A patchable finding states `TARGET-INTENT-BASIS`, evidence class when material, protected function, user-outcome impact, `patch-worthiness`, regression risk, and the tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue` classifications.
- A governance, process, analysis, critique, review, or validation finding whose truth depends on user/team/design meaning also states `SEMANTIC-INTENT-BASIS`; without it the finding stays evidence-only or `OPEN-SURFACES`.
- Quality, evidence, independent review, proof, validation, Codex independent review, and Final Acceptance Review (FAR) gates are protected functions; deletion, non-enforcement, hook silence, runtime omission, cost, latency, repetition, or ceremony is evidence only until the common finding basis proves `confirmed-defect`.
- `patch-worthy` or `patch-ready` is the finding-state ladder authority for patch dispatch.
- `PATCH-URGENCY: must-fix|narrow-fix` is a dispatch-priority subfield only after `patch-worthy` or `patch-ready` is proven.
- Patch dispatch also requires proof that correction will not remove a stronger protected function.
- `PATCH-DISPOSITION: observe|no-patch` stays retained context and does not dispatch mutation.
- Common finding-class taxonomy is shared by reviewer, review-verification, and validator-input findings:
  - `candidate-evidence`: observed evidence without defect authority.
  - `candidate-classified`: candidate evidence mapped to proposed class, severity, owner, and inspected source surface without defect authority.
  - `confirmed-defect`: live evidence proves design-intent conflict, negative operating effect, causal path, correction owner, and no stronger protected-function loss from correction.
  - `patch-worthy`: `confirmed-defect` plus protected-function preservation, user-outcome impact, regression-risk basis, smallest owner, selected operation type, and rejected non-defect alternatives.
  - `patch-ready`: `patch-worthy` plus patch-owner surface, edit operation, source meaning, destination owner when moved, direct-consumption relevance, and verification basis.
  - `risk-hypothesis`: plausible risk lacks enough proof for patch dispatch.
  - `design-tradeoff`: intentional protection with a cost.
  - `duplication`: repeated meaning without protected local-restatement basis, after proving correction will not remove a stronger protected function.
  - `protected-restatement`: repeated meaning with a named owner and direct-consumption or isolation-safety basis.
  - `non-issue`: evidence disproves the concern.
  - `unverified`: evidence basis incomplete.
  - `rejected:<basis>`: umbrella state for `protected-restatement`, `design-tradeoff`, `non-issue`, `risk-hypothesis`, `unverified`, or `not-material:<basis>` when filtering rejects promotion.

`RESOURCE-CLEANUP` records whether long-running spawned resources opened during lane work were closed at completion.
Long-running resources include Playwright MCP browser sessions, dev servers, daemons, dev-runners, codex CLI background process (`codex exec` invoked via `Bash` with `run_in_background: true`; cleanup covers process termination AND output files such as logs, JSON results, or scratch artifacts produced by the codex run), and other port-bound or session-bound processes.
Transient short-lived invocations are not long-running resources for this field.
Examples of transient invocations are one-off linter, single-pass test harness, and fixture file already removed.
- `RESOURCE-CLEANUP: complete` requires explicit enumeration of every long-running resource actually killed (server PID + port, daemon PID, or dev-runner PID) plus a post-cleanup verification that ports and resources are released.
- `RESOURCE-CLEANUP: not-applicable (no long-running resource opened)` is allowed only when the lane invoked no long-running spawn; transient invocations record `not-applicable` truthfully.
- Leaving any long-running spawned process at completion is a `RESOURCE-CLEANUP` defect; team-lead rejects completion-grade transports that misuse `not-applicable` to cover an unkilled long-running resource or a bare `complete` without enumeration and post-cleanup probe.

Lane docs require bounded additions only when they preserve this common result spine.
Completion names selected methodology or capability skills, material direct references applied or blocked, material tool/proof capability used or blocked, and work-surface basis.
Completion without `VERIFIED-DATA-FEEDBACK` is not completion-grade when the assignment requested or the lane returns material facts, counts, findings, state labels, recommendations, or verdict inputs.
Completion without `SKILL-FIELD-CONSUMPTION` is not completion-grade when the assignment packet carried non-empty `REQUIRED-SKILLS`, any `SKILL-RECOMMENDATIONS`, or any invalid, blocked, or material skill-field entry.
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
Team-lead consumes the retained carrier for synthesis, routing, validation, correction, reuse, shutdown, or closeout; completion-status visibility is controlled by `.claude/reference/reporting-prohibition-law.md`.
Correction dispatch follows `OPEN-SURFACES`, `LANE-NEXT-CANDIDATE`, or the validator correction packet.
Re-dispatch the producer for producer-owned correction.
Reuse sends another assignment-grade packet.
Shutdown sends `shutdown_request` when validator `PASS` or workflow `FINAL-ACCEPT` closes the lane surface, a user-accepted or originally frozen out-of-scope basis excludes the lane surface, or closeout owns the path.
Wait for confirmed termination evidence on shutdowns.

User-surface proof or user-surface acceptance claims on an executed surface require the completion-grade transport to keep the exercised method explicit.
The method record covers:
- `USER-RUN-PATH` and `RUN-PATH-STATUS` when the deliverable is executable user-facing
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`
- `OPERATOR-NAIVE-COMPREHENSION-AUDIT` and `IMAGE-INSPECTION-RECORD` for completions whose user-decisive surface is operator-facing rendered UI (browser, dashboard, slide deck, dense table, runtime UI, or other operator-consumed visual surface where reader-visible usefulness is part of acceptance) — field schemas, verdict types, and inspection requirements live at `.claude/skills/dev-workflow/references/phase-surfaces.md` `## Phase 4 Analysis And Acceptance` `Rendered Image Evidence Rule` `Completion-spine fields driven by Rendered Image Evidence Rule` block.

Report decisive user-surface work with the concrete proof method and execution evidence actually used.
Completion-grade transport states whether requested content, functions, format, user-facing path, reader/operator burden, applicable `CORE-WORKFLOW-CLOSURE` rows, and acceptance surface are matched, verified, `not-applicable:<basis>`, explicitly user-accepted as out-of-scope, lawfully owner-deferred through upstream record, or open/blocked in `OPEN-SURFACES` or `HOLD`.
Anchoring on the implemented subset instead of the applicable frozen `CORE-WORKFLOW-CLOSURE` coverage is procedural failure.
Executable completion-grade transport requires the exact operator launch artifact plus invocation evidence, stop/cleanup path, clean re-launch basis, access URL/port when applicable, and project-artifact hygiene status.
`ACTIVE-SLICE` evidence becomes phase, MVP, release, or workflow completion only after reconciliation against `SCOPE-BASELINE`.
Missing, placeholder-only, unimplemented, or unproven baseline items remain `OPEN-SURFACES`.

## Common Lane Completion Law
- Every agent completion is upward Communication Plane transport; user-facing admission is owned by `.claude/reference/reporting-prohibition-law.md`.
- Every agent completion goes to `team-lead` through completion-class `SendMessage` transport; rendered envelope stays no-detail and completion fields live in the retained carrier.
- Every agent completion also provides the retained carrier containing the common completion spine.
- Completion is not valid when either the retained carrier or the `SendMessage` completion state signal is missing.
- The `SendMessage` structured payload transports only one state signal; lane-local execution truth travels in the retained carrier.
- When the runtime displays a completion state signal, keep it in the canonical structured `state_signal` payload; do not add `summary`, string body text, or prose.
- Include only the canonical structured state signal in the `SendMessage` render per `message-classes.md` `### Transport Payload`.
- Transport only lane-local result truth in the retained carrier: the surface actually examined or changed, `UPSTREAM-DECISION-BASIS-CONSUMPTION`, `SCOPE-COVERAGE`, `VERIFIED-DATA-FEEDBACK`, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane/action recommendation.
- Missing `SCOPE-COVERAGE` makes the completion spine incomplete when the lane output can affect completion, review, proof, validation, governance judgment, defect audit, or patch selection.
- Wave, sample, priority-tier, or representative-slice completion stays scoped to `ACTIVE-SLICE`; full-scope completion, validation, promotion, rejection, or patch selection requires `SCOPE-COVERAGE` over the frozen `SCOPE-BASELINE`.
- Verdict or `PASS` language remains scoped to the transported lane evidence; wider acceptance, route closure, and broader user-surface proof require team-lead synthesis and the owning acceptance route.
- Completion exposes quality-relevant open surfaces clearly enough that the downstream owner can act without rediscovery.
- `LANE-NEXT-CANDIDATE` narrows the plausible next owner/action enough for team-lead to choose redispatch, verification, acceptance, correction, blocker-clear, or `HOLD` without lane-local rediscovery; routing freeze and independent-owner preservation remain team-lead-owned.
- Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- Team-lead's completion-side visible emission after receiving this transport is admitted only through `.claude/reference/reporting-prohibition-law.md`.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain routes to `scope-pressure` or `hold|blocker`.
- Pending required procedure state routes to hold|blocker-class transport with blocker fields in the governed carrier.

## Resolve Next Owner And Action
- Converged completion-grade output opens team-lead synthesis.
- Open surfaces route to corrected lane packet, proof owner, validation owner, cleanup owner, or `work-planning` when boundary axes move.
- Missing common result spine opens same-lane completion correction.
- Missing user-surface proof opens tester or proof-owner routing.
- Missing final acceptance basis opens validator routing.
- Changed owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain opens `scope-pressure` or `hold|blocker`.
