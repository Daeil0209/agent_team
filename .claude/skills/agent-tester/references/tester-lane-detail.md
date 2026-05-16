---
name: tester-reference
PRIMARY-OWNER: tester
SOURCE-ANCHOR: .claude/skills/agent-tester/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---
# Tester Reference
## Contents
- Auto-inject
- Role-Spine Completion
- Control Packet Discipline
- Tester Packet Detail
- UI Intent Proof Matrix
- Defect Detection Amplifiers
- Tool-Tier Detail
- Interaction Coverage
- Human-Facing Checklist
- Specialist Skill Loading
- Tester Completion Detail
- Resolve Next Owner And Action

## Auto-inject
false - load explicitly when packet detail, UI intent proof detail, interaction coverage, human-facing checklist detail, or completion detail is needed.

## Role-Spine Completion
`agents/tester.md` owns only the always-loaded tester charter, boundary, receipt trigger, stop rule, and proof-local completion duty. This reference owns detailed tester packet fields, UI intent proof matrix, tool-tier detail, interaction coverage, human-facing checklist, specialist skill rule, and completion detail.

When a tester role or skill says "tester additions" or "tester detail", consume this file directly. Do not re-expand `agents/tester.md` into a packet-field catalog. Missing decisive proof detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless proof target, expectation, surface, environment basis, scenario scope, and decisive evidence basis are anchored in packet or artifact evidence.

Phase packets, message classes, cleanup truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the tester-specific payload and proof discipline needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only.
- It does not replace an assignment-grade tester packet when new bounded proof work is assigned.
- Phase context and assignment-grade work arriving in the same execution segment: consume the embedded phase context inside the assignment packet, and send only the normal `dispatch-ack`.
- Shutdown intent follows the structured `shutdown_request` protocol.

## Tester Packet Detail
- Consequential tester packets must carry these fields explicitly:
  - `PROOF-TARGET`
  - `PROOF-EXPECTATION`, naming the closure row, Evidence-Quality Matrix row, receiver-surface expectation, or explicit not-applicable basis the proof must decide
  - `PROOF-SURFACE`
- Keep these runtime-context additions explicit for executable proof; use `not-applicable (<reason>)` only for genuinely static-render single-surface proof:
  - `ENV-BASIS`
  - `SCENARIO-SCOPE`
- Keep one truthful tool path explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
- Keep these delivery-contract additions explicit when applicable:
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `FIRST-USE-STATE` and sufficient `DATA-CONTENT-STATE` when visible behavior depends on operator data
  - `PRIMARY-OPERATOR-OS`, `WINDOWS-LAUNCH-SURFACE`, and `ENV-COVERAGE` for Windows primary operator proof
  - `WINDOWS-EQUIVALENCE-BASIS` only when proof runs outside Windows but claims Windows sufficiency
- Tester proves the Windows launch surface through the frozen Windows path or a proven-equivalent interop path.
- WSL/Linux execution is support evidence; it leaves Windows launch, termination, and clean re-launch as blocked proof unless `WINDOWS-EQUIVALENCE-BASIS` proves the exact operator action.

## UI Intent Proof Matrix
For UI/browser proof, build the proof around the designed behavior, not around page availability.

Required matrix columns:
- `DESIGN-INTENT`: the feature behavior or contract being proven
- `ENTRY-PATH`: how the intended user reaches the feature
- `USER-ACTION`: the visible control or interaction to execute
- `EXPECTED-VISIBLE-RESULT`: the observable UI state that must appear
- `STATE-CHECK`: persistence, route, storage, server state, validation message, disabled/enabled state, or no-state-change expectation
- `NEGATIVE-OR-BOUNDARY-PROBE`: one bounded failure, invalid, empty, duplicate, limit, or retry path when material
- `HARD-TEST-PROBE`: risk-proportional extreme/adversarial probe; use `not-applicable (<basis>)` only for static/source-read, frozen smoke-only, or explicitly narrowed proof
- `CLOSURE-DEFECT-PROBE`: row-matched probe family: disposition/access-inspection-navigation/consumer-recompute/authority-trace/reload-stale/empty-error-null/runtime-error
- `POSTCONDITION-EVIDENCE`: retained screenshot, trace, log, storage, state, or exported artifact after the user action
- `PLAYWRIGHT-PROOF`: CLI command, locator/action/assertion surface, and artifact path when available
- `RESULT`: directly proven, disproven, blocked, or out-of-scope by dispatch

