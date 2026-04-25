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
- `Self-Growth Sequence` (on-demand: self-growth-sequence skill)
- `Update/Upgrade Sequence` (on-demand: update-upgrade-sequence skill)

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

> On-demand: see `self-growth-sequence` skill. Loaded when behavioral defect is detected via hook trigger or team-lead agent rules.

## Update/Upgrade Sequence

> On-demand: see `update-upgrade-sequence` skill. Loaded when doctrine, agents, skills, settings, hooks, or team-system assets need modification.

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
- When multiple specialist skills are active on one blocked surface, the controlling order is: `biz-sys` -> `sw-spec` -> domain specialists (`edu-spec`, `eng-spec`, `math-spec`) -> `doc-auto` -> `ui-ux`. `bench-sim` and `int-op` are support overlays without controlling-chain position; they may evaluate or integrate without overriding earlier controlling contracts.
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
