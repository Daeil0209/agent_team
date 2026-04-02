---
name: team-governance-sequences
description: Standard governance procedures for change control, self-growth, and update or upgrade work in the Claude team setup. Use for the main team lead, delegated planner, and developer when rules, skills, settings, hooks, or other team-system assets are being changed.
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
- Do not compress a governance procedure into a shorter convenience path merely because the intended end state seems obvious. Classification, review, execution, and verification stages remain distinct unless the owning rule explicitly marks a lighter path.
- Treat instruction-routing changes as governance-sensitive too. The governing lane issues control downward, workers report blockers and handoffs upward, and direct worker-to-worker traffic stays bounded to local advice or challenge rather than informal co-management.

## Change Sequence

The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, and skill changes.

### Required order

1. `Classify + Plan`
- Classify the change type and scope before editing.
- At minimum distinguish patch, addition, optimization, or other governance-relevant change classes.

2. `Analysis`
- Check viability, structural fit, overlap risk, and whether the target document is the correct owner.
- When compression, merge, rewrite, or re-home is in scope, perform explicit loss-risk analysis before drafting or editing. Name protected meaning, destination owner, and what would be damaged if compression goes too far.

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

Optimization follows, it does not replace, the reviewed change path.
- For governance-sensitive work, `information-loss review -> local-context balance review -> bounded modification -> bounded optimization` remains the core path, and required related-doc review must be completed before bounded modification whenever optimization or compression is in scope.
- Do not start with optimization pressure and work backward into missing review.
- Before editing a frequently loaded owner file, inspect the immediately adjacent owner surfaces that define or consume the same contract so the local patch does not create neighbor drift.
- Record that related-owner inspection explicitly. `BALANCE-REVIEW` protects local fit; `RELATED-DOC-REVIEW` proves that adjacent contract owners were actually checked before the patch moved.

### Change constraints

- Plan review is not content review.
- Do not bypass review separation on meaningful governance changes.
- Do not add doctrine by convenience placement.
- Do not compress away unique meaning.
- Do not let repeated patch habits silently replace the designed sequence. A familiar change class still needs the owned stages and gates that govern it.
- When a legacy rule label or violation code is retired, preserve the underlying operational contract in the correct owner document or enforcement surface. Identifier removal does not justify rule loss.
- If information-loss review has not already been completed, execution is not ready.

## Self-Growth Sequence

The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.

- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar.
- When the operator has explicitly directed a `Self-Growth Sequence` execution, the pre-authorization rule in `CLAUDE.md` > `Training And Self-Growth Governance` applies to all internal approvals within that sequence.
- When self-growth expands a lane's charter, capability, or reusable content, require a bounded follow-on optimization pass before the topic is fully closed. That optimization may remove avoidable cost, runtime burden, or redundancy, but it must not weaken the upgraded quality bar or drop protected meaning.
- The default self-growth preparation path is strict: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization. Do not let benchmark pressure or familiarity skip the proposal or loss-risk stages.
- A post-change clean rerun is stability evidence, not by itself proof of advancement. Keep the baseline, comparison surface, fairness conditions, and claimed before/after delta inspectable when self-growth is said to have worked.
- If a lane, skill, or routing path is said to have advanced, keep promotion-readiness status, throughput or neighboring-lane regression visibility, and follow-on optimization closure explicit before closeout.
- Self-growth starts from an observed deficiency signal, not from a fixed discovery menu.
- Use path labels and categories only as minimal routing guides after investigation clarifies the problem and ownership question.
- Management, coordination, adjudication, monitoring, and sequence-discipline defects in `team-lead` are valid self-growth surfaces; do not force those problems into a worker-only frame.

### Required order

1. Identify the active improvement topic from evidence.
2. Require relevant lanes to inspect the topic before ownership is finalized.
3. Adjudicate ownership explicitly.
  - When more than one lane could plausibly own the improvement, open a competitive bid packet instead of defaulting to the lane that handled similar work before.
  - Each competitive bid packet should name ownership-fit basis, overlap cost, throughput effect, expected evidence quality, and bounded rollback path.
  - Lead adjudication should compare durable ownership fit, acceptance reliability, coordination cost, regression risk to neighboring lanes, and long-run cumulative team benefit.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
  - Keep the preparation stages explicit in this order:
    - benchmark
    - cross-check and anti-hallucination confirmation
    - concrete modification proposal
    - pre-edit loss-risk gate
    - bounded modification
    - verification
  - Benchmark evidence by itself does not authorize direct editing.
  - If the modification proposal or change boundary is still vague, the topic is not edit-ready.
