---
name: review-verification
description: Return bounded review packets for live intent, coherence, procedure, skill-consumption, negative-risk, finding-state, or patch-worthiness judgment before correction, routing, mutation, validation, reporting, or closure.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

## Structural Contract
- Produce internal `review_verification_packet` only; do not mutate, test, validate, report, or satisfy self-verification convergence.
- Keep this fixed order after Structural Contract: Activation, Reference Map, Named Lane Lens Index, Packet, Review Workflow, Handoff Or Next Work.
- Keep `### 1` through `### 14` as `Steps 1-14`; do not rename these anchors.
- Always run `### 5. Critical Review Gate` and `### 14. Next-Owner Routing`.

## Activation
Load and learn the full skill body when a caller supplies a bounded review question whose requested scope requires inspection of design intent, owner boundary, procedure adherence, skill consumption, coherence, integrity, negative risk, defect promotion, removal, patch-worthiness, patch-readiness, or final-arbitration readiness.
Load and learn the full skill body when an outgoing or upstream claim is intended to be used as a high-risk judgment under `.claude/reference/review-and-verification-core-law.md` `## Judgment Reliability Law`.
Run all applicable steps for binding promotion, final rejection, patch/no-patch, patch-worthiness synthesis, patch-readiness, verdict support, or mutation-readiness review.
Use named lenses only as bounded packet evidence; they do not expand beyond the assigned review question.
Reset for a new target, corpus, findings set, patch design, diff, bounded question, or scope; stale packets, summaries, memory, and pre-patch snapshots do not carry forward.
Downstream citation of an unchanged packet is valid only when the downstream owner proves the prior packet covers the same or stricter target, corpus, bounded question, scope, claim ceiling, freshness, and workflow coverage required by that owner.
A `review_verification_packet` exists only after current `Skill(review-verification)` activation reaches Step 14 for the exact target, corpus, bounded question, and scope; named-lens claims exist only for exact `REVIEW-VERIFICATION-LENSES` and returned lens-relevant fields.

## Reference Map
- Load and consume `.claude/reference/review-and-verification-core-law.md` for evidence quality, verification truth, live intent, coherence, execution force, negative risk, finding-state, or patch-worthiness.
- Load and consume `.claude/reference/judgment-core-law.md` for acceptance readiness, final arbitration, independent-lane separation, verdict support, or `PASS/HOLD/FAIL` risk.
- Load and consume `.claude/reference/modification-core-law.md` for governance patch design, removal-first choice, simplification, compression, consumed owner surface, mutation readiness, or meaning preservation.
- Load and consume `references/governance-review-gates.md` for detailed claim, artifact-change, synthesis, finding-promotion, or patch-worthiness review.

## Named Lane Lens Index
Accept only these canonical `REVIEW-VERIFICATION-LENSES`: `design-intent-lens`, `owner-boundary-lens`, `procedure-adherence-lens`, `skill-consumption-lens`, `coherence-integrity-lens`, `governance-continuity-lens`, `minimum-executable-information-lens`, `negative-risk-lens`, `removal-first-lens`, `functional-independence-lens`, `patch-worthiness-lens`.
Normalize each uniquely recoverable shorthand or omitted `-lens` suffix to the canonical value and record the normalization basis before review proceeds.
For ambiguous aliases, proxy mappings, inferred equivalence, conflicting values, or ownership-changing lens entries, return `PROCEDURE-EXECUTION-RESULT: blocked:invalid-review-verification-lens` and `NEXT-OWNER-ACTION: packet-correction`.
Use named lenses to select lens-relevant required fields inside the caller-supplied or frozen target, corpus, and claim ceiling.
Named lenses do not narrow the target, corpus, claim ceiling, or required document-consumption scope; a requested narrowing below that scope records non-rendered `problem-report` before no-detail `scope-pressure` before review proceeds.
Mark out-of-lens fields `not-applicable:<claim-scope-basis>` only after recording that the caller-supplied or frozen scope remains intact.
Run all applicable steps for three or more lenses.
Reject bare `REQUIRED-SKILLS: [review-verification]` for a non-lead participant without named `REVIEW-VERIFICATION-LENSES`.

