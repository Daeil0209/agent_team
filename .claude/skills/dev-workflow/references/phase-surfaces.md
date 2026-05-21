# dev-workflow: Phase Surfaces
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

## Contents
- Phase 0 Discovery Basis
- Phase 1 Canonical Plan Surface
- Phase 2 Design Surface
- Phase 3 Implementation Surface
- Phase 4 Analysis And Acceptance
- Phase 5 Iteration Discipline
- Resolve Next Owner And Action

## Phase 0 Discovery Basis
- Discovery shape must be explicit: `single`, `lead-boundary-read-then-shards`, or `immediate-shards`
- `lead-boundary-read-then-shards` exists only to identify shard boundaries from consumed evidence; once shard boundaries are explicit, dispatch interpretive shards immediately
- Discovery output must separate: what the reference is, what the user wants from it, and what is adopted/adapted/rejected before planning begins
- Implementation dispatch and design freeze require their owning phase gates; discovery output remains pre-freeze evidence.

## Phase 1 Canonical Plan Surface
- Canonical output path: `docs/01-plan/features/{feature}.plan.md` unless project config states otherwise
- The canonical plan surface, not internal reasoning, closes Phase 1
- Minimum canonical contents:
  - verbatim `USER-INSTRUCTION`
  - executive summary
  - `TARGET-INTENT-BASIS` for the planned artifact, program, report, document, or governance purpose, with cited design intent, applicable core-law axes, material scope boundary, and any allowed `not-applicable` basis
  - Receiver-Surface Contract: WHY / PRIMARY-RECEIVER / RECEIVER-JOB / CONSUMPTION-ENVIRONMENT / RISK / SUCCESS / SCOPE / DELIVERY, including row-granular frozen `SCOPE-BASELINE` rows that map to proofable features, workflows, surfaces, controls, data, artifacts, or reader/operator expectations, plus the run/read/operate/decide/learn/present path; executable deliverables also freeze `PRIMARY-OPERATOR-OS`, `ENV-COVERAGE`, `USER-RUN-PATH`, and `BURDEN-CONTRACT`
  - Consumption Chain for material output flow from source or setup through final receiver use
  - Reference Fit Summary when a reference exists
  - Work-Tool Pattern Packet when a practical work-tool pattern materially shapes operator use, persistence, import/export, generated artifacts, or completion proof
  - Business Workflow Packet when spreadsheet meaning, operational state, mutation authority, allocation, participation, period, reconciliation, or workflow semantics shape the user's task
  - Material Specialist Contract Basis when a required or phase-owner-consumed specialist skill materially shapes request fit, acceptance, downstream design, proof, or implementation
  - Acceptance Evidence Basis, including the decisive user-environment proof basis and `ENV-COVERAGE` when the deliverable is executable or operator-facing
  - Verification Strategy Basis
  - explicit Open Questions
- team-lead owns Phase 1 planning design, frozen plan basis, and canonical plan document authoring.

## Phase 2 Design Surface
- Canonical output path: `docs/02-design/features/{feature}.design.md` unless project config states otherwise
- team-lead owns the decision-level design basis and canonical design document authoring: selected design direction, implementation-binding internal detail bundle, and the active Phase 2 surfaces below.
- Decision-level basis records are team-lead internal decision evidence, not separate completion artifacts.
- Every decision needed by implementation, proof, acceptance, artifact-convergence, or CP4 is surfaced in the canonical design artifact or a required implementation-binding internal detail bundle.
- The canonical design artifact carries the expanded team-lead-authored body so downstream review, proof, acceptance, and artifact-convergence can apply the minimum contents below and `artifact-convergence-review.md` axes without reconstructing hidden Phase 2 decisions.
- The implementation-binding internal detail bundle is the CP4 translation input when implementation dispatch depends on it.
- Design options count scales by project tier: Lightweight 1, Standard 2, Precision 3
- Minimum design contents authored by team-lead from frozen decisions:
  - inherited `USER-INSTRUCTION`
  - `TARGET-INTENT-BASIS` continuation with applicable core-law axes, material solution-structure basis, scope boundary, affected owner surfaces, and drift stop
  - selected option and rationale
  - component and responsibility map
  - interface, format, source-of-truth, and dependency surface
  - Boundary Register for cross-artifact, cross-surface, generated-output, template/render, and downstream handoff edges
  - Verification and correction-readiness plan derived from the plan's proof basis, including `SCOPE-BASELINE` coverage, exact-launch-artifact proof when executable, review/test proof surfaces, validator acceptance surface, and Phase 5 return-evidence pattern
  - Internal Detail Bundle index: lane/surface contract paths, owner, implementation-ready status, and deferred or blocked status