6. After the quality-raising change lands, run a bounded optimization pass that removes avoidable cost, runtime burden, or redundancy without lowering the upgraded quality bar or losing protected information.
6A. Enforce iteration limits on self-growth cycles:
  - Maximum 3 optimization or hardening cycles per single topic before mandatory closeout or escalation.
  - Each cycle must produce a measurably different result from the previous cycle.
  - If 3 cycles have not resolved the topic, escalate to the operator or record the topic as deferred with an explicit owner.
  - Do not let unbounded self-improvement loops consume resources without convergence.
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
- Protect average-capability protection for active lanes.
  Do not accept a local skill-up or new-skill win if it silently weakens a neighboring lane or lowers the team's sustainable average capability.
- Do not introduce a new skill when a bounded update to an existing owner would solve the same problem more cleanly.
- Do not use self-growth, optimization, compression, or rewrite work as justification for removing protected local restatements that keep owner files safe to read in isolation.
- Require anti-drift anchors in all agent definitions: each agent file should include explicit role re-establishment statements that prevent identity drift, scope creep, and personality inconsistency during long sessions.

## Update/Upgrade Sequence

The `Update/Upgrade Sequence` applies when doctrine, agents, skills, settings, hooks, or other team-system assets are modified.

### Required checks

1. Confirm the target artifact owner.
2. Perform semantic overlap review before adding new rules or procedures.
   If execution is driven by a user-provided file list, copy set, or overwrite manifest, collapse duplicates and make the final unique source-to-destination write set explicit before any writer is dispatched.
   Deterministic manifest sync or overwrite propagation is single-writer by default; shard only after pre-execution review and disjoint write scopes are explicit.
3. Prefer `replace`, `trim`, or `re-home` over append-only accumulation.
4. Preserve migration traceability.
   The source meaning, destination owner, and verification basis must remain inspectable.
5. Perform zero-information-loss confirmation for moved, merged, compressed, or re-homed operational meaning.
   The before/after comparison must show where each unique rule meaning now lives.
6. Where a runtime setting or threshold must remain configurable, keep one owner for the value and make all other documents or prompts reference that owner instead of duplicating the literal value.
7. Reconcile inherited runtime state before patch execution.
   Treat previous setup logs, current-project auto memory, known session-scoped ledgers, and runtime-owned generated residue as stale carryover until the current environment has been re-established.
   Do not auto-clear logs or project auto memory at patch entry just to force a clean-looking surface; closeout and session-end cleanup own that reset while `session-state.md` remains continuity state.
   If the current environment cannot be reconciled cleanly, hold the patch instead of editing owner files to match stale runtime artifacts.
8. When a hook still enforces a contract, keep that contract understandable through owner-document prose and human-readable deny reasons rather than requiring a large central code table.
9. Treat intentional local restatements of role boundaries, lane contracts, and acceptance gates as protected meaning, not cosmetic duplication.
   If a rule is repeated so a file remains safe to read in isolation, do not remove it unless an equivalent owner-local contract still exists after the change.
10. When optimization, compression, rewrite, or self-evolution is the stated reason for the change, explicitly classify each repeated governance sentence as either protected common contract or safely removable duplication before trimming it.
11. For high-traffic governance optimization or compression, rebuild edit-readiness from current-session repository state. For those high-traffic shared-surface topics, after a fresh session, reset, restart, or pause-return, inherited notes and remembered partial review are continuity only; keep the topic in `HOLD` until `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`, `SOURCE-MEANING-INVENTORY: explicit`, `DESTINATION-OWNER-MAP: explicit`, and `CHANGE-BOUNDARY: <bounded intended delta>` are explicit again.
12. Run the full `Change Sequence`.
13. Record any remaining migration gap explicitly rather than assuming the update is complete.

### Skill Introduction Rules

