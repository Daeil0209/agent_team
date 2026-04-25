---
name: self-growth-sequence
description: Self-growth procedures for team capability hardening and behavioral defect correction.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed section order: Activation, Self-Growth Sequence, Sequence Activation Discipline, Change Sequence, Patch Execution Method
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Activation
Load this skill when a concrete behavioral defect, hook-confirmed process failure, or recurring missed-catch is detected (self-detected, hook-detected, or user-corrected). Trigger sources:
- UserPromptSubmit hook detects correction patterns and injects "SELF-GROWTH TRIGGER" reminder
- `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership contains the lead-owned adjudication and closure boundary
- Verified runtime/process error signals may raise confirmed self-growth without waiting for direct user instruction once the defect basis is already sufficient to govern behavior.
This skill also contains the Change Sequence and Patch Execution Method for governance changes.
Self-growth tiers:
- Quick hardening: single-line fixes, typo corrections, terminology normalization. Required: identify owner surface → apply fix through Change Sequence (developer self-review sufficient per Step 5) → verify no regression.
- Standard hardening: behavioral rule changes, new constraints, recurrence barriers. Requires all steps.
- Structural hardening: architecture-level changes, cross-document impact. Requires all steps plus governance review.
## Self-Growth Sequence
The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.
- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar or regress an already-correct path.
- Treat self-growth as the default self-healing response to a real defect. Once the problem basis is valid, move from explanation into bounded hardening immediately instead of normalizing the miss as commentary.
- Default cure: harden the failing owner-local path first. Tighten, replace, or re-home the rule, hook, checklist, packet, or reference that failed before adding new doctrine.
- When self-growth expands a lane's charter or capability, make a bounded follow-on optimization decision before closing. Run the optimization pass when material avoidable cost or redundancy is visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed`. Always preserve the upgraded quality bar and protected meaning.
### Self-Healing Algorithm
When a defect or justified challenge is recognized, run this sequence:
1. Trigger — confirm the problem basis is real enough to govern behavior now.
2. Stabilize — protect the active request's correctness and safety basis first.
3. Classify — decide: missing owner/rule/capability, or non-compliance with an existing one.
4. Dispatch — open self-growth immediately as a sidecar or nearest-safe-boundary patch path.
5. Harden — patch the correct owner surface.
6. Re-verify — gather fresh evidence on the affected path.
7. Resume corrected state — continue with the strengthened basis, not the pre-correction behavior.
Self-healing is complete only when the recurrence path is hardened or explicitly assigned with owner, boundary, and closure basis. Explanation alone is not self-healing.
### Trigger discipline
- On recognizing a behavioral defect, classify it immediately: missing rule/capability, or non-compliance with an existing one.
- Dispatch self-growth immediately as a sidecar. Fix first, then continue in the corrected state.
- Self-growth does not outrank freezing the active request's immediate request-fit, deliverable shape, or correctness/safety basis. If the defect blocks safe or correct handling now, stabilize first, then dispatch at the nearest safe boundary.
- If write-surface overlap with active production work exists, queue only until the overlap clears. That is write safety, not priority deferral.
- Classify and Dispatch are atomic. Analysis without dispatch is failure, not action.
- If an equivalent rule already exists, treat the defect as non-compliance and harden adherence instead of adding duplicates.
- While the self-growth entry gate is active, do not keep retrying blocked consequential tools. Pause queued `TaskCreate`, `Agent`, `SendMessage`, `TaskUpdate`, or other consequential retries, load `self-growth-sequence` first, then resume from the corrected state after the gate clears.
- A justified user correction is authoritative enough to open self-growth immediately even on first occurrence. Do not wait for repetition before hardening a real, well-supported failure.
- Self-growth dispatch may be immediate, but governance-sensitive file modification is still execution-gated. Use dispatch to classify, route, inspect, and prepare the bounded patch packet. Only destructive or security-sensitive execution requires explicit user confirmation.
- When a missing reusable skill blocks execution, authorize skill introduction under `Self-Growth Sequence` with explicit ownership: gap confirmation, target owner, bounded scope, review path, and verification.
- When more than one lane could plausibly own the growth topic, do not let the most familiar lane win by habit. Open the competitive bid packet and record why the chosen route was better for long-run cumulative team benefit.
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
   Capture at minimum: trigger source, defect class, impacted path, provisional root-cause basis, recurrence path, and likely owner surface.