Missing-information rule:
- If `DESIGN-INTENT`, `ENTRY-PATH`, `USER-ACTION`, `EXPECTED-VISIBLE-RESULT`, `STATE-CHECK`, material `HARD-TEST-PROBE`, `CLOSURE-DEFECT-PROBE`, `POSTCONDITION-EVIDENCE`, `PLAYWRIGHT-PROOF`, or closure/oracle basis cannot be named from the packet, frozen design, upstream oracle, or safe inference that does not invent scope or closure, stop and send `MESSAGE-CLASS: hold|blocker` to `team-lead` via `SendMessage`.
- The blocker must name the exact missing field, why proof would become guesswork without it, and the smallest corrected packet that would unblock testing.
- If the blocker concerns missing tool or execution capability, also include the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.

Rules:
- A page load, screenshot, DOM existence check, API response, or source inspection does not prove a designed UI feature by itself.
- Happy-path-only proof can prove only the happy path; it cannot support workflow-completion, reliability, or user-ready claims unless the frozen assignment explicitly limited acceptance to that narrow proof.
- Static rendered evidence proves only the pre-action visual state.
- Edit-save-reload, create/import/upsert-disposition, mutation-dependent recompute, displayed-surface inspection/action/navigation, entity or aggregate authority trace, import/export, and workflow-state rows require the user action plus postcondition assertion on the user surface.
- Those rows are not directly proven until the probe attacks the failure mode that would make the displayed behavior useless: missing disposition, unreachable displayed data, stale consumer, orphaned source, reload loss, empty/null/crashed surface, or console/runtime/network error.
- Create/import/upsert-disposition proof includes before/after state, displayed consumer visibility, disposition action, and reload or refresh proof when persistence is material.
- Mutation-dependent recompute proof executes the mutation and checks every assigned visible consumer such as dashboard cards, totals, statuses, warnings, reports, exports, or ledger views.
- Displayed-surface inspection/action/navigation proof activates the displayed record, metric, card, row, or control, or cites the frozen display-only basis as the expected no-action postcondition.
- Entity or aggregate authority-trace proof identifies the source-of-truth record or input and checks the displayed value or relationship against that authority.
- Browser/UI proof inspects the console/runtime/network error surface after navigation and material mutations; uncaptured or uninspected errors leave the affected row open.
- Hard-test proof selects bounded extreme or adversarial probes from the assigned risk.
- Probe families include: empty/null data, malformed or duplicate input, very large or limit-sized input, special characters or locale/time values, rapid double-submit, repeated add/delete, edit-then-delete, refresh/back during mutation, stale tab/session, interrupted network/server/storage, conflicting updates, malformed import, and corrupted persisted state.
- A successful API response does not prove UI consumption; UI proof must exercise the consumer path, expected populated or empty data state, visible postcondition, and browser console/runtime-error surface.
- Practical work-tool or business-workflow proof must consume the frozen pattern or workflow oracle; without that oracle, report `blocked` or `out-of-scope by dispatch`, not `matches-expectation`.
- Source inspection can prove a source-read artifact when the frozen proof target is the document text itself.
- Prefer user-facing locators such as role, label, text, placeholder, and test id when test ids are part of the app contract.
- Prefer web-first assertions that wait for the expected visible state. Avoid fixed sleeps as proof.
- Use `npx playwright test` for repeatable proof. Add `--headed`, `--project`, `--grep`, or trace options only when they materially improve the assigned proof or debug surface.
- If the UI intent cannot be exercised through Playwright CLI or the frozen equivalent path, classify the proof as blocked instead of substituting weaker evidence.