- New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
- Treat the consuming lane as the default skill-up owner. If a specialist skill is developer-exclusive, `developer` is the default maintenance and upgrade owner while `team-lead` or delegated `planner` governs approval and adoption.
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
- Runtime packet form for that same approval:
  - `SKILL-CATEGORY: repeatable-procedure|specialist-judgment-surface|integration-environment-bridge|governance-quality-hardening`
  - `REUSE-PATTERN: <expected reuse pattern>`
  - `OVERLAP-RESULT: <existing-owner overlap result>`
  - `CHOSEN-OWNER: <chosen owner>`
  - `EXPANSION-INSUFFICIENCY: <why existing skill expansion was insufficient>`
  - `FIRST-ADOPTION-PATH: <first adoption path>`
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
- Treat additions, deletions, rewrites, migrations, compressions, and optimizations all as governance modifications with loss risk.
  - None of those forms are exempt from the same preservation packet merely because the requested delta sounds small, routine, or cleanup-oriented.
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
  - For current developer-exclusive specialist skills, `developer` performs the skill-up execution while `team-lead` or delegated `planner` governs approval and adoption.
- Patch-time runtime hygiene comes before owner-surface editing.
  - Treat previous setup logs, current-project auto memory, and runtime-owned generated residue as stale carryover first, then rebuild current truth from revalidated environment state, continuity, and repository evidence.
  - Do not bend doctrine, settings, hooks, or agent files to fit stale log or auto-memory residue from an earlier setup.
- Manifest-driven propagation requires review before execution.
  - If the user supplies the file list or overwrite target set, normalize that manifest first, report the final unique write set, and treat deduplication as part of pre-execution review rather than optional cleanup.
  - Do not open multi-developer fan-out on deterministic manifest sync or overwrite work unless the disjoint write scopes are already explicit.
- After any self-growth or capability-expansion patch, run a bounded follow-on optimization pass before closing the topic.
  - That optimization may reduce cost, runtime burden, or redundancy, but it must preserve the improved quality bar and protected meaning.
- Current standard pre-dispatch packet for governance-sensitive developer execution:
  - `TASK-CLASS: governance-patch`
  - `SEQUENCE: change|self-growth|update-upgrade`
  - `PATCH-CLASS: hardening|structural-normalization|migration-rehome|config-owner-standardization|skill-up|new-skill|follow-on-optimization`
  - `OWNER-SURFACE: <owner files>`
  - `BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor`
  - `INFO-LOSS-REVIEW: done`
  - `BALANCE-REVIEW: local-context-checked`
  - `RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked`
  - `PATCH-REVIEW: pre-exec-done`
  - `MODIFICATION-PROPOSAL: explicit`
  - `SOURCE-MEANING-INVENTORY: explicit`
  - `DESTINATION-OWNER-MAP: explicit`
  - `CHANGE-BOUNDARY: <bounded intended delta>`
  - `VERIFY-BASIS: <review or verification basis>`
- Additional required fields when optimization, compression, deduplication, rewrite, or self-growth optimization is in scope:
  - `OPTIMIZATION-ORDER: post-change-only`
  - `OPTIMIZATION-GUARD: zero-loss`
  - `PROTECTED-MEANING: checked`
- Additional required fields when that governance modification targets high-traffic shared governance surfaces or resumes after session turnover:
  - `SESSION-REVALIDATION: current-session-repo`
  - `BASELINE-ANCHOR: captured`
- Additional required fields when the active governance patch is executed under `Self-Growth Sequence`:
  - `CAPABILITY-SIGNAL: <why this self-growth topic exists>`
  - `INSPECT-LANES: <lanes that inspected the topic>`
  - `OWNER-ROUTING: existing-owner|single-fit|competitive-bid`
  - `BALANCE-GUARD: average-capability-protected`
  - `BENCHMARK-MODE: light|full`
  - `BENCHMARK-BASIS: <baseline or simpler-path basis>`
  - `BENCHMARK-SURFACE: <what is being compared>`
  - `COMPARISON-CONDITIONS: fixed|equivalent|justified-delta`
  - `IMPROVEMENT-DELTA: <claimed before/after difference>`
  - `BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only`
  - `CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed`
  - `HALLUCINATION-GUARD: cite-or-hold`
  - `PROMOTION-READINESS: ready|hold|not-targeted`
  - `THROUGHPUT-STATUS: preserved|regressed|unknown`
