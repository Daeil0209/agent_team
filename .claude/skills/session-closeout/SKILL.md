---
name: session-closeout
description: Close team-lead sessions with teardown truth, runtime cleanup, residual disclosure, and continuity preservation. Use when explicit closeout, session ending, runtime shutdown, or residual state handoff is active.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned closeout surface.
- Fixed top-level section order after Structural Contract: `Activation` -> `Runtime Teardown Preflight` -> `Closeout Sequence` -> `Resolve Next Owner And Action`.
- Reference Map stays inside Structural Contract.
- PRIMARY-OWNER: team-lead
- Owns the closeout spine only.
- State schema, hold conditions, and detailed agent cleanup requirements belong in `references/closeout-state-detail.md` or the runtime cleanup owner.
### Reference Map
- `references/closeout-state-detail.md`: closeout state schema, hold conditions, residual truth, and detailed agent cleanup requirements.

## Activation
Load this skill when explicit user-directed session end or confirmed teardown intent is active, OR before any teardown-class tool call (`TeamDelete`, `CronDelete`, equivalent runtime-teardown tool).
Calling a teardown-class tool outside an active `session-closeout` boundary is a `[PROC-HABIT]` procedural defect routed to `self-growth-sequence`; the hook runtime guard is enforcement evidence, not authorization.
Reviewer / agent task completion is not session end; teardown requires user-directed intent or proven session-closing basis.
Hook feedback can surface teardown state but is not authority.
Product-delivery closeout for executable deliverables belongs to `dev-workflow` operator-delivery before session teardown.

### Reporting Curtain Inheritance
This skill governs session closeout, not report admission.
User-facing prose is owned by `.claude/reference/user-reporting-law.md`.

## Runtime Teardown Preflight
Run this before `TeamDelete`, `CronDelete`, or any runtime mutation that tears down session runtime.

### Required invariants
1. Confirm explicit closeout or teardown intent.
2. Preserve the closeout truth that would be harder to recover after runtime mutation: acceptance state, unresolved blockers, live-agent output, and residual state.
3. Account for each live process-backed teammate as terminated, shutdown, held, or still live.
4. Mutate runtime state only when it will not erase closeout truth that has not yet been preserved or carried forward.
5. If runtime deletion fails and only non-live residue remains, stop retries and carry that residue into truthful closeout output instead of improvising teardown repair work.

## Closeout Sequence
`Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed teardown handoff requires runtime shutdown.

Keep closeout narrow:
- account for live agents
- remove live runtime when available
- leave a truthful residual state when not

### Core law
- Explicit closeout intent preempts ordinary planning, synthesis, and completion-style transporting.
- Once closeout owns the path, agent outputs can narrow residual truth only.
- A late agent output after closeout intent can still narrow residual truth.
- Treat late output as residual evidence, not ordinary completion.
- Hook-maintained closeout state tracks teardown progress.
- If continuity, runtime state, and teardown evidence disagree, prefer truthful `HOLD` or warning-bearing closeout over repair choreography during teardown.
- Partially booted explicit runtime follows the direct closeout path.

### Required invariants
1. Load `session-closeout`; its hook state marks explicit closeout intent before session-level `shutdown_request`, monitor deletion, or runtime teardown.
2. Integrate agent outputs only enough to preserve unresolved acceptance, blocker, handoff, or residual-state truth.
3. Shutdown, hold, or residue-account live teammates; shutdown and `TeamDelete` order is incidental once required closeout truth is preserved or carried forward.
4. If any live process-backed teammate still has unresolved output or blocker truth after runtime deletion, report warning-bearing closeout or `HOLD`.
5. Keep continuity handling minimal during teardown.
6. Bounded teardown only while new runtime evidence changes the result.
7. No repeated teardown on the same evidence and no ad hoc runtime surgery.
8. Let `SessionEnd` finish continuity capture and clear runtime-owned transient residue.
9. Run team-lead-owned supervisor-effectiveness review only when the user asked for it, a real teardown/management defect occurred, or self-growth work is active.
10. End with concise operator-facing closeout only when blocked, warning-bearing, explicitly requested, or review-triggered.
11. Otherwise clean closeout stays silent or one-line.

### Fast paths
- No-runtime fast path: when no explicit team runtime or recurring monitor was created in the current session, closeout reduces to intent mark, exact residual disclosure if needed, and `SessionEnd` capture.
- User-facing output is a short acknowledgement at most.
- No-acceptance-surface and operational-only not-needed eligibility is defined in `references/closeout-state-detail.md`.
- Implementation deliverables route to `HOLD` until validation ownership and acceptance evidence are resolved.

### Closeout constraints
- Session-end intent comes from explicit closeout or teardown basis.
- New agent dispatch stays outside closeout.
- During active closeout, `TeamDelete` is allowed without a shutdown-order error; unresolved live-agent truth is carried as warning, hold, or residue.
- Runtime cleanup is lead-owned.
- Teammate cleanup truth stays lead-owned.
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

## Resolve Next Owner And Action
- Clean closeout exits silently or with one line.
- Warning-bearing closeout reports exact residual state, hold reason, and next recovery surface.
- Unresolved live-agent truth reports warning-bearing closeout or `HOLD`.
- Product-delivery residuals return to the owning delivery or acceptance path before teardown completion.
- Runtime residue carries forward as residual truth when teardown repair would erase closeout truth.
