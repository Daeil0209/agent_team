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
