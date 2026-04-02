---
name: team-governance-sequences
description: Standard governance procedures for change control, self-growth, and update or upgrade work in the Claude team setup. Use for the main team lead and developer when rules, skills, settings, hooks, or other team-system assets are being changed.
user-invocable: false
---

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

## Self-Growth Sequence

The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.

- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar.
- When self-growth expands a lane's charter, capability, or reusable content, require a bounded follow-on optimization pass before the topic is fully closed. That optimization may remove avoidable cost, runtime burden, or redundancy, but it must not weaken the upgraded quality bar or drop protected meaning.

### Required order

1. Identify the active improvement topic from evidence.
2. Require relevant lanes to inspect the topic before ownership is finalized.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. After the quality-raising change lands, run a bounded optimization pass that removes avoidable cost, runtime burden, or redundancy without lowering the upgraded quality bar or losing protected information.
7. When the active topic came from recurrence, missed-catch, or rejected-challenge evidence, require a rerun, retest, or equivalent fresh evidence gate before treating the hardening topic as fully closed.
8. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are either hardened into the correct parent document or explicitly assigned follow-up ownership.

### Capability-Gap Fast Path

- When a missing reusable skill is the active improvement topic, `team-lead` may authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is a prerequisite for safe, credible, or non-duplicative completion of the active task, stop the blocked work surface and complete the skill update or introduction before normal downstream execution resumes.
- The fast path still requires:
  1. gap confirmation
  2. overlap check against existing skills, agents, and rules
  3. explicit owner assignment
  4. bounded creation scope
  5. review of the resulting skill content
  6. post-adoption verification that the new skill actually closes the gap
- Fast path means reduced delay, not reduced governance. Do not skip owner fit, overlap review, or information-preservation checks merely because the need is urgent.
- Do not retroactively create a skill just to justify ad hoc behavior that already bypassed the missing capability.

### Self-growth constraints

- Do not allow undocumented doctrine drift.
- Do not let self-growth become a hidden excuse for unrelated refactors.
- Do not declare improvement complete without evidence of the actual hardening change.
- Do not introduce a new skill when a bounded update to an existing owner would solve the same problem more cleanly.
- Do not use self-growth, optimization, compression, or rewrite work as justification for removing protected local restatements that keep owner files safe to read in isolation.

### Benchmark Protocol Detail (migrated from CLAUDE.md)
- Comparative self-growth, reusable-ownership, and quality-hardening claims default to benchmark-first discipline. Name the baseline and comparison surface before the hardening claim is allowed to harden into routing or ownership.
- Benchmark conclusions must declare provenance. If benchmark inputs are not directly inspectable or credibly cited, downgrade to `HOLD`, `UNVERIFIED`, or simulator-only status.
- Default preparation sequence: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization.
- Early investigation and benchmark stages identify the actual deficiency and determine whether self-growth is warranted. Do not jump from a recurring symptom into edits.
- `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed` is still a benchmark-stage `HOLD`, not edit authorization.

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
10. Run the full `Change Sequence`.
11. Record any remaining migration gap explicitly rather than assuming the update is complete.

### Skill Introduction Rules

- New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
- Treat the consuming lane as the default skill-up owner. If a specialist skill is developer-exclusive, `developer` is the default maintenance and upgrade owner while `team-lead` governs approval and adoption.
- Before introducing a new skill, check whether the need is better handled by:
  - updating an existing skill
  - strengthening an existing agent charter
  - adding a path-scoped rule
- If the missing skill is the declared prerequisite for finishing the active task safely or credibly, the skill update or introduction must be completed before the blocked task surface re-enters normal execution.
- A new skill must state:
  - the capability gap it closes
  - its owning role
  - what it does not own
  - when it should be invoked instead of ordinary lane behavior

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
- When a missing reusable skill blocks credible completion, complete the skill update or introduction before the blocked downstream task resumes normal execution.
- Treat the consuming lane as the default skill-up owner.
  - For current developer-exclusive specialist skills, `developer` performs the skill-up execution while `team-lead` governs approval and adoption.
- After any self-growth or capability-expansion patch, run a bounded follow-on optimization pass before closing the topic.
  - That optimization may reduce cost, runtime burden, or redundancy, but it must preserve the improved quality bar and protected meaning.
- Do not create detached runtime artifacts or orphan files inside the target payload.
  - Any new persistent file must have a clear owner and, when relevant, an explicit runtime or document reference path.
- Standardize the subpath contract under the owning folder root rather than hardcoding every full path in every document.
  - For specialist skills, keep one owner for the project skill root and let downstream documents reference the standardized active subpath.
- Do not keep shadow subagent copies or reference-only shadow folders unless they preserve unique non-operational meaning that is not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep the governing patch method aligned with the real active and reference paths.
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.

