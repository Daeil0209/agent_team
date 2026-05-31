---
PRIMARY-OWNER: team-lead
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
| `dispatch-pending-no-ack` | assignment sent, no acceptance | `session-boot`: send one same-assignment receipt follow-up after current dispatch check. Keep unaffected parallel targets moving. Classify the target as dead-or-unavailable for the current assignment after that follow-up fails and assigned-surface activity/side-effect evidence is absent. |
| `problem-reported-pending-outcome` | assignment sent and `problem-report` received, but no `dispatch-ack`, `scope-pressure`, `hold|blocker`, or completion-grade `subjob-done` has followed | `team-lead`: consume the problem report, execute same-boundary correction or recovery when available, and require the lane's next state decision as `dispatch-ack`, `scope-pressure`, or `hold|blocker`. Keep unaffected parallel targets moving. |
| `dispatch-ack-no-start` | assignment accepted, quiet activity window closed with no later activity | `session-boot`: send one same-assignment execution follow-up after the frozen quiet activity window ends without agent-start, blocker, scope-pressure, failure, permission request, completion-grade handoff, blocker-routing, or assigned-surface side-effect evidence. Keep unaffected parallel targets moving. Classify the target as stalled or dead-or-unavailable after that follow-up fails and agent-start or assigned-surface activity/side-effect evidence is absent. |
| `agent-started-after-receipt` | valid first upward outcome plus agent-side activity exists | lane execution plus `session-boot` monitoring. Return to `task-execution` only when replanning freezes a new assignment. |
| `standalone-agent-call-incomplete` | legacy or accidental synchronous standalone `Agent` call has no returned result | Inspect current host/runtime state, preserve the standalone call only as bounded evidence, and reopen `work-planning`, `session-boot`, or `task-execution` redispatch for the configured lane route. Use blocker-routing only after duplicate-send risk and every executable recovery route are exhausted. Completion claims require completion-grade evidence. |
| `standalone-agent-result-returned` | legacy or accidental synchronous standalone `Agent` result returned | `team-lead` can consume it only as bounded evidence. Load and learn `Skill(self-verification)` for convergence before reporting or redispatch. Team-runtime completion requires team-runtime `subjob-done` transport. |

Recovery rules:
- `RECOVERY-EVIDENCE` must cite the concrete basis: host return, send result, runtime state, agent message, assigned-surface mtime/diff, ledger, or explicit absence checked at the current authority.
- Host API/socket errors, hook denials, malformed-envelope denials, command exit codes, missing-file checks, and absent-carrier checks are recovery evidence only; they do not admit explanatory prose while a recovery action, retry with corrected tool shape, retained evidence check, or blocker-routing can run.
- After a command violates `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`, rerun only the corrected quiet evidence command or retained-artifact check when needed; do not narrate the noisy command or the retry.
- Unknown send state is not safe to resend. First check the current dispatch authority; if still unknown, use `session-boot` recovery or blocker-routing with duplicate-send risk, exhausted recovery basis, and next safe owner/action rather than duplicate assignment.
- Missing receipt and no-start recovery are exact-target liveness drives; probe the unresolved target only.
- Agent-side activity without valid first upward outcome remains `dispatch-pending-no-ack`; `problem-report` changes only the recovery row to `problem-reported-pending-outcome` and does not satisfy receipt.
- Ack counts, missing target names, inbox read state, nudges, replacement consideration, and no-start classification stay internal while Procedure Plane or Communication Plane recovery can continue.
- Idle after `dispatch-ack` is not by itself a reason for a proceed prompt; use the no-start recovery row only after the frozen quiet activity window ends without agent-start, blocker, scope-pressure, failure, permission request, completion-grade handoff, blocker-routing, or assigned-surface side-effect evidence.
- Repeated assignment or correction messages stay out of a target with no agent-originated receipt, start, blocker, or progress.
- The one bounded follow-up asks for the missing receipt, missing post-`problem-report` state decision, start evidence, `scope-pressure`, or `hold|blocker`; resend assignment content only when prior send evidence is absent or duplicate side-effect risk is ruled out.
- Duplicate side-effect risk is not ruled out when a resend, correction, reuse, or reroute would change `RETAINED-OUTPUT-PATH` or `WRITE-SCOPE` for the same `TASK-ID` or `WORK-SURFACE` before the prior assignment is reconciled as no-side-effect, accepted by retained-carrier evidence, or superseded by route replan.
- After one bounded follow-up, continue unaffected work and let `session-boot` monitor for response, agent-start, blocker, or assigned-surface activity until the re-check window.
- Missing response and missing activity after that window is dead-or-unavailable recovery for the affected target, not another packet retry.
- A same-target packet correction to a responsive live target opens a correction-response window. Shutdown or replacement waits until the window closes without corrected receipt, blocker, scope-pressure, start evidence, or assigned-surface activity, unless the target is actively mutating outside authority or corrupting protected state.
- Parallel group internal running state may include valid `dispatch-ack` targets inside the quiet activity window; it excludes targets still in `dispatch-pending-no-ack` and targets already classified `dispatch-ack-no-start` until recovery follow-up succeeds or activity appears.
- Recover only the affected target unless the frozen parallel grouping itself is invalid.
- A phase-transition packet, shutdown request, or `Skill(governance-modification)` sidecar preserves the suspended dispatch surface.
- If `CORRECTION-OUTCOME: route-replan`, the resume owner is `work-planning`.
- If the defect itself meets the `Skill(governance-modification)` entry gate, open `Skill(governance-modification)` first.
- Leave a resume owner/action for the suspended work before closure or return.
- If recovery would change lane, owner, work surface, proof/acceptance chain, parallel grouping, or packet required skills, reopen `work-planning` instead of repairing inside `task-execution`.

