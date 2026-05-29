---
name: session-closeout
description: Close team-lead sessions with teardown truth, runtime cleanup, residual disclosure, and continuity preservation. Use when explicit closeout, session ending, runtime shutdown, or residual state handoff is active.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its closeout procedure surface.
- Fixed top-level section order after Structural Contract: `Activation` -> `Runtime Teardown Preflight` -> `Closeout Sequence` -> `Resolve Next Owner And Action`.
- Reference Map stays inside Structural Contract.
- Handles the closeout spine only.
- State schema, hold conditions, and detailed agent cleanup requirements belong in `references/closeout-state-detail.md` or the runtime cleanup path.
### Reference Map
- `.claude/reference/environment-configuration-core-law.md`: load when teardown, runtime cleanup, residual runtime truth, hook-maintained closeout state, or runtime-bound continuity changes the closeout owner/action.
- `references/closeout-state-detail.md`: closeout state schema, hold conditions, residual truth, and detailed agent cleanup requirements.

## Activation
Load this skill when explicit user-directed session end or confirmed teardown intent is active, OR before any session-teardown tool call (`TeamDelete`, `CronDelete`, equivalent session-runtime teardown tool).
Agent/member cleanup wording without explicit session-end intent routes to `Skill(task-execution)` runtime cleanup through `.claude/skills/task-execution/references/runtime-dispatch-law.md`.
If an owner consumed `Skill(session-closeout)` from agent-cleanup wording alone, classify the owner action as a `[PROC-HABIT]` scope-expansion defect and open `Skill(governance-modification)`.
Calling a session-teardown tool outside an active `session-closeout` boundary is a `[PROC-HABIT]` procedural defect routed to `Skill(governance-modification)`; the hook runtime guard is enforcement evidence, not access-control.
Reviewer / agent task completion is not session end; teardown requires user-directed intent or proven session-closing basis.
Hook feedback can surface teardown state but is not a decision basis.
Product-delivery closeout for executable deliverables belongs to `dev-workflow` operator-delivery before session teardown.

### Reporting Curtain Inheritance
This skill governs session closeout, not report exceptions.
Report admission is governed by `.claude/reference/reporting-prohibition-law.md`; admitted closeout-residual shape is governed by `.claude/reference/reporting-user-reporting-law.md`.

## Runtime Teardown Preflight
Run this before `TeamDelete`, `CronDelete`, or any runtime mutation that tears down session runtime.

### Required invariants
1. Confirm explicit closeout or teardown intent.
2. Preserve the closeout truth that would be harder to recover after runtime mutation: acceptance state, unresolved blockers, live-agent output, and residual state.
3. Account for each live process-backed teammate as terminated, shutdown, held, or still live.
4. Mutate runtime state only when it will not erase closeout truth that has not yet been preserved or carried forward.
5. If runtime deletion fails and only non-live residue remains, end retries and carry that residue into truthful closeout output instead of improvising teardown repair work.

## Closeout Sequence
`Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed teardown handoff requires runtime shutdown.

Keep closeout narrow:
- account for live agents
- remove live runtime when available
- leave a truthful residual state when not

### Core law
- Explicit closeout intent preempts ordinary planning, synthesis, and completion-style transporting.
- Once closeout handles the path, agent outputs can narrow residual truth only.
- A late agent output after closeout intent can still narrow residual truth.
- Treat late output as residual evidence, not ordinary completion.
- Hook-maintained closeout state tracks teardown progress.
- If continuity, runtime state, and teardown evidence disagree, prefer blocker-routing with residual truth or warning-bearing closeout over repair choreography during teardown.
- Partially booted explicit runtime follows the direct closeout path.

### Required invariants
1. Load `session-closeout`; its hook state marks explicit closeout intent before session-level `shutdown_request`, monitor deletion, or runtime teardown.
2. Integrate agent outputs only enough to preserve unresolved acceptance, blocker, handoff, or residual-state truth.
3. Preserve unresolved teammate output or blocker truth, then resolve each live process-backed teammate through structured shutdown, termination proof, blocker-routing with residual truth, or non-live residue classification before `TeamDelete`.
4. If any live process-backed teammate lacks termination proof, route warning-bearing closeout or blocker-routing through `.claude/reference/reporting-prohibition-law.md` and leave `TeamDelete` uncalled.
5. Keep continuity handling minimal during teardown.
6. Bounded teardown only while new runtime evidence changes the result.
7. No repeated teardown on the same evidence and no ad hoc runtime surgery.
8. Let `SessionEnd` finish continuity capture and clear runtime-bound transient residue.
9. Set `supervisorReviewState: required` only when the user asked for closeout-management review, a real teardown/management defect occurred, or `Skill(governance-modification)` work is active; set it `completed` after team-lead records the review result.
10. End with user-facing closeout prose only after `.claude/reference/reporting-prohibition-law.md` admission and `.claude/reference/reporting-user-reporting-law.md` shape control, using residual truth when blocked, warning-bearing, explicitly requested, or review-triggered.
11. Otherwise clean closeout stays silent unless `.claude/reference/reporting-prohibition-law.md` admits one-line closeout-residual prose.

### Fast paths
- No-runtime fast path: when no explicit team runtime or recurring monitor was created in the current session, closeout reduces to intent mark, exact residual disclosure if needed, and `SessionEnd` capture.
- User-facing output, when admitted by `.claude/reference/reporting-prohibition-law.md` and shaped by `.claude/reference/reporting-user-reporting-law.md`, is a short closeout-residual acknowledgement at most.
- No-acceptance-surface and operational-only not-needed eligibility is defined in `references/closeout-state-detail.md`.
- Implementation deliverables return to the governing validation or acceptance path until validation path and acceptance evidence are resolved.

### Closeout constraints
- Session-end intent comes from explicit closeout or teardown basis.
- New agent dispatch stays outside closeout.
- During active closeout, `TeamDelete` opens only after each live process-backed teammate has termination proof or non-live residue classification and unresolved live-agent truth is preserved or carried forward.
- Runtime cleanup is handled by lead.
- Teammate cleanup truth stays with lead.
- Team config, task list, mailbox, and cleanup state stay runtime-bound.
- Governed runtime cleanup uses governed runtime surfaces.
- Blocked or partially cleaned closeout routes residual truth through `.claude/reference/reporting-prohibition-law.md`.
- Clean closeout stays silent unless `.claude/reference/reporting-prohibition-law.md` admits one-line closeout-residual prose.
- Warning-bearing closeout stays short under `.claude/reference/reporting-user-reporting-law.md`: exact residual state, exact hold reason, and next recovery surface only after report admission.

See `references/closeout-state-detail.md` for:
- `Closeout State Schema`
- `not-needed Conditions`
- `Hold Conditions`
- `Agent Lifecycle Resolution`

## Resolve Next Owner And Action
- Clean closeout exits silently unless `.claude/reference/reporting-prohibition-law.md` admits one-line closeout-residual prose.
- Warning-bearing closeout routes exact residual state, hold reason, and next recovery surface through `.claude/reference/reporting-prohibition-law.md`.
- Unresolved live-agent truth routes warning-bearing closeout or blocker-routing through `.claude/reference/reporting-prohibition-law.md`.
- Product-delivery residuals return to the governing delivery or acceptance path before teardown completion.
- Runtime residue carries forward as residual truth when teardown repair would erase closeout truth.