## Packet
Return internal `review_verification_packet` with:
- `PACKET-ID` — caller-supplied identifier when present, otherwise `REVIEW-TARGET` + activation context (turn or timestamp marker); used by downstream verification gates to cite this packet
- `REVIEW-TARGET`
- `CLAIM-CEILING`
- `PROCEDURE-EXECUTION-RESULT`
- `COHERENCE-RESULT`
- `INTEGRITY-RESULT`
- `NEGATIVE-RISK-RESULT`
- `WORKFLOW-COVERAGE`
- `FINDING-STATE-INVENTORY`
- `JUDGMENT-RELIABILITY` — per high-risk judgment basis required by `.claude/reference/review-and-verification-core-law.md` `## Judgment Reliability Law`; otherwise `not-applicable:no-high-risk-judgment`
- `CAUSE-REMEDY-CLASSIFICATION` — exact item-level entries per `.claude/reference/review-and-verification-core-law.md` `## Cause And Remedy Classification Law`; otherwise `not-applicable:no-defect-remedy-or-behavior-affecting-claim`
- `CITATION-EVIDENCE-INVENTORY` — per `### 12b. Citation Substantiation Gate`; populated when the produced packet carries an outgoing external citation or anchor claim, otherwise `not-applicable:no-outgoing-external-citation`
- `REMOVAL-FIRST-PATCH-DESIGN`
- `PATCH-INDEPENDENCE`
- `PATCH-WORTHINESS`
- `OPEN-SURFACES`
- `NEXT-OWNER-ACTION`

## Review Workflow
Run steps in numeric order against the current cumulative live state.
Keep evidence local to each step; put only result fields in the packet.
If target, corpus, findings, patch design, diff, or `CLAIM-CEILING` changes, reopen the earliest invalidated step.
Run Steps 6-9 only for patch design, removal, or mutation readiness; otherwise record `not-applicable:<basis>`.

### 1. Relearn Doctrine And Owner Intent
Read the governing review/verification philosophy and the requested target surfaces.
For governance hierarchy questions, inspect only the top doctrine, mapped core law, trigger-bound owner reference, and lower surface needed by the requested judgment.
Consume the basis that controls the requested review claim.
Name only material design intent, protected meaning, owner boundary, valid procedure path, stop condition, and acceptance surface.
If requested-claim basis is missing, stale, contradicted, or unconsumed, open the smallest correction owner or blocker-routing after internal correction routes are exhausted.

### 2. Freeze Requested Review Basis
Name the caller's review request, target, requested corpus, evidence burden, claim ceiling, output form, and any requested shard basis.
Inspect only surfaces needed to answer that bounded review question.
Open adjacent owner, producer/consumer, mapped core-law, or trigger-bound owner-reference surfaces only if the requested judgment cannot be made without them.
If requested corpus is unknown, open bounded discovery before judgment.

### 3. Inspect The Requested Target Surface
Inspect every frozen requested target and only the Step 2 material supporting surfaces.
Treat inventory proof as coverage evidence only; inspect content before judgment.
Separate owner surfaces from references, generated outputs, runtime state, non-authoritative evidence, and stale artifacts before judgment.

### 4. Synthesize Findings
Combine local or requested-shard findings into one evidence map by elimination-first judgment: preserve retained items and the rejection basis for removed alternatives.
Classify by owner semantics and operating effect.
Apply `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
Apply `.claude/reference/review-and-verification-core-law.md` `## Judgment Reliability Law` before using any high-risk judgment as a decisive basis.
Apply `.claude/reference/review-and-verification-core-law.md` `## Cause And Remedy Classification Law` before promotion, rejection, patch-worthiness, patch-readiness, patch/no-patch selection, no-defect judgment, or remedy-owner routing.
For any item proposed as `confirmed-defect`, apply `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`; missing required elements keep the item at the supported lower ladder state or `rejected:<basis>`.
Do not use ordering pressure, repair-order need, reviewer agreement, repeated wording, label similarity, plausible future risk, or explanation fluency as promotion evidence.
Keep raw candidate, candidate-classified, confirmed-defect, patch-worthy, patch-ready, rejected, no-patch, and open-candidate states separate.
Reject bare `CONFIRMED`; use exact ladder state.

