---
name: team-governance-sequences
description: Standard governance procedures for change control, self-growth, and update or upgrade work in the Claude team setup. Use for the main team lead and developer when rules, skills, settings, hooks, or other team-system assets are being changed.
user-invocable: false
---

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Sequence Activation Discipline`
  2. named sequence sections
  3. `Required order` / `Required checks` / `Required actions` blocks
  4. sequence-specific constraints, gates, and state rules
- Do not add new top-level lifecycle names without explicit governance review.
- Keep exact sequence names stable when they are already referenced by doctrine, agents, settings, or hooks.
- Expand the owning sequence section rather than appending detached sidecar procedure blocks.
- Structural connectivity is immutable: new governance rules must remain attached to an owning sequence, checkpoint, or method block rather than appearing as free-floating doctrine.

# Team Governance Sequences

This skill defines the standard procedural sequences for system-governance work.

Use the exact lifecycle names defined in `CLAUDE.md`:
- `Change Sequence`
- `Self-Growth Sequence`
- `Update/Upgrade Sequence`

These procedures apply whenever governance-sensitive artifacts are being changed.

## Sequence Activation Discipline

- When a governance sequence is materially active, the lead or delegated sub-manager should name that sequence explicitly in control updates rather than leaving the control surface implicit.
- Keep the current phase, checkpoint, or blocked step visible enough that downstream lanes can tell whether the work is still in classification, review, execution, post-verify, or hardening.
- Do not silently switch between `Change Sequence`, `Self-Growth Sequence`, and `Update/Upgrade Sequence` when the distinction affects ownership, review gates, or closeout meaning.
- Route self-improvement, doctrine hardening, settings changes, and upgrade work through the standard `Self-Growth Sequence` or `Update/Upgrade Sequence` instead of ad hoc edits.

## Change Sequence

The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, and skill changes.

### Required order

1. `Classify + Plan`
- Classify the change type and scope before editing.
- At minimum distinguish patch, addition, optimization, or other governance-relevant change classes.

2. `Analysis`
- Check viability, structural fit, overlap risk, and whether the target document is the correct owner.

3. `Route + Adjudicate`
- Confirm placement and ownership using the Single Writer Principle.

4. `Draft`
- Produce a bounded proposed change before treating it as accepted execution.

5. `Content Review`
- Review the actual changed content rather than only the plan.
- Use evidence, not author intent, for acceptance judgment.

6. `Execute`
- Apply only the reviewed and authorized change.

7. `Post-Verify`
- Re-check the resulting diff and governing semantics after execution.
- When the change moves, compresses, replaces, or redistributes doctrine, confirm that unique meaning was preserved and the destination owner is explicit.

### Change constraints

- Plan review is not content review.
- Do not bypass review separation on meaningful governance changes.
- Do not add doctrine by convenience placement.
- Do not compress away unique meaning.
- When a legacy rule label or violation code is retired, preserve the underlying operational contract in the correct owner document or enforcement surface. Identifier removal does not justify rule loss.
- Destructive, security-sensitive, or governance-sensitive modifications require an explicit operator-facing approval gate before execution begins. For current high-traffic shared surfaces, treat at minimum `agents/team-lead.md`, `CLAUDE.md`, runtime hooks, `settings.json`, and skill files as approval-gated surfaces.
- Runtime permission bypass, hook approval, or pre-approved self-growth dispatch does not waive that operator-facing execution gate.

## Self-Growth Sequence

The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.

- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar.
- When self-growth expands a lane's charter, capability, or reusable content, require a bounded follow-on optimization decision before the topic is fully closed. Run the optimization pass when material avoidable cost, runtime burden, or redundancy is visible; otherwise close with an explicit `FOLLOW-ON-OPTIMIZATION: not-needed` record while preserving the upgraded quality bar and protected meaning.

### Trigger discipline

- On recognizing a behavioral defect (self-detected or user-corrected): Classify (missing rule or non-compliance?) → Dispatch a separate agent for correction via `Self-Growth Sequence` in parallel as a sidecar — current work continues without stopping. Self-growth must not preempt freezing the active user task's request-fit, deliverable shape, or immediate correctness/safety basis. If the defect directly blocks correct or safe handling of the current request, stabilize that basis first, then dispatch or explicitly queue the self-growth lane at the nearest safe boundary. Classify and Dispatch/Queue are atomic — analysis without dispatch or explicit queueing is failure, not action. If an equivalent rule exists, the defect is non-compliance — harden adherence instead of adding duplicates.
- Self-growth dispatch may be immediate, but governance-sensitive file modification is still execution-gated. Use the dispatch to classify, route, inspect, and prepare the bounded patch packet; do not execute the modification on approval-gated surfaces until the explicit user confirmation step is satisfied.
- When a missing reusable skill blocks execution, authorize skill introduction under `Self-Growth Sequence` with explicit ownership: gap confirmation, target owner, bounded scope, review path, and verification.
- When you authorize new skill introduction, keep ownership explicit: capability-gap confirmation, target owner, bounded creation scope, review path, and post-adoption verification must all be named before execution begins.
- When more than one lane could plausibly own the growth topic, do not let the most familiar lane win by habit. Open the competitive bid packet and record why the chosen route was better for long-run cumulative team benefit.

### Self-Growth Ownership Adjudication

- Ownership claims for improvement work must be explicitly adjudicated by the supervisor; approve, reject, merge, reduce, defer, and reassign are all valid outcomes.
- Ownership of improvement work must be explicit; ownerless gaps are not allowed at round close.
- The supervisor remains the staffing, mediation, adjudication, and merge-governance owner for self-growth rounds and must not become the hidden primary producer or bottleneck.

### Required order

1. Identify the active improvement topic from evidence.
2. Require relevant lanes to inspect the topic before ownership is finalized.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. After the quality-raising change lands, make a bounded follow-on optimization decision. Run the optimization pass only when material avoidable cost, runtime burden, or redundancy is now visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed` and close without manufacturing a redundant extra loop.
7. When the active topic came from recurrence, missed-catch, or rejected-challenge evidence, require a rerun, retest, or equivalent fresh evidence gate before treating the hardening topic as fully closed.
8. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are either hardened into the correct parent document or explicitly assigned follow-up ownership.

