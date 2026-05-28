---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Judgment Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 6. Judgment Core Law
## Reference Map
- `.claude/reference/design-delivery-evidence-acceptance-law.md`: load when acceptance surface, validation claim, final verdict, final-arbitration route, accepted claim, or user-ready claim is material.
- `.claude/skills/agent-validator/SKILL.md`: load through the `validator` owner when final arbitration, final acceptance, or `PASS/HOLD/FAIL` verdict execution is assigned.
- `.claude/skills/self-verification/SKILL.md`: load when a produced judgment surface is verified before report, redispatch, final-arbitration routing, or completion claim.
- `.claude/skills/review-verification/SKILL.md`: load when judgment depends on evidence quality, owner separation, acceptance risk, final-arbitration readiness, defect classification, or patch-worthiness.

## Acceptance Law
- Planning is distinct from implementation.
- Implementation is distinct from review, testing, and validation.
- Reporting is distinct from acceptance.
- Frozen independent specialist lanes required by the frozen route or acceptance basis must be used.
- Required frozen independent specialist lane unavailability routes to `HOLD`.
- Producer output routes through every independent review, proof, validation, or final-arbitration owner required by the frozen route or acceptance basis.
- Required independent lanes stay on the acceptance path.
- Acceptance stays on the user's decisive surface.
- Only `validator` issues final `PASS/HOLD/FAIL` and owns final acceptance.
- Final `PASS` stays within the frozen accepted surface.
- Sample, tier, wave, or priority evidence cannot create a fourth verdict label.
- Sample, tier, wave, or priority evidence narrows `PASS` only when the subset was frozen or deferred by cited upstream lawful owner-deferral basis; otherwise route `HOLD` with covered scope and open surfaces.
- Full-surface `PASS` requires every frozen scope, proof, and validation row to be covered, explicitly user-accepted as out-of-scope or deferred, or deferred by cited lawful owner-deferral authority; any unresolved or blocked row routes `HOLD`.
- Candidate, promotion, and patch-loop rows close only when covered, applied and verified, deferred by cited lawful owner-deferral authority, or rejected by current review basis; any unresolved or blocked row routes `HOLD` for claims depending on that row.
- Local closure report exception is owned by `.claude/reference/reporting-prohibition-law.md`.
- Final-arbitration triggers route to validator or `HOLD`.
- Test and validation packets freeze surface, expected outcome, and acceptance basis.

## Resolve Next Owner And Action
- Produced judgment surfaces open `Skill(self-verification)` before report, redispatch, final-arbitration routing, or completion claim.
- Evidence-quality, owner-separation, acceptance-risk, final-arbitration-readiness, defect-classification, or patch-worthiness judgment opens `Skill(review-verification)`.
- Final acceptance, final arbitration, or `PASS/HOLD/FAIL` verdict execution opens the `validator` owner and `Skill(agent-validator)`.
- Missing required independent review, proof, validation, or final-arbitration owner routes to that owner or `HOLD`.
- Uncovered acceptance, proof, validation, candidate, promotion, or patch-loop row routes `HOLD` for claims depending on that row.
