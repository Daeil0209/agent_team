---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Dispatch Execution Contract
- During explicit team-runtime sessions, non-exempt agent lanes should normally run in background rather than foreground.
- Use the current runtime-configured foreground exemptions instead of hardcoding an informal exception list in session behavior.
- When a dispatched lane requires explicit write authority under runtime policy, supply the required execution mode rather than relying on foreground execution as a shortcut.
- For request-bound work, interpret dispatch design in this order: request-fit packet -> deliverable shape -> phase intent -> staffing choice. Do not let TOC, shard count, or runtime convenience redefine the document class.
- For request-bound document work, keep phase intent explicit using existing packet surfaces rather than inventing new fields. `researcher` packets already express the evidence phase; `developer` packets should use `PLAN-STEP` plus `CHANGE-SPEC` to say whether the active phase is `draft` or `merge-compress`; downstream acceptance lanes remain distinct later phases even when they are expressed through reviewer/tester/validator packets rather than a separate phase field.
- Treat `review` and `validation` as acceptance phases, not cleanup afterthoughts. Review checks artifact quality, request fit, and defect classification; validation arbitrates final `PASS/HOLD/FAIL` against the authoritative expectation surfaces after review/test state is visible.
- Mixed-purpose prompts are invalid even when all requested work is related. A single dispatch must not ask one agent to expand broad evidence, draft the main artifact body, and perform final merge-compress integration at the same time.
- The most important forbidden combinations are: `research + main-body draft`, `broad research + merge-compress`, `draft + final acceptance review`, and `review + validation verdict` in one agent prompt.
- Do not require a new agent only because the phase changed. When scope remains single-purpose and context reuse is beneficial, continue with the current agent through a bounded follow-up dispatch instead of manufacturing handoff overhead.
- Late-arriving shard updates may be absorbed narrowly without reopening the whole staffing plan. If the frozen packet and current evidence already support useful progress, the designated draft or merge owner may continue and then take a bounded follow-up update for the late shard while keeping the active phase intent explicit.
- Use one foreground scout first only when independence, staffing shape, or boundary quality is still uncertain after the `intent -> deliverable shape -> phase` freeze. When those are already explicit and non-overlapping, immediate parallel fan-out is preferred over scout-first delay.
- When dispatching `developer` or another implementation lane, keep the designed downstream procedure explicit in the dispatch packet rather than assuming later cleanup will restore it. Current standard packet fields:
  - `PLAN-STATE: ready|approved|updated|revalidated`
  - `PLAN-STEP: <active plan step>`
  - `ACCEPTANCE-RISK: low|meaningful|high|critical`
  - `REVIEW-OWNER: reviewer`
  - `PROOF-OWNER: tester|not-needed`
  - `ACCEPTANCE-OWNER: reviewer|validator`
- For request-bound document work routed to `developer`, recommended `PLAN-STEP` values are `draft` and `merge-compress`. Keep `CHANGE-SPEC` explicit about whether the agent owns first answer-first drafting or integration/compression of existing shard outputs.
- For `ACCEPTANCE-RISK: meaningful|high|critical`, preserve the full downstream gate map explicitly: `REVIEW-OWNER: reviewer`, `PROOF-OWNER: tester`, `ACCEPTANCE-OWNER: validator`.
