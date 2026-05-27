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
Load when a caller supplies a bounded review question whose requested scope requires inspection of design intent, owner boundary, procedure adherence, skill consumption, coherence, integrity, negative risk, defect promotion, removal, patch-worthiness, patch-readiness, or final-arbitration readiness.
Run all applicable steps for binding promotion, final rejection, patch/no-patch, patch-worthiness synthesis, patch-readiness, verdict support, or mutation-readiness review.
Use named lenses only as bounded packet evidence; they do not expand beyond the assigned review question.
Reset for a new target, corpus, findings set, patch design, diff, bounded question, or scope.
Stale packets, summaries, memory, and pre-patch snapshots do not carry forward across resets.
A `review_verification_packet` exists only after current `Skill(review-verification)` activation reaches Step 14 for the exact target, corpus, bounded question, and scope.
Named-lens claims exist only for exact `REVIEW-VERIFICATION-LENSES` and returned lens-relevant fields.
Same-session loaded skill basis (per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`) reuse covers the Skill tool load only — it permits skipping a fresh `Skill(review-verification)` tool invocation when staleness conditions in that reference do not fire, but it does NOT carry packet output across targets.
Each new target, corpus, findings set, patch design, diff, bounded question, or scope requires fresh Steps 1-14 execution producing a fresh per-target `review_verification_packet`.
Citing a prior packet as PASS-2 basis for a different target — in a `Skill(self-verification)` record, validator verdict PASS-2 basis, or any downstream consumption — is carrier-prose-as-evidence fabrication per `Skill(self-verification)` Step 3 anti-fabrication rule.

PROTECTED-LOCAL-RESTATEMENT-BASIS: anti-narrowing operational atomic-check — Anti-Narrowing Law colocated at this skill's narrowing decision point because narrowing-intent routes through skill-specific `PROCEDURE-EXECUTION-RESULT: blocked:caller-confirm-required` packet field with bounded-review-question 4-tuple; canonical owner is `.claude/reference/review-and-verification-core-law.md` `## Anti-Narrowing Law`.
Anti-narrowing (per `.claude/reference/review-and-verification-core-law.md` `## Anti-Narrowing Law`): the bounded review question, target, requested corpus, evidence burden, and claim ceiling supplied by the caller establish the frozen review scope for this activation.
This skill MUST NOT silently narrow review scope below the caller-supplied basis (e.g., inspect narrower corpus subset, apply narrower lens than caller specified, lower claim ceiling, scope-out a finding-class without caller direction); narrowing-intent requires either explicit caller direction in the bounded review question, or `PROCEDURE-EXECUTION-RESULT: blocked:caller-confirm-required` packet field with 4-tuple (caller-supplied scope, proposed narrower scope, narrowing rationale, caller-confirm request) returned to caller before workflow proceeds under narrower scope.
Substantive correctness on a silently-narrowed scope does not cure the procedural-adherence defect per Anti-Narrowing Law.

## Reference Map
- Load `.claude/reference/review-and-verification-core-law.md` for evidence quality, verification truth, live intent, coherence, execution force, negative risk, finding-state, or patch-worthiness.
- Load `.claude/reference/judgment-core-law.md` for acceptance readiness, final arbitration, independent-lane separation, verdict support, or `PASS/HOLD/FAIL` risk.
- Load `.claude/reference/modification-core-law.md` for governance patch design, removal-first choice, simplification, compression, consumed owner surface, mutation readiness, or meaning preservation.
- Load `references/governance-review-gates.md` for detailed claim, artifact-change, synthesis, finding-promotion, or patch-worthiness review.

## Named Lane Lens Index
Accept only these `REVIEW-VERIFICATION-LENSES`: `design-intent-lens`, `owner-boundary-lens`, `procedure-adherence-lens`, `skill-consumption-lens`, `coherence-integrity-lens`, `governance-continuity-lens`, `minimum-executable-information-lens`, `negative-risk-lens`, `removal-first-lens`, `patch-worthiness-lens`.
For aliases, proxy mappings, inferred equivalence, shortened names, or omitted `-lens` suffixes, return `PROCEDURE-EXECUTION-RESULT: blocked:invalid-review-verification-lens` and `NEXT-OWNER-ACTION: packet-correction`.
Use named lenses to narrow target, corpus, required fields, and claim ceiling.
Mark out-of-lens fields `not-applicable:<claim-scope-basis>`.
Run all applicable steps for three or more lenses.
Reject bare `REQUIRED-SKILLS: [review-verification]` for a non-lead participant without named `REVIEW-VERIFICATION-LENSES`.

## Packet
Return internal `review_verification_packet` with:
- `PACKET-ID` — caller-supplied identifier when present, otherwise `REVIEW-TARGET` + activation context (turn or timestamp marker); used by downstream verification gates to cite this packet
- `WORKFLOW-COVERAGE` — exactly one of: `full-steps-1-14` (Steps 1-14 all executed for the cited target); `lens-bounded:<lens-set>` (named-lens execution per `## Named Lane Lens Index`; Steps 1, 2, 3, 4, 5, 12, 14 executed but Steps 6-9 may be `not-applicable:<basis>` when the bounded question is not patch-design-related); or `gate-only:<gate-name>` (single gate such as Step 5 Critical Review Gate only).
- `WORKFLOW-COVERAGE` consumption rule: receivers consuming the packet must cite the `WORKFLOW-COVERAGE` value when claiming downstream basis; treating a `lens-bounded` or `gate-only` packet as `full-steps-1-14` basis is carrier-prose-as-evidence fabrication.
- `REVIEW-TARGET`
- `PROCEDURE-EXECUTION-RESULT`
- `COHERENCE-RESULT`
- `INTEGRITY-RESULT`
- `NEGATIVE-RISK-RESULT`
- `FINDING-STATE-INVENTORY`
- `CITATION-EVIDENCE-INVENTORY` — per `### 12b. Citation Substantiation Gate`; populated when the produced packet carries any outgoing external citation/anchor claim. `not-applicable:no-outgoing-external-citation` when scope contains none.
- `REMOVAL-FIRST-PATCH-DESIGN`
- `PATCH-WORTHINESS`
- `OPEN-SURFACES`
- `NEXT-OWNER-ACTION`

## Review Workflow
Run steps in numeric order against the current cumulative live state.
Keep evidence local to each step; put only result fields in the packet.
If target, corpus, findings, patch design, diff, or claim strength changes, reopen the earliest invalidated step.
Run Steps 6-9 only for patch design, removal, or mutation readiness; otherwise record `not-applicable:<basis>`.

### 1. Relearn Doctrine And Owner Intent
Read the governing review/verification philosophy and the requested target surfaces.
For governance hierarchy questions, inspect only the top doctrine, mapped core law, trigger-bound owner reference, and lower surface needed by the requested judgment.
Consume the basis that controls the requested review claim.
Name only material design intent, protected meaning, owner boundary, valid procedure path, stop condition, and acceptance surface.
If requested-claim basis is missing, stale, contradicted, or unconsumed, open the smallest correction owner or `HOLD`.

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
Combine local or requested-shard findings into one evidence map.
Classify by owner semantics and operating effect.
Apply `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
Keep raw candidate, candidate-classified, confirmed-defect, patch-worthy, patch-ready, rejected, no-patch, and open-candidate states separate.
Reject bare `CONFIRMED`; use exact ladder state.

### 5. Critical Review Gate
PROTECTED-LOCAL-RESTATEMENT-BASIS: critical-review-gate atomic-defeater-test — defeater enumeration colocated here for atomic test at every Critical Review Gate execution. `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law` defines under/over-specification, evasion-enabling, ambiguous, conflicting, bottleneck-forming, and over-broad-blocking as execution-force defects; this surface enumerates them together with additional review-verification-specific defeaters (protected-function loss, source-to-destination gap, runtime/tool/user-surface failure, stronger narrower alternative, etc.) for one-shot defeater-first sweep at Step 5 execution.
Try to disprove the preferred conclusion before any packet, synthesis, bestness, no-defect, no-regression, patch-worthiness, route, completion, or closure claim leaves review-verification.
Test material defeaters: owner-boundary conflict, protected-function loss, weaker procedure, weaker clarity, weaker execution force, missing or burden-only skill consumption, upper-to-core gap, core-to-trigger-bound gap, under-specification, over-specification, evasion, ambiguity, conflict, bottleneck, over-broad blocking, source-to-destination gap, missing direct-consumption relevance, runtime/tool/user-surface failure, and stronger narrower alternative.
For source-to-destination gap review, trace every material hop in the claim chain, including source surface, producer output, synthesis, and outgoing claim when those surfaces are present.
Keep any untraced material hop as an open defeater.
Record evidence surface, confirmed/disproven/open result, correction owner, and next action for each material defeater per `.claude/reference/review-and-verification-core-law.md` `## Evidence Law` 3-component disproof-attempt evidence rule:
  - (a) the named failure mode being probed
  - (b) the observable evidence that would defeat the preferred positive claim if found
  - (c) the actual search record naming surface searched and finding
This 3-component record carries into Step 12 `FINDING-STATE-INVENTORY` as the per-defeater evidence surface.
The 3-component record is consumed by downstream `Skill(self-verification)` Step 3 PASS-2 gates per the receiver-applicability rule at `.claude/skills/self-verification/SKILL.md` `## Step 3` Receiver applicability paragraph.
Shorthand record (`tested`, `disproven`, `defeater enumerated`, `not material`) without these three components is verification-shaped prose and fails the Gate.
Test these additional generalized defeaters when applicable:
- **Same-category coverage defeater**: when the review target patches a surface belonging to a category with same-category siblings (open-set examples: completion-spine field set, marker pattern set, consumer skill set, lane agent set, hook surface set), enumerate every sibling and verdict its applicability against the patch principle; patching one surface while ignoring siblings is a coverage-survey defect recorded as `confirmed-defect` with the uncovered-sibling inventory.
- **Cumulative-input integrity defeater**: when the review target is a produced work-product spanning multiple input cycles (operator directives + critic opinions + prior verification cycles), trace every prior material input and verify it is reflected in the current produced work-product; silently dropped prior input is a `confirmed-defect` with the dropped-input citation.
Block the requested positive review result while any material defeater is open or confirmed without lawful owner deferral.
Return confirmed defeaters to Step 2 or Step 6.

### 6. Design Removal-First Patch
Consume `.claude/reference/modification-minimal-governance-change-law.md` `## Patch-Ready Gate`.
Classify challenged text, section, or document as removal-default before mutation.
Retain only if removal would lose protected function, owner boundary, recovery path, or execution force.
Select tighten, replace, trim, merge, re-home, or delete before append if that preserves protected meaning.
Record `REMOVAL-FIRST-PATCH-DESIGN` with failing path, consumed surface, source meaning, destination owner when moved, minimum-executable-information result, behavior-weakening result, continuity result, adjacent-surface status, selected operation, rejected removals, and retention basis.
If multiple defensible removal-first patch operations (tighten / replace / trim / merge / re-home / delete) exist for the same failing path per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (choice-situation + INVARIANT + ANTI-PASSIVE-WAIT + BACKGROUND-DECISION-SUPPORT clauses), apply that canonical rule before `REMOVAL-FIRST-PATCH-DESIGN` row authoring.

### 7. Pre-Patch Negative-Risk Gate
Apply `.claude/CLAUDE.md` `## 5. Modification Philosophy` keyword gate.
Test meaning loss, owner conflict, weaker procedure, weaker clarity, weaker execution force, weaker next action, broken reference, added burden, runtime side effect, user-surface regression, reuse failure, and acceptance regression.
Revise, re-home, narrow, or `HOLD` until every material risk is removed, disproven, or assigned.

### 8. Widen Coherence Radius
Inspect surrounding references, sibling skills, lane roles, phase gates, packet fields, runtime/hook/settings mirrors, and acceptance paths affected by the patch.
Update the design when wider review finds drift, overlap, missing owner handoff, stale meaning, or newly material negative risk.

### 9. Integrity Gate Before Live Patch
Verify structural contract, fixed order, source-to-destination meaning, protected local restatement, minimum executable information, direct simplification, positive execution path, direct-consumption relevance, reference integrity, and no behavior-weakening wording.
When execution meaning changed, verify top-to-core coverage and core-to-trigger-bound guidance or valid `not-material:<basis>`.
After trim, re-home, merge, or pointer replacement, verify adjacent surfaces are removed, citation-only, or protected local restatements.
Enumerate positively-working functions in the coherence radius and verify no regression.
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
PROTECTED-LOCAL-RESTATEMENT-BASIS: inventory-construction atomic-check — Evidence Law 3-component disproof-attempt rule colocated for atomic test at FINDING-STATE-INVENTORY construction moment (distinct from Step 5 Critical Review Gate atomic moment; Step 12 applies the rule at inventory record-building time). `.claude/reference/review-and-verification-core-law.md` `## Evidence Law` defines the general rule; this surface applies it as the Step 12 atomic check.
Use the common finding-class taxonomy from `.claude/skills/task-execution/references/completion-handoff.md`.
Record each material finding in `FINDING-STATE-INVENTORY` with exact ladder state, evidence surface, owner, and open next owner when applicable.
For material defeaters that produced or supported a positive verification claim, the `FINDING-STATE-INVENTORY` entry must carry the 3-component disproof-attempt evidence per `.claude/reference/review-and-verification-core-law.md` `## Evidence Law`: (a) named failure mode probed, (b) observable evidence that would defeat the preferred positive claim if found, and (c) actual search record naming surface searched and finding.
Downstream `Skill(self-verification)` Step 3 PASS-2 rejects packets where material-defeater entries lack these three components or carry shorthand-only evidence surface.

### 12b. Citation Substantiation Gate
PROTECTED-LOCAL-RESTATEMENT-BASIS: citation-substantiation atomic-check — distinct from Step 5 Critical Review Gate (defeater-enumeration disproof-attempt) and Step 12 Classify Findings (defect 3-component inventory). Step 12b applies at every outgoing external citation/anchor authoring moment as anti-citation-fabrication enforcement. Canonical carrier-citation rule lives at `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`; this surface applies it at packet-population time with the 2-class deterministic test inline.
For every outgoing external citation/anchor claim in the produced packet, populate `CITATION-EVIDENCE-INVENTORY` with one 3-tuple entry per citation. "Outgoing external citation/anchor" = cited surface is a different file or different carrier than the produced packet itself (cited file path, section name, line:column, PACKET-ID, retained carrier path, or content claim referencing another file). "Internal/structural" citation (exempt) = produced packet's own section header / self-PACKET-ID / produced file's own line:column self-reference.
Apply the 2-class deterministic test:
- **Class A (admissible)**: current turn carries a Read/Grep/Bash tool-call against the cited surface AND the cited line/section/PACKET-ID is contained in that tool-call output. Citation immediately admissible.
- **Class B (deferred Class A, admissible only with explicit citation)**: cited surface was loaded earlier in the same session via a Class-A-qualifying tool-call at turn-N AND (i) staleness check passed per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, (ii) the entry explicitly cites the originating turn-N tool-call evidence (Read/Grep/Bash invocation identifier or retained carrier PACKET-ID + retained path). Class B claims without explicit originating-turn citation are inadmissible.
- **Not-A-not-B**: citation is inadmissible; the writer MUST execute a fresh Class-A tool-call in the current turn before the citation enters the packet. Carrier prose marking "Class A required" without executing the tool-call is fabrication, not admissibility.
Each `CITATION-EVIDENCE-INVENTORY` entry records: (a) cited target identifier (file path + section/line/PACKET-ID); (b) freshness class (A or B) + verifying tool-call type and parameters + (Class B only) originating turn-N tool-call evidence citation; (c) observed verbatim content snippet from the tool-call output (Class A) or originating-turn output reference (Class B). Entries missing any of (a)(b)(c) are inadmissible; treat as citation fabrication and fail Step 12b.
This Gate is distinct from Step 5 (failure-mode disproof) and Step 12 (defect inventory) in purpose — Step 12b probes citation-correctness substantiation, not defeater disproof.
Bootstrap exemption: this Gate enforces from the patch installing it forward; review-verification packets produced prior to installation are not retroactively reclassified. Bootstrap pattern parallels `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` bootstrap exemption clauses.
Downstream `Skill(self-verification)` Step 3 PASS-2 rejects packets where outgoing-external-citation entries are missing from `CITATION-EVIDENCE-INVENTORY` or lack any required 3-tuple component.

### 13. Decide Patch Worthiness
Record protected function, negative operating effect, user-outcome impact, regression risk, smallest owner, operation type, and tested rejection of `protected-restatement`, `design-tradeoff`, and `non-issue`.
Use the Step 6 operation or return to Step 6 when the operation changes.
Do not authorize mutation from incomplete patch-ready proof; keep the current ladder state.

### 14. Next-Owner Routing
Return `review_verification_packet` only after all required steps are current for the requested target, corpus, patch design, and diff.
The returned packet is the canonical citable artifact for the requested review question; downstream verification gates (e.g., `Skill(self-verification)` Step 3 `PASS-2`) cite this packet by `PACKET-ID`, by `REVIEW-TARGET` + verdict summary (`PROCEDURE-EXECUTION-RESULT` / `PATCH-WORTHINESS`), or by full-content reference.
Return the smallest truthful next owner/action: triggering owner, `researcher`, `reviewer`, `developer`, `tester`, `validator`, `Skill(governance-modification)`, `Skill(self-verification)`, or `HOLD`.
Use `Skill(governance-modification)` for governance asset update or confirmed recurrence-barrier hardening.
Use `Skill(self-verification)` before consequential reporting, completion claims, synthesis-triggered `Skill(governance-modification)`, or synthesis-triggered redispatch.

## Handoff Or Next Work
Do not stop at packet existence.
After Step 14, hand the packet to the triggering owner, open the named next owner/action, or record `HOLD` with owner, blocker, and next safe evidence step.
When Step 14 returns `Skill(self-verification)` or `Skill(governance-modification)`, resume that owner immediately with the packet as upstream decision basis.
