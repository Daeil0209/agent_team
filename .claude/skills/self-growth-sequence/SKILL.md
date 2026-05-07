---
name: self-growth-sequence
description: Self-growth procedures for team capability hardening and behavioral defect correction.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned self-growth and change surface.
- Fixed section order: Ultimate Purpose, Activation, Self-Growth Sequence, Sequence Activation Discipline, Change Sequence, Patch Execution Method
- PRIMARY-OWNER: team-lead
## Ultimate Purpose
Repair repeated failure from causal basis, not symptom-only edits.
When evidence shows a behavioral or procedural defect, protect the active request's correctness and safety first.
Convert the defect into a durable recurrence barrier on the narrowest correct owner surface.
Resume ordinary execution only from that corrected basis.

Mandatory path:
1. Defect evidence identifies the failure.
2. Design-intent review reconstructs the rule or procedure intended to govern.
3. Causal analysis explains why it failed in execution.
4. Failure classification exposes the recurrence path.
5. Ownership adjudication chooses the prevention surface.
6. Hardening installs the barrier.
7. Verification proves the barrier or assigns bounded follow-up ownership.
8. Only then can the team resume from the corrected basis.

Use the narrowest owner-local surface that blocks recurrence with less drift.

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
If any required record item is unknown, the round stays open as inspection, `HOLD`, or explicit follow-up ownership.
## Activation
Load this skill when evidence confirms a behavioral or procedural defect requiring recurrence-barrier hardening.
Load this skill to classify a justified user correction, hook signal, runtime/process error, or recurring missed-catch that may indicate process failure.
Classification selects self-growth hardening, active workflow repair, `update-upgrade-sequence`, `HOLD`, or explicit follow-up ownership.
Routine asset maintenance routes through `update-upgrade-sequence`.
Use `Change Sequence` from here only as patch-mechanics support per `Sequence Arbitration Law` in CLAUDE.md.
Trigger sources:
- UserPromptSubmit hook emits `self-growth-evidence` as owner cue when a prompt supplies possible defect evidence
- `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership contains the lead-owned adjudication and closure boundary
- Verified runtime/process error signals can raise confirmed self-growth once the defect basis is sufficient to govern behavior.
- Sufficient confirmed defect basis opens self-growth hardening without direct user instruction.
Self-growth tiers:
- Quick hardening applies when owner surface and write scope are unambiguous and the change is meaning-preserving or owner-local.
- Quick hardening covers typo corrections, terminology normalization, dead-text removal, and same-owner wording clarification.
- Quick hardening path: identify owner surface -> apply the relevant Change Sequence steps -> owner-local self-review -> verify no regression.
- If meaning, owner, write scope, runtime enforcement, acceptance impact, or cross-surface effect is ambiguous, upgrade to standard or structural hardening.
- Standard hardening: behavioral rule changes, new constraints, recurrence barriers. Requires all steps.
- Structural hardening: architecture-level changes, cross-document impact. Requires all steps plus governance review.

### Reference Map
Load trigger-specific files directly from `SKILL.md`.
- `references/self-healing.md`: trigger matrix and closure checklist.
- `references/retroactive-application.md`: retroactive audit requirements after new/sharpened rules land.
- `references/causal-analysis.md`: reconstruction questions and causal-basis standard.
- `references/governance-architecture-map.md`: owner-surface map for doctrine, role, skill, packet, hook, setting, and reference placement.
- `references/repair-decision-guide.md`: narrowest repair selection and no-duplicate-doctrine guard.
- `references/capability-gap-fast-path.md`: missing reusable-skill fast path and default rapid-skill routing.
- `references/skill-introduction.md`: new-skill category gate, reject criteria, and approval packet.
- `references/benchmark-protocol.md`: benchmark-first preparation and self-growth comparison gates.
- `references/patch-classification.md`: patch class definitions.
- `references/failure-mode-response.md`: failure mode matrix and response boundaries.
- `references/human-readable-packet-owners.md`: semantic packet catalogs for governance and solution-development patches.
- `references/high-traffic-surfaces.md`: high-traffic governance surfaces and protection layers.
- `references/self-growth-constraints.md`: constraint checklist.
- `references/change-patch-method.md`: detailed Change Sequence, patch execution method, meaning routing, specialist ordering, file/runtime hygiene, and hook enforcement rules.
## Self-Growth Sequence
When the team hardens its own rules, skills, charters, or capability boundaries:
- Protect the upgraded quality bar before reducing redundancy or runtime footprint.
- Move from valid defect basis into bounded hardening immediately.
- Default cure: harden the failing owner-local path first.
- Tighten, replace, re-home, or merge before adding new doctrine.
- When self-growth expands a lane's charter or capability, make a bounded follow-on optimization decision before closing.
- Run the optimization pass when material avoidable redundancy or runtime burden is visible.
- Otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed`.
- Always preserve the upgraded quality bar and protected meaning.
### Self-Healing Algorithm
### Defect-To-Barrier Contract
Every self-growth round must preserve this chain:
Required chain part 1: `DEFECT-BASIS -> DESIGN-INTENT-BASIS -> CAUSAL-BASIS -> FAILURE-MODE -> RECURRENCE-PATH -> OWNER-SURFACE -> BARRIER-TYPE -> CHANGE-BOUNDARY`.
Required chain part 2: `VERIFICATION-BASIS -> CONVERGENCE-STATUS -> SUSPENDED-WORK-SURFACE -> RESUME-OWNER -> RESUME-CONDITION -> RESUME-ACTION`.
If any link is missing, inspect until the link is known, keep the round on `HOLD`, or assign explicit follow-up ownership with boundary and closure basis.