### Capability-Gap Fast Path

- When a missing reusable skill is the active improvement topic, `team-lead` may authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is a prerequisite for safe, credible, or non-duplicative completion of the active task, stop only the genuinely blocked work surface and complete the skill update or introduction before that surface resumes normal downstream execution. Unrelated or already-safe work should continue instead of being stalled by habit.
- The fast path still requires:
  1. gap confirmation
  2. overlap check against existing skills, agents, and rules
  3. explicit owner assignment
  4. bounded creation scope
  5. review of the resulting skill content
  6. post-adoption verification that the new skill actually closes the gap
- Fast path means reduced delay, not reduced governance. Do not skip owner fit, overlap review, or information-preservation checks merely because the need is urgent.
- Do not retroactively create a skill just to justify ad hoc behavior that already bypassed the missing capability.
- Default rapid-skill routing:
  - `researcher` confirms the gap and checks for overlap with existing assets
  - `team-lead` fixes owner, scope, and adoption path
  - `developer` creates or updates the skill assets
  - `reviewer` checks placement, overlap, and information-loss risk
  - `validator` is assigned when acceptance risk is meaningful

### Self-growth constraints

- Do not allow undocumented doctrine drift.
- Do not let self-growth become a hidden excuse for unrelated refactors.
- Do not declare improvement complete without evidence of the actual hardening change.
- Do not introduce a new skill when a bounded update to an existing owner would solve the same problem more cleanly.
- Do not use self-growth, optimization, compression, or rewrite work as justification for removing protected local restatements that keep owner files safe to read in isolation.
- When self-growth affects reusable ownership, protect average-capability and prevent lane hollowing.

### Benchmark Protocol Detail (migrated from CLAUDE.md)
- Comparative self-growth, reusable-ownership, and quality-hardening claims default to benchmark-first discipline. Name the baseline and comparison surface before the hardening claim is allowed to harden into routing or ownership.
- Benchmark conclusions must declare provenance. If benchmark inputs are not directly inspectable or credibly cited, downgrade to `HOLD`, `UNVERIFIED`, or simulator-only status.
- Default preparation sequence: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization.
- Early investigation and benchmark stages identify the actual deficiency and determine whether self-growth is warranted. Do not jump from a recurring symptom into edits.
- `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed` is still a benchmark-stage `HOLD`, not edit authorization.
- When a self-growth round claims advancement, keep the current readiness label, visible evidence delta, throughput or neighbor-regression visibility, and follow-on optimization closure explicit in the active sequence packet before the round is handed back for lead judgment.

### Readiness And Promotion Handoff

- Readiness, promotion, and adaptation policy stay in `agents/team-lead.md` `RPA-4` because the lead owns those judgments directly during self-growth supervision.
- This sequence skill uses that policy only as execution-gating context; it does not become a second owner of promotion doctrine.
- When a self-growth round reaches hardening or promotion evaluation, keep the target capability surface, current readiness label, evidence basis, and follow-on optimization closure explicit before the round is treated as closed.

