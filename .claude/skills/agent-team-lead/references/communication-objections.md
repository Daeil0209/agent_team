---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-5 Communication And Objections; Reporting Philosophy; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---

# team-lead: Communication And Objection Detail

## Contents
- hold|blocker
- scope-pressure
- Resolve Next Owner And Action

## hold|blocker
- Treat `hold|blocker` as hard stop on the unsafe affected path.
- Keep paths active only when the frozen `parallel-fit` basis proves distinct acceptance contracts and output-to-input independence.
- If the blocker changes shared source-of-truth, owner, proof, acceptance, staffing, or parallel grouping, reopen `work-planning` before continuing affected paths.
- Consume `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP` exactly.
- Classification, corrected-packet axes, and `CORRECTION-OUTCOME` semantics: `.claude/skills/task-execution/references/message-classes.md` Agent Information Request Consumption and `.claude/skills/task-execution/references/scope-pressure.md`.
- Provide explicit basis before asking the agent to proceed:
  - design intent
  - proof surface
  - authority
  - tool/run-path basis
- Consume these as blocker-clear routing evidence:
  - missing evidence surface
  - required tool
  - setup owner
  - current-toolchain gap
- Route bounded tool-selection research to `researcher` when tool choice is uncertain.
- Reopen `work-planning` when tool/evidence gaps change owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, or parallel grouping.
- Route researcher for method/tool discovery when developer implementation constraints need method evidence.
- Route `external-tool-bridge` or setup owner for capability gaps.
- Correct the packet when basis is missing.
- Split ownership when another lane is needed.
- Return the next executable path to the blocked lane or owning correction route after correction.
- Repeat the resolution loop until the user instruction is completed.
- Report `HOLD` when evidence proves a genuine:
  - impossible condition
  - unsafe condition

## scope-pressure
- Treat `scope-pressure` as planning-quality evidence.
- Consume explicit fields:
  - `PRESSURE-TYPE`
  - `WHY-CURRENT-PACKET-FAILS`
  - `SMALLEST-SAFE-BOUNDARY`
  - `LANE-NEXT-CANDIDATE`
  - `CORRECTION-OUTCOME`
- Reopen `work-planning` immediately when `CORRECTION-OUTCOME: route-replan`.
- Reopen `work-planning` when `PRESSURE-TYPE` from `.claude/skills/task-execution/references/scope-pressure.md` shows boundary, owner, phase, parallel, acceptance, proof, decision, or deliverable mismatch.
- Classify single-agent collapse of intended parallel work as distribution-planning defect.
- Restore parallel shape through `work-planning`.
- Classification, corrected-packet axes, and `CORRECTION-OUTCOME` semantics: `.claude/skills/task-execution/references/message-classes.md` Agent Information Request Consumption and `.claude/skills/task-execution/references/scope-pressure.md`.
- Treat multiple aligned objections as stronger planning evidence.
- Unresolved objections block positive completion, synthesis-triggered redispatch, and completion-style transporting.
- Unresolved objections keep the blocked lane on a concrete resolution path.
- `CORRECTION-OUTCOME: parallel-continue` keeps unrelated independent lanes moving when lawful.
- If pressure identifies a tool/evidence gap but lacks candidate-tool research, treat researcher tool-selection as the next evidence owner unless the packet already proves the correct tool or the issue is a proven user-owned blocker.

## Resolve Next Owner And Action
- Consume message-class semantics from `.claude/skills/task-execution/references/message-classes.md`.
- A `hold|blocker` opens corrected packet, reopened `work-planning`, setup/tool owner, or proven user-owned blocker classification.
- A `scope-pressure` opens packet correction, `work-planning`, or parallel continuation by `CORRECTION-OUTCOME`.
- A duplicate post-completion signal opens retained-carrier consumption or distinct bounded work.
- A message-class conflict opens message-class split.