2. Require relevant lanes to inspect the topic before ownership is finalized.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. Install the recurrence barrier on the correct owner surface.
   Harden the rule, checklist, packet requirement, hook, capability boundary, or owner-local procedure that will make the same miss less likely next time.
7. After the quality-raising change lands, make a bounded follow-on optimization decision. Run the optimization pass only when material avoidable cost, runtime burden, or redundancy is now visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed` and close without manufacturing a redundant extra loop.
8. When the active topic came from recurrence, missed-catch, rejected-challenge evidence, or user-corrected process failure, require a rerun, retest, or equivalent fresh evidence gate before treating the hardening topic as fully closed.
9. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are either hardened into the correct parent document or explicitly assigned follow-up ownership.
### Closure Standard
- Self-growth is not closed while the recurrence path remains implicit.
- If the recurrence path is known but cannot be patched immediately because of write overlap or higher-priority stabilization, keep the topic on `HOLD` with explicit owner, blocked surface, and next safe execution boundary.
- If the issue was real but the owner surface remains uncertain, close only with explicit adjudicated follow-up ownership — never with an ownerless "noted" state.
### Capability-Gap Fast Path
- When a missing reusable skill is the active improvement topic, `team-lead` may authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is a prerequisite for safe, credible, or non-duplicative completion of the active task, stop only the genuinely blocked work surface and complete the skill update or introduction before that surface resumes normal downstream execution. Unrelated or already-safe work should continue instead of being stalled by habit.
- The fast path still requires all 6 steps. See `reference.md` `§Capability-Gap Fast Path` for the checklist and default routing.
- Fast path means reduced delay, not reduced governance. Do not skip owner fit, overlap review, or information-preservation checks merely because the need is urgent.
- Do not retroactively create a skill just to justify ad hoc behavior that already bypassed the missing capability.
### Skill Introduction Category Gate
Every proposed new skill must be classified into exactly one primary category before approval. See `reference.md` `§Skill Introduction Category Gate` for categories, reject criteria, and approval packet requirements.
### Self-growth constraints
See `reference.md` `§Self-Growth Constraints` for the constraint checklist.
### Benchmark Protocol Detail
See `reference.md` `§Benchmark Protocol Detail` for full specifications.
### Readiness And Promotion Handoff
Readiness, promotion, and adaptation handoff stay under `.claude/agents/team-lead.md` §RPA-11 Self-Growth Ownership for lead adjudication and this skill's sequence gates for execution. This skill does not create a second owner for those judgments. When a round reaches hardening or promotion evaluation, keep the target capability surface, current readiness label, evidence basis, and follow-on optimization closure explicit before treating the round as closed.
## Sequence Activation Discipline
When the Self-Growth Sequence or Change Sequence is materially active, name it explicitly in progress updates and keep the current phase, step, or blocking condition visible enough that a successor can interpret the next update against the same sequence.
Do not silently switch between Self-Growth Sequence and Change Sequence while active runtime depends on one of them. If a stage is optional, that optionality must come from the owning rule, not habit or convenience.
When building a sequencing decision for self-growth work, derive it from the loaded skill procedure rather than memory. If the governing procedure cannot be pointed to cleanly, keep the work on HOLD until the procedure basis is explicit.
## Change Sequence
The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, and skill changes.
### Required order
Prerequisite A. Load the `work-planning` skill. Freeze scope, approach, and verification criteria before proceeding to Step 1.
Prerequisite B. Load the `self-verification` skill and execute Critical Challenge on the change plan before proceeding to Step 1. This is the MWEC Plan Verification phase.
1. `Classify + Plan`
- Classify the change type and scope before editing.
- At minimum distinguish patch, addition, optimization, or other governance-relevant change classes.
2. `Analysis`
- Identify the target document's authoring principles: Structural Contract, fixed section order, priority hierarchy, numbering conventions, mapping chains, and design intent. These are binding constraints on any proposed change.
- Check viability, structural fit, overlap risk, and whether the target document is the correct owner.
- Verify that the proposed change complies with the target document's own authoring rules.
3. `Route + Adjudicate`
- Confirm placement and ownership using the Single Writer Principle.
4. `Draft`
- Produce a bounded proposed change before treating it as accepted execution.
5. `Content Review`
- Review the actual changed content rather than only the plan. For non-trivial changes, route to the reviewer lane; developer self-review is sufficient for trivial single-line fixes.
- Use evidence, not author intent, for acceptance judgment.
5b. `Execution Gate`
- For governance-sensitive modifications (CLAUDE.md `### Ownership` and `### Change And Preservation Law`): complete the reviewed change path before Execute. Explicit user approval is required only when the action is destructive or security-sensitive; reviewed non-destructive governance changes proceed autonomously.
- For non-governance changes: proceed directly to Execute.
6. `Execute`
- Apply only the reviewed, bounded, and policy-compliant change.
7. `Post-Verify`
- Re-check the resulting diff and governing semantics after execution.
- When the change moves, compresses, replaces, or redistributes doctrine, confirm that unique meaning was preserved and the destination owner is explicit.
- Load the `self-verification` skill and execute Critical Challenge before declaring the change verified.
### Change constraints
- Plan review is not content review.
- Do not bypass review separation on meaningful governance changes.
- Do not add doctrine by convenience placement.
- Do not compress away unique meaning.
- When a legacy rule label or violation code is retired, preserve the underlying operational contract in the correct owner document or enforcement surface. Identifier removal does not justify rule loss.
- When adding, deprecating, retiring, or merging rules, record the lifecycle state transition explicitly (`ACTIVE` -> `DEPRECATED` -> `RETIRED` -> `MERGED`) on the owning governance surface. New rules start as `ACTIVE`.
- The execution gate in step 5b governs governance-sensitive execution. See step 5b above.
- Runtime permission bypass, hook approval, or pre-authorized self-growth dispatch does not waive review separation, preservation checks, or the destructive/safety gate.
- High-traffic governance surfaces named by `CLAUDE.md` `### Ownership` and `### Change And Preservation Law` require session revalidation and baseline anchoring before modification resumes after interruption.
## Patch Execution Method
Use this method when an AI model updates doctrine, agents, skills, settings, hooks, or other team-system assets and the result must remain understandable without hidden session memory.
### Patch classification map
See `reference.md` `§Patch Classification Map` for the full classification table.
### Required operating rules
- Treat every self-growth patch as bounded recurrence-barrier installation, not content accumulation. The patch must close a confirmed recurrence path without opening unrelated scope.
- Default patch direction is to strengthen an existing owner-local rule, gate, checklist, packet, hook, or reference chain. Prefer `tighten`, `replace`, or `re-home` before `append`, and do not weaken an already-correct path just to land the hardening.
- Add brand-new doctrine only when the recurrence barrier cannot be absorbed into the current owner surface without information loss, owner confusion, or hidden meaning drift.
- This method refines `Change Sequence` Step 1 through Step 3; it does not replace the `Change Sequence`, review separation, execution gate, or post-verify requirements.
- Before drafting, freeze the defect basis, recurrence path, `PATCH-CLASS`, `BASELINE-CLASS`, owner surface, protected meaning, and proposed edit operation. If any item is unclear, inspect or hold instead of editing by intuition.
- Classify the failure mode before choosing text: `missing-owner`, `weak-owner`, `wrong-owner`, `non-compliance`, `weak-enforcement`, or `capability-gap`. Use `reference.md` `§Failure Mode Response Matrix` for allowed and prohibited responses.
- Choose the smallest edit operation that preserves protected meaning: `tighten`, `replace`, `re-home`, `merge`, `append`, or `delete`. Append only when no existing owner slot can absorb the meaning cleanly; delete only when the removed meaning is proven duplicate, obsolete, or preserved elsewhere.
- For every moved, compressed, replaced, or removed meaning, keep source-meaning inventory and destination-owner mapping explicit in `CHANGE-BOUNDARY` — enough that another model can reconstruct the patch from repository state alone.
- Preserve closed boundaries. Do not broaden a role, skill, rule, hook, or packet beyond the defect's proven recurrence path, and do not remove protected local restatements that keep owner files independently readable.
- When the failure mode is `non-compliance`, do not add duplicate doctrine. Harden adherence only through a clearer trigger, checklist, packet field, hook, or self-verification gate when the existing rule was not sufficiently surfaced.
- Review the proposed changed content, not only the plan, before execution. Check owner fit, structural fit, information-loss risk, adjacent-document overlap, boundary overreach, and enforcement false-positive risk.
- Verification must prove both sides of the patch: the recurrence path is blocked or explicitly assigned, and the existing design remains closed with no unique meaning lost, no dead cross-reference, no weakened owner boundary, and no regression on a previously working behavior, acceptance path, or runtime truth surface.
### Structural Baseline
- Treat the current target design as the structure baseline.
  - Legacy or reference material may restore missing meaning, but it does not automatically reclaim file layout, ownership, or runtime structure.
