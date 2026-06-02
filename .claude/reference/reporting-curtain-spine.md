---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/reference/reporting-prohibition-law.md
SOURCE-RULES: "Reporting Philosophy hot-path consumption spine"
LOAD-POLICY: hot-path before routine assistant-authored renderable surfaces and reporting-sensitive hook context
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Reporting Curtain Spine

## Purpose
- This spine is the compact hot-path report curtain for routine suppression and state-signal envelope decisions.
- It reduces repeated consumption cost; it does not admit user-facing prose.
- Full report admission remains owned by `.claude/reference/reporting-prohibition-law.md`.
- Admitted report wording remains owned by `.claude/reference/reporting-user-reporting-law.md` after admission only.

## Hot-Path Rule
- Default assistant-authored visible prose is suppressed while Procedure Plane or Communication Plane action can continue.
- Startup, boot, skill-load, reference-load, planning, review, verification, task-execution, dispatch, receipt, monitoring, waiting, carrier, runtime, route, shard, and cleanup facts are not report reasons.
- Tool rows, hook rows, errors, state changes, and checked information are internal evidence only; they do not create adjacent prose permission.
- After a denied or routine surface, execute the next governed tool, packet, carrier, task-state, dispatch, verification, synthesis, correction, or blocker-routing action silently.
- Do not render self-referential silence, compliance, awaiting, continuing, suppression, readiness, or transition prose.

## State-Signal Envelope
- Worker-to-lead `dispatch-ack`, `scope-pressure`, `hold|blocker`, and `subjob-done` render at most one no-detail token.
- Put that token only in `SendMessage.summary`.
- Omit `SendMessage.message` when possible; if schema requires it, use one ASCII space.
- Counts, paths, ids, evidence, rationale, completion detail, and carrier fields stay in non-rendered carriers, task state, runtime ledgers, or retained artifacts.

## Escalate To Full Reporting Law
- Load `.claude/reference/reporting-prohibition-law.md` when a candidate may be `final verified result`, `user-action blocker`, `explicit status answer`, or `closeout residual`.
- Load `.claude/reference/reporting-prohibition-law.md` when the user explicitly requests exact internal material, when report admission is uncertain, or when a governance/reporting defect or remedy claim is being reported.
- Load `.claude/reference/reporting-user-reporting-law.md` only after `.claude/reference/reporting-prohibition-law.md` admits the exact report reason.
- If this spine and the full reporting law appear to conflict, the full reporting law governs admission and this spine governs only routine hot-path suppression.