### 5. Critical Review Gate
PROTECTED-LOCAL-RESTATEMENT-BASIS: critical-review-gate atomic-defeater-test — defeater enumeration colocated here for atomic test at every Critical Review Gate execution. `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law` defines under/over-specification, evasion-enabling, ambiguous, conflicting, bottleneck-forming, and over-broad-blocking as execution-force defects; this surface enumerates them together with additional review-verification-specific defeaters (protected-function loss, source-to-destination gap, runtime/tool/user-surface failure, stronger narrower alternative, etc.) for one-shot defeater-first sweep at Step 5 execution.
Try to disprove the preferred conclusion before any packet, synthesis, bestness, no-defect, no-regression, patch-worthiness, route, completion, or closure claim leaves review-verification.
Test material defeaters: owner-boundary conflict, protected-function loss, weaker procedure, weaker clarity, weaker execution force, missing confirmed-defect element, repair-order-as-defect-proof, reviewer-convergence-as-defect-proof, text-feature-only promotion, missing or burden-only skill consumption, upper-to-core gap, core-to-trigger-bound gap, under-specification, over-specification, evasion, ambiguity, conflict, bottleneck, over-broad blocking, judgment-reliability gap, cause/remedy classification gap, invalid cause/remedy enum, theme-level-only cause/remedy classification, unsplit mixed failure source, remedy-owner mismatch, hook-eligibility overclaim, missing counterexample oracle, untested stronger narrower alternative, self-ratification risk, untested strongest contrary hypothesis or classification, functional-independence violation, positive-function regression, hidden cross-function coupling, incidental behavior change, report-prohibition regression, source-to-destination gap, missing direct-consumption relevance, runtime/tool/user-surface failure, and stronger narrower alternative.
For source-to-destination gap review, trace every material hop in the claim chain, including source surface, producer output, synthesis, and outgoing claim when those surfaces are present.
Keep any untraced material hop as an open defeater.
Record evidence surface, confirmed/disproven/open result, correction owner, and next action for each material defeater per `.claude/reference/review-and-verification-core-law.md` `## Evidence Law` 3-component disproof-attempt evidence rule: (a) the named failure mode being probed, (b) the observable evidence that would defeat the preferred positive claim if found, and (c) direct inspection evidence naming the inspected surface plus observed line, section, content, tool result, or retained artifact finding. This 3-component record carries into Step 12 `FINDING-STATE-INVENTORY` as the per-defeater evidence surface and is consumed by downstream `Skill(self-verification)` Step 3 PASS-2 gates per receiver applicability; shorthand record (`tested`, `disproven`, `defeater enumerated`, `not material`) without these three components is verification-shaped prose and fails the Gate.
Block the requested positive review result while any material defeater is open or confirmed without cited lawful owner-deferral authority.
Return confirmed non-patch defeaters to Step 2 for basis correction. Return confirmed patch-design, removal, or mutation-readiness defeaters to Step 6 only when Steps 6-9 are in scope.

### 6. Design Removal-First Patch
Consume `.claude/reference/modification-minimal-governance-change-law.md` `## Patch-Ready Gate`.
Classify challenged text, section, or document as removal-default before mutation.
Retain only if removal would lose protected function, owner boundary, recovery path, or execution force.
Select tighten, replace, trim, merge, re-home, or delete before append if that preserves protected meaning.
Record `REMOVAL-FIRST-PATCH-DESIGN` with failing path, cause/remedy classification basis, consumed surface, source meaning, destination owner when moved, minimum-executable-information result, behavior-weakening result, functional-independence result, intended changed function set, positive-function inventory, no-negative-impact result, cross-function correlation basis, continuity result, adjacent-surface status, selected operation, rejected removals, and retention basis.

