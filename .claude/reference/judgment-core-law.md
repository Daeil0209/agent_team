---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Judgment Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# 6. Judgment Core Law
## Reference Map
When this core law is consumed, use this file as the representative law and load separated references only when their triggers are active.
- `.claude/reference/design-delivery-evidence-acceptance-law.md`: load when acceptance surface, validation claim, final verdict, final-arbitration route, accepted claim, or user-ready claim is material.

## Acceptance Law
- Planning is distinct from implementation.
- Implementation is distinct from review, testing, and validation.
- Reporting is distinct from acceptance.
- Frozen independent specialist lanes must be used.
- `HOLD` when a frozen independent specialist lane cannot be used.
- Producer output routes through every independent review, proof, validation, or final-arbitration owner required by the frozen route or acceptance basis.
- Required independent lanes cannot be skipped.
- Acceptance stays on the user's decisive surface.
- Only `validator` issues final `PASS/HOLD/FAIL` and owns final acceptance.
- Local closure report admission is owned by `.claude/reference/reporting-user-reporting-law.md`.
- Final-arbitration triggers route to validator or `HOLD`.
- Test and validation packets freeze surface, expected outcome, and acceptance basis.
Detailed acceptance rules live in `.claude/reference/design-delivery-evidence-acceptance-law.md`.
