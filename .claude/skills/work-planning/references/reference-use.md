# Work-Planning Reference Use
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

This rule fires when the planning target involves any of:
1. data model design or modification
2. domain regulation or business rule encoding
3. operator workflow design
4. deliverable structure derived from external source such as Excel, PDF, spec sheet, or user-authorized prior analysis
5. terminology or categorization scheme
6. quantitative threshold or invariant

An active trigger makes reference handling hard-mandatory planning evidence.
Record the result in `REQUEST-FIT-BASIS`.
Carry cited identities or deviation basis through `REQUEST-BOUND-PACKET-FIELDS` when downstream work depends on it.
Inactive trigger records `REFERENCE-USE: not-applicable (no trigger condition active)` in the planning basis.

Prior analysis is user-authorized only when the current user request explicitly asks to reuse, merge, validate, report, compare against, or otherwise use that specific prior artifact.
A current-target or current-corpus work request does not authorize prior-analysis reference use by itself.
When prior analysis is not user-authorized, it is an excluded source under `boundary-gates.md`, including its taxonomy, shard structure, finding shape, workflow, route, methodology, and conclusions.

## Reference Discovery
`team-lead` first inventories available authoritative references for the active scope through `work-planning`.
The inventory includes project discovery notes, canonical plan/design artifacts, external source documents, source data, specifications, and project-named reference files when present.
Excluded prior outputs may be inventoried by existence only; do not consume their content, structure, or conclusions.

Record the inventory in the reference-use result as a list.
An empty inventory still records explicitly; explicit empty inventory is not an implicit skip.

## Citation Specificity
A reference present in inventory requires citation of specific path plus location identifier.
Location identifiers include section number, line number, page number, table identifier, or equivalent location consulted.

Format:
`<path>:<location-id>:<topic-summary>`

Bare "reference exists" or "consulted source material" without specific location citation is a citation-specificity defect.
That defect blocks any dispatch that depends on the reference-based basis.

## Deviation From Reference
A plan or spec that deviates from the reference (such as simpler categorization, omitted fields, or renamed terminology) records the deviation explicitly:

`DEVIATION-FROM-REFERENCE: <reference-citation> | <deviation-description> | <rationale>`

Silent deviation is a spec that contradicts reference without explicit acknowledgement.
Silent deviation is a silent-PASS class defect.

## Packet And Verification Gate
- `task-execution` does not require a standalone `REFERENCE-USE` packet field.
- `task-execution` rejects assignment-grade dispatch when the packet needs a reference-based basis and the material citation or deviation identity is absent from request-bound packet fields or cited artifact basis.
- Citation specificity must match trigger scope before dispatch that consumes the reference-based plan.
- `Skill(self-verification)` plan audit opens only when the plan's citation basis is disputed.
- Reviewer and validator lanes verify spec-vs-reference compliance when the cited reference or deviation basis is material to their assigned surface, claim, or acceptance basis.
- Missing material reference basis is packet or planning debt, not lane rediscovery by habit.

## Reference Precedence
External authoritative references are high-weight evidence.
They become binding when they are law, standard, safety, policy, contract, or frozen project source of truth.
Explicit user direction authorizes a safe and lawful deviation only with recorded rationale.
A material conflict unresolvable from doctrine, active plan, reference authority, or explicit safe user direction surfaces as the smallest truthful blocker.
Routine user escalation is not the default conflict-resolution path.

## Resolve Next Owner And Action
- Active reference trigger opens authoritative reference inventory.
- Completed inventory opens citation-specific planning basis.
- Safe deviation opens recorded `DEVIATION-FROM-REFERENCE` basis.
- Missing material citation opens planning correction before dispatch.
- Missing downstream reference basis opens packet correction before assignment.
- Unresolved material conflict opens the smallest truthful blocker.
- Completed reference-use basis returns to `REQUEST-FIT-BASIS` and `REQUEST-BOUND-PACKET-FIELDS`.
