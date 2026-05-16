---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# task-execution: Downward Lifecycle Control Packet
Structured lifecycle control is exceptional non-work control that changes agent-side behavior without assigning new bounded work.

## Validity
- Lifecycle control records exceptional runtime control outside the normal assignment work-state flow.
- Workflow phase movement uses phase-transition control.
- Same-segment assignment-grade work replaces lifecycle-control for that agent.

Carry:
- `MESSAGE-CLASS: lifecycle-control`
- `LIFECYCLE-DECISION`
- `DECISION-BASIS`

When team-lead sends a valid lifecycle-control packet, the agent returns a one-line `control-ack`.
Team-lead sends lifecycle control only when an exceptional lifecycle edge requires agent-side behavior and no assignment-grade packet or shutdown request fits.
Shutdown intent is normalized to the structured shutdown protocol below.

Termination form for shutdown specifically:
- Any agent-shutdown intent must be normalized to the structured shutdown protocol.
- Send `SendMessage` with `message: {"type": "shutdown_request"}`.
- During session closeout, team-lead sends this automatically to every live process-backed teammate before `TeamDelete`.
- Routine teardown proceeds from lifecycle evidence without user selection.
- A free-text shutdown control records intent only.
- Termination proceeds through the structured shutdown request.
- Termination evidence requires the structured shutdown response and harness termination event.
- The agent replies with `{"type": "shutdown_response", "approve": true|false}`.
- On approve, the agent process exits and the harness emits a `teammate_terminated` event.
- Post-shutdown or post-stand-down output is cleanup, quarantine, or self-growth evidence; it satisfies the frozen lane deliverable only when `team-lead` explicitly cancels shutdown before that work starts.
- `TeamDelete` succeeds only after every live process-backed teammate is confirmed terminated.
- Termination proof requires `teammate_terminated` evidence rather than text `control-ack`.

## Resolve Next Owner And Action
- Exceptional non-work control sends `MESSAGE-CLASS: lifecycle-control`.
- Shutdown intent sends structured `shutdown_request`.
- Missing termination evidence keeps closeout open.
- New bounded work returns to assignment-grade dispatch.
- Workflow phase movement opens phase-transition control.
