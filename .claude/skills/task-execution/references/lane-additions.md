---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Lane-Specific Additions
## Common Lane-Core Preconditions
Every lane-core skill inherits these common preconditions:
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md`.
- Classify receipt against the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Receive the agent-facing packet, not the full internal planning record.
- Send `dispatch-ack` first for every fresh assignment-grade receipt.
- Receipt is not permission to execute a defective packet.
- Then classify in the same turn.
- Execute, reconstruct safely, or send a separate `scope-pressure` / `hold|blocker`.
- Do not idle after receipt.
- Preserve global routing, staffing, and acceptance ownership from packet basis.
- Reconcile completion-grade handoff against the common end closure contract in `.claude/skills/task-execution/references/completion-handoff.md`.
- Load lane-core skill only for consequential lane-owned work.
- Receipt/control/status/lifecycle/phase/clarification messages do not activate it unless they assign or reopen work.
- Once loaded, lane-core procedure outranks packet non-lane-core skills inside the lane.
- Before lane work, run a capability-fit pass against target intent, assigned surface, required/recommended skills, and material tool or rendered/runtime needs.
- Every `REQUIRED-SKILLS` entry is mandatory consumption: load and apply it before lane execution or handoff, or return `scope-pressure` / `hold|blocker` with the smallest correcting owner.
- A required entry that is non-fitting, lane-mismatched, contradictory, or outside the frozen boundary is a packet or route defect, not permission to drop the skill.
- Use fitting skills and tools as execution lenses inside the assigned lane; naming them without applying them to the work surface is not capability fit.
- When a selected non-lane-core skill's `SKILL.md` names a direct reference that owns material method detail for the assigned surface, capability fit includes loading and applying that reference, or marking it `not-material` / blocked with basis.
- During lane work, a newly discovered skill or tool need is lane-local refinement only when it stays inside the same owner, phase, work surface, deliverable shape, proof/acceptance chain, and staffing route.
- Lane-local refinement applies the skill or tool immediately inside that boundary and records the basis in handoff.
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

Each lane's lane-core skill and lane-detail reference own exact assignment additions and lane-specific completion extras beyond the common result spine. Lane role documents own always-loaded lane identity, boundary, and stop conditions; they are not packet catalogs.

For session-side controlled packet value tables and lane-specific presence hints, see `.claude/skills/team-session-sequences/references/dispatch-packet-compliance.md` for assignment-side values such as `RESEARCH-MODE`, `BENCHMARK-MODE`, `PLAN-STATE`, `ACCEPTANCE-RISK`, `PROOF-OWNER`, `PREREQ-STATE`, `REVIEW-STATE`, and `TEST-STATE`; see `.claude/skills/team-session-sequences/references/upward-handoff.md` for upward lane-owned state such as `VERDICT`. Those reference sections are lookup indexes. `team-session-sequences` owns session-sequence indexes and dispatch-detail lookups, not packet schema or lane-core additions. Runtime spine stays with `session-boot`, closeout with `session-closeout`, and packet schema with `task-execution`. Hooks guard runtime integrity as last-resort checks; normal agent behavior stays with the owning procedure.
