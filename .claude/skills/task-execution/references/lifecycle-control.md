---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Downward Lifecycle Control Packet
Use a structured lifecycle control packet when team-lead resolves post-completion or runtime lifecycle state for an agent and no new bounded work is being assigned.

## Validity
- Lifecycle control records post-completion or runtime lifecycle state.
- Workflow phase movement uses phase-transition control.
- Same-segment assignment-grade work replaces lifecycle-control for that agent.

Carry:
- `MESSAGE-CLASS: lifecycle-control`
- `LIFECYCLE-DECISION`
- `DECISION-BASIS`

Agents acknowledge non-terminating lifecycle receipt when the decision materially affects active assignment, reuse, standby readiness, or hold-for-validation.
Team-lead sends lifecycle control explicitly after agent completion, reuse decision, or runtime coordination when a non-terminating lifecycle edge must be recorded truthfully.
Shutdown intent is normalized to the structured shutdown protocol below.

Termination form for shutdown specifically:
- Any agent-shutdown intent must be normalized to the structured shutdown protocol.
- Send `SendMessage` with `message: {"type": "shutdown_request"}`.
- During session closeout, team-lead sends this automatically to every live process-backed teammate before `TeamDelete`.
- Routine teardown proceeds from lifecycle evidence without user selection.
- A free-text lifecycle-control message with `LIFECYCLE-DECISION: shutdown` is a malformed shutdown attempt.
- It records intent only.
- Termination requires the structured shutdown request immediately after malformed intent is detected.
- Termination evidence requires the structured shutdown response and harness termination event.
- The agent replies with `{"type": "shutdown_response", "approve": true|false}`.
- On approve, the agent process exits and the harness emits a `teammate_terminated` event.
- Use the free-text `lifecycle-control` form only when the decision is `reuse`, `standby`, or `hold-for-validation`.
- Reuse, standby, and hold-for-validation require only a lifecycle-edge record.
- `TeamDelete` succeeds only after every live process-backed teammate is confirmed terminated.
- Termination proof requires `teammate_terminated` evidence rather than text `control-ack`.

## Next-Action Drive
- Reuse, standby, or hold-for-validation sends `MESSAGE-CLASS: lifecycle-control`.
- Shutdown intent sends structured `shutdown_request`.
- Missing termination evidence keeps closeout open.
- New bounded work returns to assignment-grade dispatch.
- Workflow phase movement opens phase-transition control.
