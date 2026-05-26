---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Dispatch Recovery
## Dispatch Interruption Recovery
Use this table only when `task-execution` was active or had not yet moved out cleanly. It records dispatch side-effect truth while `work-planning`, `self-verification`, `session-boot`, `Skill(governance-modification)`, and lane execution keep their ownership.

Required recovery record:
- `INTERRUPT-POINT`
- `LAST-PROVEN-DISPATCH-TRUTH`
- `RECOVERY-EVIDENCE`
- `PACKET-SEND-STATUS`
- `RUNTIME-SIDE-EFFECT`
- `RESUME-OWNER`
- `RESUME-ACTION`
- `CORRECTION-OUTCOME`

| `INTERRUPT-POINT` | Last proven truth | Resume owner/action |
|---|---|---|
| `before-packet-final-check` | no dispatch side effect | `task-execution`: rerun packet final check; reopen `work-planning` if frozen fields are stale, missing, or contradicted |
| `packet-ready-not-sent` | packet is assembled only | `task-execution`: verify no send evidence, then send once or return to the same frozen owner if packet basis drifted without changing route |
| `team-created-no-assignment` | `member-created` only | `session-boot` if runtime readiness is uncertain; otherwise `task-execution` sends the next assignment-grade `SendMessage` |
| `dispatch-pending-no-ack` | assignment sent, no acceptance | `session-boot`: send one same-assignment receipt follow-up after current dispatch check. Keep unaffected parallel targets moving. Classify the target as dead-or-unavailable for the current assignment after that follow-up returns no `dispatch-ack` / `scope-pressure` / `hold|blocker` and no assigned-surface activity/side-effect evidence within the `session-boot` re-check window (see `.claude/skills/session-boot/references/runtime-state-detail.md` for window duration). |
| `dispatch-ack-no-start` | assignment accepted, no later activity | `session-boot`: send one same-assignment execution follow-up after the receipt segment ends without agent-start, blocker, scope-pressure, failure, or `HOLD`. Keep unaffected parallel targets moving. Classify the target as stalled or dead-or-unavailable after that follow-up returns no agent-start / blocker / scope-pressure / `HOLD` and no assigned-surface activity/side-effect evidence within the `session-boot` re-check window. |
| `agent-started` | agent-side activity exists | lane execution plus `session-boot` monitoring. Return to `task-execution` only when replanning freezes a new assignment. |
| `standalone-agent-call-incomplete` | legacy or accidental synchronous standalone `Agent` call has no returned result | default to `HOLD`. Reopen `work-planning` when route validity is stale or contradicted. Configured lane work stays on the configured lane route, and completion claims require completion-grade evidence. |
| `standalone-agent-result-returned` | legacy or accidental synchronous standalone `Agent` result returned | `team-lead` can consume it only as bounded evidence. Load `Skill(self-verification)` for convergence before reporting or redispatch. Team-runtime completion requires team-runtime completion transport. |

Recovery rules:
- `RECOVERY-EVIDENCE` must cite the concrete basis: host return, send result, runtime state, agent message, assigned-surface mtime/diff, ledger, or explicit absence checked at the current authority.
- Unknown send state is not safe to resend. First check the current dispatch authority; if still unknown, use `HOLD` or `session-boot` recovery rather than duplicate assignment.
- Missing receipt and no-start recovery are exact-target liveness drives; probe the unresolved target only.
- Ack counts, missing target names, inbox read state, nudges, replacement consideration, and no-start classification stay internal while Procedure Plane or Communication Plane recovery can continue.
- Repeated assignment or correction messages stay out of a target with no agent-originated receipt, start, blocker, or progress.
- The one bounded follow-up asks for the missing receipt, start evidence, `scope-pressure`, or `hold|blocker`; resend assignment content only when prior send evidence is absent or duplicate side-effect risk is ruled out.
- After one bounded follow-up, wait for response, agent-start, blocker, or assigned-surface activity until the `session-boot` re-check window.
- Missing response and missing activity after that window is dead-or-unavailable recovery for the affected target, not another packet retry.
- A same-target packet correction to a responsive live target opens a correction-response window. Shutdown or replacement waits until the window closes without corrected receipt, blocker, scope-pressure, start evidence, or assigned-surface activity, unless the target is actively mutating outside authority or corrupting protected state.
- Parallel group "running" status requires every target to be past `dispatch-pending-no-ack` and `dispatch-ack-no-start`.
- Recover only the affected target unless the frozen parallel grouping itself is invalid.
- A phase-transition packet, shutdown request, or `Skill(governance-modification)` sidecar preserves the suspended dispatch surface.
- If `CORRECTION-OUTCOME: route-replan`, the resume owner is `work-planning`.
- If the defect itself meets the `Skill(governance-modification)` entry gate, open `Skill(governance-modification)` first.
- Leave a resume owner/action for the suspended work before closure or return.
- If recovery would change lane, owner, work surface, proof/acceptance chain, parallel grouping, or packet required skills, reopen `work-planning` instead of repairing inside `task-execution`.

## Agent Compaction Recovery
A compacted agent has lost the assignment-grade packet context but retains its agent-specific skill. To resume truthfully:

- Agent emits the exact literal `MESSAGE-CLASS: hold|blocker`.
- It includes `BLOCKER-TYPE: context-loss-after-compaction`.
- It includes `BLOCKER-BASIS: prior packet context not in working memory`.
- It includes `SAFE-NEXT-STEP: team-lead reissues the assignment-grade packet for the previously-frozen surface`.
- Team-lead consumes the blocker, locates the original assignment-grade packet from internal carry-forward, and reissues the same packet or a same-boundary packet correction so the agent can resume.
- Packet correction during compaction recovery preserves the previously frozen scope, route, proof/acceptance chain, parallel grouping, and required-skill basis.
- Agent reports the context-loss blocker; assignment context returns through packet redelivery rather than gist or partial-memory reconstruction.
- Recovery is packet redelivery, not a fresh planning event. The frozen `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof chain remain unchanged.
- If the prior frozen scope is no longer truthful, team-lead reopens `work-planning` instead of redelivering. That is a fresh planning event, not compaction recovery.

## Resolve Next Owner And Action
- Completed recovery record opens the named `RESUME-OWNER` and `RESUME-ACTION`.
- `CORRECTION-OUTCOME: route-replan` opens `work-planning`.
- Uncertain runtime readiness opens `session-boot`.
- Missing send-state evidence opens current dispatch-authority inspection.
- Duplicate-send risk opens `HOLD` or `session-boot` recovery.
- Agent compaction opens assignment-packet reissue from the frozen route.
- Route-changing recovery opens `work-planning`.
- Recurrence-hardening recovery defect opens `Skill(governance-modification)` before suspended dispatch closure.