## Update/Upgrade Sequence

The `Update/Upgrade Sequence` applies when doctrine, agents, skills, settings, hooks, or other team-system assets are modified.

### Required checks

1. Confirm the target artifact owner.
2. Perform semantic overlap review before adding new rules or procedures.
3. Prefer `replace`, `trim`, or `re-home` over append-only accumulation.
4. Preserve migration traceability.
   The source meaning, destination owner, and verification basis must remain inspectable.
5. Perform zero-information-loss confirmation for moved, merged, compressed, or re-homed operational meaning.
   The before/after comparison must show where each unique rule meaning now lives.
6. Where a runtime setting or threshold must remain configurable, keep one owner for the value and make all other documents or prompts reference that owner instead of duplicating the literal value.
7. When a hook still enforces a contract, keep that contract understandable through owner-document prose and human-readable deny reasons rather than requiring a large central code table.
8. Treat intentional local restatements of role boundaries, lane contracts, and acceptance gates as protected meaning, not cosmetic duplication.
   If a rule is repeated so a file remains safe to read in isolation, do not remove it unless an equivalent owner-local contract still exists after the change.
9. When optimization, compression, rewrite, or self-evolution is the stated reason for the change, explicitly classify each repeated governance sentence as either protected common contract or safely removable duplication before trimming it.
10. Preserve approved structural hierarchies and connection mappings when the target document already uses them.
   Role documents must preserve their declared role/procedure/reference hierarchy and keep required mapping lines intact. Skill documents must preserve their fixed structural contract and keep reference detail attached to an owning workflow or sequence block.
11. New top-level sections, orphaned procedure blocks, orphaned reference blocks, or broken mapping chains require explicit governance review before execution.
12. Run the full `Change Sequence`.
13. Record any remaining migration gap explicitly rather than assuming the update is complete.

### Skill Introduction Rules

- New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
- Treat the consuming lane as the default skill-up owner. If a specialist skill is developer-exclusive, `developer` is the default maintenance and upgrade owner while `team-lead` governs approval and adoption.
- Distinguish `specialist skill` from `common skill` before assigning ownership.
  - A `specialist skill` sharpens one lane's charter-bound execution or judgment surface. That lane is the direct patch owner.
  - A `common skill` carries shared runtime, governance, routing, lifecycle, or other cross-lane operating procedure. A common skill is not jointly owned even when many lanes consume it.
- Common-skill ownership follows the Single Writer Principle.
  - Every common skill must have exactly one primary owner.
  - Other impacted lanes are required inspectors, challengers, or reviewers, not co-owners of the direct patch.
  - A patch packet for a common skill must name at minimum: `PRIMARY-OWNER`, `IMPACTED-LANES`, `OVERLAP-REVIEW`, `INFO-LOSS-REVIEW`, and `VERIFY-BASIS`.
- Current default rule for shared team-operation skills:
  - `team-session-sequences` and `team-governance-sequences` are `team-lead`-owned common skills unless an explicit governance decision reassigns them.
  - Impacted lanes may inspect, challenge, and review those skills, but final direct patch execution still belongs to the primary owner.
- Before introducing a new skill, check whether the need is better handled by:
  - updating an existing skill
  - strengthening an existing agent charter
  - adding a path-scoped rule
- If the missing skill is the declared prerequisite for finishing the active task safely or credibly, the skill update or introduction must be completed before the blocked task surface re-enters normal execution, but keep that pause scoped to the blocked surface rather than freezing unrelated safe work.
- A new skill must state:
  - the capability gap it closes
  - its owning role
  - what it does not own
  - when it should be invoked instead of ordinary lane behavior

### Specialist Skill Routing Architecture

- In the current target design, specialist capabilities live as skills under the current project skill root `.claude/skills` using the active specialist subpath `<skill-id>/SKILL.md`, not as active subagents under `.claude/agents/`.
- Authorization packets should name `skill-id` and bind it to the target lane plus blocked surface.
- `developer` resolves `skill-id` against the current project skill root and active specialist subpath.
- `team-lead` may authorize developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- Do not treat a common skill like a developer-exclusive specialist skill by habit.
  - Specialist-skill authorization binds a blocked lane to a bounded specialist aid.
  - Common-skill ownership binds a shared procedure surface to one primary owner plus named impacted lanes.