Allowed barrier types:
- rule hardening
- owner re-home
- checklist or packet-field hardening
- Hook-Last-approved runtime enforcement refinement
- skill capability update
- role-boundary correction
- reference or template repair
- explicit follow-up ownership when immediate hardening is blocked

The barrier must match the failure mode.
`non-compliance` demands adherence hardening, not duplicate doctrine.
`capability-gap` demands capability installation or bounded owner update, not ad hoc execution.
`wrong-owner` demands re-home or explicit owner correction, not local patching by habit.

### Causal Repair Standard
Patch from causal basis.
Defect admission gate:
- Call a team-system item `confirmed defect` only when live owner evidence proves target-intent conflict, protected function, proven negative operating effect or reserved hard-deny/runtime-truth breach, causal failure mode, recurrence path, and smallest intent-preserving correction.
- Treat literal contradiction, heavy gate, hook burden, deletion permission, or plausible misuse as defect evidence only until that proof exists.
Use `references/causal-analysis.md` for the required reconstruction, failure-mode proof, recurrence path, and hypothesis limit.

### Governance Repair Orientation
Self-growth repairs and preserves the existing operating model.
Use `references/governance-architecture-map.md` to reconstruct owners.
Use `references/repair-decision-guide.md` to choose the narrowest barrier.
Change philosophy, route ownership, lane boundary, proof owner, acceptance owner, or skill-loading model only when structural evidence proves that surface is the defect.
Before ownership adjudication or patch drafting, classify `REVIEW-VERIFICATION-NEED: required|not-required`.
Set it to `required` when design intent, owner-boundary coherence, integrity, negative risk, or patch-worthiness is material, disputed, or cross-surface.
Consume `review-verification` output before adjudication, patch design, or Change Sequence execution when it is required.
Set it to `not-required` only for quick hardening when owner surface, write scope, and meaning-preserving repair are unambiguous.

When a defect or justified challenge is recognized, run this sequence:
1. Trigger — confirm the problem basis is real enough to govern behavior now.
2. Stabilize — protect the active request's correctness and safety basis first.
   If active work is interrupted, record suspended surface, last safe state, current owner, and next resume decision.
3. Reconstruct — identify the intended rule, owner, procedure, packet, hook, or verification path that was supposed to prevent the failure.
4. Diagnose — explain why that design failed in execution.
   Classify the failure mode.
5. Open — open self-growth classification immediately as a sidecar or nearest-safe-boundary path.
6. Harden — patch the correct owner surface with the smallest meaning-preserving edit only after defect basis, causal basis, and recurrence path are sufficient.
7. Re-verify — gather fresh evidence on the affected path.
8. Iterate — if verification finds a remaining or newly created defect, return to Reconstruct or Diagnose.
   Repair again with the new evidence.
