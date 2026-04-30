---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Parallel Shard And Merge Protocol
- When one parent task is split across multiple agents inside the same phase, freeze the parent packet first: request-fit, deliverable shape, phase intent, and merge objective must stay shared across all shards.
- Parallel shard fan-out is allowed only when shard boundaries are genuinely non-overlapping at the active work surface. If boundaries overlap, the work is not independent and must be resized, resequenced, or routed to one owner instead of parallelized by convenience.
- Name one explicit `MERGE-OWNER` before full fan-out whenever the parent task will require a recomposed deliverable, integrated judgment, or compressed final body. `MERGE-OWNER` may be the lead or a designated agent, but it must be explicit before shard outputs start accumulating.
- Naming `MERGE-OWNER` does not force a global wait for shard completeness. Once the frozen parent packet and available shard set support useful progress, that owner may begin bounded drafting or integration and fold later shard arrivals into explicit follow-up merge work while missing inputs remain visible.
- Each shard dispatch must stay bounded and must say what part of the parent work it owns, what it must not absorb, and what form its handoff should take so the merge owner does not have to reconstruct shard intent from prose.
- Each shard handoff should carry at minimum:
  - shard id or equivalent surface label
  - covered boundary and excluded boundary
  - concrete result payload
  - unresolved gaps or blockers
  - duplication or conflict risk seen from that shard
  - recommended downstream placement when the parent artifact will be recomposed
- Merge work is its own phase-intent. Do not hide merge responsibility inside one shard writer's ordinary draft step after parallel fan-out has already happened.
- Phase separation does not require passive waiting. Starting draft from an incomplete but already useful shard set, then advancing the designated owner through bounded merge-compress follow-up as later shard results arrive, is valid when the parent packet, merge ownership, and unresolved gaps stay explicit.
- The merge owner must:
  - collect shard outputs against the frozen parent packet
  - remove duplication and collapse overlapping support material
  - keep the direct answer, decision surface, or controlling conclusion visible early
  - preserve `EXCLUDED-SCOPE` and final page/volume target when the parent artifact is request-bound
  - make any unresolved contradiction, missing shard, or weak-evidence area explicit rather than flattening it into a false clean merge
- If shard outputs expand the volume beyond the intended artifact class, optimize at merge time by demoting or trimming locally correct but non-decisive material before acceptance routing. Merge does not owe every shard full local preservation in the final reader-facing body.
- After merge, route one authoritative integrated output forward. Do not send multiple shard bodies downstream as if acceptance lanes should perform the merge implicitly.
