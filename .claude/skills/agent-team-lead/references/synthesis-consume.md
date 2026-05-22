---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "opinion-inventory; three-bucket-synthesis; self-verification-discrimination; count-closure; synthesis-result"
---
# team-lead: Synthesis Consume

## Purpose
Consume this reference when team-lead reconciles multiple lane, shard, review, proof, validation, or fallback-evidence results.
Own only synthesis: classify every handed opinion, combine supported common meaning, preserve unresolved items, and return the synthesized result with next owner/action.
Completion transport, report admission, finding promotion, verification, runtime reuse, and acceptance stay on their owning skills or references.

## Consume When
- Completion-grade lane results or bounded fallback evidence must be merged.
- Multiple opinions/results overlap, diverge, contradict, or feed one downstream decision.
- Final Acceptance Review (FAR) `FINAL-REJECT` correction evidence enters the next synthesis.

## Synthesis Procedure
1. Inventory every handed opinion once.
2. Mark missing, late, or insufficient inputs as unresolved input items; do not count them as handed opinions until received.
3. Group opinions with the same evidence-backed material feature into `common`; count member opinions, not group headings.
4. Keep opinions separate when owner/action, causal mechanism, evidence need, acceptance truth, or correction path differs materially.
5. For each remaining opinion, decide locally when evidence is sufficient.
6. Use `Skill(self-verification)` only when a remaining opinion needs discrimination between `common`, `rejected`, and `undeterminable`.
7. Put the opinion into `common` when verification proves the shared material feature.
8. Put the opinion into `rejected` when verification proves invalid, duplicate-without-new-feature, or immaterial status.
9. Put the opinion into `undeterminable` when verification cannot decide; attach next owner/action.
10. Close synthesis only when `rejected` opinions + `common` member opinions + `undeterminable` opinions = handed opinion inventory.

## Synthesis Result
- Return only `rejected`, `common`, and `undeterminable` as final reviewed opinion states.
- Keep unresolved input items separate from the handed-opinion count.
- Carry evidence anchors for common members, rejection bases, undeterminable next owner/action, unresolved inputs, result coverage, and material `UPSTREAM-DECISION-BASIS`.
- State only the evidence and corpus coverage the synthesis actually supports.
- Use frozen delivery contract, `SEMANTIC-INTENT-BASIS`, and `TARGET-INTENT-BASIS` only when meaning-dependent synthesis needs them.

## Resolve Next Owner And Action
- Uninventoried opinion opens inventory correction.
- Count mismatch opens classification correction before synthesis closure.
- Remaining undecided opinion opens local evidence check or `Skill(self-verification)`.
- Missing or late input stays an unresolved input item unless final/completion coverage is required by the active route.
- Synthesis strength beyond evidence opens narrowing, reclassification, redispatch, exclusion, or `HOLD`.
- Non-synthesis effects route to the owning skill, reference, lane, or `Skill(work-planning)`.
