---
name: self-growth-sequence
description: Self-growth procedures for team capability hardening and behavioral defect correction.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: Ultimate Purpose, Activation, Self-Growth Sequence, Sequence Activation Discipline, Change Sequence, Patch Execution Method
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Ultimate Purpose
This skill exists because repeated team failure must not be treated as ordinary variance or repaired with symptom-only edits. When evidence shows a behavioral or procedural defect, the team first protects the active request's correctness and safety, then explains why the existing operating system failed, and only then converts the defect into a durable recurrence barrier on the narrowest correct owner surface before ordinary execution resumes.

Mandatory path: defect evidence identifies the failure; design-intent review reconstructs the rule or procedure that should have governed; causal analysis explains why it failed in execution; failure classification exposes the recurrence path; ownership adjudication chooses the prevention surface; hardening installs the barrier; verification proves the barrier or assigns bounded follow-up ownership; only then may the team resume from the corrected basis.

Self-growth is not explanation, apology, awareness, intent, or "will remember" language. Those describe a miss; they do not change future behavior. Self-growth is also not broad doctrine accumulation when a narrow owner-local rule, checklist, packet field, hook, skill, reference, role boundary, or settings surface blocks the same failure with less drift.

Every self-growth round must remain reconstructable through this minimum record:
- `DEFECT-BASIS`
- `DESIGN-INTENT-BASIS`
- `CAUSAL-BASIS`
- `FAILURE-MODE`
- `RECURRENCE-PATH`
- `OWNER-SURFACE`
- `BARRIER-TYPE`
- `CHANGE-BOUNDARY`
- `VERIFICATION-BASIS`
- `CONVERGENCE-STATUS`
- `SUSPENDED-WORK-SURFACE`
- `RESUME-OWNER`
- `RESUME-CONDITION`
- `RESUME-ACTION`
- `FOLLOW-ON-OPTIMIZATION`
If any required record item is unknown, the round stays open as inspection, `HOLD`, or explicit follow-up ownership; it does not close as commentary.
## Activation
Load this skill when a concrete behavioral defect, hook-confirmed process failure, or recurring missed-catch is detected (self-detected, hook-detected, or user-corrected). If the trigger is ordinary non-defect asset maintenance, this sequence is not primary; route through `update-upgrade-sequence` instead and use `Change Sequence` from here only as patch-mechanics support (per `Sequence Arbitration Law` in CLAUDE.md). Trigger sources:
- UserPromptSubmit hook detects correction patterns and injects "SELF-GROWTH TRIGGER" reminder
- `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership contains the lead-owned adjudication and closure boundary
- Verified runtime/process error signals may raise confirmed self-growth without waiting for direct user instruction once the defect basis is already sufficient to govern behavior.
This skill also contains the Change Sequence and Patch Execution Method for governance changes.
Self-growth tiers:
- Quick hardening: single-line fixes, typo corrections, terminology normalization. Required: identify owner surface → apply fix through Change Sequence (developer self-review sufficient per Step 5) → verify no regression.
- Standard hardening: behavioral rule changes, new constraints, recurrence barriers. Requires all steps.
- Structural hardening: architecture-level changes, cross-document impact. Requires all steps plus governance review.

### Reference Map
Load these files directly from `SKILL.md` when their trigger is active. Do not route through an intermediate `reference.md`.
- `references/self-healing.md`: trigger matrix and closure checklist.
- `references/retroactive-application.md`: retroactive audit requirements after new/sharpened rules land.
- `references/causal-analysis.md`: reconstruction questions and causal-basis standard.
- `references/governance-architecture-map.md`: owner-surface map for doctrine, role, skill, packet, hook, setting, and reference placement.
- `references/repair-decision-guide.md`: narrowest repair selection and no-duplicate-doctrine guard.
- `references/capability-gap-fast-path.md`: missing reusable-skill fast path and default rapid-skill routing.
- `references/skill-introduction.md`: new-skill category gate, reject criteria, and approval packet.
- `references/benchmark-protocol.md`: benchmark-first preparation and self-growth comparison gates.
- `references/patch-classification.md`: patch class definitions.
- `references/failure-mode-response.md`: failure mode matrix and allowed/prohibited responses.
- `references/human-readable-packet-owners.md`: semantic packet catalogs for governance and solution-development patches.
- `references/high-traffic-surfaces.md`: high-traffic governance surfaces and protection layers.
- `references/self-growth-constraints.md`: constraint checklist.
- `references/change-patch-method.md`: detailed Change Sequence, patch execution method, meaning routing, specialist ordering, file/runtime hygiene, and hook enforcement rules.
## Self-Growth Sequence
The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.
- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar or regress an already-correct path.
- Treat self-growth as the default self-healing response to a real defect. Once the problem basis is valid, move from explanation into bounded hardening immediately instead of normalizing the miss as commentary.
- Default cure: harden the failing owner-local path first. Tighten, replace, or re-home the rule, hook, checklist, packet, or reference that failed before adding new doctrine.
- When self-growth expands a lane's charter or capability, make a bounded follow-on optimization decision before closing. Run the optimization pass when material avoidable cost or redundancy is visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed`. Always preserve the upgraded quality bar and protected meaning.
### Self-Healing Algorithm
The algorithm is expressed by the defect-to-barrier contract, causal repair standard, governance repair orientation, numbered sequence, trigger discipline, ownership adjudication, required order, and closure standard below.
### Defect-To-Barrier Contract
Every self-growth round must preserve this chain:
`DEFECT-BASIS -> DESIGN-INTENT-BASIS -> CAUSAL-BASIS -> FAILURE-MODE -> RECURRENCE-PATH -> OWNER-SURFACE -> BARRIER-TYPE -> CHANGE-BOUNDARY -> VERIFICATION-BASIS -> CONVERGENCE-STATUS -> SUSPENDED-WORK-SURFACE -> RESUME-OWNER -> RESUME-CONDITION -> RESUME-ACTION`.
If any link is missing, do not close. Either inspect until the link is known, keep the round on `HOLD`, or assign explicit follow-up ownership with boundary and closure basis.

