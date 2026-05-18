# governance-change: Change And Patch Method Detail
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/governance-change/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

## Contents
- Change Sequence Required Order
- Change Constraints
- Patch Execution Method
- Resolve Next Owner And Action

## Change Sequence Required Order
Prerequisite A. Load `work-planning` only at a fresh or reopened change boundary. Same-boundary patch repair consumes the active boundary.
Prerequisite B. Do not run routine plan audit. Use `Skill(self-verification)` plan audit only when the change plan is disputed; otherwise use result verification for Post-Verify.
Prerequisite C. Governance patch placement, generalization, and patch-ready record consume `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.

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
- Review the actual changed content rather than only the plan.
- For non-trivial changes, route to the reviewer lane.
- Developer defect-seeking self-review is sufficient for trivial single-line fixes.
- Recurrence-hardening patch Draft starts from the returned internal `review_verification_packet.REMOVAL-FIRST-PATCH-DESIGN` on doctrine, role, skill, spine, hook, or reference surfaces.
- The narrow single-file quick-hardening wording-fix exception (defined by the parent skill) records owner-surface citation.
- Reviewer and Codex input are evidence.
- The returned internal packet is the review-consumption record.
- Acceptance judgment uses evidence, not author intent.

5b. `Execution Gate`
- For governance-sensitive modifications, complete the reviewed change path before Execute.
  Governance-sensitive surfaces include CLAUDE.md `## Priority And Ownership` and `## Change And Preservation`.
  Explicit user approval is required for destructive or security-sensitive action.
  Reviewed non-destructive governance changes proceed autonomously except hook/settings runtime enforcement expansion, which uses the Hook-Last operator-approval gate.
- For non-governance changes: proceed directly to Execute.

6. `Execute`
- Apply only the reviewed, bounded, and policy-compliant change.

7. `Post-Verify`
- Re-check the resulting diff and governing semantics after execution.
- Use the post-execution live owner documents as the current governance basis for post-verification, affected-surface audit, and follow-on review.
- When running simulation, smoke, or review verification, use the post-execution live owner documents, not memory, pre-patch snapshots, stale mirrors, or prior verdicts.
- Parallel-agent verification counts only when the packet or returned evidence proves the agent used the post-execution live owner documents or received the resulting diff and owner-document basis as preserved artifacts.
- If that basis is absent or unproved, treat the agent result as non-authoritative and verify the live owner documents locally or redispatch with a self-contained packet carrying the existing basis.
- Use the resulting diff as change evidence.
- Treat pre-execution snapshots and prior verdicts as baseline or preservation evidence only; memory-only recall is not governance evidence.
- When the change moves, compresses, replaces, or redistributes doctrine, confirm that unique meaning was preserved and the destination owner is explicit.
- A verified sub-batch, patch log, or partial applied set is not convergence while same-request patch groups, review owners, proof owners, validation owners, or dispatch owners remain open.
- After a verified sub-batch or Post-Verify result verification, execute or dispatch the next same-request owner/action unless explicit cancellation, explicit redirect, proven user-owned blocker, destructive/security/operator-approval gate, or owning upstream deferral applies.
- Load the `self-verification` skill and execute Critical Challenge before declaring the change verified.
- Failed Post-Verify result verification reopens the smallest Change Sequence correction; a newly exposed material review question returns to Step 5 before further mutation.

## Change Constraints
- Plan review is not content review.
- Do not bypass review separation on meaningful governance changes.
- Do not add doctrine by convenience placement.
- Do not compress away unique meaning.
- When a legacy rule label or violation code is retired, preserve the underlying operational contract in the correct owner document or enforcement surface.
- Identifier removal does not justify rule loss.
- When adding, deprecating, retiring, or merging rules, record the lifecycle state transition explicitly on the owning governance surface.
- Lifecycle state order is `ACTIVE` -> `DEPRECATED` -> `RETIRED` -> `MERGED`.
- New rules start as `ACTIVE`.
- The execution gate in step 5b governs governance-sensitive execution. See step 5b above.
- Runtime permission bypass, hook approval, and pre-authorized governance-change dispatch do not waive review separation.
- They also do not waive preservation checks.
- They also do not waive the destructive/safety gate.
- High-traffic governance surfaces named by `CLAUDE.md` `## Priority And Ownership` and `## Change And Preservation` require session revalidation and baseline anchoring before modification resumes after interruption.

