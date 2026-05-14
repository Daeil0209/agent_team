---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Dispatch Recovery
## Dispatch Interruption Recovery
Use this table only when `task-execution` was active or had not yet moved out cleanly. It records dispatch side-effect truth; it does not replace `work-planning`, `self-verification`, `session-boot`, `self-growth-sequence`, or lane execution.

Required recovery record:
- `INTERRUPT-POINT`
- `LAST-PROVEN-DISPATCH-TRUTH`
- `RECOVERY-EVIDENCE`
- `PACKET-SEND-STATUS`
- `RUNTIME-SIDE-EFFECT`
- `RESUME-OWNER`
- `RESUME-ACTION`
- `REPLAN-REQUIRED`

| `INTERRUPT-POINT` | Last proven truth | Resume owner/action |
|---|---|---|
| `before-packet-final-check` | no dispatch side effect | `task-execution`: rerun packet final check; reopen `work-planning` if frozen fields are stale, missing, or contradicted |
| `packet-ready-not-sent` | packet is assembled only | `task-execution`: verify no send evidence, then send once or return to the same frozen owner if packet basis drifted without changing route |
| `team-created-no-assignment` | `member-created` only | `session-boot` if runtime readiness is uncertain; otherwise `task-execution` sends the next assignment-grade `SendMessage` |
| `assignment-sent-no-ack` | `dispatch pending` only | `session-boot`: send one same-assignment receipt follow-up after current dispatch check. Keep unaffected parallel targets moving. Classify stale only after that follow-up fails and assigned-surface activity/side-effect evidence is absent. |
| `dispatch-ack-no-start` | receipt only. ack-only idle is not work. | `session-boot`: send one same-assignment execution follow-up after the receipt segment ends without agent-start, blocker, scope-pressure, failure, or `HOLD`. Keep unaffected parallel targets moving. Classify stale only after that follow-up fails and agent-start or assigned-surface activity/side-effect evidence is absent. |
| `agent-started` | agent-side activity exists | lane execution plus `session-boot` monitoring. Do not return to `task-execution` unless replanning freezes a new assignment. |
| `standalone-agent-call-incomplete` | legacy or accidental synchronous standalone `Agent` call has no returned result | default to `HOLD`. Reopen `work-planning` when route validity is stale or contradicted. Do not convert configured lane work into standalone retry. Do not claim completion. |
| `standalone-agent-result-returned` | legacy or accidental synchronous standalone `Agent` result returned | `team-lead` can consume it only as bounded evidence. Run `self-verification (SV-RESULT)` before reporting or redispatch. It does not create team-runtime completion. |

Recovery rules:
- `RECOVERY-EVIDENCE` must cite the concrete basis: host return, send result, runtime state, agent message, assigned-surface mtime/diff, ledger, or explicit absence checked at the current authority.
- Unknown send state is not safe to resend. First check the current dispatch authority; if still unknown, use `HOLD` or `session-boot` recovery rather than duplicate assignment.
- Do not stack repeated assignment or correction messages into a target with no agent-originated receipt, start, blocker, or progress.
- After one bounded follow-up, wait for response, agent-start, blocker, or assigned-surface activity until the `session-boot` re-check window; missing response after that window is runtime recovery, not another packet retry.
- A parallel group is not "running" while any target remains `assignment-sent-no-ack` or `dispatch-ack-no-start`.
- Recover only the affected target unless the frozen parallel grouping itself is invalid.
- A control packet, lifecycle packet, phase-transition packet, or self-growth sidecar must not erase the suspended dispatch surface.
- If `REPLAN-REQUIRED: yes`, the resume owner is `work-planning`.
- If the defect itself meets the `self-growth-sequence` entry gate, open `self-growth-sequence` first.
- Leave a resume owner/action for the suspended work before closure or return.
- If recovery would change lane, owner, work surface, proof/acceptance chain, parallel grouping, or packet required skills, reopen `work-planning` instead of repairing inside `task-execution`.

## Agent Compaction Recovery
A compacted agent has lost the assignment-grade packet context but retains lane-core skill. To resume truthfully:

- Agent emits the exact literal `MESSAGE-CLASS: hold|blocker`.
- It includes `BLOCKER-TYPE: context-loss-after-compaction`.
- It includes `BLOCKER-BASIS: prior packet context not in working memory`.
- It includes `SAFE-NEXT-STEP: team-lead reissues the assignment-grade packet for the previously-frozen surface`.
- Team-lead consumes the blocker, locates the original assignment-grade packet from internal carry-forward, and reissues the same packet (or a corrected version if the underlying scope changed) so the agent can resume.
- Agent does NOT improvise the lost context; do not reconstruct the assignment from gist or partial memory.
- Recovery is packet redelivery, not a fresh planning event. The frozen `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof chain remain unchanged.
- If the prior frozen scope is no longer truthful, team-lead reopens `work-planning` instead of redelivering. That is a fresh planning event, not compaction recovery.

## Resolve Next Owner And Action
- Completed recovery record opens the named `RESUME-OWNER` and `RESUME-ACTION`.
- `REPLAN-REQUIRED: yes` opens `work-planning`.
- Uncertain runtime readiness opens `session-boot`.
- Missing send-state evidence opens current dispatch-authority inspection.
- Duplicate-send risk opens `HOLD` or `session-boot` recovery.
- Agent compaction opens assignment-packet reissue from the frozen route.
- Route-changing recovery opens `work-planning`.
- Self-growth-triggering recovery defect opens `self-growth-sequence` before suspended dispatch closure.
