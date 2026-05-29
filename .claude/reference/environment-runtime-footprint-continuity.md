---
doc-type: reference-cache
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Environment Configuration Philosophy; runtime footprint; hook-last continuity"
captured: 2026-04-29
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Runtime Footprint And Continuity

## Purpose
Use this section only when a governance decision concerns hook footprint, generated continuity files, agent-team runtime overhead, or runtime-footprint claims.
Not always-loaded doctrine; does not authorize bypassing `CLAUDE.md`, owner skills, settings, hooks, or runtime evidence.

## Resolve Next Owner And Action
- Failed Hook-Last review opens owner-procedure repair, hook narrowing, or hook removal.
- Missing runtime-footprint measurement opens measurement or downgrades the claim to `UNVERIFIED`.
- Legitimate lane-action blocking opens over-broad-blocking correction.
- A remaining reserved hard-deny danger opens the narrowest runtime guardrail owner.

## Consumer And Ownership
- Primary consumer: `team-lead`.
- Use during governance design review, hook-density review, runtime-footprint claims, continuity-file disputes, and context-footprint audits.
- Lane agents receive only packetized facts from this section when the assigned lane needs them.

## Hook-Last Footprint Review
Hooks are valid runtime guardrails, but they are the last resort.

Before adding, broadening, or defending a blocking hook, verify all items:
1. Non-hook owner tried first: the defect cannot be fixed sufficiently by `CLAUDE.md`, the owning role, the owning skill, packet fields, or settings permissions.
2. Named failure: identify the exact prohibited action, irreversible side effect, secret boundary, runtime-truth corruption, or dispatch/lifecycle risk the hook protects.
3. Narrow matcher: the hook triggers only on the smallest event/tool/path/message class that can catch the failure.
4. Recovery path: a lawful next owner or retry path is stated; a blocked user/agent is not left guessing.
5. False-positive review: known legitimate actions that might be blocked are listed, exempted, downgraded to silent tracking, or explicitly accepted as risk.
6. Footprint review: record affected hook event, matcher count, script size trend, matched-tool side-effect map, and whether the change adds latency to high-frequency tool paths.
7. Operator approval: record explicit operator approval for blocking hook/settings runtime-enforcement expansion, or `not-applicable:<basis>` when the change does not expand blocking enforcement.

If any item is missing, do not add, broaden, or defend blocking enforcement as verified. Preserve hard security or reserved danger blockers only when their protected danger is explicit; otherwise remove, narrow, downgrade to silent tracking, or repair the owner procedure.

## Captured Local Hook Posture
Before classifying current hook posture, density, or improvement, read live `.claude/settings.json` and apply measured latency, context, or runtime evidence. Classify the live posture as `high-footprint guardrail debt` until measured evidence proves runtime-footprint improvement; then narrow the classification per `## Hook-Last Footprint Review` matcher-narrowing procedure.

## Baseline Capture (2026-04-29)
Historical anchor: `.claude/settings.json` used multiple high-frequency `PreToolUse` hooks, including activity monitoring, task-start, self-verification, runtime-entry, dispatch sizing/proof, and compliance supervision.

This baseline is historical context, not authoritative current state; live-classification per `## Captured Local Hook Posture` always reads live `.claude/settings.json` first. Baseline recapture is required when (a) live settings.json hook inventory diverges materially from this captured list, (b) operator records explicit refresh basis, or (c) recurrence-barrier governance modification opens a fresh footprint review.

Rules:
- Broaden a blocking hook only after the full Hook-Last Footprint Review above.
- Treat missing itemized ledger records as `UNVERIFIED`.
- When a broad hook blocks a legitimate lane action, classify over-broad blocking as a defect and repair the narrowest owner surface before adding hook logic.
- Before narrowing an existing matcher, publish a per-tool side-effect map citing the hook script body and the protected ledgers/sequence-markers each removed tool currently writes; classify each removed tool as `no-side-effect`, `side-effect-replaced-elsewhere`, or `protected-side-effect-blocks-removal`.
- Removed warning code does not prove the matcher is dead.
- A matcher that writes protected ledgers or sequence markers is not removable by footprint argument alone.
- Reduce footprint by removing, merging, narrowing, or downgrading existing hook work before adding hook work.

## Runtime Footprint Claims
Report runtime-footprint improvement as verified only when measured on the relevant surface.

Claim classes:
- `design-level`: structure reduces context or coordination footprint, but no runtime measurement was taken.
- `measured`: evidence includes command/run identity, before/after sample, hook path or agent-team path, and measured context/latency/runtime effect.
- `UNVERIFIED`: evidence is absent, partial, or only inferred from line counts or file structure.

Minimum measurement record:
- surface: hook event, tool path, skill load, agent-team dispatch, or report/synthesis path
- before/after or baseline/current sample
- metric: latency, context size, hook count, script count, matcher count, or agent count
- sample count or reason why only one sample is truthful
- result classification: `measured`, `design-level`, or `UNVERIFIED`

Line counts and file sizes support diagnosis only as non-proof evidence.

Enabled MCP server processes, including Playwright MCP, are runtime footprint surfaces when they affect a route. Treat their latency, process lifetime, and child-process cleanup claims as `UNVERIFIED` until measured on the active route.

## Continuity Truth Law
Runtime continuity truth uses current-session authorities: `.runtime/procedure-state.json`, `SessionStart` snapshot lines, hook logs, retained carriers, and agent handoffs.

## Scenario Matrix
| Scenario | Required result |
| --- | --- |
| New blocking hook proposed | Reject unless non-hook owner gap, narrow matcher, recovery path, false-positive review, and footprint review are present. |
| Hook density criticized | Separate official legality from local `[HOOK-LAST]` philosophy fit; measure or label runtime footprint as `UNVERIFIED`. |
| Runtime footprint improvement claimed | Classify as `measured`, `design-level`, or `UNVERIFIED`; keep design structure at `design-level` until measured. |
