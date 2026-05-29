---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
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
- `malformed-completion-contract`
- `upstream-carrier-fabrication`

Use `parallel-split-needed` when nominally parallel or independently staffable work lets two or more independent tasks or surfaces collapse onto one agent strongly enough that the agent becomes the schedule bottleneck.
Use `boundary-too-wide` when the packet already exceeds the smallest truthful lane-owned boundary even before throughput evidence accumulates.
Use `upstream-carrier-fabrication` only when upstream `PASS`, verification, or `Skill(...) loaded` claims are the only or decisive basis and no direct artifact or evidence surface is inspectable inside lane scope. When direct artifact or evidence inspection is available, inspect that surface and carry the fabrication as a blocking finding or open surface instead of blocking intake.

Carrier fields for actual `scope-pressure` transport:
- `PRESSURE-TYPE`
- `PRESSURE-BASIS`
- `CORRECTION-OUTCOME`
- `ATTEMPTED-DEFAULTS`
- `SMALLEST-SAFE-CORRECTION`
- `RESUME-ROUTE`

Correction outcome law:
- `CORRECTION-OUTCOME: route-replan` when the objection moves any `work-planning` boundary-change axis.
- `CORRECTION-OUTCOME: packet-correction` only when one bounded packet correction preserves all `work-planning` boundary-change axes plus same agent boundary.
- `CORRECTION-OUTCOME: parallel-continue` when the affected lane is blocked or being corrected while unrelated independent lanes remain executable inside the same frozen route.
- Single-agent overload inside intended parallel work is a serious distribution-planning defect. Represent it as `PRESSURE-TYPE: parallel-split-needed` with `CORRECTION-OUTCOME: route-replan`; do not downgrade it to packet correction.
- If the agent cannot state a smallest safe boundary, default to `hold|blocker` instead of vague `scope-pressure`.

## Resolve Next Owner And Action
- `CORRECTION-OUTCOME: route-replan` opens `work-planning`.
- `CORRECTION-OUTCOME: packet-correction` opens bounded packet correction.
- `CORRECTION-OUTCOME: parallel-continue` keeps unrelated independent lanes moving while the affected surface resolves.
- `parallel-split-needed` opens distribution replanning.
- Missing smallest safe boundary opens `hold|blocker`.
- Resolved pressure returns corrected executable path to the affected lane.
- Unrelated independent lanes continue inside the frozen route when their boundaries remain executable.