- Treat structural connectivity as protected meaning.
  - When a document already declares a fixed hierarchy or explicit mapping chain, preserve that structure and restore its links after any migration, compression, or normalization patch.
- Preserve zero information loss.
  - If meaning moves, merges, compresses, or is re-homed, the destination owner and preserved rule meaning must remain inspectable afterward.
### Meaning Routing
- Route meaning to the owning surface.
  - shared doctrine -> `CLAUDE.md`
  - file-scoped governance overlay with mandatory `paths:` frontmatter -> files under ``.claude/rules/*.md` files`
  - role identity, boundaries, output contract, completion condition -> matching agent file
  - repeatable workflow/checklist -> matching `SKILL.md`
  - runtime enforcement or state -> settings, hooks, or runtime owner file
- Do not place always-on doctrine in ``.claude/rules/*.md` files`. If the content should load unconditionally, route it into `CLAUDE.md` or the correct owner-local surface instead.
- Prefer `replace`, `trim`, or `re-home` over append-only accumulation, but never at the cost of protected meaning.
- When a rule is repeated so a file remains safe to read in isolation, treat that local restatement as protected common contract rather than cosmetic duplication.
- When a value must stay configurable, keep one literal owner for that value and make all other documents or prompts reference that owner instead of copying the literal value.
### Specialist And Skill Ordering
- When a missing reusable skill blocks credible completion, complete the skill update or introduction before the blocked downstream task resumes normal execution, but keep the pause scoped to the blocked downstream surface rather than stalling unrelated safe work.
- Treat the consuming lane as the default skill-up owner. Each specialist skill declares its `PRIMARY-OWNER` (and optional `SECONDARY-CONSUMER`) in its own SKILL.md body. The owning role file enumerates its specialists and the cross-specialist controlling order applicable within that role:
  - developer-owned specialists and their controlling order: `agents/developer.md` § RPA-4 Specialist Skills.
  - reviewer-owned specialists: `agents/reviewer.md` § RPA-4 Specialist Skills.
  - tester-owned specialists: `agents/tester.md` § RPA-4 Specialist Skills.
- Treat common-skill hardening differently from specialist skill-up.
  - Common-skill patches still require one primary owner, never diffuse co-ownership.
  - Inspectors may propose wording, challenge defects, and review the patch, but the primary owner performs the final direct edit for the shared procedure surface.
  - For current shared team-operation skills, `team-lead` is the default primary owner unless governance explicitly records a different owner.
### Post-Change Discipline
- After any self-growth or capability-expansion patch, make a bounded follow-on optimization decision before closing the topic.
  - Run the optimization pass when material avoidable cost, runtime burden, or redundancy is visible.
  - Otherwise close with `FOLLOW-ON-OPTIMIZATION: not-needed`.
  - Any optimization that does run must preserve the improved quality bar and protected meaning.
### File And Runtime Hygiene
- Do not create detached runtime artifacts or orphan files inside the target payload.
  - Any new persistent file must have a clear owner and, when relevant, an explicit runtime or document reference path.
- Standardize the subpath contract under the owning folder root rather than hardcoding every full path in every document.
  - For specialist skills, keep one owner for the project skill root and let downstream documents reference the standardized active subpath.
- Do not keep shadow subagent copies or reference-only shadow folders unless they preserve unique non-operational meaning not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep the governing patch method aligned with the real active and reference paths.
### Hook And Enforcement
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.
- Promote a rule to hard-block only when the enforcement basis is objective, deterministic, low-cost, and available from the current tool payload or current session state.
- If a rule depends on semantic interpretation, broad repo inspection, process-wide runtime scanning, or materially elevated false-positive risk, keep it `advisory` or `doctrine-only` until the meaning is packetized into exact fields.
- Do not add new hard-blocks merely to raise apparent coverage or enforcement rate. Protect operator autonomy and ordinary throughput before ceremonial enforcement expansion.
- When supervising doctrine, agent, skill, or hook patches, preserve owner-local boundary contracts and acceptance-gate restatements when they keep a file understandable in isolation.
- Do not let optimization, compression, rewrite, or self-growth directives erase protected common contracts that multiple owner files need for local readability and safe downstream use.
- For governance-sensitive patches, require the patch class, owner surfaces, preserved meaning, and verification basis to remain explicit enough that another model can continue safely from repository state alone without relying on a dedicated patch-ledger file.
### Human-readable packet owners
See `reference.md` `§Human-Readable Packet Owners` for field catalogs.
