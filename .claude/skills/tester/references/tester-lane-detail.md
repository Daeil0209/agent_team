---
name: tester-reference
PRIMARY-OWNER: tester
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Tester Reference
## Auto-inject
false - load explicitly when packet detail, UI intent proof detail, interaction coverage, human-facing checklist detail, or handoff detail is needed.

## Role-Spine Handoff
`agents/tester.md` owns only the always-loaded tester charter, boundary, receipt trigger, stop rule, and proof-local completion duty. This reference owns detailed tester packet fields, UI intent proof matrix, tool-tier detail, interaction coverage, human-facing checklist, specialist skill rule, and handoff detail.

When a tester role or skill says "tester additions" or "tester detail", consume this file directly. Do not re-expand `agents/tester.md` into a packet-field catalog. Missing decisive proof detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless proof target, expectation, surface, environment basis, scenario scope, and decisive evidence basis are anchored in packet or artifact evidence.

Control packets, message classes, lifecycle truth, and completion spine remain owned by `.claude/skills/task-execution/references/`. This reference only states the tester-specific payload and proof discipline needed on top of those common contracts.

## Control Packet Discipline
- `phase-transition-control` is workflow coordination context only. It does not replace an assignment-grade tester packet when new bounded proof work is assigned.
- If phase context and assignment-grade work arrive in the same execution segment, consume the embedded phase context inside the assignment packet and send `dispatch-ack`, not a separate `control-ack`.
- `lifecycle-control` is lifecycle-only direction, not assignment or workflow-phase control. Acknowledge it with `control-ack` only when it materially affects active work, standby readiness, or shutdown path.

## Tester Packet Detail
- Consequential tester packets should keep these fields explicit:
  - `PROOF-TARGET`
  - `PROOF-EXPECTATION`
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

## UI Intent Proof Matrix
For UI/browser proof, build the proof around the designed behavior, not around page availability.

Required matrix columns:
- `DESIGN-INTENT`: the feature behavior or contract being proven
- `ENTRY-PATH`: how the intended user reaches the feature
- `USER-ACTION`: the visible control or interaction to execute
- `EXPECTED-VISIBLE-RESULT`: the observable UI state that must appear
- `STATE-CHECK`: persistence, route, storage, server state, validation message, disabled/enabled state, or no-state-change expectation
- `NEGATIVE-OR-BOUNDARY-PROBE`: one bounded failure, invalid, empty, duplicate, limit, or retry path when material
- `PLAYWRIGHT-PROOF`: CLI command, locator/action/assertion surface, and artifact path when available
- `RESULT`: directly proven, disproven, blocked, or out-of-scope by dispatch

Missing-information rule:
- If `DESIGN-INTENT`, `ENTRY-PATH`, `USER-ACTION`, `EXPECTED-VISIBLE-RESULT`, `STATE-CHECK`, or `PLAYWRIGHT-PROOF` basis cannot be named from the packet or safe inference, stop and send `MESSAGE-CLASS: hold|blocker` to `team-lead` via `SendMessage`.
- The blocker must name the exact missing field, why proof would become guesswork without it, and the smallest corrected packet that would unblock testing.
- If the blocker concerns missing tool or execution capability, also include the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`.

Rules:
- A page load, screenshot, DOM existence check, API response, or source inspection does not prove a designed UI feature by itself.
- Prefer user-facing locators such as role, label, text, placeholder, and test id when test ids are part of the app contract.
- Prefer web-first assertions that wait for the expected visible state. Avoid fixed sleeps as proof.
- Use `npx playwright test` for repeatable proof. Add `--headed`, `--project`, `--grep`, or trace options only when they materially improve the assigned proof or debug surface.
- If the UI intent cannot be driven through Playwright CLI or the frozen equivalent path, classify the proof as blocked instead of substituting weaker evidence.

## Defect Detection Amplifiers
Use only amplifiers that materially strengthen the intent proof matrix. The goal is higher fault discovery per check, not larger reports.
- Data and rule surfaces: use equivalence partitions, boundary values, decision tables, and invalid/empty/duplicate/extreme data probes.
- Stateful or workflow surfaces: use state-transition probes, repeat/undo/retry/order-change paths, interruption paths, and post-action state checks.
- Multi-parameter surfaces: use pairwise or small t-way combinations before exhaustive matrices when combinations drive risk.
- Structure-aware surfaces: target changed branches, error handlers, configuration paths, serialization/deserialization edges, and resource cleanup. Treat coverage as a gap finder, not proof by itself.
- User-interaction surfaces: exercise visible controls directly, verify user-visible postconditions, and keep browser/runtime/reader evidence distinct from source evidence.
- Weak-oracle surfaces: use properties, invariants, round trips, differential/reference checks, metamorphic relations, and stateful generated sequences when exact expected output is hard to know.
- Regression surfaces: ask which plausible developer mistake would survive the current proof; add one bounded probe when the risk is material.
- Security-exposed web surfaces: enumerate access points, inputs, parameters, cookies, headers, auth/session transitions, and passive-to-active test targets before claiming sufficient proof.

If a material amplifier is skipped, classify it as `out-of-scope by dispatch`, `blocked`, or an `OPEN-SURFACES` item. Do not hide it behind generic "tested" language.

## Tool-Tier Detail
Browser interaction requires a browser-proof path. Playwright CLI is the preferred tester profile when available or explicitly frozen for repeated dev-loop proof because it is fast and low cost per run. Playwright MCP is lawful when explicitly frozen, but is generally validator-tier for final-acceptance fidelity.

When the same proof surface offers multiple tool profiles at different cost-vs-fidelity tiers, tester defaults to the lowest-cost profile that still proves the iteration's bounded scope. The higher-fidelity profile belongs to validator final acceptance unless packet `TOOL-REQUIREMENT` freezes it for tester work.

## Interaction Coverage
- For executable, user-facing software, keep an interaction-coverage matrix explicit.
- Each in-scope control must end in exactly one explicit state:
  - directly proven
  - disproven
  - blocked
  - out-of-scope by dispatch
- Navigation-only or indirect evidence does not justify `matched` interaction coverage when direct interaction remained required.

## Human-Facing Checklist
- Page image / visual layout captured when rendered usefulness matters
- First-glance comprehension assessed when reader-first usefulness matters
- Package validity and openability verified for office-format artifacts
- Per-page rendered evidence kept separate from text-level proof for page-read artifacts
- Rendered evidence kept distinct from wording, logic, and request-fit review

## Specialist Skill Loading
Specialist skills with `PRIMARY-OWNER: tester` load only via packet `REQUIRED-SKILLS`, `SKILL-AUTH`, or verified phase-local refinement; never by habit:
- `log-based-qa` - log-based QA methodology using structured JSON logging and Docker log monitoring as an alternative to traditional test scripts. It complements tester execution authority and does not replace user-surface proof.

## Tester Handoff Detail
- In completion-grade handoff, keep these tester-specific fields explicit; use `not-applicable` instead of omission when a status axis was not part of the frozen surface:
  - `TEST-STATE`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
  - `PROOF-SURFACE-MATCH`
  - `RUN-PATH-STATUS`
  - `CORE-WORKFLOW-STATUS`
  - `INTERACTION-COVERAGE-STATUS`
  - `BURDEN-STATUS`
- `matched` is reserved for true contract alignment on that exact surface.
- If executed proof makes the frozen validator contract untruthful, use `TEST-STATE: hold` or `TEST-STATE: blocked` as appropriate and explain the contradiction in `OPEN-SURFACES` instead of silently mutating the validator basis.
