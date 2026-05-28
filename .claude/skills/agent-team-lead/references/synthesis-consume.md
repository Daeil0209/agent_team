---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "admitted-case-inventory; category-mapping; duplicate-work-collapse; coordinate-correlation; work-coordinate-work-items; synthesis-result; validator-pass-synthesis"
---
# team-lead: Synthesis Consume

## Purpose
Consume this reference when team-lead reconciles multiple completion-grade lane, shard, review, proof, or validation results.
Own only synthesis: inventory every admitted completion-grade handed case, group same material meaning into categories, preserve independent cases, derive follow-on work-items from work coordinates, and return the synthesized result with next owner/action.
Completion transport, report admission, finding promotion, verification, runtime reuse, and acceptance stay on their owning skills or references.

## Terms
- `case` — one admitted material completion-grade `VERIFIED-DATA-FEEDBACK` row from a lane, shard, review, proof, or validation surface.
- `category` — groups cases with the same evidence-backed material feature without deleting any member case.
- `work-coordinate` — records a coordinate expression that deterministically resolves to an evidence-backed downstream target.
- `retained material content` — the normalized downstream-relevant meaning of a category member after preserving its source case identifier and evidence anchor.
- `work-item` — one de-duplicated downstream execution unit by resolved coordinate target.
- `correlation-analysis` work-item — covers one resolved coordinate target with multiple categories or retained material contents that must be handled together without merging their categories.

## Consume When
- Completion-grade lane results must be merged.
- Previously bounded fallback evidence must be converted into completion-grade retained feedback before synthesis.
- Multiple cases/results overlap, diverge, contradict, correlate, or feed one downstream decision.
- Final Acceptance Review (FAR) `FINAL-REJECT` correction evidence enters the next synthesis.

## Carrier-Citation Atomic-Check
PROTECTED-LOCAL-RESTATEMENT-BASIS: synthesis-input-reading atomic-check — carrier-citation rule colocated at the synthesis input consumption decision moment because synthesis decisions consume completion carriers as upstream-decision-basis at this exact step. Canonical carrier-citation rule lives at `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`; this surface applies it at synthesis read time.
Before treating any cited carrier as `VERIFIED-DATA-FEEDBACK`, `ADMITTED-CASE-INVENTORY`, or upstream-decision-basis for synthesis, run carrier-identification fresh verification as quiet synthesis-input work:
- (i) Read the cited carrier path in the current turn (or cite originating same-session Class-A turn-N tool-call evidence per `Skill(review-verification)` Step 12b Citation Substantiation Gate);
- (ii) verify the carrier's `PACKET-ID` (or equivalent identifier) matches the expected ID referenced in the dispatch / completion context;
- (iii) verify the carrier's verdict label, completion class, or cited content matches the synthesis-consumed claim.
Carrier-by-memory or filename-by-inference consumption without (i)+(ii)+(iii) is carrier-citation fabrication and fails the canonical rule. Synthesis based on unverified carrier identity is procedural failure regardless of downstream synthesis correctness. Carrier-presence, carrier-reading, completion-acceptance, and ingest visibility is owned by `.claude/reference/reporting-prohibition-law.md`; the synthesis owner continues through the actual read, verification, correction, monitoring, or synthesis action.

## Synthesis Procedure
1. Admit only completion-grade `VERIFIED-DATA-FEEDBACK` rows as synthesis input.
2. Inventory every admitted handed case once with its source surface, original identifier or label, evidence anchor, and `ADMITTED-CASE-TOTAL`.
3. Keep missing, late, or insufficient inputs as unresolved input items outside the admitted-case inventory; partial-acceptance, accepted/missing-lane, and wait-for-remaining-input visibility is owned by `.claude/reference/reporting-prohibition-law.md`, while monitoring, correction, or `HOLD` remains the procedure path.
4. Map every admitted case to exactly one `category` by same evidence-backed material feature; single-member categories are valid and `CATEGORY-MEMBER-TOTAL` must equal `ADMITTED-CASE-TOTAL`.
5. Keep cases in separate categories when owner/action, causal mechanism, evidence need, acceptance truth, or correction path differs materially.
6. For each category member, record every material resolved `work-coordinate` target; record `no-follow-on:<basis>` only when the category member has no material coordinate target.
7. Collapse duplicate follow-on work only when category, retained material content, and resolved coordinate target are all the same; preserve collapsed case identifiers as `covered-cases`.
8. When one resolved coordinate target carries multiple categories or retained material contents, emit one `correlation-analysis` work-item for that target and preserve all covered cases.
9. Treat unresolved category mapping, malformed/non-resolving coordinate, uncollapsed duplicate, or missing correlation item as mapping correction, not synthesis closure.
10. Close synthesis only after both completion gates pass.
   - Gate 1: `ADMITTED-CASE-TOTAL` equals `CATEGORY-MEMBER-TOTAL`.
   - Gate 2: every category member either records `no-follow-on:<basis>` or has every material resolved coordinate target mapped exactly once to one de-duplicated `work-item` or one `correlation-analysis` work-item.