### 7. Pre-Patch Negative-Risk Gate
Apply `.claude/CLAUDE.md` `## 5. Modification Philosophy` keyword gate.
Test meaning loss, owner conflict, weaker procedure, weaker clarity, weaker execution force, weaker next action, broken reference, added burden, runtime side effect, user-surface regression, reuse failure, acceptance regression, positive-function regression, hidden cross-function coupling, and incidental behavior change.
Record functional restoration, intended changed function set, positive-function inventory, no-negative-impact result for each positive function, report-prohibition no-negative-impact when renderable or reporting behavior can change, cross-function correlation basis, and `philosophy-conformance: pass | hold:<basis> | fail:<basis>` in the patch-design evidence surface.
Revise, re-home, narrow, or blocker-route after internal correction routes are exhausted until every material risk is removed, disproven, or assigned.

### 8. Widen Coherence Radius
Inspect surrounding references, sibling skills, lane roles, phase gates, packet fields, runtime/hook/settings mirrors, and acceptance paths affected by the patch.
Update the design when wider review finds drift, overlap, missing owner handoff, stale meaning, or newly material negative risk.

### 9. Integrity Gate Before Live Patch
Verify structural contract, fixed order, source-to-destination meaning, protected local restatement, minimum executable information, direct simplification, positive execution path, direct-consumption relevance, reference integrity, no behavior-weakening wording, and functional independence.
For governance patches, verify the 5-axis patch independence matrix: defect closure, intent preservation, no new defect, cross-reference integrity, and functional independence.
When execution meaning changed, verify top-to-core coverage and core-to-trigger-bound guidance or valid `not-material:<basis>`.
After trim, re-home, merge, or pointer replacement, verify adjacent surfaces are removed, citation-only, or protected local restatements.
Enumerate every positive function in the coherence radius and verify no-negative-impact for each one; missing inventory, missing per-function no-negative-impact result, or missing material report-prohibition no-negative-impact blocks mutation readiness.
Return any failed item to Step 6.

### 10. Patch Sequence Boundary
Do not mutate files; return file mutation to the named patch sequence or production owner.
Return mutation-readiness evidence only after required Steps 1-9 and 12-14 are current for the requested target, corpus, patch design, and diff.
If Step 1-9 evidence is missing, reopen the smallest incomplete review step.

### 11. Post-Patch Coherence Re-engagement
Run Step 11 only when the executing owner re-engages review-verification after a changed result exposes material coherence, removal, patch-worthiness, negative-risk, owner-surface, or governance-judgment questions.
Re-read changed live surfaces, resulting diff, surrounding owner surfaces, and affected references.
Route newly found requested-scope defects to the smallest correction owner/path.
Return post-patch changed-result convergence to the executing patch sequence's Post-Verify `Skill(self-verification)` gate.

### 12. Classify Findings
Use the canonical finding-state ladder and rejection-basis labels from `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
Record each material finding in `FINDING-STATE-INVENTORY` with exact ladder state, cause/remedy classification reference, evidence surface, owner, and open next owner when applicable.
A `confirmed-defect` entry must cite expected behavior, observed deviation, causal link from candidate source, correction-restores-behavior basis, correction owner, and protected-function no-loss basis; otherwise classify as `open-candidate` or `rejected:<basis>`.
Each material finding or disposition whose state is `confirmed-defect`, `patch-worthy`, `patch-ready`, `rejected:<basis>`, `no-patch`, or `open-candidate` must cite a current item-level `CAUSE-REMEDY-CLASSIFICATION` entry when the claim can affect owner action, procedure, reporting, transport defect/remedy, malformed transport, runtime/tool behavior, hook/settings behavior, or governance mutation; missing, invalid-enum, theme-level-only, contradicted, or open classification returns to Step 4 or Step 5.
For material defeaters that produced or supported a positive verification claim, the `FINDING-STATE-INVENTORY` entry must carry the 3-component disproof-attempt evidence per `.claude/reference/review-and-verification-core-law.md` `## Evidence Law`: (a) named failure mode probed, (b) observable evidence that would defeat the preferred positive claim if found, and (c) direct inspection evidence naming the inspected surface plus observed line, section, content, tool result, or retained artifact finding.
Each high-risk judgment used as a decisive basis must cite its `JUDGMENT-RELIABILITY` entry; a missing, stale, contradicted, or open entry fails classification and returns to Step 4 or Step 5.
Downstream `Skill(self-verification)` Step 3 PASS-2 rejects packets where material-defeater entries lack these three components or carry shorthand-only evidence surface.

