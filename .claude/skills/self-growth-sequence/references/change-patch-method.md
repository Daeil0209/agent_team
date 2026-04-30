# self-growth-sequence: Change And Patch Method Detail
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

## Change Sequence Required Order
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

## Change Constraints
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
See `.claude/skills/self-growth-sequence/references/patch-classification.md` for the full classification table.

### Required operating rules
- Treat every self-growth patch as bounded recurrence-barrier installation, not content accumulation. The patch must close a confirmed recurrence path without opening unrelated scope.
- Default patch direction is to strengthen an existing owner-local rule, gate, checklist, packet, hook, or reference chain. Prefer `tighten`, `replace`, or `re-home` before `append`, and do not weaken an already-correct path just to land the hardening.
- Add brand-new doctrine only when the recurrence barrier cannot be absorbed into the current owner surface without information loss, owner confusion, or hidden meaning drift.
- This method refines `Change Sequence` Step 1 through Step 3; it does not replace the `Change Sequence`, review separation, execution gate, or post-verify requirements.
- Before drafting, freeze the defect basis, design-intent basis, causal basis, recurrence path, `PATCH-CLASS`, `BASELINE-CLASS`, owner surface, protected meaning, and proposed edit operation. If any item is unclear, inspect or hold instead of editing by intuition.
- Before drafting, enumerate affected surfaces beyond the edited file: exact text/pattern matches, semantic-family terms, downstream doctrine references, sibling owner surfaces, and runtime/hook/settings mirrors. Missing this enumeration is a patch-readiness defect, not a post-review nit.
- When the modified artifact has no declared design-intent surface (no Structural Contract, fixed section order, owner boundaries, or authoring principles), the change packet itself must carry the intent: assign a `PATCH-CLASS` failure-mode tag plus a one-sentence rationale in `CHANGE-BOUNDARY`. Add the missing declared-intent surface to the artifact in a follow-on patch when scope allows.
- Classify the failure mode before choosing text: `missing-owner`, `weak-owner`, `wrong-owner`, `non-compliance`, `weak-enforcement`, or `capability-gap`. Use `.claude/skills/self-growth-sequence/references/failure-mode-response.md` for allowed and prohibited responses.
- Choose the smallest edit operation that preserves protected meaning: `tighten`, `replace`, `re-home`, `merge`, `append`, or `delete`. Append only when no existing owner slot can absorb the meaning cleanly; delete only when the removed meaning is proven duplicate, obsolete, or preserved elsewhere.
- For every moved, compressed, replaced, or removed meaning, keep source-meaning inventory and destination-owner mapping explicit in `CHANGE-BOUNDARY` -- enough that another model can reconstruct the patch from repository state alone.
- Preserve closed boundaries. Do not broaden a role, skill, rule, hook, or packet beyond the defect's proven recurrence path, and do not remove protected local restatements that keep owner files independently readable.
- When the failure mode is `non-compliance`, do not add duplicate doctrine. Harden adherence only through a clearer trigger, checklist, packet field, hook, or self-verification gate when the existing rule was not sufficiently surfaced.
- Review the proposed changed content, not only the plan, before execution. Check owner fit, structural fit, information-loss risk, adjacent-document overlap, boundary overreach, and enforcement false-positive risk.
- Verification must prove both sides of the patch: the recurrence path is blocked or explicitly assigned, and the existing design remains closed with no unique meaning lost, no dead cross-reference, no weakened owner boundary, and no regression on a previously working behavior, acceptance path, or runtime truth surface.
- If verification finds a defect in the patch, do not close with partial improvement. Reopen the smallest invalidated step, revise the patch, and run fresh verification again until `CONVERGENCE-STATUS` is `converged`, `HOLD`, or explicit follow-up ownership. Each fresh verification pass remains bounded by `self-verification` Step 4.

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
  - file-scoped governance overlay with mandatory `paths:` frontmatter -> files under `.claude/rules/*.md`
  - role identity, boundaries, output contract, completion condition -> matching agent file
  - repeatable workflow/checklist -> matching `SKILL.md`
  - runtime enforcement or state -> settings, hooks, or runtime owner file
- Do not place always-on doctrine in `.claude/rules/*.md` files. If the content should load unconditionally, route it into `CLAUDE.md` or the correct owner-local surface instead.
- Prefer `replace`, `trim`, or `re-home` over append-only accumulation, but never at the cost of protected meaning.
- When a rule is repeated so a file remains safe to read in isolation, treat that local restatement as protected common contract rather than cosmetic duplication.
- When a value must stay configurable, keep one literal owner for that value and make all other documents or prompts reference that owner instead of copying the literal value.

### Specialist And Skill Ordering
- When a missing reusable skill blocks credible completion, complete the skill update or introduction before the blocked downstream task resumes normal execution, but keep the pause scoped to the blocked downstream surface rather than stalling unrelated safe work.
- Treat the consuming lane as the default skill-up owner. Each specialist skill declares its `PRIMARY-OWNER` and optional `SECONDARY-CONSUMER` in SKILL.md frontmatter and may restate them in its Structural Contract when local readability requires it. The owning role file or lane detail reference enumerates its specialists and the cross-specialist controlling order applicable within that role:
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
- Do not keep shadow agent copies or reference-only shadow folders unless they preserve unique non-operational meaning not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep the governing patch method aligned with the real active and reference paths.

### Hook And Enforcement
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.
- Hook enforcement is a runtime guard, not a substitute for owner-document prose. The model-facing rule must remain in the correct owner surface; hooks only check or block its observable edges.
- Keep governance-flow hook enforcement separate from settings-deny secret protection. `settings.json` `permissions.deny` is for hard credential and secret paths; runtime hooks own governance procedure enforcement.
- Promote a rule to hard-block only when the enforcement basis is objective, deterministic, low-cost, and available from the current tool payload or current session state.
- If a rule depends on semantic interpretation, broad repo inspection, process-wide runtime scanning, or materially elevated false-positive risk, keep it `advisory` or `doctrine-only` until the meaning is packetized into exact fields.
- Do not add new hard-blocks merely to raise apparent coverage or enforcement rate. Protect operator autonomy and ordinary throughput before ceremonial enforcement expansion.
- When supervising doctrine, agent, skill, or hook patches, preserve owner-local boundary contracts and acceptance-gate restatements when they keep a file understandable in isolation.
- Do not let optimization, compression, rewrite, or self-growth directives erase protected common contracts that multiple owner files need for local readability and safe downstream use.
- For governance-sensitive patches, require the patch class, owner surfaces, preserved meaning, and verification basis to remain explicit enough that another model can continue safely from repository state alone without relying on a dedicated patch-ledger file.

### Human-readable packet owners
See `.claude/skills/self-growth-sequence/references/human-readable-packet-owners.md` for field catalogs.