## Patch Execution Method
Use this method for team-system asset patches that must remain understandable without hidden session memory. It refines patch mechanics; it does not decide the primary sequence owner.

### Patch classification map
See `.claude/skills/governance-change/references/decision-and-repair.md` for patch classification.

### Required operating rules
- For confirmed recurrence-hardening patches, treat the patch as bounded recurrence-barrier installation, not content accumulation. The patch must close a confirmed recurrence path without opening unrelated scope.
- Default patch direction is to strengthen an existing owner-local rule, gate, checklist, packet, or reference chain.
- Satisfy `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate` before drafting or mutating.
- Hook-Last-approved runtime edges remain under the hook/settings expansion gate.
- Do not weaken an already-correct path just to land the hardening.
- This method refines `Change Sequence` Step 1 through Step 3; it does not replace the `Change Sequence`, review separation, execution gate, or post-verify requirements.
- Before drafting, freeze:
  - defect basis, design-intent basis, causal basis, and recurrence path
  - `PATCH-CLASS`, `BASELINE-CLASS`, and owner surface
  - consumed-layer basis and generalization basis
  - positive execution path, recovery path, enforcement tier, protected meaning, and proposed edit operation
- If any item is unclear, inspect or hold instead of editing by intuition.
- The positive execution path states the valid owner, trigger, evidence, next action, and user/operator burden after the patch lands.
- The enforcement tier states the lightest sufficient surface: owner prose, checklist, packet field, owner instruction warning, Hook-Last-approved runtime warning, or Hook-Last-approved hard block.
- Warning, block, deny, deletion, restriction, or removal edits are valid only when that positive execution path remains explicit and executable.
- Before drafting, enumerate affected surfaces beyond the edited file.
- Affected surfaces include exact text/pattern matches, semantic-family terms, downstream doctrine references, sibling owner surfaces, and runtime/hook/settings mirrors.
- Missing this enumeration is a patch-readiness defect, not a post-review nit.
- For MCP or external-tool capability changes, affected surfaces include:
  - project-root `.mcp.json`
  - `.claude/settings.json`
  - role tool authorization
  - hook/settings posture
  - the owning skill/reference authority boundary
- When the modified artifact has no declared design-intent surface, the change packet itself carries the intent.
- "No declared intent" means no Structural Contract, no fixed section order, no owner boundaries, and no authoring principles.
- The packet assigns a `PATCH-CLASS` failure-mode tag.
- The packet adds a one-sentence rationale in `CHANGE-BOUNDARY`.
- A follow-on patch adds the missing declared-intent surface when scope allows.
- Classify the failure mode before choosing text.
- Failure modes are `missing-owner`, `weak-owner`, `wrong-owner`, `non-compliance`, `weak-enforcement`, and `capability-gap`.
- Use `.claude/skills/governance-change/references/decision-and-repair.md` for allowed and prohibited responses.
- Choose the smallest edit operation that preserves protected meaning: `tighten`, `replace`, `re-home`, `merge`, `append`, or `delete`.
- Append only when no existing owner slot can absorb the meaning cleanly.
- Delete only when the removed meaning is proven duplicate, obsolete, or preserved elsewhere.
- Use one rule or action per sentence.
- Split different ideas into separate sentences or bullets.
- Line count is not the strength metric; the shortest owner-local edit that preserves stop, owner, evidence, recovery, and protected meaning wins.
- For every moved, compressed, replaced, or removed meaning, keep source-meaning inventory and destination-owner mapping explicit in `CHANGE-BOUNDARY`.
- `CHANGE-BOUNDARY` must let another model reconstruct the patch from repository state alone.
- Preserve closed boundaries. Keep each role, skill, rule, hook, and packet inside the defect's proven recurrence path.
- Preserve protected local restatements with a named owner and direct-consumption or isolation-safety basis.
- When the failure mode is `non-compliance`, harden adherence through a clearer trigger, checklist, packet field, self-verification gate, or Hook-Last-approved runtime edge instead of duplicate doctrine.
- Review the proposed changed content, not only the plan, before execution.
- Check owner fit, structural fit, positive execution path clarity, information-loss risk, adjacent-document overlap, boundary overreach, and enforcement false-positive risk.
- Verification must prove both sides of the patch.
  The recurrence path is blocked or explicitly assigned.
  The positive execution path remains visible and executable.
  The existing design remains closed.
  No unique meaning is lost.
  No cross-reference is dead.
  No owner boundary is weakened.
  No previously working behavior, acceptance path, or runtime truth surface regresses.
