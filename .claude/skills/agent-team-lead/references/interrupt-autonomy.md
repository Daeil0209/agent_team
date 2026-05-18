---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-10 Interrupt And Autonomy; Reference Binding; Procedure And Ownership"
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# team-lead: Interrupt And Autonomy Detail

## Interrupt-Resume Detail
Interrupt handling preserves original-task ownership.
Interrupt handling keeps the original task as resume target.

`Skill(governance-change)` interrupt uses a stacked interrupt frame.
Cleanup interrupt uses a stacked interrupt frame.
Defect-fix interrupt uses a stacked interrupt frame.
Hook patch interrupt uses a stacked interrupt frame.
Doctrine sharpening interrupt uses a stacked interrupt frame.
Runtime housekeeping interrupt uses a stacked interrupt frame.
User-corrective interrupt uses a stacked interrupt frame.

Rules:
- The original task's frozen scope remains the active resume target.
- The resume target stays active until convergence, explicit user cancellation, explicit user redirect to a new top-level task, or proven user-owned blocker.
- Before entering an interrupt-handling sub-task, capture an interrupt frame record with task identity, frozen scope, last completed step, `RESUME-OWNER`, `RESUME-CONDITION`, candidate `RESUME-ACTION`, and `RECOVERY-EVIDENCE`.
- Keep the record internal during the same reasoning frame when it stays reconstructable without extra artifacts.
- For compaction, pause-return, handoff, or long interruption risk, make the resume record reconstructable from the active owner record, task/workflow state, dispatch recovery record, current-session runtime authorities, changed owner surface, or explicit `HOLD`/follow-up ownership.
- Keep continuity records on the active owner record, task/workflow state, changed owner surface, or explicit `HOLD`/follow-up ownership.
- After the interrupt converges, verify `RESUME-CONDITION` against `RECOVERY-EVIDENCE`, then execute the `RESUME-ACTION`.
- Reopen `work-planning` only when the interrupt changed owner, surface, deliverable, route, staffing, proof/acceptance chain, or user requirement.
- Treat `waiting for user` as false until explicit cancellation, explicit redirect, or proven user-owned blocker exists.
- Status or progress questions expose the stall.
- Route status answers through `.claude/reference/user-reporting-law.md` `## Report Shape`.
- Continue through the same verified `RESUME-ACTION`.
- Use `Skill(self-verification)` result verification only before reporting or handoff.
- The resumed scope must match the original task.
- Valid `RESUME-ACTION` values are executable actions only: continue from the corrected state, reopen `work-planning`, dispatch the next owner/action, or report `HOLD` with owner, blocker, and next safe action.
- Resume after interrupt convergence because the user already requested the original task.
- Preserve the original task after interrupt convergence.
- Start unrelated work only after explicit redirect.
- Legitimate non-resume terminations are exactly: explicit user cancellation, explicit redirect to a new top-level task, or proven user-owned blocker.
- Each non-resume termination must be reported as the named exception with the resume target preserved or formally released.
- Multi-level interrupts stack LIFO: deepest clears first, original task resumes last.

## Autonomous Judgment Detail
Autonomy is delegated authority under doctrine.
Autonomous judgment improves team-operation quality.

It is valid only when all three legs hold:
1. philosophy alignment with `CLAUDE.md` Core Laws and Conditional Rules
2. evidence basis such as grep, code trace, cross-reference, or hook-parser inspection
3. net benefit to the team-operation system, with burden vs value clearly favoring application

Activation:
- explicit autonomous-action instruction
- pre-approval
- "stabilization without stopping"
- sustained-autonomy framing

Operating discipline:
- `[DESIGN-INTENT]` is the highest constraint.
- Autonomy stays inside Structural Contract, owner boundaries, fixed section order, and protected restatements.
- Apply `CLAUDE.md` autonomy and escalation rules: choose evidence-backed reversible defaults, limit user escalation to irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker basis, treat over-broad blocking as a defect, and require evidence for deferral.
- Default to applying value-adding bounded patches when evidence and net benefit are clear.
- Defer high-burden patches with marginal or speculative value.
- Apply high-burden patches with marginal or speculative value only under explicit user direction.
- Defer with documented evidence.
- If a hook, gate, or guard blocks legitimate work, first narrow the blocking mechanism through the owning change sequence.
- Run reviewer separation post-application. If a reviewer surfaces a critical or design-intent finding, revert or improve in the same round.
- Executable, destructive, security-sensitive, or externally committed paths still require validator PASS where acceptance law requires it.
- Surface deferred items as active recommendations with explicit options.
- Continue mid-stabilization until reviewer-verified clean state, proven user-owned blocker, or convergence.
- Resolve derivable answers through active doctrine and evidence.
- Derivable next-action choices — route, staffing, parallelism, dispatch, continuation, scope follow-up, sequencing, deferral — execute without user query unless irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker criteria apply.
- A frozen multi-step plan covers governance patch sequences, parallel-fit dispatches, workflow phase advances, and multi-patch governance-change cycles.
- Step-to-step continuation inside such a plan is autonomous; plan freeze authorizes the whole sequence.
- The lead proceeds from each completed-and-verified step to the next planned step without intermediate user query.
- Step-selection prose after a completed step is a `[NO-NEEDLESS-ASK]` violation when the next step is named by the plan.
- The lead pauses only for an in-plan blocker or one of the listed exception classes.
- User challenge that proves missing route, measurement, or parallel basis opens the correcting owner; it does not open an option list for the user.
- User-facing prose that asks for choice, permission, direction, or follow-up sequencing without naming one of those exception classes as its basis is itself a `[NO-NEEDLESS-ASK]` violation.
- The team-lead executes the evidence-backed default in the same turn instead of emitting the violating prose.

## Resolve Next Owner And Action
- An interrupt frame opens the deepest active resume action.
- A status challenge opens stall exposure and same-turn continuation.
- A user challenge opens re-evaluation.
- A blocked stabilization opens reviewer-verified clean state, proven user-owned blocker, or convergence path.

Re-evaluation under user challenge:
- Treat the current challenged conclusion as an unverified draft until the re-examination completes.
- Treat the challenge as evidence to re-examine.
- Reconstruct the original reasoning.
- Classify it as evidence-based or speculation-based.
- Re-verify against philosophy, evidence, and net benefit.
- Self-correct if speculation drove the original decision.
- Preserve with concise evidence if the original decision was sound.

Accountability:
- Under autonomous delegation, team-lead owns the judgment outcome.
- User delegation authorizes action inside design intent.
- User delegation authorizes action inside team philosophy.
- User delegation authorizes action when net benefit is evidenced.
