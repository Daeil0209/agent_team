---
name: governance-modification
description: Govern team-system asset changes and install recurrence barriers.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Structural Contract
- Produce governance asset change or confirmed recurrence-barrier hardening only; do not perform inspection, audit, proposal-only review, or non-mutation routing as a substitute.
- Keep this fixed order after Structural Contract: Flow Overview, Reference Map, Step 1, Step 2, Step 3, Step 4, Step 5, Step 6, Patch Execution Method, Output Format.
- Keep `# Step 1` through `# Step 6` and `# Patch Execution Method` as canonical anchors; do not rename or renumber.
- Always run Step 3 (review-verification) and Step 5 (self-verification) before Patch Execution Method.

# Flow Overview
```mermaid
flowchart TD
    Step1[Load Skill] --> Step2[Change Boundary] --> Step3[review-verification] --> Step4[Change Sequence Design] --> Step5[self-verification] --> Step6[Handoff or Next Work] --> END([AUTO-PROC])
```

# Reference Map
Load only the reference whose trigger is active.
- `.claude/reference/modification-core-law.md`: load for Modification Philosophy keyword gates, preservation rules, source-to-destination continuity, and retroactive current-session handling.
- `.claude/reference/modification-minimal-governance-change-law.md`: load for Patch-Ready Gate, removal-first edit selection, consumed-surface routing, and minimum executable information checks.

# Step 1: Load Skill
PROTECTED-LOCAL-RESTATEMENT-BASIS: skill-activation atomic-check — anti-fabrication tool-invocation rule colocated at every Step 1 invocation moment to defeat carrier-prose substitution at the load decision point. `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` defines the general rule; this surface applies it as the Step 1 atomic check at first execution of governance-modification.
Load `Skill(governance-modification)` via actual `Skill(governance-modification)` tool invocation; in-context awareness, prior-session memory, or carrier prose asserting "loaded" without same-turn tool invocation does not satisfy this step.
Record the load as the same-turn `Skill(governance-modification)` tool-call evidence; this evidence is the basis for downstream Step 3 packet consumption and Step 5 verification.

# Step 2: Change Boundary
Freeze change boundary:
- `REQUEST-FIT-BASIS`
- `TARGET-INTENT-BASIS`
- active path/action boundary
- target `.claude` asset or asset set

# Step 3: review-verification
Load `Skill(review-verification)` and call with bounded design question:
- target: Step 2 target asset or asset set
- scope: mode, tier, problem basis, correction direction, consumed target surface, removal-first design, direct-consumption relevance, negative risk, patch-worthiness, patch-readiness, mutation readiness

Consume `review_verification_packet` returned by `Skill(review-verification)` Step 14.
Require `REMOVAL-FIRST-PATCH-DESIGN`, `PATCH-WORTHINESS`, `FINDING-STATE-INVENTORY`, and `NEXT-OWNER-ACTION`.
Reject post-hoc review on already-applied governance patches; route the order failure to recurrence-hardening at the narrowest failed pre-mutation path.

# Step 4: Change Sequence Design
Write `CHANGE-SEQUENCE-DESIGN` only from `review_verification_packet.REMOVAL-FIRST-PATCH-DESIGN`.

Each design item records:
- `PROBLEM-BASIS`
- `CONSUMED-TARGET-SURFACE`
- `EDIT-OPERATION`
- `PRESERVED-MEANING`
- `PRE-MUTATION-BASIS`
- `REVIEW-PACKET-CITATION` — `review_verification_packet` `PACKET-ID` (or `REVIEW-TARGET` + verdict summary, or full-content reference) that supplied this design item
- `NEXT-OWNER-ACTION`

Derive `PRE-MUTATION-BASIS` from `.claude/reference/modification-minimal-governance-change-law.md` and `# Patch Execution Method`.
Apply `.claude/CLAUDE.md` `## 5. Modification Philosophy` keyword gate through `.claude/reference/modification-core-law.md`; the canonical operator-emphasized keyword set lives at `.claude/CLAUDE.md` `## 5. Modification Philosophy` (consume the canonical list at design-time rather than an inline restatement that drifts stale).
Design items lacking `REVIEW-PACKET-CITATION` are carrier prose, not review-verified design; reject and reopen Step 3.
Keep Step 4 design-only; route file mutation through Step 6.

Choice-situation law:
- If multiple defensible CHANGE-SEQUENCE-DESIGN row-ordering / row-atomicity / serial-vs-parallel application options exist for the same patch-set per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before design-row selection. Per-row EDIT-OPERATION selection (re-home / delete / split / merge) is owned upstream at `Skill(review-verification)` Step 6 Design Removal-First Patch; that step also consumes the canonical rule when multiple defensible operations exist.