Allowed barrier types:
- rule hardening
- owner re-home
- checklist or packet-field hardening
- hook or runtime enforcement refinement
- skill capability update
- role-boundary correction
- reference or template repair
- explicit follow-up ownership when immediate hardening is blocked

The barrier must match the failure mode. `non-compliance` demands adherence hardening, not duplicate doctrine. `capability-gap` demands capability installation or bounded owner update, not ad hoc execution. `wrong-owner` demands re-home or explicit owner correction, not local patching by habit.

### Causal Repair Standard
Do not patch from the visible symptom alone. Before drafting, explain why the existing rule, procedure, packet, role boundary, hook, reference, or verification gate failed to produce the expected behavior in the actual work path.

A valid causal basis must identify:
- the intended governing rule or procedure
- the execution point where it failed to surface, bind, or stop behavior
- whether the failure came from missing rule, weak wording, wrong owner, weak trigger, weak packet field, weak runtime signal, weak verification, or non-compliance
- why the proposed edit blocks the recurrence path without creating a broader or conflicting operating model

If causal basis is only a hypothesis, do not present the patch as a completed hardening result. Either gather stronger evidence, mark the basis as hypothesis and install only a bounded reversible guard, or assign follow-up ownership.

### Governance Repair Orientation
Self-growth does not invent a parallel operating model. It repairs the existing agent-team operating system so its intended doctrine, role boundaries, procedures, packet contracts, hooks, and verification gates work reliably during real execution.

Before choosing a barrier, reconstruct the governing design from the active owner surfaces:
- top-level doctrine philosophy, priority, ownership, and preservation law
- team-lead intake, routing, dispatch, synthesis, closeout, and self-growth ownership
- lane role contracts and lane-core skill boundaries
- `work-planning`, `self-verification`, `task-execution`, workflow, session, and closeout procedure ownership
- packet fields, message classes, runtime truth, and handoff contracts
- hook, settings, and runtime enforcement maturity
- reference files as lookup surfaces, not hidden always-on doctrine