- For early comparative evidence shaping, let `researcher` own baseline construction, comparison-axis framing, fairness notes, and contradiction mapping before the topic escalates into a full `bench-sim` adjudication path.
- Use those investigation and benchmark stages to make the deficiency and its significance explicit before self-growth execution hardens into editing.
- Upgrade the self-growth packet to the full benchmark form when `PATCH-CLASS: skill-up|new-skill` or `OWNER-ROUTING: competitive-bid`:
  - `BENCHMARK-MODE: full`
  - `BENCHMARK-SKILL: bench-sim`
  - `BENCHMARK-BASELINE: <before path or incumbent owner>`
  - `BENCHMARK-AXIS: fairness|promotion-gate|competitiveness|average-capability`
  - `BENCHMARK-EVIDENCE: simulator-only|repo-local|live-task|mixed`
- Treat benchmark folklore, memory-only examples, or uncited external comparisons as unfit benchmark input. If provenance or inspectability is weak, hold or downgrade the benchmark claim instead of letting it steer ownership.
- Keep benchmark cross-check state explicit as well. If corroboration is missing, do not let a polished comparative story masquerade as repo-confirmed or externally confirmed evidence.
- For self-growth execution readiness, `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed` is still benchmark-stage `HOLD`, not edit-ready evidence.
- Additional required fields when `PATCH-CLASS: skill-up|new-skill`:
  - `GROWTH-PATH: existing-skill-expansion|new-skill-introduction|agent-charter-hardening|path-scoped-governance-rule|role-routing-correction`
- Additional required fields when `PATCH-CLASS: new-skill`:
  - `SKILL-CATEGORY: repeatable-procedure|specialist-judgment-surface|integration-environment-bridge|governance-quality-hardening`
  - `REUSE-PATTERN: <expected reuse pattern>`
  - `OVERLAP-RESULT: <existing-owner overlap result>`
  - `CHOSEN-OWNER: <chosen owner>`
  - `EXPANSION-INSUFFICIENCY: <why existing skill expansion was insufficient>`
  - `FIRST-ADOPTION-PATH: <first adoption path>`
- Additional required fields when `OWNER-ROUTING: competitive-bid`:
  - `BID-CANDIDATES: <candidate owners>`
  - `BID-BASIS: ownership-fit|overlap-cost|throughput-effect|evidence-quality|rollback-path`
  - `ADJUDICATION-BASIS: durable-ownership-fit|acceptance-reliability|coordination-cost|neighbor-regression-risk|long-run-cumulative-team-benefit`
- Do not create detached runtime artifacts or orphan files inside the target payload.
  - Any new persistent file must have a clear owner and, when relevant, an explicit runtime or document reference path.
- Standardize the subpath contract under the owning folder root rather than hardcoding every full path in every document.
  - For specialist skills, keep one owner for the project skill root and let downstream documents reference the standardized active subpath.
- Do not keep shadow subagent copies or reference-only shadow folders unless they preserve unique non-operational meaning that is not already captured by the active owner documents.
- When normalizing folder structure, update the owning index or doctrine surfaces that explain the layout.
  - At minimum keep `CLAUDE.md` and the governing patch method aligned with the real active and reference paths.
- Keep deny reasons and owner-document prose human-readable when hooks enforce the contract.
- Do not require or create a dedicated patch-ledger file for governance-sensitive work.
  - Session handoff prose may summarize the work, but reconstructability must already live in the touched owner surfaces, active preservation packet, and verification assets.


### Patch Reconstructability

For governance-sensitive patches, make the following reconstructable from the touched owner surfaces, active patch packet, and verification assets without a dedicated patch-ledger file:

1. patch class
2. touched owner surfaces
3. source meaning inventory for each unique rule, contract, or runtime ownership surface that moved, merged, or was intentionally restated
4. destination owner map for each preserved, merged, re-homed, or protected meaning
5. configurable value owner when literals were standardized
6. verification basis
7. unresolved gap or deferred hardening owner when anything remains open
8. follow-on optimization result after self-growth, including either the bounded optimization change or the explicit statement that no safe further reduction was available without lowering quality