- Internal Detail Bundle is the Phase 2-owned implementation-binding design detail; it must be present as bounded sub-artifacts, linked as explicit sub-artifacts, or explicitly excluded from the active implementation scope before Phase 3:
  - real-use contract for every material user-facing surface:
    - `ENTRY-OPEN-PATH`: exact user action, artifact, prerequisite, environment, and first open/start path
    - `VISIBLE-SURFACE-INVENTORY`: user-visible windows/pages/files and producer-only surfaces that stay hidden or non-primary
    - `FIRST-USE-STATE`: initial visible state, empty/demo/imported state, and minimum useful information before user configuration
      - `CORE-WORKFLOW-CLOSURE`: enumerate every applicable executable user-facing software action and its mandatory paired completion.
      Required pair types:
      - create/import/upsert→disposition: every created, imported, or upserted item has an allowed disposition path: delete, clear, archive, void, deactivate, restrict, or frozen no-disposition basis.
      - edit→save+reload+consumer-persist: every edit control has a save whose result persists across reload and every in-scope visible consumer of the changed fact.
      - input/mutation→dependent-recompute/reactivity: every editable value or mutation feeding a sum, total, badge, warning, status, report, export, ledger, or dashboard triggers recompute on the user surface.
      - displayed-surface→inspection/action/navigation: every displayed record, metric, card, row, icon, or button names its inspection, action, arrival surface, or explicit display-only basis.
      - entity/aggregate→authority trace: every material relation, derived value, or displayed aggregate surfaces as an authority-fit source trace and related-entity path, unless a frozen not-applicable basis states why no user decision or action depends on that path.
      Each row names trigger surface, paired completion surface, source authority, disposition, consumer/recompute, inspection/action/navigation, or display-only basis as applicable.
        Phase 3 entry for an executable user-facing software action requires a `CORE-WORKFLOW-CLOSURE` row.
      The design must add the row or explicitly defer it via frozen-record citation.
    - `DATA-CONTENT-STATE`: sample, fixture, imported, saved, reloaded, reset, and real-data states that affect usefulness
    - `FAILURE-RECOVERY-SURFACE`: user-readable error message, technical log location, safe fallback, and next user action
    - `EXIT-CLEANUP-REENTRY`: stop/close action, process/lock/port/temp cleanup, and clean relaunch result
    - `VISUAL-RENDERED-QUALITY`: required route/page/document/viewport states, readability, no clipping, no overlap, and visible hierarchy
    - `EVIDENCE-RETURN-CONTRACT`: tester/validator actions, retained proof artifacts, PASS blockers, and Phase 5 return evidence
  - material specialist packets, oracles, and contract deltas selected by Phase 1, `LANE-REQUIRED-SKILLS-MAP`, `LEAD-LOCAL-REQUIRED-SKILLS`, or lawful phase-local refinement; each must be folded into implementation-binding detail, cited as a linked contract, or marked `deferred`/`blocked` with owner before Phase 3
  - business workflow packet: source-of-truth meaning, operator workflow meaning, mutation authority, period basis, allocation or participation semantics, reconciliation behavior, and proof oracle when spreadsheet or operations workflow meaning determines acceptance
  - ERD/data invariants/lifecycle when persistence or imported data matters
  - work-tool pattern packet: tool family, operator job, product-surface topology, persistence/import/export expectations, rejected pattern basis, and pattern proof oracle when practical work-tool structure determines acceptance
  - benchmark / information-representation packet:
    - Phase 2 owns the benchmark-required decision for detailed design.
    - Require `benchmark-simulation` before design freeze when external references can materially improve information representation, visual structure, workflow pattern, methodology choice, domain pattern, or design element selection.
    - Benchmark-required surfaces are scoped by the cue table in `.claude/skills/benchmark-simulation/references/self-initiated-discovery.md`; the named pattern classes (dashboards, gauges, charts, dense tables, multi-step forms, decks, reports, diagrams, document layouts, governance/procedure representations, monitoring surfaces) trigger by default. Other surfaces trigger only when a cue from that reference materially fires.
    - Benchmark capture uses external sites, public examples, authoritative docs, standards, reference UIs, images, and demos when those sources are the best available task input.
    - Concrete characteristics fed into the canonical design artifact via abstraction-fit-adapt include information elements, layout hierarchy, table/chart/card patterns, font size, spacing, ratio, hierarchy, color contrast, label patterns, navigation affordance, workflow states, anti-patterns, and standards constraints.
    - Visual or rendered acceptance also feeds the extracted characteristics into the `visual-composition` packet.
    - Trivial surfaces skip only with recorded basis.
    - Trivial surfaces include: single-control forms, isolated text-only output, internal-only diagnostic surfaces, and surfaces fully governed by a frozen prior benchmark.
  - verifiable interface, runtime data-shape, format, and error contracts when production surfaces interact; when drift would break user-visible behavior, name the shared source-of-truth, generated or audited type path, producer-consumer field/shape mapping, and runtime validation/proof oracle
  - screen/user-flow/first-viewport contracts when visible UX determines acceptance
  - import/export mapping and validation error model when data migration or file I/O matters
  - reader/report/deck/lesson flow, including source-data/example/application contract when read, decide, learn, present, or reuse surfaces determine acceptance
  - evidence-method oracle, source-family schema, claim-strength tiers, and update-trace contract when market, technology, patent, literature, standards, or research evidence determines output or automation
  - engineering oracle: governing equations, standard or specification citations, unit path, tolerance policy, valid range, and reference test vectors when engineering design or calculation determines acceptance
  - proof path, feature/surface/control closure map, and CP4 implementation decomposition when dispatch, review, test, or validation depends on them
