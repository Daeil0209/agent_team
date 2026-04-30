---
PRIMARY-OWNER: task-execution
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
| `packet-ready-not-sent` | packet is assembled only | `task-execution`: verify no send evidence, then send once or reopen the previous freeze owner if packet basis drifted |
| `team-created-no-assignment` | `team exists` only | `session-boot` if runtime readiness is uncertain; otherwise `task-execution` sends the next assignment-grade packet |
| `assignment-sent-no-ack` | `dispatch pending` only | `session-boot`: monitor for `dispatch-ack`, blocker, or stale dispatch; do not resend by habit |
| `dispatch-ack-no-start` | receipt only | `session-boot`: observe until agent-side action, progress, blocker, or stale classification exists |
| `agent-started` | agent-side activity exists | lane execution plus `session-boot` monitoring; do not return to `task-execution` unless replanning freezes a new assignment |
| `standalone-agent-call-incomplete` | legacy or accidental synchronous standalone `Agent` call has no returned result | default to `HOLD`; reopen `work-planning` when route validity is stale or contradicted; do not convert configured lane work into standalone retry; do not claim completion |
| `standalone-agent-result-returned` | legacy or accidental synchronous standalone `Agent` result returned | `team-lead` may consume it only as bounded evidence, then `self-verification (SV-RESULT)` before reporting or redispatch; it does not create team-runtime completion |

Recovery rules:
- `RECOVERY-EVIDENCE` must cite the concrete basis: host return, send result, runtime state, agent message, ledger, or explicit absence checked at the current authority.
- Unknown send state is not safe to resend. First check the current dispatch authority; if still unknown, use `HOLD` or `session-boot` recovery rather than duplicate assignment.
- A control packet, lifecycle packet, phase-transition packet, or self-growth sidecar must not erase the suspended dispatch surface.
- If `REPLAN-REQUIRED: yes`, the resume owner is `work-planning`; if the defect itself meets the `self-growth-sequence` entry gate, open `self-growth-sequence` first and leave a resume owner/action for the suspended work before closure or return.
- If recovery would change lane, owner, work surface, proof/acceptance chain, parallel grouping, or packet required skills, reopen `work-planning` instead of repairing inside `task-execution`.

## Agent Compaction Recovery
A compacted agent has lost the assignment-grade packet context but retains lane-core skill. To resume truthfully:

- Agent emits the exact literal `MESSAGE-CLASS: hold|blocker` with `BLOCKER-TYPE: context-loss-after-compaction`, `BLOCKER-BASIS: prior packet context not in working memory`, `SAFE-NEXT-STEP: re-receive assignment-grade packet for the previously-frozen surface`.
- Team-lead consumes the blocker, locates the original assignment-grade packet from internal carry-forward, and reissues the same packet (or a corrected version if the underlying scope changed) so the agent can resume.
- Agent does NOT improvise the lost context; do not reconstruct the assignment from gist or partial memory.
- Recovery is packet redelivery, not a fresh planning event. The frozen `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof chain remain unchanged.
- If the prior frozen scope is no longer truthful, team-lead reopens `work-planning` instead of redelivering. That is a fresh planning event, not compaction recovery.
