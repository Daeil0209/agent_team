---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Scope-Pressure Canonical Use
Use `scope-pressure` when the packet is directionally related to the right work but unsafe to absorb as written.

Canonical `PRESSURE-TYPE` values:
- `missing-critical-field`
- `boundary-too-wide`
- `hidden-prerequisite`
- `owner-split`
- `phase-split`
- `parallel-split-needed`
- `acceptance-burden-mismatch`
- `proof-surface-mismatch`
- `decision-surface-mismatch`
- `deliverable-shape-mismatch`

Use `parallel-split-needed` when nominally parallel or independently staffable work lets two or more independent tasks or surfaces collapse onto one agent strongly enough that the agent becomes the schedule bottleneck.
Use `boundary-too-wide` when the packet already exceeds the smallest truthful lane-owned boundary even before throughput evidence accumulates.

Replanning law:
- `REPLAN-REQUIRED: yes` when the objection changes owner, phase, work-surface decomposition, staffing shape, acceptance chain, proof surface, or deliverable shape.
- `REPLAN-REQUIRED: no` only when one bounded packet correction can preserve the same frozen owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, and parallel grouping.
- Single-agent overload inside intended parallel work is a serious distribution-planning defect. Represent it as `PRESSURE-TYPE: parallel-split-needed` with `REPLAN-REQUIRED: yes`; do not downgrade it to packet correction.
- If the agent cannot state a smallest safe boundary, default to `hold|blocker` instead of vague `scope-pressure`.