### 12b. Citation Substantiation Gate
For every outgoing external citation or anchor claim in the produced packet, populate `CITATION-EVIDENCE-INVENTORY` with one entry per citation.
Outgoing external citation or anchor means a cited surface outside the produced packet itself: file path, section name, line:column, `PACKET-ID`, retained carrier path, or content claim referencing another file or carrier.
Internal structural citation is exempt when it names the produced packet's own section header, own `PACKET-ID`, or own self-reference.
Class A is admissible when the current turn carries direct tool-call inspection against the cited surface and the cited line, section, `PACKET-ID`, or content appears in that tool output.
Class B is admissible only when the cited surface was loaded earlier in the same session by Class-A-equivalent tool-call evidence, staleness check passed under `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, and the entry explicitly cites the originating same-session evidence.
Not-A-not-B is inadmissible; execute fresh Class-A inspection before the citation enters the packet.
Each entry records cited target identifier, freshness class with verifying tool-call evidence, and observed content snippet or originating-output reference.
Entries missing target, freshness evidence, or observed content are inadmissible and fail Step 12b.
This gate checks citation substantiation only; Step 5 still owns failure-mode disproof and Step 12 still owns finding-state inventory.
Downstream `Skill(self-verification)` Step 3 PASS-2 rejects packets where outgoing external citations are absent from `CITATION-EVIDENCE-INVENTORY` or lack required entry components.

### 13. Decide Patch Worthiness
Record cause/remedy classification, protected function, positive-function inventory, no-negative-impact result, negative operating effect, user-outcome impact, regression risk, smallest owner, operation type, and tested rejection of `protected-restatement`, `design-tradeoff`, and `non-issue`.
Reject patch-worthiness when remedy owner, remedy class, hook eligibility, or stronger narrower alternative is missing, stale, contradicted, or mismatched to the cause/remedy classification.
Use the Step 6 operation or return to Step 6 when the operation changes.
Do not authorize mutation from incomplete patch-ready proof; keep the current ladder state.

### 14. Next-Owner Routing
Return `review_verification_packet` only after all required steps are current for the requested target, corpus, patch design, and diff.
Record `WORKFLOW-COVERAGE` as `full-steps-1-14`, `lens-bounded:<exact lenses and covered steps>`, or `gate-only:<exact gate and basis>`; omit none.
`full-steps-1-14` is valid when every step is either executed or explicitly recorded `not-applicable:<basis>` under this workflow, including non-patch reviews where Steps 6-9 are out of scope.
Record `CLAIM-CEILING` exactly from Step 2; missing or stale `CLAIM-CEILING` blocks Step 14 currentness.
The returned packet is the canonical citable artifact for the requested review question; downstream verification gates (e.g., `Skill(self-verification)` Step 3 `PASS-2`) cite this packet by `PACKET-ID`, by `REVIEW-TARGET` + verdict summary (`PROCEDURE-EXECUTION-RESULT` / `PATCH-WORTHINESS`), or by full-content reference.
Return the smallest truthful next owner/action: triggering owner, `researcher`, `reviewer`, `developer`, `tester`, `validator`, `Skill(governance-modification)`, `Skill(self-verification)`, or blocker-routing with exhausted internal correction basis.
Use `Skill(governance-modification)` for governance asset update or confirmed recurrence-barrier hardening.
Use `Skill(self-verification)` before consequential reporting, completion claims, synthesis-triggered `Skill(governance-modification)`, or synthesis-triggered redispatch.

## Handoff Or Next Work
Do not stop at packet existence.
After Step 14, hand the packet to the triggering owner, open the named next owner/action, or record blocker-routing with owner, blocker, exhausted internal correction basis, and next safe owner/action.
When Step 14 returns `Skill(self-verification)` or `Skill(governance-modification)`, resume that owner immediately with the packet as upstream decision basis.