- If verification finds a defect in the patch, do not close with partial improvement.
  Reopen the smallest invalidated step.
  Revise the patch.
  Rerun verification until `CONVERGENCE-STATUS` is `converged`, `HOLD`, or explicit follow-up ownership.
  Each verification pass remains bounded by `self-verification` Step 4.

### Structural Baseline
- Treat the current target design as the structure baseline.
  - Legacy or reference material can restore missing meaning, but it does not automatically reclaim file layout, ownership, or runtime structure.
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
- Do not place always-on doctrine in `.claude/rules/*.md` files. If the content loads unconditionally, route it into `CLAUDE.md` or the correct owner-local surface instead.
- Apply `replace`, `trim`, or `re-home` over append-only accumulation, but never by weakening protected meaning.
- When repeated meaning has a named owner and direct-consumption or isolation-safety basis, treat that local restatement as protected common contract rather than cosmetic duplication.
- When a value must stay configurable, keep one literal owner for that value and make all other documents or prompts reference that owner instead of copying the literal value.

### Specialist And Skill Ordering
- When a missing reusable skill blocks credible completion, complete the skill update or introduction before the blocked downstream task resumes normal execution.
- Keep the pause scoped to the blocked downstream surface rather than stalling unrelated safe work.
- Treat the consuming lane as the default skill-up owner.
- Each specialist skill declares its `PRIMARY-OWNER`.
- Each specialist skill declares `SECONDARY-CONSUMER` when present in SKILL.md frontmatter.
- Each specialist skill restates those fields in its Structural Contract when local readability requires it.
- The owning role file or lane detail reference enumerates its specialists and the cross-specialist controlling order applicable within that role:
  - developer-owned specialists and their controlling order: `skills/agent-developer/references/developer-lane-detail.md` § Specialist Skill Loading.
  - reviewer-owned specialists: `skills/agent-reviewer/references/reviewer-lane-detail.md` § Specialist Skill Loading.
  - tester-owned specialists: `skills/agent-tester/references/tester-lane-detail.md` § Specialist Skill Loading.
- Treat common-skill hardening differently from specialist skill-up.
  - Common-skill patches still require one primary owner, never diffuse co-ownership.
  - Inspectors propose wording, challenge defects, and review the patch, but the primary owner performs the final direct edit for the shared procedure surface.
  - For current shared team-operation skills, `team-lead` is the default primary owner unless governance explicitly records a different owner.

### Post-Change Discipline
- After any recurrence-hardening or capability-expansion patch, make a bounded follow-on optimization decision before closing the topic.
  - Run the optimization pass when material avoidable redundancy or runtime burden is visible.
  - Otherwise close with `FOLLOW-ON-OPTIMIZATION: not-needed`.
  - Any optimization that does run must preserve the improved quality bar and protected meaning.