## Defect Detection Amplifiers
Use only amplifiers that materially strengthen the intent proof matrix. The goal is higher fault discovery per check, not larger reports.
- Data and rule surfaces: use equivalence partitions, boundary values, decision tables, and invalid/empty/duplicate/extreme data probes.
- Hard-test surfaces: prefer probes that are plausible but hostile to brittle code, including malformed data, huge/small limits, rapid repeated actions, interrupted flows, stale views, conflicting state, corrupted imports, and weird-but-valid user input.
- Stateful or workflow surfaces: use state-transition probes, repeat/undo/retry/order-change paths, interruption paths, and post-action state checks.
- Multi-parameter surfaces: use pairwise or small t-way combinations before exhaustive matrices when combinations determine risk.
- Structure-aware surfaces: target changed branches, error handlers, configuration paths, serialization/deserialization edges, and resource cleanup. Treat coverage as a gap finder, not proof by itself.
- User-interaction surfaces: exercise visible controls directly, verify user-visible postconditions, and keep browser/runtime/reader evidence distinct from source evidence.
- Closure-defect surfaces: for assigned `CORE-WORKFLOW-CLOSURE` rows, exercise the row-matched probe family; generic smoke, navigation, or render proof cannot replace the probe.
- Work-tool lifecycle surfaces: when in scope, exercise create/import/upsert -> displayed consumer -> inspect or navigate -> edit/save/reload -> dependent recompute -> disposition/clear/archive/delete/void/deactivate, and keep skipped links explicit.
- Weak-oracle surfaces: use properties, invariants, round trips, differential/reference checks, metamorphic relations, and stateful generated sequences when exact expected output is hard to know.
- Regression surfaces: ask which plausible developer mistake would survive the current proof; add one bounded probe when the risk is material.
- Reliability surfaces: a check set that never tries to break the workflow is not enough for user-ready or completion claims; report the missing hard-test class as an open surface.
- Security-exposed web surfaces: enumerate access points, inputs, parameters, cookies, headers, auth/session transitions, and passive-to-active test targets before claiming sufficient proof.

If a material amplifier is skipped, classify it as `out-of-scope by dispatch`, `blocked`, or an `OPEN-SURFACES` item. Do not hide it behind generic "tested" language.

## Tool-Tier Detail
Browser interaction requires a browser-proof path. Playwright CLI is the default tester profile when available for repeated dev-loop proof because it is fast and low-friction per run; unavailable CLI requires explicit blocked/fallback evidence. Playwright MCP is lawful when explicitly frozen, but is generally validator-tier for final-acceptance fidelity.

When the same proof surface offers multiple tool profiles at different friction-vs-fidelity tiers, tester defaults to the smallest truthful profile that still proves the iteration's bounded scope. The higher-fidelity profile belongs to validator final acceptance unless packet `TOOL-REQUIREMENT` freezes it for tester work.

## Interaction Coverage
- For executable, user-facing software, keep an interaction-coverage matrix explicit against `SCOPE-BASELINE` and `ACTIVE-SLICE` when those fields are material.
- Each in-scope feature/surface/control in the assigned proof slice must end in exactly one explicit state:
  - directly proven
  - disproven
  - blocked
  - out-of-scope by dispatch
- Navigation-only or indirect evidence does not justify `matched` interaction coverage when direct interaction remained required.
- Each assigned closure row must carry closure-defect probe status: executed, disproven, blocked, or out-of-scope by dispatch.
- Each material workflow or data-state family must carry hard-test probe status: executed, disproven, blocked, not-material with basis, or out-of-scope by dispatch.
- `out-of-scope by dispatch` is local proof classification only; it cannot close or defer a frozen `SCOPE-BASELINE` item unless `DEFERRED-SURFACES` carries that upstream decision.