Then locate the actual break in that design. A patch is valid only when it strengthens the intended operating behavior at the narrowest correct owner surface. Prefer rewriting, tightening, replacing, merging, or re-homing existing wording before adding a new rule. Do not change the operating philosophy, route ownership, lane boundary, proof owner, acceptance owner, or skill-loading model unless structural evidence proves that design surface itself is the defect.

Use `references/causal-analysis.md`, `references/governance-architecture-map.md`, and `references/repair-decision-guide.md` when the root cause, correct owner surface, or patch direction is not obvious.

When a defect or justified challenge is recognized, run this sequence:
1. Trigger — confirm the problem basis is real enough to govern behavior now.
2. Stabilize — protect the active request's correctness and safety basis first; if active work is interrupted, record the suspended surface, last safe state, current owner, and next resume decision.
3. Reconstruct — identify the intended rule, owner, procedure, packet, hook, or verification path that should have prevented the failure.
4. Diagnose — explain why that design failed in execution and classify the failure mode.
5. Dispatch — open self-growth immediately as a sidecar or nearest-safe-boundary patch path.
6. Harden — patch the correct owner surface with the smallest meaning-preserving edit.
7. Re-verify — gather fresh evidence on the affected path.
8. Iterate — if verification finds a remaining or newly created defect, return to Reconstruct or Diagnose with the new evidence and repair again.
9. Resume corrected state — continue with the strengthened basis, reopen planning, or assign an explicit blocker owner; never leave the interrupted work ownerless.
Self-healing is complete only when the recurrence path is hardened or explicitly assigned with owner, boundary, and closure basis. Explanation alone is not self-healing.
### Trigger discipline
- On recognizing a behavioral defect, classify it before any unsafe continuation, then complete causal diagnosis before drafting durable hardening.
- Open self-growth as a sidecar or nearest-safe-boundary patch path. Durable hardening waits for sufficient causal basis; ordinary continuation waits for the corrected state or explicit `HOLD` ownership.
- Self-growth does not outrank freezing the active request's immediate request-fit, deliverable shape, or correctness/safety basis. If the defect blocks safe or correct handling now, stabilize first, then dispatch at the nearest safe boundary.
- If write-surface overlap with active production work exists, queue only until the overlap clears. That is write safety, not priority deferral.
- Classification without an opened self-growth path is not action.
- If an equivalent rule already exists, treat the defect as non-compliance and harden adherence instead of adding duplicates.
- While the self-growth entry gate is active, do not keep retrying blocked consequential tools. Pause queued `TaskCreate`, `Agent`, `SendMessage`, `TaskUpdate`, or other consequential retries, load `self-growth-sequence` first, then resume from the corrected state after the gate clears.
- When self-growth interrupts active work, record `SUSPENDED-WORK-SURFACE`, last safe state, `RESUME-OWNER`, and candidate `RESUME-ACTION` before the interruption becomes invisible.
- A justified user correction is authoritative enough to open self-growth immediately even on first occurrence. Do not wait for repetition before hardening a real, well-supported failure.
- Self-growth dispatch may be immediate, but governance-sensitive file modification is still execution-gated. Use dispatch to classify, route, inspect, and prepare the bounded patch packet. Only destructive or security-sensitive execution requires explicit user confirmation.
- When a missing reusable skill blocks execution, authorize skill introduction under `Self-Growth Sequence` with explicit ownership: gap confirmation, target owner, bounded scope, review path, and verification.
- When more than one lane could plausibly own the growth topic, do not let the most familiar lane win by habit. Record the competing owner candidates, choose the narrowest prevention owner, and state why the rejected owners would duplicate, miss, or weaken the recurrence barrier.
### Self-Growth Ownership Adjudication
- Ownership claims for improvement work must be explicitly adjudicated by the supervisor; approve, reject, merge, reduce, defer, and reassign are all valid outcomes.
- Ownership of improvement work must be explicit; ownerless gaps are not allowed at round close.
- The supervisor remains the staffing, mediation, adjudication, and merge-governance owner for self-growth rounds and must not become the hidden primary producer or bottleneck.
### Required order
Self-growth does not bypass the default consequential work sequence. `work-planning` and `self-verification` remain the default prerequisite basis unless the recursion guard inherits an already-active WP/SV context.
Prerequisite A. Load the `work-planning` skill. Freeze scope, approach, and verification criteria before proceeding to Step 1.
Prerequisite B. Load the `self-verification` skill and execute Critical Challenge on the improvement plan before proceeding to Step 1. This is the MWEC Plan Verification phase.
Recursion guard: When self-growth triggers during active work-planning or self-verification execution (the defect is detected while those skills are already loaded and running in the current work cycle), the self-growth sidecar inherits the already-active WP/SV context as its prerequisite basis. Do not re-load work-planning or self-verification for the self-growth sidecar if either is the source of the trigger. Dispatch the sidecar at the nearest safe boundary after the triggering WP/SV execution completes in the current work cycle.
1. Identify the active improvement topic from evidence.
   Capture at minimum: trigger source, defect class, impacted path, intended governing design, causal basis, recurrence path, and likely owner surface.
