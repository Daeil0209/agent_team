---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Request-Bound Conditional Packet Fields
When truthful lane execution depends on the original request shape, the assignment packet must also carry:
- `REQUEST-INTENT`
- `CORE-QUESTION`
- `REQUIRED-DELIVERABLE`
- `PRIMARY-AUDIENCE`
- `EXCLUDED-SCOPE`

When exact instruction wording materially affects acceptance, decision-fit, or request-fit review, the packet must additionally carry:
- `USER-INSTRUCTION-VERBATIM`
- `USER-INSTRUCTION-AMENDMENTS`

When planning or the active workflow already froze methodology guidance for the lane, the packet must also carry:
- `SKILL-RECOMMENDATIONS`

`SKILL-RECOMMENDATIONS` is mandatory when frozen by `work-planning` or the active workflow owner, and advisory only inside the already bounded lane surface. It does not create lane ownership, replace `REQUIRED-SKILLS`, authorize a lane-core skill listing, or change proof/acceptance ownership. If it is missing from the frozen planning/workflow basis, do not invent it during dispatch.

Do not leave these request-fit or methodology fields only in linked-path references when the receiving lane must use them to plan, verify, or judge the assigned surface truthfully.

When frozen governance depth materially changes staffing, checkpoint, review, proof, or acceptance burden for the receiving lane, the assignment packet must also carry:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

`PROJECT-TIER` is the floor. `ACTIVE-REQUEST-TIER` may stay at that floor or raise above it for the current request, but the packet must not silently rewrite the project floor.
Tier may avoid unnecessary over-governance, but it must never be used to downshift decisive user-surface proof or acceptance integrity.

When proof or acceptance depends on the real user-facing surface rather than source-state alone, the packet must also make that surface explicit:
- `USER-SURFACE`
- `USER-SURFACE-PROOF-PATH`
- `TOOL-REQUIREMENT` when one exact truthful tool is already frozen
- `SURFACE-EQUIVALENCE-BASIS` when the frozen proof path is not the obvious native/default tool for that surface

`USER-SURFACE` names what the user actually experiences: browser interaction, rendered page-read document, office document, spreadsheet runtime, PDF reader surface, HWP/HWPX reader/editor surface, operator console, or another concrete user-consumed surface. Do not force tester or validator to rediscover that surface from gist.

`TOOL-REQUIREMENT` is not a convenience preference field. Keep assignments method-neutral by default and freeze an exact tool only when the user explicitly requires it, the active workflow already froze it for bounded cost/risk reasons, or no equivalent truthful path exists.
If the exact tool is not yet frozen, the packet may instead freeze a bounded discovery/setup objective:
- `TOOL-DISCOVERY-GOAL`
- `TOOL-DISCOVERY-BOUNDARY`
- `TOOL-VERIFICATION-STANDARD`
- `TOOL-CLEANUP-EXPECTATION`

This keeps the assignment autonomy-preserving without allowing vague or unbounded tool hunting.
For browser-ui proof or acceptance, an exact `TOOL-REQUIREMENT` and the full bounded discovery/setup bundle are alternatives at dispatch time. Do not force both unless the workflow truly needs both.

`USER-RUN-PATH` and `BURDEN-CONTRACT` are delivery-contract fields scoped by deliverable surface class:
- **MANDATORY** when target lane is `tester` or `validator` AND the deliverable surface is **executable user-facing** (operator runs the program / launches a server / interacts with a browser-rendered UI / opens a runnable artifact). For these surfaces, launch path materially defines proof and operator burden materially defines acceptance. Omitting these fields is a packet defect that `task-execution`, tester, and validator must not absorb by guesswork. Default for web apps, CLI tools, GUI apps, runnable scripts, and any deliverable with a "the user starts it and uses it" surface.
- **OPTIONAL (use `not-applicable` if omitted)** when the deliverable surface is a non-runnable rendered static artifact (PDF/HWP/document/slides where the operator just reads, no run/launch step) and run-path burden plus operator workflow burden are not part of the frozen acceptance surface. Completion gates may treat omitted values as `not-applicable` only in this narrow case.
- **NOT a permission-graded field**. There is no "I prefer to skip these" option for executable user-facing surfaces; the delivery contract treats them as schema floor.

Tester/validator completion status fields such as `PROOF-SURFACE-MATCH`, `RUN-PATH-STATUS`, `CORE-WORKFLOW-STATUS`, `INTERACTION-COVERAGE-STATUS`, and `BURDEN-STATUS` stay explicit; use `not-applicable` instead of omission when a status axis was not part of the frozen surface.

`DECISION-SURFACE` is a conditional validator arbitration field. Keep it explicit when the decisive acceptance surface materially differs from the validator execution surface or when the verdict must reconcile more than one candidate acceptance surface. When `VALIDATION-SURFACE` already names the single decisive user-facing acceptance surface for the bounded acceptance path, `DECISION-SURFACE` may inherit from `VALIDATION-SURFACE`.

`ENV-BASIS` and `SCENARIO-SCOPE` are tester-proof context fields with conditional default but executable-proof-floor enforcement. The narrow `not-applicable (...)` carve-out for genuinely static-render single-surface proof remains valid; default for any executable surface is mandatory.

When the assigned surface is office-format, page-read, or other rendered human-facing material where reader-visible usefulness is part of acceptance, keep the rendered chain explicit instead of implying it:
- `developer/document-automation -> tester -> reviewer -> validator` when risk is meaningful
- rendered evidence supports human-visible usefulness only; it does not replace wording, logic, request-fit, proof, or verdict ownership
- if the current toolchain cannot truthfully exercise the decisive user surface, freeze one bounded next step only: explicit tool discovery/acquisition/setup via `external-tool-bridge` or the appropriate setup owner, or `hold|blocker`. Do not quietly downgrade to source-only checking.