- The bundle reduces Phase 2 burden by splitting detail by lane or surface while team-lead retains design ownership and CP4/Phase 3 consume it as implementation input.
- For executable, user-facing software deliverables, design must freeze every `SCOPE-BASELINE` feature/surface/control path plus the operator-delivery implementation contract: exact launch artifact, `PRIMARY-OPERATOR-OS`, `ENV-COVERAGE`, `USER-RUN-PATH`, `BURDEN-CONTRACT`, launch surface such as `WINDOWS-LAUNCH-SURFACE` when Windows is primary, operator invocation shape, setup/build path, hidden/visible process policy, failure visibility, shutdown/cleanup path, clean re-launch path, infrastructure exposure policy, and the inventory needed for tester first-pass proof, Phase 5 return evidence, and validator final acceptance.
- If that operator-delivery implementation contract is missing or vague for an in-scope executable surface, the internal detail bundle is not implementation-ready; Phase 3 dispatch for that surface is blocked until Phase 2 correction records the contract or an upstream deferral/exclusion.

## Phase 3 Implementation Surface
- Implementation starts after team-lead CP4 resolves from the Phase 2 implementation-binding internal detail bundle.
- CP4 scope summary must make lane decomposition explicit: parallel-default production surfaces, first parallel dispatch segment, later-segment parallel-fit basis, bounded specialist-fit work surfaces, dependency boundaries, Boundary Register rows, surface-to-agent map, merge ownership
- An independent, nonblocked work surface whose required input is already frozen in the Phase 2 implementation-binding internal detail bundle enters the first parallel dispatch segment; a later segment requires sequential or interdependent classification from the frozen parallel-fit basis
- Developer handoff must include `OUTPUT-SURFACE`, changed surfaces, executed checks, row-mapped `SCOPE-BASELINE` coverage/delta, `DESIGN-ROW-IMPL-MATRIX`, and `FROZEN-CONTRACT-STATUS`.
- `DESIGN-ROW-IMPL-MATRIX` maps every Phase 2 design-stated entity, route, template, and applicable `CORE-WORKFLOW-CLOSURE` row to an exact implementation path or `not-implemented:<frozen-defer-citation>`.
- Silent omission of any design row blocks Phase 3 → 4 transition.
- For executable user-facing surfaces, the handoff also names the implemented launch artifact, `PRIMARY-OPERATOR-OS`, `ENV-COVERAGE`, `USER-RUN-PATH`, `BURDEN-CONTRACT`, `WINDOWS-LAUNCH-SURFACE` when Windows is primary, setup/start behavior, shutdown/cleanup, clean re-launch status, and blocked or unrun operator-delivery checks.
- Parallel production advancement follows `Skill(dev-workflow)` Phase 3 merge-owner exit law.

