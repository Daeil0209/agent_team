---
doc-type: reference-cache
PRIMARY-OWNER: team-lead
captured: 2026-04-29
LOAD-POLICY: on-demand reference only
---
# Runtime Footprint And Continuity Reference

## Purpose
Use this file only when a governance decision concerns hook footprint, generated continuity files, agent-team runtime overhead, or cost/latency claims.
It is not always-loaded doctrine and does not authorize bypassing `CLAUDE.md`, owner skills, settings, hooks, or runtime evidence.

## Consumer And Ownership
- Primary consumer: `team-lead`.
- Use during governance design review, hook-density review, runtime-cost claims, continuity-file disputes, and context-cost optimization audits.
- Lane agents receive only packetized facts from this file when the assigned lane needs them.

## Hook-Last Footprint Review
Hooks are valid runtime guardrails, but they are the last resort.

Before adding, broadening, or defending a blocking hook, verify all items:
1. Non-hook owner tried first: the defect cannot be fixed sufficiently by `CLAUDE.md`, the owning role, the owning skill, packet fields, or settings permissions.
2. Named failure: identify the exact prohibited action, irreversible side effect, secret boundary, runtime-truth corruption, or dispatch/lifecycle risk the hook protects.
3. Narrow matcher: the hook triggers only on the smallest event/tool/path/message class that can catch the failure.
4. Recovery path: a lawful next owner or retry path is stated; a blocked user/agent is not left guessing.
5. False-positive review: known legitimate actions that might be blocked are listed, exempted, downgraded to warning, or explicitly accepted as risk.
6. Footprint review: record affected hook event, matcher count, script size trend, and whether the change adds latency to high-frequency tool paths.

If any item is missing, do not expand blocking enforcement. Prefer owner-procedure repair, warning-only feedback, settings deny rules for hard security paths, or a narrower hook.

## Current Local Hook Posture
The current `.claude/settings.json` uses multiple high-frequency `PreToolUse` hooks, including activity monitoring, task-start, SV, runtime-entry, dispatch sizing/proof, and compliance supervision.

This is a high-footprint guardrail posture, not proof of runtime-cost optimization. Treat it as existing runtime guardrail debt unless measured evidence proves otherwise.

Rules:
- Do not broaden a blocking hook without the full Hook-Last Footprint Review above.
- Current active blocking-hook review records live in `.claude/hooks/MANIFEST.md` `Hook-Last Review Ledger`; absence of an itemized record is `UNVERIFIED`, not permission to broaden the hook.
- Do not describe current hook density as optimized without measured latency, token, or runtime evidence.
- If a legitimate lane action is blocked by a broad hook, classify that as a `[BLOCK-AS-DEFECT]` candidate and repair the narrowest owner surface before adding more hook logic.

## Runtime Cost Claims
Do not report runtime-cost, token, or latency optimization as verified unless measured on the relevant surface.

Claim classes:
- `design-level`: structure should reduce context or coordination cost, but no runtime measurement was taken.
- `measured`: evidence includes command/run identity, before/after sample, hook path or agent-team path, and measured token/latency/runtime effect.
- `UNVERIFIED`: evidence is absent, partial, or only inferred from line counts or file structure.

Minimum measurement record:
- surface: hook event, tool path, skill load, agent-team dispatch, or report/synthesis path
- before/after or baseline/current sample
- metric: latency, token/context size, hook count, script count, matcher count, or agent count
- sample count or reason why only one sample is truthful
- result classification: `measured`, `design-level`, or `UNVERIFIED`

Line counts and file sizes may support diagnosis, but they are not runtime latency or token proof by themselves.

## Continuity Snapshot Law
`session-state.md` is a generated continuity snapshot and startup anchor.

It is not:
- authoritative runtime state
- task state
- mailbox state
- cleanup state
- acceptance evidence
- a replacement for `procedure-state.json`, hook logs, task records, or agent handoffs

Use it only to recover what the next session should inspect first. If it is stale, partial, or auto-captured without explicit handoff, report that limitation instead of treating it as settled state.

## Scenario Matrix
| Scenario | Required result |
| --- | --- |
| New blocking hook proposed | Reject unless non-hook owner gap, narrow matcher, recovery path, false-positive review, and footprint review are present. |
| Hook density criticized | Separate official legality from local `[HOOK-LAST]` philosophy fit; measure or label runtime cost as `UNVERIFIED`. |
| Cost optimization claimed | Classify as `measured`, `design-level`, or `UNVERIFIED`; do not upgrade design structure to measured result. |
| `session-state.md` exists | Treat as generated continuity snapshot, not runtime/task state. |
| `session-state.md` is stale | Preserve as startup clue only; reopen the owning runtime/procedure evidence before making a state claim. |