- For self-growth and consequential quality-hardening claims, default to benchmark-first comparison. Let `researcher` own the benchmark-light evidence shaping for baseline, fairness, comparison-axis framing, provenance visibility, and cross-check visibility; use `bench-sim` as the supporting specialist when the active packet escalates into the full benchmark form.
- When multiple specialist skills are active on one blocked surface, keep the controlling order explicit: `biz-sys` -> `sw-spec` -> domain specialists (`edu-spec`, `eng-spec`, `math-spec`) -> `doc-auto` -> `ui-ux`; `bench-sim` and `int-op` support evaluation or integration without overriding earlier controlling contracts.
- This controlling order is a lead-side routing discipline for logical flow, not a runtime chaining engine. Authorization hooks may gate who can use a specialist skill, but the lead still owns the ordering judgment for the active request.
- When approving developer-side specialist skill use, send an explicit authorization packet to the target developer lane using `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>` so runtime enforcement and human doctrine stay aligned.
- Route specialist skills per the controlling order in the Skill Routing And Specialist Architecture section above. Authorize via `SKILL-AUTH` packet bound to lane, surface, and `skill-id`.

### Skill Introduction Category Gate

- Every proposed new skill must be classified into exactly one primary category before approval:
  - `repeatable procedure`
    - reusable multi-step workflow that will recur across tasks or sessions
  - `specialist judgment surface`
    - recurring expert perspective that sharpens implementation, review, or planning quality
  - `integration or environment bridge`
    - reusable external-tool, connector, or setup protocol with stable verification and fallback steps
  - `governance or quality hardening`
    - reusable review, validation, migration, or operational-discipline procedure not already owned elsewhere
- Reject the proposal when it is primarily:
  - a one-off task brief
  - project-local knowledge that belongs in local doctrine
  - a temporary workaround with no expected reuse
  - a duplicate of an existing skill, agent charter, or rule owner
  - a style preference with no clear reusable procedure or authority boundary
- Approval packet for a new skill must name:
  - category
  - expected reuse pattern
  - existing-owner overlap result
  - chosen owner
  - why existing skill expansion was insufficient
  - first adoption path
- If the proposal cannot survive this category gate cleanly, do not create a new skill. Update the correct existing owner instead.

### Update/upgrade constraints

- No new operational rule without a clear owner.
- Do not weaken shared doctrine silently in lower-level documents.
- Do not leave the same rule half-owned by multiple documents unless duplication is intentional and justified for hierarchy consistency.
- Treat rule, skill, settings, and hook changes as governance-sensitive by default.
- When the active patch is governance-sensitive, the sequence must keep the user-confirmation boundary explicit: classify and prepare autonomously if allowed, but do not execute the actual modification until the operator-facing approval gate is satisfied.

## Patch Execution Method

Use this method when an AI model updates doctrine, agents, skills, settings, hooks, or other team-system assets and the result must remain understandable without hidden session memory.

### Patch classification map

- `hardening patch`
  - strengthens an existing owner with clearer doctrine, boundary, gate, or evidence rules
- `structural normalization patch`
  - aligns runtime prose, owner documents, and configuration ownership into one coherent target design
- `migration or re-home patch`
  - preserves meaning while moving it from a legacy or temporary location into the correct current owner
- `config-owner standardization patch`
  - keeps one literal owner for a configurable value and converts all other surfaces into references
- `skill-up patch`
  - hardens, expands, or repairs an existing reusable skill under the consuming lane's ownership model
- `new-skill patch`
  - introduces a new reusable skill only after category, reuse need, and owner fit are proven
- `follow-on optimization patch`
  - removes avoidable cost, runtime burden, or redundancy only after the stronger quality bar is already secured

### Required operating rules

- Treat the current target design as the structure baseline.
  - Legacy or reference material may restore missing meaning, but it does not automatically reclaim file layout, ownership, or runtime structure.
- Treat structural connectivity as protected meaning.
  - When a document already declares a fixed hierarchy or explicit mapping chain, preserve that structure and restore its links after any migration, compression, or normalization patch.
- Preserve zero information loss.
  - If meaning moves, merges, compresses, or is re-homed, the destination owner and preserved rule meaning must remain inspectable afterward.
- Route meaning to the owning surface.
  - shared doctrine -> `CLAUDE.md`
  - role identity, boundaries, output contract, completion condition -> matching agent file
  - repeatable workflow/checklist -> matching `SKILL.md`
  - runtime enforcement or state -> settings, hooks, or runtime owner file
