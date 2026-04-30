---
name: session-closeout
description: Closeout procedures for team-lead session teardown and runtime cleanup.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: `Activation` -> `Runtime Teardown Preflight` -> `Closeout Sequence`
- PRIMARY-OWNER: team-lead
- This file owns the closeout spine only. State schema, hold conditions, and detailed agent lifecycle requirements belong in `references/closeout-state-detail.md` or the runtime lifecycle owner.
- Structural changes require governance review.
### Reference Map
- `references/closeout-state-detail.md`: closeout state schema, hold conditions, residual truth, and detailed agent lifecycle requirements.

## Activation
Load this skill when explicit user-directed session end or confirmed teardown intent is active. Hook feedback may surface teardown state, but hook signals alone do not prove session-end intent.

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

Closeout is not a recovery project, retrospective audit, or completion theater. Its default purpose is narrow:
- account for live agents
- remove live runtime when possible
- leave a truthful residual state when not

### Core law
- Explicit closeout intent preempts ordinary planning, synthesis, and completion-style reporting.
- Once closeout owns the path, agent outputs may narrow residual truth only. They must not upgrade the session into ordinary positive completion reporting or stronger deliverable-complete claims.
- A late agent output after closeout intent may still narrow residual truth even when it does not carry the ordinary completion spine; treat it as residual evidence, not as ordinary completion.
- Hook-owned closeout state tracks teardown progress, but hook signals alone do not determine user intent.
- If continuity, runtime state, and teardown evidence disagree, prefer truthful `HOLD` or warning-bearing closeout over repair choreography during teardown.
- If the explicit runtime is only partially booted, do not finish boot just to tear it down. Closeout takes the path directly.

### Required order
1. Mark explicit closeout intent before sending session-level `shutdown_request`, deleting monitors, or tearing down runtime.
2. Integrate agent outputs only enough to disclose unresolved acceptance, blocker, or residual-state truth.
3. Resolve or explicitly account for remaining live agents through explicit lifecycle messages, using the teardown exception only where closeout doctrine allows it.
4. Keep continuity handling minimal during teardown. Do not create helper lanes or re-open runtime only to polish continuity.
5. Remove live-session monitors only after current-runtime agents are fully accounted for.
6. Tear down explicit runtime only after agent state is drained. Bounded teardown once; no teardown loops or ad hoc runtime surgery.
7. Let `SessionEnd` finish continuity capture after runtime teardown.
8. Let `SessionEnd` cleanup clear runtime-owned transient residue after continuity capture.
9. Run team-lead-owned supervisor-effectiveness review only when the user asked for it, a real teardown/management defect occurred, or self-growth work is active.
10. End with concise operator-facing closeout only when blocked, warning-bearing, explicitly requested, or review-triggered; otherwise clean closeout may stay silent or one-line.

### Fast paths
- No-runtime fast path: when no explicit team runtime or recurring monitor was created in the current session, closeout reduces to intent mark, exact residual disclosure if needed, `SessionEnd` capture, and short acknowledgement at most.
- No-acceptance-surface fast path: when the session produced no implementation deliverable or no acceptance surface was created, set validation ownership to `not-needed` and do not manufacture extra closeout ceremony.

### Closeout constraints
- Do not infer session-end intent from hook feedback, runtime residue, or repeated warnings alone.
- Do not dispatch new agents during closeout.
- Do not treat `TeamDelete` as agent cleanup; drain or account for live agents first.
- Runtime cleanup is lead-owned. Teammates must not perform team cleanup, and project files must not be used to hand-author or repair Claude Code team config, task list, mailbox, or cleanup state.
- Do not use mutable shell cleanup or ad hoc registry surgery on governed runtime surfaces during closeout.
- Do not present blocked or partially cleaned closeout as complete success.
- Clean closeout stays silent or one-line. Warning-bearing closeout stays short: exact residual state, exact hold reason, and next recovery surface only.

See `references/closeout-state-detail.md` for:
- `Closeout State Schema`
- `not-needed Conditions`
- `Hold Conditions`
- `Agent Lifecycle Resolution`
