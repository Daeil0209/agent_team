---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Reporting Philosophy; admitted user-facing report shape"
LOAD-POLICY: mandatory after reporting-prohibition-law grants a report exception and before admitted user-facing prose is drafted
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# User Reporting Law

## Purpose
- This reference owns admitted user-facing report wording, report shape, final-result line budget, and report-location line.
- This reference does not admit visible prose; report admission remains with `.claude/reference/reporting-prohibition-law.md`.
- This reference cannot add report reasons, broaden exceptions, or move internal Procedure Plane or Communication Plane detail into user-facing prose.
- Communication Plane and Procedure Plane detail stays out of user-facing prose unless the user explicitly requested the exact internal material and `.claude/reference/reporting-prohibition-law.md` admitted it.

## Consume When
- Consume after `.claude/reference/reporting-prohibition-law.md` grants `final verified result`, `user-action blocker`, `explicit status answer`, or `closeout residual`.
- Consume before drafting any admitted user-facing prose.
- Consume before final-result report wording, artifact-link placement, status-answer wording, blocker wording, or closeout-residual wording.

## Report Shape
- `final verified result` uses at most eight rendered lines.
- `final verified result` reports only the user-instructed work result and user-decisive exceptions required by the admitted report reason.
- `final verified result` states the result first in concise Korean.
- The first rendered line of a `final verified result` is the user-result line; no report-admission preface, verification preface, delivery announcement, or procedure-complete announcement appears before it.
- `final verified result` includes verification basis, cited lawful owner-deferral authority, explicit out-of-scope surface, or material defect state only when it affects the instructed work result or was explicitly requested.
- `final verified result` excludes unrequested internal procedure, skill/reference loads, route or dispatch topology, diff inventories, raw candidate counts, broad evidence detail, self-accusation, excuses, intent promises, proceed prompts, and follow-up offers.
- `final verified result` must not append confirmation-needed or scope-decision notes for unresolved in-scope work; unresolved scope is handled before report admission as internal continuation or `user-action blocker`.
- `final verified result` places `REPORT-LOCATION-LINE` as the last rendered line: `<localized-report-label>: <canonical artifact path>` when a report artifact exists or the user requested a report location, otherwise `<localized-report-label>: <localized-none-value>`.
- `final verified result` ends the final-result report block at `REPORT-LOCATION-LINE`; no assistant-authored rendered content follows that line in the same final-result block.
- Post-final runtime, standby, idle, cleanup, no-further-work, or follow-up suggestion content stays out of final-result prose.
- A separately admitted explicit status answer or closeout residual uses its own report event and is not appended after the final-result `REPORT-LOCATION-LINE`.
- `final verified result` avoids final acceptance or `PASS/HOLD/FAIL` wording unless the `validator` issued that verdict.
- `user-action blocker` states the blocked user decision/action and the smallest safe next step.
- `explicit status answer` uses the narrowest truthful answer, including exact internal material only when that exact material was explicitly requested, and then returns to the active owner action unless the user redirected or a user-action blocker exists.
- Binary status questions get one yes/no sentence plus a user-action blocker only when present.
- Status answers omit internal topology, packet, shard, dispatch-ack/subjob-done, counts, paths, findings, evidence detail, retained-carrier detail, and per-agent narratives unless that exact field was requested.
- `closeout residual` reports only residual state that affects the user.

## Resolve Next Owner And Action
- Passing `## Report Shape` returns to `team-lead` for the admitted prose, then follows the continuation named by `.claude/reference/reporting-prohibition-law.md` or resumes the prior live owner/action unless redirected, blocked by a proven user-owned action, or final closure applies.
- Missing line-budget, requested-work-only, report-location, post-final-tail absence for a final-result report, or link-placement basis opens `.claude/skills/agent-team-lead/references/reporting-user-reporting-rules.md` evidence-basis correction.
- Report-admission gaps return to `.claude/reference/reporting-prohibition-law.md`.
- Non-excepted prose returns to the owning Procedure Plane or Communication Plane path without visible drafting.
