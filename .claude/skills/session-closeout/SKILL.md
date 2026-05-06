---
name: session-closeout
description: Closeout procedures for team-lead session teardown and runtime cleanup.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned closeout surface.
- Fixed section order: `Activation` -> `Runtime Teardown Preflight` -> `Closeout Sequence`
- PRIMARY-OWNER: team-lead
- Owns the closeout spine only.
- State schema, hold conditions, and detailed agent lifecycle requirements belong in `references/closeout-state-detail.md` or the runtime lifecycle owner.
### Reference Map
- `references/closeout-state-detail.md`: closeout state schema, hold conditions, residual truth, and detailed agent lifecycle requirements.

## Activation
Load this skill when explicit user-directed session end or confirmed teardown intent is active.
Hook feedback can surface teardown state.
Session-end intent requires explicit closeout or teardown basis.
Product-delivery closeout for executable deliverables belongs to `dev-workflow` operator-delivery before session teardown.

## Runtime Teardown Preflight
Run this before `TeamDelete`, `CronDelete`, or any runtime mutation that tears down session runtime.

### Required order
1. Confirm explicit closeout or teardown intent.
2. Determine whether any live agent still needs lifecycle action.
3. Determine whether monitor ownership and runtime teardown ownership are already accounted for.
4. Mutate runtime state only after live-agent and monitor readiness are accounted for.
5. If runtime deletion fails and only non-live residue remains, stop retries and carry that residue into truthful closeout output instead of improvising teardown repair work.

## Closeout Sequence
`Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed teardown handoff requires runtime shutdown.

Keep closeout narrow:
- account for live agents
- remove live runtime when available
- leave a truthful residual state when not

### Core law
- Explicit closeout intent preempts ordinary planning, synthesis, and completion-style reporting.
- Once closeout owns the path, agent outputs can narrow residual truth only.
- A late agent output after closeout intent can still narrow residual truth.
- Treat late output as residual evidence, not ordinary completion.
- Hook-maintained closeout state tracks teardown progress.
- If continuity, runtime state, and teardown evidence disagree, prefer truthful `HOLD` or warning-bearing closeout over repair choreography during teardown.
- Partially booted explicit runtime follows the direct closeout path.

### Required order
1. Mark explicit closeout intent before sending session-level `shutdown_request`, deleting monitors, or tearing down runtime.
2. Integrate agent outputs only enough to disclose unresolved acceptance, blocker, or residual-state truth.
3. Auto-drain every live process-backed teammate with structured `shutdown_request`.
4. Wait for `shutdown_response`/`teammate_terminated` evidence for every live process-backed teammate.
5. If a teammate has no live agent process, treat the roster entry as residue.
6. If any live process-backed teammate remains, report warning-bearing closeout or `HOLD`; `TeamDelete` waits.
7. Keep continuity handling minimal during teardown.
8. Remove live-session monitors only after current-runtime agents are fully terminated, proven non-live residue, or explicitly held.
9. Run `TeamDelete` only after no live process-backed teammate remains.
10. Bounded teardown only while new runtime evidence changes the result.
11. No repeated teardown on the same evidence and no ad hoc runtime surgery.
12. Let `SessionEnd` finish continuity capture after runtime teardown.
13. Let `SessionEnd` cleanup clear runtime-owned transient residue after continuity capture.
14. Run team-lead-owned supervisor-effectiveness review only when the user asked for it, a real teardown/management defect occurred, or self-growth work is active.
15. End with concise operator-facing closeout only when blocked, warning-bearing, explicitly requested, or review-triggered.
16. Otherwise clean closeout stays silent or one-line.

### Fast paths
- No-runtime fast path: when no explicit team runtime or recurring monitor was created in the current session, closeout reduces to intent mark, exact residual disclosure if needed, and `SessionEnd` capture.
- User-facing output is a short acknowledgement at most.
- No-acceptance-surface fast path: when the session produced no implementation deliverable or no acceptance surface was created, set validation ownership to `not-needed` and close without extra ceremony.

### Closeout constraints
- Session-end intent comes from explicit closeout or teardown basis.
- New agent dispatch stays outside closeout.
- `TeamDelete` runs after live-agent cleanup.
- Drain or account for live agents first.
- Runtime cleanup is lead-owned.
- Teammates report lifecycle state; team cleanup stays lead-owned.
- Claude Code team config, task list, mailbox, and cleanup state stay runtime-owned.
- Governed runtime cleanup uses governed runtime surfaces.
- Blocked or partially cleaned closeout reports residual truth.
- Clean closeout stays silent or one-line.
- Warning-bearing closeout stays short: exact residual state, exact hold reason, and next recovery surface only.

See `references/closeout-state-detail.md` for:
- `Closeout State Schema`
- `not-needed Conditions`
- `Hold Conditions`
- `Agent Lifecycle Resolution`