9. Resume corrected state — continue with the strengthened basis, reopen planning, or assign an explicit blocker owner.
   Interrupted work keeps `RESUME-OWNER` and `RESUME-ACTION`.
Self-healing is complete only when a confirmed recurrence path is hardened or explicitly assigned with owner, boundary, and closure basis.
If classification disproves a durable defect, close only with the active-task correction, no-recurrence basis, and owner truth.
Explanation alone is not self-healing.
### Trigger discipline
- On recognizing a behavioral defect, classify it before unsafe continuation.
- Complete causal diagnosis before drafting durable hardening.
- Open self-growth classification as a sidecar or nearest-safe-boundary path.
- Durable hardening waits for sufficient causal and recurrence basis.
- Ordinary continuation waits for the corrected state or explicit `HOLD` ownership.
- Active request-fit, deliverable shape, and correctness/safety basis outrank self-growth.
- If the defect blocks safe or correct handling now, stabilize first.
- Then dispatch at the nearest safe boundary.
- If write-surface overlap with active production work exists, queue only until the overlap clears. That is write safety, not priority deferral.
- Classification without an opened self-growth path is not action.
- If an equivalent rule already exists, treat the defect as non-compliance.
- Harden adherence instead of adding duplicates.
- While the self-growth entry gate is active, pause consequential retries on the affected unsafe surface.
- Independent surfaces continue when owner, write surface, proof, and acceptance chain remain unchanged.
- Pause queued `TaskCreate`, `Agent`, `SendMessage`, `TaskUpdate`, and other consequential retries only on the affected surface.
- Load `self-growth-sequence` first.
- Resume from the corrected state after the gate clears.
- When self-growth interrupts active work, record `SUSPENDED-WORK-SURFACE`, last safe state, `RESUME-OWNER`, and candidate `RESUME-ACTION` before the interruption becomes invisible.
- A justified user correction opens classification immediately.
- A first failure opens hardening when classification confirms a behavioral or procedural defect, missed-catch owner, and recurrence path.
- Self-growth opening can be immediate.
- Governance-sensitive file modification is still execution-gated.
- Use this owner opening to classify, route, inspect, and prepare the bounded patch packet. Assignment-grade `Agent` or `SendMessage` dispatch still belongs to `task-execution`.
- Only destructive or security-sensitive execution requires explicit user confirmation; hook/settings runtime enforcement expansion still follows `update-upgrade-sequence` Hook-Last preflight and explicit operator approval.
- When a missing reusable skill blocks execution, authorize skill introduction under `Self-Growth Sequence` with explicit ownership: gap confirmation, target owner, bounded scope, review path, and verification.
- When more than one lane can own the growth topic, compare owner candidates before choosing.
- Record competing owner candidates.
- Choose the narrowest prevention owner.
- State why rejected owners would duplicate, miss, or weaken the recurrence barrier.
### Self-Growth Ownership Adjudication
- The supervisor must adjudicate owner and barrier path directly.
- Allowed decisions: approve, reject, merge, reduce, defer, or reassign.
- Codex/reviewer input is evidence; supervisor owns the decision.
- User confirmation is allowed only for destructive, security-sensitive, policy-level, or objectively undecidable barrier choices.
- Ownership of improvement work must be explicit.
- Ownerless gaps are not allowed at round close.
- The supervisor remains the staffing, mediation, adjudication, and merge-governance owner for self-growth rounds; production ownership stays explicit.
### Required order
Standard and structural hardening follow this order.
Quick hardening follows the Quick path in Activation and the relevant Change Sequence steps only.
If a quick change reveals recurrence, owner ambiguity, cross-surface impact, new rule meaning, runtime enforcement, or acceptance impact, upgrade it before execution.
The default consequential work sequence remains active.
`work-planning` remains the prerequisite basis for standard and structural hardening.
`self-verification` closes the result at Post-Verify.
Use `SV-PLAN` only when the improvement plan is disputed.
Prerequisite A. Load `work-planning` only at a fresh or reopened self-growth boundary. Same-boundary hardening iterations consume the active boundary.
Prerequisite B. `SV-PLAN` remains exception-only for disputed improvement plans.
Recursion guard:
When self-growth triggers during active work-planning or self-verification execution, the self-growth sidecar inherits the already-active owner context.
The active owner context carries the sidecar when work-planning or self-verification is the trigger source.
Dispatch the sidecar at the nearest safe boundary after the triggering owner execution completes.
1. Identify the active improvement topic from evidence.
   Capture at minimum: trigger source, defect class, impacted path, intended governing design, causal basis, recurrence path, review-verification need basis, and likely owner surface.
