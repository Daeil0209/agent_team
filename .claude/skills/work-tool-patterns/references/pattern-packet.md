---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/work-tool-patterns/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false
---
# work-tool-patterns: Pattern Packet

Use this file when a practical work-tool request needs a reusable product-pattern packet before implementation, review, proof, or validation.

## Packet Fields
`work_tool_pattern_packet` stays as small as possible while preserving downstream execution truth.

Required when material:
- `TOOL-FAMILY`: dashboard-management, research-analysis, patent-analysis, report-automation, engineering-calculation-design, spreadsheet-migration, or custom-with-basis.
- `OPERATOR-JOB`: the concrete job the user/operator must complete.
- `DECISIVE-USER-SURFACE`: where the user runs, reads, operates, decides, presents, or receives the artifact.
- `CORE-ENTITIES`: product-level entities and relationship shape; detailed rules stay with `business-workflow` or `software-architecture`.
- `PRIMARY-SURFACES`: pages, tabs, panels, flows, or generated artifacts that make the tool usable.
- `STATE-AND-PERSISTENCE`: what must be saved, restored, recalculated, re-run, or audited.
- `INGEST-AND-EXPORT`: import, bulk entry, export, report, file, or handoff artifact expectations.
- `DEFAULTS-AND-SETTINGS`: which values stay top-surface and which are demoted to settings or editable rule tables.
- `FAILURE-AND-RECOVERY`: empty, invalid, partial, failed import, stale source, rerun, and recovery expectations.
- `PROOF-ORACLE`: observable user-surface outcomes that prove the pattern is operational.
- `BENCHMARK-BASIS`: `adopted`, `trial`, `benchmark-light`, `benchmark-full`, or `inference`.
- `REJECTED-PATTERNS`: tempting patterns rejected with destination-fit reason.
- `OPEN-SURFACES`: unresolved surfaces and next owner/action.

## Benchmark Basis
- `adopted`: verified stable across two or more destination cycles.
- `trial`: synthesized and applied once with feedback captured.
- `benchmark-light`: comparison used for pattern choice but not durable promotion.
- `benchmark-full`: routing, durable pattern adoption, or capability-growth claim depends on the benchmark.
- `inference`: local reasoning with insufficient benchmark basis; keep confidence narrow and keep durable promotion unavailable.

When external references materially shape the packet, consume `benchmark-simulation` output.
Use abstraction-fit-adapt synthesis only.
Convert external product observations into destination-fit packet decisions.

## Proof Oracle Shape
The proof oracle names observable outcomes, not implementation intentions.

Examples:
- operator can launch the tool, see the resume console, add or import records, save, close, relaunch, and recover the same state
- dashboard totals update from authoritative records and expose stale or invalid inputs
- report generation preserves evidence-linked claims and produces the requested export
- engineering calculation rejects invalid units or ranges and matches frozen reference vectors
- spreadsheet migration imports representative sheets, reports validation failures, reconciles totals, and exports the required handoff artifact

Source inspection can support diagnosis.
Runnable or rendered proof proves an operator-facing work tool when that proof is feasible.

## Handoff Rules
- Carry the packet into `dev-workflow` Phase 1/2 when it materially shapes plan or design.
- Carry the `PROOF-ORACLE` into reviewer, tester, and validator packets when pattern behavior affects acceptance.
- If an adjacent owner owns a field more precisely, cite that owner packet instead of restating detail.
- Missing adjacent-owner basis is `OPEN-SURFACES`, `scope-pressure`, or `hold|blocker`.
- Leave missing adjacent-owner basis unresolved until the owning surface supplies evidence.

## Resolve Next Owner And Action
- Return selected pattern packet, adjacent-owner basis, proof oracle, and open surfaces to the active work-tool-patterns workflow.
- If the proof oracle affects design, implementation, reviewer, tester, or validator scope, carry it into the next owning packet before work continues.
