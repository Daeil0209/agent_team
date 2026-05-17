---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# task-execution: Lane-Specific Additions
## Common Lane-Core Preconditions
Every agent-specific skill inherits these common preconditions:
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md`.
- Classify receipt against the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Receive the agent-facing packet, not the full internal planning record.
- Fresh assignment-grade receipt has a mandatory first upward outcome before first lane work: one host-visible `SendMessage` header/preview state signal `ack task <TASK-ID>` when task tracking is active, otherwise `ack`; message/body slots stay blank or whitespace-only; use `scope-pressure` / `hold|blocker` when receipt cannot be accepted safely.
- Completion-grade `completion` closes through one host-visible header/preview state signal with blank or whitespace-only message/body slots, then immediate `TaskUpdate(status: completed)` for the same assigned task when task tracking is active.
- After `completion`, same `TASK-ID` replay is closed-work replay and the lane sends no further message for that work.
- This duty is lane-baseline; packet wording does not need to request it.
- Agent spawn success, visible `working`, visible pane/final text, tool output, skill loading, status, or later completion never satisfies receipt.
- Receipt event content, post-ACK continuation, one-execution-block discipline, and pane-prose suppression follow `message-classes.md` Receipt Event Contract and Communication Integrity.
- Execution-block internals (skill-loading, corpus enumeration, file-read plan, retained-output path planning, evidence strategy, next action, progress notes) stay inside the block.
- Every upward message follows `.claude/skills/task-execution/references/message-classes.md` Communication Plane Law.
- Carry receiver-required detail through governed Communication Plane payload; use retained-output or task carriers only for size, evidence retention, or reuse.
- Never use report suppression or visible-row hygiene to omit, distort, or weaken assignment facts.
- Preserve the following in governed carriers when material: exact request intent, target intent, acceptance basis, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action.
- Load and apply duties remain internal unless a receiver-owned packet, blocker, or completion field requires them.
- Receipt is not permission to execute a defective packet; classify in the same turn, then execute, reconstruct safely, or send a separate `scope-pressure` / `hold|blocker`.
- Continue into lane work after receipt.
- Preserve global routing, staffing, and acceptance ownership from packet basis.
- If frozen host-authorized parallel-agent work collapses multiple independent surfaces onto one lane, send `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `CORRECTION-OUTCOME: route-replan`.
- Reconcile completion-grade output against the common end closure contract in `.claude/skills/task-execution/references/completion-handoff.md`.
- Before completion, load `self-verification`.
- Before completion, run lane-local `SV-RESULT`.
- Lane-local `SV-RESULT` verifies producer execution truth only.
- Team-lead owns synthesis `SV-RESULT`.
- Consume the agent-specific skill only for consequential lane-owned work.
- Receipt, status, shutdown, phase, or clarification messages do not activate it unless they assign or reopen work.
- Once consumed, the agent-specific skill outranks packet capability skills inside the lane.
- Run capability fit through these axes:
  - `SEMANTIC-INTENT-BASIS`
  - `TARGET-INTENT-BASIS` per `[DESIGN-INTENT]`
  - assigned surface
  - `CLAIM-CEILING`
  - common finding basis for critique/removal/patch-worthiness
  - skill basis
  - material tool or rendered/runtime needs
- If meaning-dependent work lacks a usable `SEMANTIC-INTENT-BASIS`, treat literal-text execution as unsafe and return `scope-pressure` or `hold|blocker` instead of narrowing the task by local interpretation.
- Every `REQUIRED-SKILLS` entry is mandatory consumption.
- Agent role names are invalid `REQUIRED-SKILLS` entries; agent-specific skills come from the assigned lane, not the packet skill list.
- Load each valid `REQUIRED-SKILLS` entry before lane execution.
- Apply each valid `REQUIRED-SKILLS` entry before lane execution.
- Load each valid `REQUIRED-SKILLS` entry before completion.
- Apply each valid `REQUIRED-SKILLS` entry before completion.
- A blocked required entry sends `scope-pressure` when packet correction or replanning can restore execution.
- A blocked required entry sends `hold|blocker` when truthful execution remains blocked.
- A non-fitting required entry is a packet or route defect.
- A lane-mismatched required entry is a packet or route defect.
- A contradictory required entry is a packet or route defect.
- A required entry outside the frozen boundary is a packet or route defect.
- A required entry defect is not permission to drop the skill.
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
