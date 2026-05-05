---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Message Classes
## Common Message Law
- `work-planning` produces the full frozen plan internally.
- `task-execution` translates that frozen basis into agent-facing packets.
- Agents never receive the full internal planning record.
- One agent, one execution segment, one primary downward message class.
- In team-agent runtime, official upward delivery requires `SendMessage` with a valid `MESSAGE-CLASS`.
- Plain-text output, pane output, or agent final prose is not delivery proof.
- Plain-text output, pane output, or agent final prose is not ledger evidence, lifecycle evidence, or synthesis-ready handoff until resent through `SendMessage`.
- `status` is progress only.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` is positive-state reporting only.
- `scope-pressure` is the structured objection path when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked path when truthful execution cannot continue even with a narrow packet correction.

## Upward Message Classes
- `dispatch-ack`
  - accepted assignment receipt only, never a standalone stop point
  - use when fresh assignment-grade work has coherent `WORK-SURFACE` and required task state
  - first upward outcome is mandatory: `dispatch-ack`, `scope-pressure`, or `hold|blocker`
  - silence is invalid
  - after it, continue the same turn into lane work or send a separate `scope-pressure` / `hold|blocker`
  - use the minimal receipt spine:
    - `MESSAGE-CLASS: dispatch-ack`
    - `WORK-SURFACE`
    - `ACK-STATUS: accepted`
    - `PLANNING-BASIS: loading`
    - `TASK-ID` when assigned or present
  - missing/incoherent `WORK-SURFACE` uses `hold|blocker`
  - missing/non-open required `TASK-ID` uses `scope-pressure` or `hold|blocker`
  - do not infer missing fields or treat a defective packet as executable
  - if one bounded packet correction preserves the same owner, phase, deliverable, proof/acceptance chain, staffing shape, and agent boundary, send a separate `scope-pressure` in the same turn
  - if the defect prevents truthful execution even with narrow correction, send a separate `hold|blocker` in the same turn
  - if the packet remains executable after explicit same-boundary inference, continue lane work and mark the inference
  - do not stuff blocker text into `dispatch-ack`
- `control-ack`
  - receipt only for structured control packets such as `phase-transition-control` or `lifecycle-control`
  - not an assignment receipt
  - not progress, not completion, not proof of closure
- `status`
  - internal progress only
  - not completion, not lifecycle, not proof of closure
- `scope-pressure`
  - structured objection to workload, ownership split, hidden prerequisite, missing critical field, or burden contract
  - use when the agent must not absorb the packet as written, but packet correction or replanning can still be the right next step
  - must include:
    - `PRESSURE-TYPE`
    - `WHY-CURRENT-PACKET-FAILS`
    - `SMALLEST-SAFE-BOUNDARY`
    - `RECOMMENDED-NEXT-LANE`
    - `REPLAN-REQUIRED`
- `handoff` / `completion`
  - completion-grade candidate only
  - requires converged lane-owned work
  - synthesis-ready only when the lane report satisfies `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution
  - use as a separate blocked message class after receipt or intake when the lane cannot continue truthfully
  - when emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`
  - do not downgrade it to bare `hold` or bare `blocker`
  - use this instead of downgrading to source-only or code-only checks when the decisive user surface cannot be truthfully exercised
  - if the blocker is an information request, team-lead must answer it through a corrected packet, reopened planning, or proven user-owned blocker
  - silence, reassurance, or "proceed as best you can" is invalid
  - must include:
    - `BLOCKER-TYPE`
    - `BLOCKER-BASIS`
    - `SAFE-NEXT-STEP`

### Agent Information Request Consumption
When an agent sends `MESSAGE-CLASS: hold|blocker` because decisive assignment basis is missing, team-lead must consume it before any re-dispatch, synthesis, completion claim, or user-facing positive report.
Information requests are quality-control events.
They are resolution triggers.
They must improve the assignment basis.
They must restore an executable route.
They must not convert one blocked lane into a whole-route bottleneck when independent surfaces can lawfully continue.

Before any re-dispatch, synthesis, or positive report, team-lead must classify the request as one of:
- `packet-correction`: same frozen owner, phase, deliverable, proof or acceptance chain, staffing shape, and agent boundary
  - send the missing field explicitly through a corrected packet
- `route-replan`: missing basis changes owner, phase, deliverable, proof surface, acceptance chain, staffing shape, parallel grouping, or route
  - reopen `work-planning`
- `parallel-continue`: the affected lane is blocked or being corrected, but unrelated independent lanes remain executable inside the same frozen route
  - keep those lanes moving while the affected lane is resolved
- proven user-owned blocker: team-lead cannot truthfully supply the requested basis after corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, and assumption routes are exhausted

Tool/evidence-gap consumption:
- If the agent names a missing evidence surface, required tool, setup owner, or current-toolchain gap, team-lead must not resolve it by asking the same lane to downgrade evidence or continue from text-only approximation.
- A usable tool/evidence-gap request names the missing evidence surface, required capability, current toolset limit, candidate tools considered, recommended tool or program, fit rationale, why weaker evidence is invalid, smallest truthful boundary, and recommended setup owner or packet correction.
- If those details are missing, team-lead must request a corrected blocker/pressure report, route bounded tool-selection research to `researcher`, or reopen `work-planning`.
- Do not invent the missing basis silently.
- A corrected packet is valid only when the same frozen route remains truthful and the missing setup/tool basis is explicit.
- Otherwise reopen `work-planning` to freeze `external-tool-bridge`, the exact setup owner, or a proven user-owned blocker.

The corrected packet must name the original blocker, the supplied field or correction, the unchanged boundary, and the open executable `TASK-ID` when task tracking is active.
If those cannot be named, `packet-correction` handling is forbidden.
If one missing basis affects multiple assignments, correct the shared basis once.
Then send bounded corrected packets to every affected agent.
If only one lane is blocked, keep unrelated independent lanes moving inside the frozen route instead of waiting by habit.
For developer constraints, the expected outcome is resumed execution.
Valid resume routes are method research, setup/tool bridge, packet correction, or owner split.
Then return the corrected executable path to developer.
Do not treat the constraint report as final failure until a genuine impossible or unsafe condition is proven.
