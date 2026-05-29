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
Load and learn the full `Skill(governance-modification)` body via actual `Skill(governance-modification)` tool invocation; in-context awareness, prior-session memory, or carrier prose asserting "loaded" without same-turn tool invocation does not satisfy this step.
Record the load as the same-turn `Skill(governance-modification)` tool-call evidence; this evidence is the basis for downstream Step 3 packet consumption and Step 5 verification.

# Step 2: Change Boundary
Freeze change boundary:
- `REQUEST-FIT-BASIS`
- `TARGET-INTENT-BASIS`
- active path/action boundary
- target `.claude` asset or asset set
- `RECURRENCE-BARRIER-BASIS` only when the active path/action is confirmed recurrence-barrier hardening

# Step 3: review-verification
Load and learn the full `Skill(review-verification)` body and call with bounded design question:
- target: Step 2 target asset or asset set
- scope: tier, problem basis, correction direction, consumed target surface, recurrence-barrier basis when material, removal-first design, direct-consumption relevance, functional independence, positive-function inventory, no-negative-impact result, report-prohibition no-negative-impact when renderable or reporting behavior can change, negative risk, patch-worthiness, patch-readiness, mutation readiness

Consume `review_verification_packet` returned by `Skill(review-verification)` Step 14.
Require `REMOVAL-FIRST-PATCH-DESIGN`, `PATCH-INDEPENDENCE`, `PATCH-WORTHINESS`, `FINDING-STATE-INVENTORY`, `JUDGMENT-RELIABILITY` when the change depends on a high-risk judgment, and `NEXT-OWNER-ACTION`.
Reject post-hoc review when it is offered as the missing pre-mutation basis for already-applied governance patches; route that order failure to recurrence-barrier hardening at the narrowest failed pre-mutation path.

# Step 4: Change Sequence Design
Write `CHANGE-SEQUENCE-DESIGN` only from `review_verification_packet.REMOVAL-FIRST-PATCH-DESIGN`.

Each design item records:
- `PROBLEM-BASIS`
- `CONSUMED-TARGET-SURFACE`
- `EDIT-OPERATION`
- `PRESERVED-MEANING`
- `PRE-MUTATION-BASIS`
- `REVIEW-PACKET-CITATION` — `review_verification_packet` `PACKET-ID` (or `REVIEW-TARGET` + verdict summary, or full-content reference) that supplied this design item
- `PATCH-INDEPENDENCE` — intended changed function set, positive-function inventory, no-negative-impact result, report-prohibition no-negative-impact when material, cross-function correlation basis, and philosophy-conformance basis from `.claude/reference/modification-core-law.md` `## Modification Law`
- `NEXT-OWNER-ACTION`

Derive `PRE-MUTATION-BASIS` from `.claude/reference/modification-minimal-governance-change-law.md` and `# Patch Execution Method`.
Apply `.claude/CLAUDE.md` `## 5. Modification Philosophy` keyword gate through `.claude/reference/modification-core-law.md`; the canonical operator-emphasized keyword set lives at `.claude/CLAUDE.md` `## 5. Modification Philosophy` (consume the canonical list at design-time rather than an inline restatement that drifts stale).
Design items lacking `REVIEW-PACKET-CITATION` or `PATCH-INDEPENDENCE` are carrier prose, not review-verified design; reject and reopen Step 3.
Keep Step 4 design-only; route file mutation through Step 6.

# Step 5: self-verification
Load and learn the full `Skill(self-verification)` body via actual `Skill(self-verification)` tool invocation on the produced `CHANGE-SEQUENCE-DESIGN`.
Call with result-verification target `CHANGE-SEQUENCE-DESIGN`, outgoing governance-change claim, the Step 2 change boundary, and the Step 3 `review_verification_packet` `PACKET-ID` (or content reference) as upstream basis.
Let `Skill(self-verification)` handle failure, correction packet construction, and repeated correction until convergence or blocker-routing after internal correction routes are exhausted.
Self-verification `PASS-1`/`PASS-2` records cite this Step 5 invocation and the consumed Step 3 packet; carrier prose asserting "self-verification converged" without these citations is fabrication and blocks Step 6 handoff.

# Step 6: Handoff or Next Work
Hand off only self-verified `CHANGE-SEQUENCE-DESIGN` items.
If patch execution is next, execute or hand off through `# Patch Execution Method` with `PRE-MUTATION-BASIS`.
If same-request design rows remain, continue the next row through Step 2.
If a recurrence-barrier hardening path converged, carry verified `RESUME-ACTION`.
If the governance design interrupted another procedure path, reopen that path with the verified design basis.
Return converged governance-modification state to the calling owner through internal handoff without user-facing report when no same-request executable owner/action remains.

# Patch Execution Method
Use this section to prepare `PRE-MUTATION-BASIS` during Step 4.
Execute patches through this section only after Step 4 design and Step 5 self-verification converge.

## Preconditions
- Current owner/action boundary, `REQUEST-FIT-BASIS`, `TARGET-INTENT-BASIS`, and target `.claude` asset set are recorded.
- `PRE-MUTATION-BASIS` is recorded before mutation and may be prepared from this section during Step 4.
- `Skill(review-verification)` supplied the current mutation-readiness, patch-worthiness, and patch-independence basis required by the change tier; `PRE-MUTATION-BASIS` must cite the actual `review_verification_packet` `PACKET-ID` (or content reference) from Step 3. Carrier prose asserting "review-verification supplied basis" without packet citation is fabrication and blocks mutation.
- `PASS-1`, `PASS-2`, validator `PASS`, accepted report text, or upstream carrier labels do not create mutation authority; mutation opens only from current `PRE-MUTATION-BASIS` plus current Step 3 mutation-readiness and required `JUDGMENT-RELIABILITY` basis.
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
- Record the 5-axis post-patch verification matrix: defect closure, intent preservation, no new defect, cross-reference integrity, and functional independence.
- Record positive-function inventory and no-negative-impact result for every positive function in the coherence radius.
- Record report-prohibition no-negative-impact when any changed surface can affect user-facing prose, renderable transport, completion, hook, runtime, or reporting-governance behavior.
- Reopen `Skill(review-verification)` when any post-patch axis, positive-function no-negative-impact item, or philosophy-conformance item fails or remains open.
- Classify affected current-session surfaces as `unaffected`, `fixed`, `invalidated`, or `deferred by cited lawful owner-deferral authority`.
- Treat affected prior verdicts, PASS labels, handoffs, or closures as stale until fresh re-verification.
- Keep team-operation continuity through retained carriers, packet fields, consumed owner surfaces, or verification records.
- Reopen `Skill(review-verification)` when post-verification exposes material coherence, owner-surface, negative-risk, removal, or patch-worthiness risk.
- Load and learn the full `Skill(self-verification)` body on the changed-result or resume-action claim before closure, reporting, or handoff.

# Output Format
```
GOVERNANCE-MODIFICATION:
CONVERGENCE-STATE:
```