## Human-Facing Checklist
- Rendered evidence is a defect oracle, not an artifact receipt. Inspect captured output for unreadable glyphs, clipping, overlap, hidden controls, broken hierarchy, missing media, blank/crashed screens, unexpected empty states, and first-glance failure before claiming user-facing proof.
- For source-read governance, report, or documentation artifacts, the source/read document can be the decisive proof surface when rendering is not material.
- For browser/UI or other scrollable visual surfaces, capture the route/page/screen-state x viewport matrix required by the frozen proof surface; use full-page or full design-area capture for whole-surface claims, and label viewport-only captures as viewport-limited; whole-surface `matched` requires whole-surface capture.
- Run glyph and legibility sanity on representative user-language strings before layout judgment; placeholder glyph boxes, tofu, or unreadable text must block `matched` proof on that surface.
- First-glance comprehension assessed when reader-first usefulness matters
- Package validity and openability verified for office-format artifacts
- Per-page rendered evidence kept separate from text-level proof for page-read artifacts
- Rendered evidence kept distinct from wording, logic, and request-fit review

## Specialist Skill Loading
Packet `REQUIRED-SKILLS` entries stay mandatory under the common lane-additions preconditions.
Tester lane evaluation selects and applies materially relevant specialist lenses from the proof surface, frozen `SCOPE-BASELINE`, Phase 1/2 design basis, and expectation sources.
- Work-tool, spreadsheet, operations, business-rule, and workflow-state proof: `business-workflow`, `work-tool-patterns`.
- Log and runtime-observation proof support: `log-based-qa`.
Specialist lenses complement tester execution authority and do not replace user-surface proof.

## Tester Completion Detail
- In completion-grade completion, keep these tester-specific fields explicit; use `not-applicable` instead of omission when a status axis was not part of the frozen surface:
  - `TEST-STATE`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `PROOF-SURFACE-MATCH`
  - `RUN-PATH-STATUS`
  - `FIRST-USE-STATE-STATUS`
  - `DATA-CONTENT-STATE-STATUS`
  - `CORE-WORKFLOW-STATUS`
  - `INTERACTION-COVERAGE-STATUS`
  - `ROW-PROOF-CLASSIFICATIONS`
  - `CLOSURE-DEFECT-PROBE-STATUS`
  - `HARD-TEST-PROBE-STATUS`
  - `POSTCONDITION-EVIDENCE-STATUS`
  - `RUNTIME-ERROR-SURFACE-STATUS`
  - `BURDEN-STATUS`
  - cross-environment conditional fields (`ENV-COVERAGE`, `EQUIVALENCE-DECLARATION`, `WINDOWS-EQUIVALENCE-BASIS`) per `.claude/skills/task-execution/references/request-bound-fields.md` when proof spans multiple environments or claims single-env cross-env sufficiency
- `matched` is reserved for true contract alignment on that exact surface.
- `TEST-STATE: ready` requires every assigned proof row to have an explicit proof classification; it does not turn disproven, blocked, indirect-only, or uncovered rows into passing evidence.
- Direct-required executable user-facing rows need direct proof, executed closure-defect probe, and retained postcondition evidence; indirect proof can support diagnosis or narrowing only.
- User-ready, reliability, or workflow-completion completion needs material hard-test probe status; absent hard-test evidence narrows the proof claim to normal-path or smoke coverage.
- For a Windows primary operator surface, completion names `WINDOWS-LAUNCH-SURFACE`; `RUN-PATH-STATUS: matched` requires Windows native or proven-equivalent interop launch evidence.
- For visual or rendered proof, `matched` requires the Evidence-Quality Matrix row, capture matrix, capture scope, glyph sanity result, and inspected defect classes to be named in the completion or evidence anchor.
- If executed proof makes the frozen validator contract untruthful, use `TEST-STATE: hold` or `TEST-STATE: blocked` according to the contradiction and explain it in `OPEN-SURFACES` instead of silently mutating the validator basis.

## Resolve Next Owner And Action
- `execute` opens tester-owned proof work.
- `reconstruct-with-inference` opens tester-owned proof work with marked inference.
- Directly proven surface opens tester completion.
- Disproven surface opens proof-failure completion.
- Blocked proof surface opens `scope-pressure` or `hold|blocker`.
- Missing decisive tool path opens bounded tool discovery or setup route through team-lead.
- Untruthful validator contract opens `TEST-STATE: hold` or `TEST-STATE: blocked`.
- Completed proof completion opens reviewer, validator, correction owner, or team-lead synthesis by frozen route.