## Phase 4 Analysis And Acceptance
- Reviewer and tester are both mandatory analysis owners for executable, user-facing software
- Reviewer packet must evaluate design conformance, producer-consumer contract fit, blocking defect classification, delivery experience, and user-readiness on the declared acceptance surface
- Tester packet must execute the planned proof surface and data state, not a narrowed substitute
- Review, proof, and validation close baseline scope only by reconciling delivered `ACTIVE-SLICE` against the frozen `SCOPE-BASELINE`; unimplemented, stubbed, placeholder, or unproven baseline surfaces remain open.
- Evidence-Quality Matrix rows connect each material expectation to the receiver surface, evidence artifact, inspection method, inspected defect classes, claim strength, and open surface.
- Acceptance packets are built from the frozen plan/design delivery contract first, including frozen `FIRST-USE-STATE` and `DATA-CONTENT-STATE` when they affect usefulness. Current implemented routes, files, screens, working demos, or empty states are evidence rows for `ACTIVE-SLICE`, not the authority for what counts as complete. A Phase 4/5 packet that starts from "what exists" instead of "what was promised" is invalid even when reviewer, tester, Codex, and validator later agree inside that narrowed frame.
- Practical work-tool deliverables require review and proof against the frozen work-tool pattern packet when that packet materially shaped plan or design; operator workflow, persistence, import/export, generated-artifact, and proof-oracle coverage stay decisive.
- Knowledge-analysis, report-automation, and engineering-calculation deliverables require review and proof against the frozen evidence-method or engineering oracle; claim-evidence, formula, unit, tolerance, and standards-conformance proof stay decisive when material.
- For web/UI deliverables:
  - tester proof path = repeatable browser-driver proof on the frozen browser interaction surface
  - tester proof capability examples include Playwright, Cypress, or a project-frozen equivalent
  - the selected tool freezes in the proof packet
  - blocked or fallback evidence is recorded when no repeatable browser-driver is feasible
  - validator final acceptance path = browser-proof confirmation on the same resolved interaction/control inventory
  - Playwright MCP is the default final browser/UI acceptance profile when available to the validator lane
  - unused available MCP blocks PASS/FAR until justified by unavailable evidence or a frozen narrower tool contract
  - Rendered Image Evidence Rule: rendered proof covers the route/page/screen-state/data-state x viewport matrix required by the acceptance surface; capture an image per acceptance-relevant feature/state, or full-page/full-design-area image for whole-surface claims. Each reviewer, tester, validator, or team-lead synthesis owner who cites an image for an AC verdict, FAR claim, or visual-conformance assertion opens that image directly via the multimodal `Read` tool and compares it with the design-stated expectation for the AC, named element, state, or behavior.
  - Rendered image inspection records glyph sanity, clipping, overlap, hidden controls, readable hierarchy, missing media, browser console/runtime-error status when material, and concrete visual deltas such as font size, spacing, ratio, alignment, color, or label clarity. Cite-path-only evidence, capture-without-open, or opened images not checked against the design-stated expectation are not rendered acceptance evidence.
  - expected populated states must prove non-empty user-meaningful DOM; expected empty states must trace why they are empty rather than treating emptiness as proof
  - operator-naive comprehension definition is owned by `.claude/skills/visual-composition/SKILL.md`; tester records per-element rendered comprehension evidence and validator final-arbitration repeats it independently.
  - when multiple environments are in scope, cross-environment conditional fields per `.claude/skills/task-execution/references/request-bound-fields.md` accompany handoff
- Reviewer + tester no-gap is necessary but not sufficient when validator-governed acceptance is required

## Phase 5 Iteration Discipline
- Phase 5 consumes the CP5 acceptance-grade correction contract with root-cause classification; raw review/test findings are evidence inputs, not dispatch scope
- Independent correction surfaces are split by correcting owner and run in parallel when lawful; integrated quick-check and re-verification follow the authoritative corrected output
- No self-certification inside iteration
- Convergence is the goal.
- Continue while each pass reduces real acceptance risk and has a changed artifact, changed evidence basis, or changed correction path.
- Repeating the same gap class without new artifact evidence, new proof evidence, or a new correction path forces explicit `HOLD`/replan or Incident Response.
- Iteration resets only after genuine re-analysis, not by habit.
- Cross-environment gaps stay in the same acceptance stream.
- Env-coverage substitution closes visual, launch, or interaction deltas only inside the frozen Phase 4 surface or explicit replan.

## Resolve Next Owner And Action
- Complete Phase 1 surface opens Phase 2 boundary through `work-planning`.
- Complete Phase 2 implementation-binding detail opens CP4 and Phase 3 boundary through `work-planning`.
- Missing Phase 2 implementation-binding detail opens Phase 2 correction.
- Complete Phase 3 implementation surface opens Phase 4 boundary through `work-planning`.
- Missing `DESIGN-ROW-IMPL-MATRIX` blocks Phase 3 -> 4 transition and opens developer or design correction.
- Complete Phase 4 acceptance evidence opens CP5 or Final Acceptance Review by acceptance path.
- Phase 5 cleared correction opens affected review, proof, validation, and operator-delivery rerun.
- Repeated same-class gap opens `HOLD`, `work-planning`, or incident response by root cause.
