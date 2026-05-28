---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "report-exception; evidence-basis; final-verified-result; open-work-truth"
---
# team-lead: Reporting Prohibition Rules

## Purpose
Consume this reference only after `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
Return report admission, exception reasons, non-reportable content, and report shape to `.claude/reference/reporting-prohibition-law.md`.
Record team-lead's compact evidence-basis decision for the admitted report.

## Consume When
- A reporting-law-admitted team-lead report needs compact evidence-basis control.
- The admitted report uses visual, rendered, runtime, or user-surface proof to support final verified result wording.
- The admitted report might include a surface deferred by cited lawful authority, an out-of-scope surface, user-action blocker truth, closeout residual truth, or artifact links.

## Required Output
Record:
- reporting-law exception reason
- current `Skill(self-verification)` convergence when required
- concise evidence basis
- included or omitted cited lawful deferral or out-of-scope basis
- link placement basis when material

## Routing Gate
- Missing reporting-law exception returns to `.claude/reference/reporting-prohibition-law.md`.
- Missing required `Skill(self-verification)` convergence opens `Skill(self-verification)`.
- Claim strength beyond evidence narrows to verified scope or routes `INFERENCE/UNVERIFIED` through `.claude/reference/reporting-prohibition-law.md`.
- Missing cited lawful deferral, out-of-scope, user-action blocker, residual, or artifact-link basis opens the owning synthesis, proof, acceptance, closeout, or filesystem-result path.

## Resolve Next Owner And Action
- Satisfied evidence-basis control returns to `.claude/reference/reporting-prohibition-law.md` for admitted prose.
- Reporting-law gaps stay suppressed and continue through the owning Procedure Plane or Communication Plane path.
- Verification gaps open `Skill(self-verification)`.
- Basis gaps open the smallest owner that can supply the missing evidence.

## Evidence Basis
- Include only the basis admitted by `.claude/reference/reporting-prohibition-law.md`.
- Final-result proof basis names retained evidence anchor, decisive surface, inspected scope/action, and material cited lawful deferral, out-of-scope, or defect state only when material to the admitted report.
- Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.

## Composition Atomic-Check

PROTECTED-LOCAL-RESTATEMENT-BASIS: composition-atomic-check colocated at team-lead reporting-discipline owner because cure activates at every team-lead admitted-prose composition moment. Canonical rules at `.claude/reference/reporting-prohibition-law.md` `## Report Shape` Multi-Element Inline-Render Constraint + `## Pre-Report Gate`; this surface applies them at team-lead-specific composition moments with atomic-check framing.

NAMING DISAMBIGUATION: this file `.claude/skills/agent-team-lead/references/reporting-prohibition-rules.md` is the OPERATIONAL team-lead reference for reporting discipline; it is DISTINCT from the PROTECTED `.claude/reference/reporting-prohibition-law.md` which carries the canonical rules. Modifications here go through normal Skill(governance-modification) cycle; modifications to the PROTECTED file require operator-policy-choice gate per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`.

### Multi-Element Inline-Render Atomic-Check
- Before composing any admitted-class report containing multi-element required content, atomically test the candidate inline shape against the applicable canonical cap in `.claude/reference/reporting-prohibition-law.md` `## Report Shape`.
- For `final verified result`, count every non-empty visible line including the `REPORT-REASON` marker and the final file-location line; maximum is 8 lines.
- For `final verified result`, keep the last non-empty visible line shaped as `파일: <retained-carrier-or-artifact-path>`.
- If the candidate report exceeds its applicable cap or would expose evidence/detail lists already retained in a carrier, suspend inline composition and route required detail to a retained carrier.
- Emit only the result/decision statement, material unresolved result or needed next action, operator decision options only when a proven user-owned decision remains, and the final file/carrier path when required by the canonical shape.
- Inline-dump of all required elements × N patches/items or all available retained evidence is anti-pattern per canonical `## Report Shape` Multi-Element Inline-Render Constraint.

### Final-Result Pre-Emission Builder
- Before emitting `REPORT-REASON: final verified result`, build the visible report from fixed slots only: report-reason marker, one result sentence, one optional material-unresolved-or-next-action sentence, and final `파일: <retained-carrier-or-artifact-path>` line.
- Keep all candidate inventories, finding inventories, defect counts, lane/shard/member counts, evidence counts, file:line lists, patch enumerations, verification packet summaries, carrier body summaries, runtime state, and standby-agent state in the retained carrier.
- Reject any visible draft that repeats a prior blocked report, appends a correction report to old prose, duplicates a result unit, includes a middle `Carrier:` citation, or exceeds the canonical 8-line maximum.
- Repair a rejected visible draft internally before emission; do not rely on post-emission controls, hook errors, or corrective re-emission to achieve report-shape compliance.
- When the user did not explicitly request detailed material in the current turn, default-concise remains active and the builder emits only the user-relevant result plus the final file location.

### Direct-Question Answer-Required Atomic-Check
When the active user turn is answer-only or status-only and the answer is already truthfully known from current evidence, emit the narrow answer with `REPORT-REASON: explicit status answer` before any non-trivial tool batch.
When a direct question also assigns audit, mutation, verification, dispatch, cleanup, or evidence-dependent judgment, do not classify it as `explicit status answer` by question shape alone; freeze and execute the required owner path first, then report only if `.claude/reference/reporting-prohibition-law.md` `## Pre-Report Gate` admits the result or a true status answer.
Tool-batch-only response to an answer-only/status-only direct question whose answer is already known is `explicit status answer` evasion.
Post-answer next-tool-call duty is owned by `.claude/skills/agent-team-lead/references/pre-action-gate.md` `## Action Invariants` Report separation invariant.