## Synthesis Result
- Return category inventory as the case-classification surface; include work-item mapping when follow-on work is material.
- Keep unresolved input items separate from the admitted-case inventory.
- Carry source surfaces, case identifiers or labels, evidence anchors for category members, `ADMITTED-CASE-TOTAL`, `CATEGORY-MEMBER-TOTAL`, category mapping bases, coordinate resolution bases, work-item mapping, unresolved inputs, result coverage, and material `UPSTREAM-DECISION-BASIS`.
- When follow-on work is material, return `ADMITTED-CASE-INVENTORY`, `CATEGORY-MEMBER-MAP`, `WORK-ITEMS`, each `work-item`'s type, resolved coordinate target, coordinate expression aliases, covered categories, retained material contents, and covered case identifiers or labels.
- Do not emit two ordinary `WORK-ITEMS` for the same category, retained material content, and resolved coordinate target; preserve duplicated source cases only as covered cases.
- Emit `TYPE: correlation-analysis` when one resolved coordinate target contains multiple categories or retained material contents; the follow-on owner must resolve all covered categories or return a narrower owner/action basis.
- A single case or category may emit multiple `WORK-ITEMS` when retained material content is the same but resolved coordinate targets differ.
- State only the evidence and corpus coverage the synthesis actually supports.
- Use frozen delivery contract, `SEMANTIC-INTENT-BASIS`, and `TARGET-INTENT-BASIS` only when meaning-dependent synthesis needs them.

## Synthesis-Discipline For Validator PASS Verdicts
PROTECTED-LOCAL-RESTATEMENT-BASIS: synthesis-time validator-PASS atomic-check — Validator PASS discipline colocated for atomic team-lead consultation during synthesis of validator outputs. `.claude/reference/judgment-core-law.md` and `.claude/skills/dev-workflow/references/final-acceptance-review.md` define general validator handling; this surface applies it at synthesis-execution moment to prevent unverified gap framing.
- Challenge validator PASS evidence that frames an unverified operator-relevant gap as a testing artifact, harness limitation, or "would work in operator flow" claim; unsupported framing stays `INFERENCE/UNVERIFIED`.
- An uneliminated execution-context delta keeps the affected PASS basis at `INFERENCE/UNVERIFIED` until equivalent-context evidence or an explicit operator-environment limitation basis exists.
- Skipped material operator-environment E2E verification is a verification defect during synthesis, not PASS support.

## Resolve Next Owner And Action
- Uninventoried case opens inventory correction.
- Non-completion-grade input, including completion carriers that assert PASS-2 without the required packet/lens basis, opens completion correction before synthesis.
- Category count mismatch, uncategorized admitted case, or admitted case mapped to multiple categories opens category mapping correction before synthesis closure.
- Missing `work-coordinate`, incomplete/malformed/stale/non-resolving coordinate expression, uncollapsed duplicate `work-item`, missing `correlation-analysis` item for one coordinate target with multiple categories or retained material contents, same case mapped to multiple `work-item`s without distinct resolved coordinate targets, or uncovered material follow-on case opens work-item mapping correction before redispatch or mutation.
- Remaining unmapped synthesis case opens category mapping correction or work-item mapping correction.
- Missing or late input stays an unresolved input item unless final/completion coverage is required by the active route.
- Synthesis strength beyond evidence opens narrowing, category mapping correction, work-item mapping correction, redispatch, exclusion, or `HOLD`.
- Non-synthesis effects route to the owning skill, reference, lane, or `Skill(work-planning)`.
