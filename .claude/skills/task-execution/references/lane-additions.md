---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---

# task-execution: Lane-Specific Additions
## Common Lane-Core Preconditions
Every agent-specific skill inherits these common preconditions:
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md`.
- Producer self-review means the assigned lane's defect-seeking check of its own lane-owned output before completion; it is not acceptance, validation, or permission to skip independent owners.
- For non-developer lanes, producer self-review applies only to the lane-owned report, proof, verdict, evidence carrier, or review output and routes discovered out-of-lane defects to the owning path.
- Classify receipt against the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Receive the agent-facing packet, not the full internal planning record.
- Fresh assignment-grade receipt has a mandatory first upward outcome before first lane work.
- `dispatch-ack` is valid only after packet review confirms no objection to starting the assigned work.
- Upward outcome envelope shape governed by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
- Lane upward `SendMessage` sets top-level `to: team-lead`.
- A recipient named only in visible text, `summary`, `message`, or packet fields does not satisfy the tool envelope.
- Missing `SendMessage.to` is an envelope defect, not a compliance retry loop.
- Before any `MESSAGE-CLASS: dispatch-ack` or `MESSAGE-CLASS: completion` `SendMessage`, the producing lane verifies the render matches the canonical state-signal envelope owned by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`; mismatch (extra wording in `summary`; any body content beyond empty or single ASCII space) is a producer self-review defect that blocks the `SendMessage` and routes to packet-correction.
- Use `scope-pressure` or `hold|blocker` instead of `dispatch-ack` when the lane cannot truthfully start the assigned work as written.
- A hook block that enforces positive-pattern, doctrine-shape, or compliance-field presence (not destructive, security-critical, or session-stability-breaking per `.claude/reference/work-runtime-boundary-law.md` `## Runtime Boundary Rules`) is an over-broad-blocking defect per `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`; the lane sends `scope-pressure` to team-lead naming the hook surface and the exact block message, and does not strain its own compliance to satisfy the block.
- Converged lane work must hand off to `team-lead` through `.claude/skills/task-execution/references/completion-handoff.md`.
- The handoff requires both the retained carrier containing the common completion spine and `MESSAGE-CLASS: completion` sent to `team-lead` through `SendMessage`.
- Disk output, pane/final prose, `status`, and `TaskUpdate` do not replace the required completion handoff.
- Completion-grade `completion` envelope shape governed by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
- Immediately call `TaskUpdate(status: completed)` for the same assigned task when task tracking is active after `completion`.
- After `completion`, same `TASK-ID` replay is closed-work replay and the lane sends no further message for that work.
- This duty is lane-baseline; packet wording does not need to request it.
- For lane work that touches governance assets (`.claude/` doctrine, agents, skills, settings, hooks, or live-surface mirrors), the lane-side quality contract is the trio plus the operator-emphasized keyword self-check.
- Trio member 1: `Skill(governance-modification)` patch mechanics.
- Trio member 2: lane-local `Skill(self-verification)` produced result truth.
- Trio member 3: consume `Skill(review-verification)` named lenses `removal-first-lens`, `coherence-integrity-lens`, `minimum-executable-information-lens`, `negative-risk-lens`, and `patch-worthiness-lens` on the proposed patch before mutation.
- The lane adds `governance-continuity-lens` before mutation when the proposed patch can change top-doctrine intent, mapped core-law executable detail, or trigger-bound owner-reference guidance.
- Post-execute lane-local `Skill(self-verification)` may recheck the applied diff but does not satisfy the pre-mutation `Skill(review-verification)` gate.
- Operator-emphasized keyword self-check applies per `.claude/CLAUDE.md` `## 5. Modification Philosophy`.
- Operator-emphasized keyword self-check covers under-specification, over-specification, evasion, ambiguity, semantic conflict, bottleneck burden, and over-broad blocking.
- A candidate patch failing any keyword check is rejected before mutation.
- Lane direct-execution drive (`Edit`/`MultiEdit`/`Write`/`Bash`/`SendMessage`) does not decay between consecutive bounded lane actions inside the assigned packet boundary per `.claude/reference/work-execution-core-law.md` `[AUTO-PROC]`.
- Lane continues to the next executable lane action in the same turn until completion, blocker, or scope-pressure.
- Bare lane-local `Skill(self-verification)` without `Skill(review-verification)` named-lens consumption is insufficient quality guarantee for governance asset changes; lane completion in that state is a quality-contract defect that returns to lane lens supplementation.
- When the assignment packet's completion contract or upward-message instructions direct the lane to place retained-output paths, retained-output contents, INSPECTION-COVERAGE, OPEN-SURFACES, file or findings counts, excerpts, summaries, operational notes, or any field other than the canonical state signal in the upward `SendMessage` render, the lane sends `scope-pressure` with `PRESSURE-TYPE: malformed-completion-contract` and `CORRECTION-OUTCOME: packet-correction` and does not obey the malformed instruction. Envelope canonical: `message-classes.md` `### Transport Payload`.
- Agent spawn success, visible `working`, visible pane/final text, tool output, skill loading, status, or later completion never satisfies receipt.
- Receipt event content, post-ACK continuation, one-execution-block discipline, and pane-prose suppression follow `message-classes.md` Receipt Event Contract and Communication Integrity.
- Execution-block internals (skill-loading, corpus enumeration, file-read plan, retained-output path planning, evidence strategy, next action, progress notes) stay inside the block.
- Every upward message follows `.claude/skills/task-execution/references/message-classes.md` Communication Plane Law.
- Carry receiver-required detail through governed Communication Plane payload; use retained-output or task carriers only for size, evidence retention, or reuse.
- Never use report suppression or visible-row hygiene to omit, distort, or weaken assignment facts.
- Preserve the following in governed carriers when material: exact request intent, target intent, acceptance basis, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action.
- Load and apply duties remain internal unless a receiver-owned packet, blocker, or completion field requires them.
- When lane work names candidates, findings, defects, removal, patch-worthiness, patch readiness, or issue counts, consume `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` and `.claude/skills/task-execution/references/completion-handoff.md` `Common finding basis` before classifying or completing the output.
- Lane outputs may maximize candidate recall, but they preserve `candidate-evidence` or `candidate-classified` state until the assigned lane has authority and evidence to promote the item.
- Lane outputs do not report raw candidate volume as confirmed defect volume.
- Lane outputs use `confirmed-defect`, `patch-worthy`, or `patch-ready` only when the consumed promotion basis proves that exact state.
- This finding-state duty is lane-baseline; packet wording does not need to request it.
- Receipt is not permission to execute a defective packet; classify in the same turn, then execute, reconstruct safely, or send a separate `scope-pressure` / `hold|blocker`.
- Continue into lane work after receipt.
- Packet intake classifies into one of 4 states: `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker`.
- `execute` admits when packet bounds (owner, phase, proof, acceptance, deliverable) are unambiguous for the lane's work.
- `reconstruct-with-inference` admits only when inferred surface preserves the common boundary axes (owner, phase, proof, acceptance, deliverable) plus the lane-specific axes named in the lane's `agent-<lane>/SKILL.md`.
- `scope-pressure` routes mixed-phase, wrong-owner, shardable overload, or hidden-prerequisite packets.
- `hold|blocker` routes materially ambiguous decisive basis or non-derivable missing fields.
- Silence when assigned specialist-surface structure is weak is a lane failure.
- The lane surfaces the gap to team-lead through Communication Plane.
- A retry is materially changed when evidence basis, blocker route, or fix/strategy/scope changes.
- A retry with no material change is a materially similar retry.
- Do not repeat a materially similar retry.
- Preserve global routing, staffing, and acceptance ownership from packet basis.
- If frozen host-authorized parallel-agent work collapses multiple independent surfaces onto one lane, send `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `CORRECTION-OUTCOME: route-replan`.
- Reconcile completion-grade output against the common end closure contract in `.claude/skills/task-execution/references/completion-handoff.md`.
- Before completion, run lane-local `Skill(self-verification)` result verification.
- For AC-supporting rendered evidence, open every cited screenshot or full-page capture directly via the multimodal `Read` tool before claiming the rendered surface; cite-path-only or capture-without-open on AC-supporting evidence proves nothing about the rendered surface. Routine non-AC baseline captures stay cite-only when they neither support a verdict nor evidence a defect.
- Lane-local `Skill(self-verification)` result verification verifies producer execution truth only.
- Team-lead owns synthesis `Skill(self-verification)` result verification.
- Consume the agent-specific skill only for consequential lane-owned work.
- Receipt, status, shutdown, phase, or clarification messages do not activate it unless they assign or reopen work.
- Once consumed, the agent-specific skill outranks packet capability skills inside the lane.
- Run capability fit through these axes:
  - `SEMANTIC-INTENT-BASIS`
  - `COMPLETION-STOP-CONDITION`
  - `DERIVED-DEFAULTS`
  - `TARGET-INTENT-BASIS` per `[DESIGN-INTENT]`
  - assigned surface
  - `CLAIM-CEILING`
  - common finding basis for critique/removal/patch-worthiness
  - skill basis
  - material tool or rendered/runtime needs
- If meaning-dependent work lacks a usable `SEMANTIC-INTENT-BASIS`, treat literal-text execution as unsafe and return `scope-pressure` or `hold|blocker` instead of narrowing the task by local interpretation.
- Every valid `REQUIRED-SKILLS` entry must be loaded and applied before first lane execution; completion must preserve its applied or blocked truth.
- Agent role names are invalid `REQUIRED-SKILLS` entries; agent-specific skills come from the assigned lane, not the packet skill list.
- A blocked required entry sends `scope-pressure` when packet correction or replanning can restore execution.
- A blocked required entry sends `hold|blocker` when truthful execution remains blocked.
- A non-fitting, lane-mismatched, contradictory, or outside-boundary required entry is a packet or route defect.
- A required entry defect is not permission to drop the skill locally.
- `REQUIRED-SKILLS: [review-verification]` is invalid for lane dispatch.
- A lane dispatch that needs `review-verification` names one exact lens from `Skill(review-verification)` `## Named Lane Lens Index`.
- Full `review-verification` workflow routes to `team-lead`.
- A bare full-workflow skill entry is a packet defect when the skill reserves full activation to another owner.
- Every carried `SKILL-RECOMMENDATIONS` entry is classified as applied, not-material, or blocked before completion.
- Use fitting skills and tools as execution lenses inside the assigned lane; naming them without applying them to the work surface is not capability fit.
- When a selected capability skill's `SKILL.md` names a direct reference that owns material method detail for the assigned surface, capability fit includes loading and applying that reference, or marking it `not-material` / blocked with basis.
- During lane work, a newly discovered skill or tool need is lane-local refinement only when it stays inside the same owner, phase, work surface, deliverable shape, proof/acceptance chain, and staffing route.
- Lane-local refinement applies the skill or tool immediately inside that boundary and records the basis in completion.
- A discovered need that changes any boundary above is not local refinement; send `scope-pressure` / `hold|blocker` or require reopened planning.
- If a required skill, decisive tool, rendered/runtime surface, or domain method is missing, unavailable, or outside the packet boundary, send `scope-pressure` / `hold|blocker` with the smallest correcting owner instead of downgrading quality.
- It cannot override `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, or `self-verification`.

## Lane-Specific Additions
The common base packet is extended by lane-specific required fields:
- `developer`: change boundary plus downstream review/proof/acceptance-owner context fields
- `researcher`: question and evidence boundary
- `reviewer`: review boundary plus acceptance-evidence surface
- `tester`: proof and scenario boundary
- `validator`: verdict and expectation boundary

Each lane's agent-specific skill and lane-detail reference own exact assignment additions, lane-specific blocker conditions, and lane-specific completion extras.
They carry direct pointers to common transport and completion law instead of restating the common result spine.
Lane role documents own always-loaded lane identity, boundary, and stop conditions; they are not packet catalogs.

For session-side controlled packet value tables and lane-specific presence hints, see `.claude/skills/team-session-sequences/references/dispatch-packet-compliance.md` for assignment-side values such as `RESEARCH-MODE`, `BENCHMARK-MODE`, `PLAN-STATE`, `ACCEPTANCE-RISK`, `PROOF-OWNER`, `PREREQ-STATE`, `REVIEW-STATE`, and `TEST-STATE`; see `.claude/skills/team-session-sequences/references/upward-handoff.md` for upward lane-owned state such as `VERDICT`. Those reference sections are lookup indexes. `team-session-sequences` owns session-sequence indexes and dispatch-detail lookups, not packet schema or agent-specific additions. Runtime spine stays with `session-boot`, closeout with `session-closeout`, and packet schema with `task-execution`. Hooks guard runtime integrity as last-resort checks; normal agent behavior stays with the owning procedure.

## Resolve Next Owner And Action
- Satisfied common preconditions open lane-owned work.
- Defective receipt opens `scope-pressure` or `hold|blocker`.
- Missing lane-specific additions return to packet correction before dispatch.
- Missing required capability-skill consumption opens capability-skill consumption or `scope-pressure`.
- Boundary-changing discovered skill or tool need opens `scope-pressure`, `hold|blocker`, or `work-planning`.
- Completion-grade lane output opens completion-contract reconciliation.