# Step 5: self-verification
Load `Skill(self-verification)` via actual `Skill(self-verification)` tool invocation on the produced `CHANGE-SEQUENCE-DESIGN`.
Call with result-verification target `CHANGE-SEQUENCE-DESIGN`, outgoing governance-change claim, the Step 2 change boundary, and the Step 3 `review_verification_packet` `PACKET-ID` (or content reference) as upstream basis.
Let `Skill(self-verification)` handle failure, correction packet construction, and repeated correction until convergence or `HOLD`.
Self-verification `PASS-1`/`PASS-2` records cite this Step 5 invocation and the consumed Step 3 packet; carrier prose asserting "self-verification converged" without these citations is fabrication and blocks Step 6 handoff.

# Step 6: Handoff or Next Work
Hand off only self-verified `CHANGE-SEQUENCE-DESIGN` items.
If patch execution is next, execute or hand off through `# Patch Execution Method` with `PRE-MUTATION-BASIS`.
If same-request design rows remain, continue the next row through Step 2.
If a recurrence barrier design converged, carry verified `RESUME-ACTION`.
If the governance design interrupted another procedure path, reopen that path with the verified design basis.
Return converged governance-modification state silently to the calling owner when no same-request executable owner/action remains.

# Patch Execution Method
Use this section to prepare `PRE-MUTATION-BASIS` during Step 4.
Execute patches through this section only after Step 4 design and Step 5 self-verification converge.

## Preconditions
- Current owner/action boundary, `REQUEST-FIT-BASIS`, `TARGET-INTENT-BASIS`, and target `.claude` asset set are recorded.
- `PRE-MUTATION-BASIS` is recorded before mutation and may be prepared from this section during Step 4.
- `Skill(review-verification)` supplied the current mutation-readiness or patch-worthiness basis required by the change tier; `PRE-MUTATION-BASIS` must cite the actual `review_verification_packet` `PACKET-ID` (or content reference) from Step 3. Carrier prose asserting "review-verification supplied basis" without packet citation is fabrication and blocks mutation.
- `Skill(self-verification)` Step 5 convergence is recorded with its `Skill(self-verification)` tool-call evidence; carrier-asserted convergence without tool-call evidence is fabrication and blocks mutation.
- The patch target is the consumed owner surface that can execute the changed meaning.

## Execution
PROTECTED-LOCAL-RESTATEMENT-BASIS: patch-execution atomic-check — execution rules colocated here for atomic team-lead consultation at every patch application moment. `.claude/reference/modification-core-law.md` (removal-first edit selection, preservation rules) and `.claude/reference/modification-minimal-governance-change-law.md` (Patch-Ready Gate, Minimal Governance Rules) define the general patch rules; this surface applies them at execution time as a single-load operational check, with skill-specific additions (Hook-Last, MCP/external-tool handling) inline.
- Patch from the current live file state; stale baselines, remembered content, and pre-session copies are evidence only.
- Apply only reviewed, bounded, policy-compliant edits.
- Prefer tighten, replace, trim, merge, re-home, or delete before append.
- For moved meaning, record source meaning, destination rationale, changed references, and preserved execution-critical fields.
- For deletion, verify the deleted meaning is duplicate, obsolete, harmful, or preserved on the destination owner surface.
- For recurrence or capability-gap repair, patch the existing consumed surface when it can carry the barrier.
- Create or expand a governance surface only when the review-verified path proves no existing consumed surface can carry the required barrier or reusable capability.
- For blocking hook/settings runtime-enforcement expansion, use Hook-Last review, `.claude/hooks/MANIFEST.md` ledger entry, and explicit operator approval before activation.
- For MCP or external-tool capability changes, preserve official-behavior alignment, capability boundary, fallback, and cleanup truth on the owning environment/runtime surface.

## Post-Verify
PROTECTED-LOCAL-RESTATEMENT-BASIS: post-mutation atomic-check — retroactive-application rules colocated here for atomic team-lead consultation at every patch post-verify moment. `.claude/reference/modification-core-law.md` `### Retroactive Application Rules` defines the general affected-surface classification and stale-verdict treatment; this surface applies them at post-mutation moment with skill-specific verification chain (review-verification reopen + self-verification load) inline.
- Verify the resulting diff, owner semantics, live references, information preservation, affected consumed surfaces, and in-flight or prior-verdict impact.
- Classify affected current-session surfaces as `unaffected`, `fixed`, `invalidated`, or `deferred per lawful owner-deferral basis`.
- Treat affected prior verdicts, PASS labels, handoffs, or closures as stale until fresh re-verification.
- Keep team-operation continuity through retained carriers, packet fields, consumed owner surfaces, or verification records.
- Reopen `Skill(review-verification)` when post-verification exposes material coherence, owner-surface, negative-risk, removal, or patch-worthiness risk.
- Load `Skill(self-verification)` on the changed-result or resume-action claim before closure, reporting, or handoff.

# Output Format
```
GOVERNANCE-MODIFICATION:
CONVERGENCE-STATE:
```