2. For standard hardening, structural hardening, material ownership ambiguity, or cross-lane capability impact, require relevant lanes to inspect the topic before ownership is finalized.
   Quick hardening can use owner-local inspection when owner surface and write scope are unambiguous and the change is meaning-preserving or owner-local.
   If `REVIEW-VERIFICATION-NEED: required`, consume `review-verification` output before ownership finalization.
   Lane inspection, reviewer input, or Codex input is evidence only; it is not a substitute for a required `review-verification` packet.
   Lane inspection can be local evidence review, routed agent work, or lawful single-thread fallback.
   Additional-agent dispatch is valid only on a host-authorized active-runtime path through `task-execution`.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. Install the recurrence barrier on the correct owner surface.
   Harden the rule, checklist, packet requirement, Hook-Last-approved runtime edge, capability boundary, or owner-local procedure that blocks recurrence.
6.5. **Retroactive application phase (per CLAUDE.md `[RETRO-APPLY]`)**.
   Before optimization decision and before close, audit current-session surfaces the new rule directly governs or contradicts.
   Include artifacts, in-flight agent output, prior verdicts, active acceptance state, and live deliverable surfaces only when directly governed or contradicted.
   Produce an explicit list of audited surfaces with result: not affected, fixed, owner-deferred, or invalidated.
   Produce a defect inventory with proposed fixes.
   Send fixes in the same patch chain.
   Or defer with named follow-up owner, boundary, and closure basis.
   Invalidate current-session prior verdicts, PASS states, or closures that pre-date this rule and conflict with it.
   Mark those states `STALE-PRE-{ROUND}`.
   Those states require fresh re-verification before downstream work proceeds on their basis.
   Skipping retroactive application is a `[RETRO-APPLY]` defect.
   Landing doctrine while bypassing directly governed current-session surfaces recreates the same failure.