## Agent Compaction Recovery
A compacted agent has lost the assignment-grade packet context but retains its agent-specific skill. To resume truthfully:

- Agent records non-rendered `MESSAGE-CLASS: problem-report` when a receiver-consumable channel exists, then sends no-detail `hold|blocker`; renderable state fields stay empty, omitted, or single ASCII space except the state token.
- It includes `PROBLEM-TYPE: context-loss-after-compaction`.
- It includes `PROBLEM-BASIS: prior assignment-grade packet context not in working memory`.
- It includes `AFFECTED-ACTION: resume previously frozen assignment surface`.
- It includes `ATTEMPTED-RECOVERY: checked current working memory and available packet context; no truthful reconstruction`.
- It includes `CAN-CONTINUE: no`.
- It includes `NEXT-STATE: hold|blocker`.
- It includes `SMALLEST-NEXT-OWNER-ACTION: team-lead reissues the assignment-grade packet for the previously-frozen surface`.
- Team-lead consumes the blocker, locates the original assignment-grade packet from internal carry-forward, and reissues the same packet or a same-boundary packet correction so the agent can resume.
- Packet correction during compaction recovery preserves the previously frozen scope, route, proof/acceptance chain, parallel grouping, and required-skill basis.
- Agent records the context-loss blocker in non-rendered problem detail; assignment context returns through packet redelivery rather than gist or partial-memory reconstruction.
- Recovery is packet redelivery, not a fresh planning event. The frozen `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof chain remain unchanged.
- If the prior frozen scope is no longer truthful, team-lead reopens `work-planning` instead of redelivering. That is a fresh planning event, not compaction recovery.

## Resolve Next Owner And Action
- Completed recovery record opens the named `RESUME-OWNER` and `RESUME-ACTION`.
- `CORRECTION-OUTCOME: route-replan` opens `work-planning`.
- Uncertain runtime readiness opens `session-boot`.
- Missing send-state evidence opens current dispatch-authority inspection.
- Duplicate-send risk opens `session-boot` recovery, or blocker-routing only after recovery cannot remove the duplicate-send risk.
- Agent compaction opens assignment-packet reissue from the frozen route.
- Route-changing recovery opens `work-planning`.
- Recurrence-hardening recovery defect opens `Skill(governance-modification)` before suspended dispatch closure.
