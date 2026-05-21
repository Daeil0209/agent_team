---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-17 Interrupt And Autonomy; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# team-lead: Interrupt And Autonomy Detail

## Interrupt-Resume Detail
Interrupt handling preserves original-task ownership.
Interrupt handling keeps the original task as resume target.

These interrupt classes use a stacked interrupt frame: `Skill(governance-modification)`, cleanup, defect-fix, hook patch, doctrine sharpening, runtime housekeeping, and user-corrective interrupts.

Rules:
- The original task's frozen scope remains the active resume target.
- The resume target stays active until convergence, explicit user cancellation, explicit user redirect to a new top-level task, or proven user-owned blocker.
- Before entering an interrupt-handling sub-task, capture an interrupt frame record with task identity, frozen scope, last completed step, `RESUME-OWNER`, `RESUME-CONDITION`, candidate `RESUME-ACTION`, and `RECOVERY-EVIDENCE`.
- Keep the record internal during the same reasoning frame when it stays reconstructable without extra artifacts.
- For compaction, pause-return, handoff, or long interruption risk, make the resume record reconstructable from the active owner record, task/workflow state, dispatch recovery record, current-session runtime authorities, changed owner surface, or explicit `HOLD`/follow-up ownership.
- Keep continuity records on the active owner record, task/workflow state, changed owner surface, or explicit `HOLD`/follow-up ownership.
- After the interrupt converges, verify `RESUME-CONDITION` against `RECOVERY-EVIDENCE`, then execute the `RESUME-ACTION`.
- A corrective interrupt is not closed until the verified `RESUME-ACTION` is executed, the original owner is reopened, or a legitimate non-resume termination is recorded.
- Reopen `work-planning` only when the interrupt changed owner, surface, deliverable, route, staffing, proof/acceptance chain, or user requirement.
- Treat `waiting for user` as false until explicit cancellation, explicit redirect, or proven user-owned blocker exists.
- Status or progress questions expose the stall.
- Route status answers through `.claude/reference/reporting-prohibition-law.md` `## Report Shape`.
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
1. philosophy alignment with `.claude/CLAUDE.md` numbered philosophy sections
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
- Apply `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.
- Default to applying value-adding bounded patches when evidence and net benefit are clear.
- Defer high-burden patches with marginal or speculative value.
- User-requested `patch-ready` rows and frozen `SCOPE-BASELINE` rows keep their owning completion route outside this high-burden deferral rule.
- Apply high-burden patches with marginal or speculative value only under explicit user direction.
- Defer with documented evidence.
- If a hook, gate, or guard blocks legitimate work, first narrow the blocking mechanism through the owning change sequence.
- Run reviewer separation post-application. If a reviewer surfaces a critical or design-intent finding, revert or improve in the same round.
- Executable, destructive, security-sensitive, or externally committed paths still require validator PASS where acceptance law requires it.
- Surface deferred items as active recommendations with explicit options.
- Continue mid-stabilization until reviewer-verified clean state, proven user-owned blocker, or convergence.
- Resolve derivable answers through active doctrine and evidence.
- Derivable next-action choices — route, staffing, parallelism, dispatch, continuation, scope follow-up, sequencing, deferral — execute without user query unless irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker criteria apply.
- `[NO-NEEDLESS-ASK]` governs owner-decidable choices inside existing authority; status, yes/no, verification, explanation, audit, or explicit hold-conversation channels stay non-mutating unless the user instruction or current frozen execution boundary already authorizes mutation.
- Deferral that changes frozen deliverable scope, `SCOPE-BASELINE`, completion stop, review-promotion coverage, patch-loop coverage, or validation scope is operator-policy-choice unless explicit user acceptance or `[USER-DELIVERY-FIT]` lawful basis is already recorded.
- A frozen multi-step plan covers governance patch sequences, parallel-fit dispatches, workflow phase advances, and multi-patch governance modification cycles.
- Step-to-step continuation inside such a plan is autonomous; plan freeze authorizes the whole sequence.
- The lead proceeds from each completed-and-verified step to the next planned step without intermediate user query.
- Step-selection prose after a completed step is a `[NO-NEEDLESS-ASK]` violation when the next step is named by the plan.
- The lead pauses only for an in-plan blocker or one of the listed exception classes.
- User challenge that proves missing route, measurement, parallel basis, or doctrine-derived correction opens the correcting owner.
- User-facing prose that asks for choice, permission, direction, or follow-up sequencing, or declares a self-created `HOLD`/waiting state, without naming one of those exception classes as its basis is itself a `[NO-NEEDLESS-ASK]` violation.
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
- Team-lead owns the autonomous-judgment outcome under the three-leg validity rule above.