2. For standard hardening, structural hardening, material ownership ambiguity, or cross-lane capability impact, require relevant lanes to inspect the topic before ownership is finalized. Quick hardening may use owner-local inspection only when owner surface, write scope, and review path are unambiguous.
   Lane inspection may be local evidence review, routed agent work, or lawful single-thread fallback. Additional-agent dispatch is valid only on a host-authorized active-runtime path and `task-execution` after `SV-PLAN`.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. Install the recurrence barrier on the correct owner surface.
   Harden the rule, checklist, packet requirement, hook, capability boundary, or owner-local procedure that will make the same miss less likely next time.
6.5. **Retroactive application phase (per CLAUDE.md `[RETRO-APPLY]`)**. Before optimization decision and before close, MUST audit every existing artifact, in-flight agent output, prior verdict, active acceptance state, and live deliverable surface that the new rule would have caught. Produce: (a) explicit list of audited surfaces with audit result (clean / defect found / deferred), (b) defect inventory with proposed fixes, (c) fix dispatches sent in same patch chain OR explicit deferral with named follow-up owner + boundary + closure basis, (d) prior verdicts/PASS/closures that pre-date this rule and would have been rejected under it explicitly invalidated (mark `STALE-PRE-{ROUND}` flag) — those acceptance states require fresh re-verification under the new rule before any downstream work proceeds on their basis. Skipping retroactive application — landing doctrine and moving on with "applies going forward only" — is itself a `[RETRO-APPLY]` defect equivalent to silent-PASS class: the recurrence path the new rule targets is already manifest in existing surfaces; not auditing them recreates the same failure the rule was meant to prevent.
7. After the quality-raising change lands AND retroactive application completes, make a bounded follow-on optimization decision. Run the optimization pass only when material avoidable cost, runtime burden, or redundancy is now visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed` and close without manufacturing a redundant extra loop.
8. When the active topic came from recurrence, missed-catch, rejected-challenge evidence, or user-corrected process failure, require a rerun, retest, or equivalent fresh evidence gate before treating the hardening topic as fully closed.
9. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are either hardened into the correct parent document or explicitly assigned follow-up ownership.
### Closure Standard
- Self-growth is not closed while the recurrence path remains implicit.
- If the recurrence path is known but cannot be patched immediately because of write overlap or higher-priority stabilization, keep the topic on `HOLD` with explicit owner, blocked surface, and next safe execution boundary.
- An acknowledgement, user-facing apology, hook marker, dispatch success, role/skill load, or later `self-verification` load is entry or process evidence only. None proves closure unless recurrence barrier, owner surface, and fresh verification basis are explicit.
- A failed verification is not a reporting result. It reopens the self-growth round at the smallest invalidated step: Reconstruct when design intent was wrong, Diagnose when causal basis was weak, Adjudicate when owner surface was wrong, Harden when edit operation was wrong, or Re-verify when evidence was insufficient.
- Each verification attempt still obeys `self-verification` Step 4. If the SV pass reaches `HOLD`, the self-growth round records `CONVERGENCE-STATUS: HOLD`, owner, reason, boundary, and next safe evidence step; it does not claim convergence.
- If `SUSPENDED-WORK-SURFACE` is not `none`, closure requires `RESUME-OWNER` and a verified `RESUME-ACTION`: continue from the corrected state, reopen `work-planning`, dispatch the next owner, or report `HOLD` with owner and blocker. `assigned-follow-up` for the recurrence barrier does not by itself satisfy the resume duty.
- Before closure, the minimum self-growth record must be reconstructable from the changed owner surface, active sequence packet, or explicit follow-up assignment. Hidden session memory is not closure evidence.
- If the issue was real but the owner surface remains uncertain, close only with explicit adjudicated follow-up ownership — never with an ownerless "noted" state.
### Capability-Gap Fast Path
- When a missing reusable skill is the active improvement topic, `team-lead` may authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is a prerequisite for safe, credible, or non-duplicative completion of the active task, stop only the genuinely blocked work surface and complete the skill update or introduction before that surface resumes normal downstream execution. Unrelated or already-safe work should continue instead of being stalled by habit.
- The fast path still requires all 6 steps. See `references/capability-gap-fast-path.md` for the checklist and default routing.
- Fast path means reduced delay, not reduced governance. Do not skip owner fit, overlap review, or information-preservation checks merely because the need is urgent.
- Do not retroactively create a skill just to justify ad hoc behavior that already bypassed the missing capability.
### Skill Introduction Category Gate
Every proposed new skill must be classified into exactly one primary category before approval. See `references/skill-introduction.md` for categories, reject criteria, and approval packet requirements.
### Self-growth constraints
See `references/self-growth-constraints.md` for the constraint checklist.
### Benchmark Protocol Detail
See `references/benchmark-protocol.md` for full specifications.
### Readiness And Promotion Handoff
Readiness, promotion, and adaptation handoff stay under `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership for lead adjudication and this skill's sequence gates for execution. This skill does not create a second owner for those judgments. When a round reaches hardening or promotion evaluation, keep the target capability surface, current readiness label, evidence basis, and follow-on optimization closure explicit before treating the round as closed.
## Sequence Activation Discipline
When the Self-Growth Sequence or Change Sequence is materially active, name it explicitly in progress updates and keep the current phase, step, or blocking condition visible enough that a successor can interpret the next update against the same sequence.
Do not silently switch between Self-Growth Sequence and Change Sequence while active runtime depends on one of them. If a stage is optional, that optionality must come from the owning rule, not habit or convenience.
When building a sequencing decision for self-growth work, derive it from the loaded skill procedure rather than memory. If the governing procedure cannot be pointed to cleanly, keep the work on HOLD until the procedure basis is explicit.
## Change Sequence
The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, and skill changes.
Use `references/change-patch-method.md` for the detailed step table and constraints.
Hard surface:
- `work-planning` and `self-verification` are prerequisite gates unless the recursion guard inherits an already-active WP/SV context.
- Review the changed content, not just the plan; do not bypass review separation on meaningful governance changes.
- Execute only the reviewed, bounded, policy-compliant change.
- Post-verify the resulting diff, owner semantics, live references, and information preservation before claiming convergence.
- Governance-sensitive execution follows Step 5b: explicit user approval is required only for destructive or security-sensitive action; reviewed non-destructive governance changes proceed through the normal execution gate.
## Patch Execution Method
Use this method when an AI model updates doctrine, agents, skills, settings, hooks, or other team-system assets and the result must remain understandable without hidden session memory.
Use `references/change-patch-method.md` for detailed patch mechanics.
Hard surface:
- Treat every patch as bounded recurrence-barrier installation, not content accumulation.
- Prefer `tighten`, `replace`, `re-home`, or `merge` before `append`; delete only when meaning is duplicate, obsolete, or preserved elsewhere.
- Freeze defect basis, design intent, causal basis, recurrence path, patch class, owner surface, protected meaning, and edit operation before drafting.
- Preserve structural connectivity, local restatements needed for isolated readability, live references, semantic-family consistency, sibling surfaces, and source-to-destination meaning.
- Verification must prove recurrence blockage or assigned follow-up plus no owner-boundary, reference, acceptance, runtime-truth, or information-loss regression.