- Prefer `replace`, `trim`, or `re-home` over append-only accumulation, but never at the cost of protected meaning.
- When a rule is repeated so a file remains safe to read in isolation, treat that local restatement as protected common contract rather than cosmetic duplication.
- When a value must stay configurable, keep one literal owner for that value and make all other documents or prompts reference that owner instead of copying the literal value.
- When a missing reusable skill blocks credible completion, complete the skill update or introduction before the blocked downstream task resumes normal execution, but keep the pause scoped to the blocked downstream surface rather than stalling unrelated safe work.
- Treat the consuming lane as the default skill-up owner.
  - For current developer-exclusive specialist skills, `developer` performs the skill-up execution while `team-lead` governs approval and adoption.
- Treat common-skill hardening differently from specialist skill-up.
  - Common-skill patches still require one primary owner, never diffuse co-ownership.
  - Inspectors may propose wording, challenge defects, and review the patch, but the primary owner performs the final direct edit for the shared procedure surface.
  - For current shared team-operation skills, `team-lead` is the default primary owner unless governance explicitly records a different owner.
- After any self-growth or capability-expansion patch, make a bounded follow-on optimization decision before closing the topic.
  - Run the optimization pass when material avoidable cost, runtime burden, or redundancy is actually visible.
  - Otherwise close with `FOLLOW-ON-OPTIMIZATION: not-needed`.
  - Any optimization that does run must preserve the improved quality bar and protected meaning.
- Do not create detached runtime artifacts or orphan files inside the target payload.
  - Any new persistent file must have a clear owner and, when relevant, an explicit runtime or document reference path.
- Standardize the subpath contract under the owning folder root rather than hardcoding every full path in every document.
  - For specialist skills, keep one owner for the project skill root and let downstream documents reference the standardized active subpath.
- Do not keep shadow subagent copies or reference-only shadow folders unless they preserve unique non-operational meaning that is not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep the governing patch method aligned with the real active and reference paths.
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.
- Promote a rule to hard-block only when the enforcement basis is objective, deterministic, low-cost, and available from the current tool payload or current session state.
- If a rule depends on semantic interpretation, broad repo inspection, process-wide runtime scanning, or materially elevated false-positive risk, keep it `advisory` or `doctrine-only` until the meaning is packetized into exact fields.
- Do not add new hard-blocks merely to raise apparent coverage or enforcement rate. Protect operator autonomy and ordinary throughput before ceremonial enforcement expansion.
- When supervising doctrine, agent, skill, or hook patches, preserve owner-local boundary contracts and acceptance-gate restatements when they keep a file understandable in isolation.
- Do not let optimization, compression, rewrite, or self-growth directives erase protected common contracts that multiple owner files need for local readability and safe downstream use.
- For governance-sensitive patches, require the patch class, owner surfaces, preserved meaning, and verification basis to remain explicit enough that another model can continue safely from repository state alone without relying on a dedicated patch-ledger file.

### Human-readable packet owners

- For `developer` governance-modification execution, keep the governance packet readable here even though hooks enforce it at dispatch time. Current packet surface: `TASK-CLASS: governance-patch`, `SEQUENCE: change|self-growth|update-upgrade`, `PATCH-CLASS: hardening|structural-normalization|migration-rehome|config-owner-standardization|skill-up|new-skill|follow-on-optimization`, `OWNER-SURFACE`, `BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor`, `INFO-LOSS-REVIEW: done`, `BALANCE-REVIEW: local-context-checked`, `RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked`, `PATCH-REVIEW: pre-exec-done|done|approved`, `MODIFICATION-PROPOSAL: explicit`, `SOURCE-MEANING-INVENTORY: explicit`, `DESTINATION-OWNER-MAP: explicit`, `CHANGE-BOUNDARY`, `VERIFY-BASIS`.
- For consequential solution work, keep the solution-development packet readable here even though hooks enforce it at dispatch time. Current packet surface: `PROBLEM-CLASS: instance|structural|systemic`, `ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown`, `SOLUTION-PASS: 1|2|3`, `DECISION-BASIS`, `REJECTED-OPTIONS`. When `SOLUTION-PASS: 2|3`, also keep `PASS-DELTA`. When `PROBLEM-CLASS: structural|systemic`, also keep `ALTERNATIVE-REVIEW: done` and `SELECTED-SCOPE: class-fix|system-fix|staged-class-fix`. When `ROOT-CAUSE-BASIS: hypothesis|unknown`, also keep `COMPETING-HYPOTHESES`. When `SELECTED-SCOPE: staged-class-fix`, also keep `FOLLOW-UP-OWNER`.
- `team-session-sequences` remains the owner for shared cross-lane dispatch packets and common enumerated runtime values. This section exists so governance-sensitive packet meaning stays readable without requiring a hook-code lookup.