7. After the quality-raising change lands and retroactive application completes, make a bounded follow-on optimization decision.
   Run the optimization pass only when material avoidable redundancy or runtime burden is visible.
   Otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed`.
8. When the active topic came from recurrence, missed-catch, rejected-challenge evidence, or user-corrected process failure, require fresh evidence before full closure.
   Fresh evidence means rerun, retest, or equivalent evidence gate.
9. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are hardened into the correct parent document or assigned follow-up ownership.
### Closure Standard
- Self-growth is not closed while the recurrence path remains implicit.
- If the recurrence path is known but cannot be patched immediately, keep the topic on `HOLD`.
- `HOLD` must name owner, blocked surface, and next safe execution boundary.
- Acknowledgement, apology, hook marker, dispatch success, role/skill load, and later `self-verification` load are entry or process evidence only.
- None proves closure without recurrence barrier, owner surface, and current verification basis.
- Failed verification reopens the self-growth round at the smallest invalidated step.
- Reconstruct when design intent was wrong.
- Diagnose when causal basis was weak.
- Adjudicate when owner surface was wrong.
- Harden when edit operation was wrong.
- Re-verify when evidence was insufficient.
- Each verification attempt still obeys `self-verification` Step 4.
- If the SV pass reaches `HOLD`, record `CONVERGENCE-STATUS: HOLD`, owner, reason, boundary, and next safe evidence step.
- Convergence stays open.
- If `SUSPENDED-WORK-SURFACE` is not `none`, closure requires `RESUME-OWNER` and a verified `RESUME-ACTION`.
- Valid resume actions: continue from corrected state, reopen `work-planning`, dispatch next owner/action, or report `HOLD` with owner and blocker.
- Without explicit cancellation, redirect, or proven user-owned blocker, `waiting for user` is false closure.
- Status/progress questions expose the stall only.
- Resume duty requires `RESUME-OWNER` and verified `RESUME-ACTION`.
- Before closure, the minimum self-growth record must be reconstructable from changed owner surface, active sequence packet, or explicit follow-up assignment.
- Hidden session memory is not closure evidence.
- If the issue was real but the owner surface remains uncertain, closure requires explicit adjudicated follow-up ownership.
### Capability-Gap Fast Path
- When a missing reusable skill is the active improvement topic, `team-lead` can authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is prerequisite for safe, credible, or non-duplicative completion, stop only the genuinely blocked work surface.
- Complete the skill update or introduction before that surface resumes normal downstream execution.
- Unrelated or already-safe work continues instead of being stalled by habit.
- The fast path still requires all 6 steps. See `references/capability-gap-fast-path.md` for the checklist and default routing.
- Fast path means reduced delay with owner fit, overlap review, and information-preservation checks preserved.
- Ad hoc bypass evidence routes to non-compliance or capability-gap diagnosis.
### Skill Introduction Category Gate
Every proposed new skill must be classified into exactly one primary category before approval. See `references/skill-introduction.md` for categories, reject criteria, and approval packet requirements.
### Self-growth constraints
See `references/self-growth-constraints.md` for the constraint checklist.
### Benchmark Protocol Detail
See `references/benchmark-protocol.md` for full specifications.
### Readiness And Promotion Handoff
Readiness, promotion, and adaptation handoff stay under `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership for lead adjudication.
When a round reaches hardening or promotion evaluation, keep the target capability surface explicit.
Keep the current readiness label explicit.
Keep the evidence basis explicit.
Keep follow-on optimization closure explicit before treating the round as closed.
## Sequence Activation Discipline
When Self-Growth Sequence or Change Sequence is materially active, name it in progress updates.
Keep current phase, step, or blocker visible enough for successor interpretation.
Sequence switches require explicit transition while active runtime depends on one of them.
Optionality must come from the owning rule, not habit or convenience.
Build sequencing decisions from the loaded skill procedure, not memory.
If the governing procedure cannot be pointed to cleanly, keep the work on HOLD until the basis is explicit.
## Change Sequence
The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, and skill changes.
Use `references/change-patch-method.md` for the detailed step table and constraints.
Hard surface:
- `work-planning` is the prerequisite gate only at a fresh or reopened change boundary.
- `self-verification` closes at Post-Verify.
- Use `SV-PLAN` only when the change plan is disputed.
- For self-growth changes, missing required `review-verification` output blocks Draft, Execute, and convergence.
- Review changed content, not just the plan.
- Meaningful governance changes preserve review separation.
- Execute only the reviewed, bounded, policy-compliant change.
- Post-verify resulting diff, owner semantics, live references, and information preservation before claiming convergence.
- Governance-sensitive execution follows Step 5b.
- Explicit user approval is required for destructive or security-sensitive action.
- Reviewed non-destructive governance changes proceed through the normal execution gate except hook/settings runtime enforcement expansion, which follows `update-upgrade-sequence` Hook-Last preflight and explicit operator approval.
## Patch Execution Method
Use this method for team-system asset patches that must remain understandable without hidden session memory.
Use `references/change-patch-method.md` for detailed patch mechanics.
Hard surface:
- For confirmed self-growth patches, treat the patch as bounded recurrence-barrier installation, not content accumulation.
- Prefer `tighten`, `replace`, `re-home`, or `merge` before `append`.
- Delete only when meaning is duplicate, obsolete, or preserved elsewhere.
- Preserve full clarity and execution force; reduce words or clause chains only when the resulting rule remains at least as clear and strong.
- Keep changed lines single-intent and readable.
- Freeze defect basis, design intent, causal basis, recurrence path, patch class, owner surface, positive execution path, recovery path, enforcement tier, protected meaning, and edit operation before drafting.
- Warning, block, deny, deletion, restriction, or removal edits are valid only when the positive execution path remains explicit and executable.
- Preserve structural connectivity, local restatements needed for isolated readability, live references, semantic-family consistency, sibling surfaces, and source-to-destination meaning.
- Verification must prove recurrence blockage or assigned follow-up, positive execution path preservation, and no owner-boundary, reference, acceptance, runtime-truth, or information-loss regression.