### Retroactive Application Phase
Doctrine landing is incomplete until the new or sharpened rule is applied to current-session surfaces it directly governs or contradicts.
Before a governance-hardening round closes, audit current-session artifacts, in-flight agent output, prior verdicts, active acceptance state, and live deliverable surfaces only when the new rule directly governs or contradicts them.
Required closeout surface: audited surfaces with result `unaffected`, `fixed`, `invalidated`, or `deferred by owning upstream record`; defect inventory and proposed fixes; same-chain fix dispatches or explicit deferral with named follow-up owner, boundary, and closure basis; stale prior verdicts blocked from downstream use until fresh re-verification.
Rounds hardening dashboard, verification, launcher, monitoring, governance migration, or similar recurring surfaces require the same retroactive audit.
Closing without that audit is a `[RETRO-APPLY]` defect.
The recurrence path already exists in the surfaces the new rule targets.

### File And Runtime Hygiene
- Keep the target payload free of detached runtime artifacts and orphan files.
  - Any new persistent file must have a clear owner and, when relevant, an explicit runtime or document reference path.
- Standardize the subpath contract under the owning folder root rather than hardcoding every full path in every document.
  - For specialist skills, keep one owner for the project skill root and let downstream documents reference the standardized active subpath.
- Do not keep shadow agent copies or reference-only shadow folders unless they preserve unique non-operational meaning not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep the governing patch method aligned with the real active and reference paths.

### Hook And Enforcement
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.
- Hook enforcement is a runtime guard, not a substitute for owner-document prose. The model-facing rule must remain in the correct owner surface; hooks only check or block its observable edges.
- Hook/settings edits that broaden runtime enforcement use `.claude/skills/governance-change/references/asset-change-checks.md` Hook-Last preflight; otherwise keep the issue owner-rule-only or `HOLD`.
- Keep governance-flow hook enforcement separate from settings-deny secret protection. `settings.json` `permissions.deny` is for hard credential and secret paths; runtime hooks technically guard observable governance procedure edges.
- Promote a rule to hard-block only when the enforcement basis is objective, deterministic, low-friction, and available from the current tool payload or current session state.
- If a rule depends on semantic interpretation, broad repo inspection, process-wide runtime scanning, or materially elevated false-positive risk, keep it `owner-rule-only` or `doctrine-only` until the meaning is packetized into exact fields.
- Do not add new hard-blocks merely to raise apparent coverage or enforcement rate.
- Protect operator autonomy and ordinary throughput.
- For non-destructive/non-security patches, choose the narrowest valid enforcement tier internally.
- Ask the user only when destructive, security-sensitive, operator-policy-choice, or objectively undecidable.
- When supervising doctrine, agent, skill, or hook patches, preserve owner-local boundary contracts and acceptance-gate restatements when they keep a file understandable in isolation.
- Do not let optimization, compression, rewrite, or governance-change directives erase protected common contracts that multiple owner files need for local readability and safe downstream use.
- For governance-sensitive patches, keep the patch class, owner surfaces, preserved meaning, and verification basis explicit.
- Another model must be able to continue safely from repository state alone.
- Do not rely on a dedicated patch-ledger file.

### Human-readable packet owners
See `.claude/skills/governance-change/references/human-readable-packet-owners.md` for field catalogs.

## Resolve Next Owner And Action
- Completed patch design opens the owning patch execution path.
- Completed retroactive audit opens this sequence's closeout.
- Affected current-session surface opens fix, invalidation, or deferred-by-owner record.
- Stale prior verdict opens fresh re-verification before downstream use.
- Missing retroactive audit keeps the hardening round open.
- Missing owner surface opens governance architecture mapping.
- Semantic overlap opens replace, trim, re-home, or protected restatement decision.
- Missing skill blocks only the affected downstream surface and opens skill update or introduction.
- Hook/settings enforcement expansion opens `Skill(governance-change)` Hook-Last preflight.
- Post-change material redundancy opens bounded optimization.
- Preserved patch basis returns to this sequence's verification.
