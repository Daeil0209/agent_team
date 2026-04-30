# Work-Planning Reference Use
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

This rule fires when the planning target involves any of:
1. data model design or modification
2. domain regulation or business rule encoding
3. operator workflow design
4. deliverable structure derived from external source such as Excel, PDF, spec sheet, or prior analysis
5. terminology or categorization scheme
6. quantitative threshold or invariant

If the trigger fires, the rule is hard-mandatory. If it does not fire, record `REFERENCE-USE: not-applicable (no trigger condition active)`.

## Reference Discovery
Planner must first inventory available authoritative references for the active scope, including project discovery notes, canonical plan/design artifacts, external source documents, source data, specifications, and project-named reference files when present.

Record the inventory in `REFERENCE-USE` as a list, even when the result is no reference found in standard locations. Explicit empty inventory is not an implicit skip.

## Citation Specificity
When reference exists in inventory, `REFERENCE-USE` must cite specific path plus section number, line number, page number, table identifier, or equivalent location consulted.

Format:
`<path>:<location-id>:<topic-summary>`

Bare "reference exists" or "consulted source material" without specific location citation is a citation-specificity defect and blocks dispatch.

## Deviation From Reference
If the spec the planner writes deviates from the reference, such as simpler categorization, omitted fields, or renamed terminology, `REFERENCE-USE` must include:

`DEVIATION-FROM-REFERENCE: <reference-citation> | <deviation-description> | <rationale>`

Silent deviation, where the spec contradicts reference without explicit acknowledgement, is a silent-PASS class defect.

## Verification Gate
- `task-execution` must reject assignment-grade dispatch whose `REFERENCE-USE` field is empty when trigger conditions fire.
- `self-verification` SV-PLAN must verify citation specificity matches trigger scope before authorizing dispatch.
- reviewer and validator must verify spec-vs-reference compliance as part of acceptance check.

## Reference Precedence
When an external authoritative reference and user verbal clarification conflict, reference takes precedence unless the user explicitly directs deviation with rationale. Verbal clarification interpreted as implicit reference override is an interpretation defect. Planner must surface conflict to the user with both interpretations before resolving.
