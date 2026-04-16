# Reference Material

## Event Planning Domain Rules

When the active task involves automated generation of event planning documents (institutional events, team retreats, operational gatherings), apply the following domain-specific business rules in addition to the general workflow rules above.

**Authority boundary:** biz-sys owns the business domain state machine (purpose definition, feasibility criteria, element necessity validation, constraint modeling, priority resolution rules). doc-auto owns document generation pipeline stages (structure, formatting, compression, template conformance). These are complementary authorities, not competing models. Cross-reference: doc-auto reference.md §Event Planning Document Generation.

### Generation State Machine

For document generation pipeline architecture, refer to doc-auto reference.md (Event Planning Document Generation, Generation Stage Sequence) and sw-spec reference.md § Constraint-Satisfaction Document Generator Architecture Extension. biz-sys owns the business rules and domain constraints at each stage.

Event planning document generation follows a strict business-rule state sequence. Do not skip or reorder stages.

0. **Hidden-criteria elicitation (pre-generation gate)** -- Before generation begins, surface hidden review criteria through structured questions (see Hidden-Criteria Question Set below). Do not generate until critical hidden inputs are captured. This stage must execute before any generation starts.
1. **Purpose definition + constraint capture** -- Establish why the event exists, what outcome is required, and who the audience is before selecting any operational element. The same institution may run events with radically different purposes (education-focused, cohesion-building, performance-sharing, morale/refresh), and purpose determines every downstream choice.
2. **Element selection + necessity validation** -- Select operational elements (education, meals, recognition, networking, free time, site tours, presentations, Q&A, etc.) as composable options, not fixed procedures. Each selected element must pass a necessity gate: does it materially serve the stated purpose, and is there a simpler alternative?
3. **Operational feasibility check** -- Validate that the selected elements are physically and logistically feasible given venue constraints, movement constraints, schedule density, participant burden, and budget.
4. **Draft generation + compression** -- Generate the full structured draft, then compress: remove redundant explanations, excessive formality, decorative content, and elements that failed the necessity or feasibility gates. The result must read as an approval-ready operational document, not a ceremonial proposal.
5. **Repeatability and sustainability validation** -- Post-generation gate: can this plan be repeated next cycle with proportional cost and effort? Does it fit the institution's approval patterns? Unsustainable one-off structures must be flagged.

### Organizational Culture and Decision-Maker Parameters

Event planning parameters are classified into three layers with explicit override semantics:

- **Hard constraints**: budget ceiling, date, mandatory attendees, regulatory or policy requirements, venue capacity. These cannot be overridden by preference.
- **Soft preferences**: atmosphere (formal vs relaxed), program density, meal style, free-time ratio. These can be adjusted within hard constraint boundaries.
- **Derived constraints**: constraints that emerge from the combination of hard constraints and venue/logistics reality (e.g., venue type limits meal options, travel distance limits schedule density).

Parameter override chain: `org-culture defaults -> event-type defaults -> event-specific overrides`. Each layer can narrow but not contradict the layer above.

Key parameter profiles to capture:

- **Institution culture profile**: formality level, approval conservatism, typical event patterns, organizational hierarchy sensitivity.
- **Decision-maker preference profile**: the approver's known preferences for length, style, expenditure comfort, attitude toward education components, tolerance for informal elements.
- **Formality level**: determines document tone, program structure rigidity, and the boundary between formal ceremony and operational convenience.

When the decision-maker's preferences conflict with participant welfare (e.g., excessive formality causing participant burden), document the tension explicitly rather than silently favoring one side.

**Stakeholder-Priority Authority Hierarchy**: In hierarchical-group events, the senior authority figure's comfort constraints (transport, accommodation, meals, atmosphere, evening program) are hard constraints processed before general participant preferences. When authority preference and participant satisfaction conflict (e.g., authority figure dislikes unstructured time but participants need recovery breaks), the system must surface the conflict for explicit human resolution rather than silently overriding either side.

### Element Composability and Necessity Validation

Operational elements (education sessions, meals, recognition ceremonies, networking time, presentations, free time, site activities, etc.) are **composable building blocks**, not fixed procedures.

For each candidate element, validate:

- **Purpose alignment**: does this element directly serve the stated event purpose?
- **Necessity gate**: if removed, would the event fail its purpose? If not, is the element justified by secondary benefits that outweigh its burden?
- **Burden assessment**: what is the participant cost (time, fatigue, attention, discomfort) of including this element?
- **Substitution check**: is there a simpler, lower-burden alternative that achieves the same purpose contribution?

Burden constraints:

- Total participant burden (physical, temporal, psychological) must remain within a level that produces positive reception and willingness to attend future events.
- Education components, when included, must be proportional to total event duration; excessive education degrades satisfaction of all subsequent elements.
- Meals are not auxiliary items but core operational elements that affect atmosphere, social interaction, schedule buffering, and overall satisfaction.

### Physical Constraint Modeling

Venue, movement, and logistics physically constrain what elements are feasible:

- **Venue constrains elements**: venue type (conference room, retreat center, outdoor space, restaurant-centered) determines which activities are possible, meal options, noise/smoke tolerance, group vs individual space, and weather contingency.
- **Movement constrains schedule**: travel time, parking, assembly points, inter-location transit, and arrival variance all consume schedule time and degrade controllability. Movement planning is an independent operational item, not a footnote.
- **Logistics constrains controllability**: preparation complexity, equipment needs, weather dependency, vendor coordination, and cleanup overhead determine whether an element can be reliably executed. An element that requires conditions the venue cannot guarantee is a feasibility failure.

When the event requires specific operational elements (e.g., barbecue is mandatory), venue selection criteria must be evaluated against those operational requirements, not aesthetic appeal.

**Mandatory-Element Operational Checklist**: When a specific operational element is declared mandatory, expand the feasibility check into a concrete operational checklist before accepting the element as viable. Each mandatory element type must derive its own feasibility checklist from venue and logistics constraints; a generic feasibility pass is insufficient.

**Personal-Vehicle Transport Modality**: When transport mode is personal vehicles, require a transport assignment data model as a first-class document section with fields for operator, capacity, assigned participants, timing, and logistics details (departure, assembly point, estimated arrival, parking). Do not treat transport logistics as a prose footnote; missing allocation data is a feasibility gap that blocks schedule reliability.

### Priority Resolution

When approved claims conflict during element selection or schedule construction:

- **Burden vs education**: if education increases participant burden beyond the sustainability threshold, reduce education scope or adjust format (shorter, lighter, integrated into social time) rather than accepting unsustainable burden. Education that degrades all downstream satisfaction is a net negative.
- **Decision-maker preference vs necessity**: decision-maker preferences shape style and emphasis but cannot override necessity validation. An element the decision-maker wants that fails the necessity gate must be flagged with explicit justification, not silently included. An element that passes the necessity gate but conflicts with decision-maker style must be adapted in form, not removed.
- **Formality vs participant comfort**: maintain the minimum formality level required by institution culture, but do not add formality that creates participant burden without proportional institutional value.
- **Repeatability vs ambition** (BP-Repeatability vs single-event optimization): prefer repeatable standard structures over ambitious one-off designs that cannot survive the next approval cycle.

> **Note:** BP- labels are biz-sys domain-local priority identifiers, not CLAUDE.md Deliverable Quality Philosophy P-numbers.

**Authority preference vs participant satisfaction**: when a senior authority figure's preference directly conflicts with a participant-satisfaction design principle (e.g., authority figure prefers fully structured time vs free-time recovery need), flag the conflict as an explicit decision point requiring human resolution. Do not silently resolve in favor of either side; document the trade-off and present options to the planning owner.

When conflicts cannot be resolved by these rules, document the conflict explicitly and escalate to the planning owner for a decision rather than silently favoring one priority.

### Repeatability and Sustainability Validation

After draft generation, validate:

- **Repeatable?** Could this plan be run again next quarter/year with similar effort and cost? If preparation requires exceptional effort that normal staff cannot sustain, flag it.
- **Proportional cost?** Is the budget proportional to the event's institutional importance and the organization's spending norms? Disproportionate expenditure reduces approval likelihood.
- **Fits approval patterns?** Does the plan match how this institution typically approves events -- conservative vs flexible, detailed justification vs brief outline, cost-breakdown required vs lump-sum acceptable?
- **Operator executable?** Can the designated organizer (often a junior staff member or student) understand and execute this plan without expert guidance? Complexity that exceeds operator capability is a sustainability failure.

Plans that fail repeatability validation must be simplified or restructured before final output.

### Hidden-Criteria Question Set

The following questions must be surfaced before generation begins. Missing answers to critical questions block generation; missing answers to secondary questions trigger explicit assumptions.

**Critical (generation-blocking):**

1. What is the primary purpose of this event? (education, cohesion, performance sharing, morale/refresh, networking, other)
2. What operational elements are considered mandatory by the requester or approver?
3. Are there decision-maker preferences or sensitivities that constrain style, formality, or specific elements?
4. What is the venue situation? (confirmed venue, venue type preference, or unconstrained)
5. What is the budget level? (specific amount, approximate range, or institutional norm reference)

**Secondary (assumption-documented if missing):**

6. What is the participant burden tolerance? (full-day acceptable, half-day preferred, minimal-commitment expected)
7. Is education/training a component? If so, what proportion of total time?
8. What is the movement/transportation situation? (institutional transport, personal vehicles, walking distance, mixed)
9. What is the meal expectation? (formal dining, casual group meal, self-organized, catered on-site)
10. What is the formality level? (official institutional event, semi-formal, casual operational)
11. What is the balance between structured program and free time?
12. Are there weather or seasonal constraints affecting outdoor elements?
13. Is this event expected to be repeatable in future cycles?

### Overlap Discipline Note

- Domain-specific exception: `edu-spec` owns pedagogical design when education is a component; biz-sys governs only education's weight and necessity within the event workflow, not its instructional design.

## R&D Proposal Domain Rules

When the active task involves automated generation of R&D proposals against external announcements or RFPs, apply the following domain-specific business rules in addition to the general workflow rules above.

### Announcement-as-Business-Rule-Source

When a proposal targets an external announcement or RFP, the business packet must decompose the source document into three distinct requirement classes: **explicit requirements** (stated evaluation criteria, mandatory sections, format rules), **implicit requirements** (unstated expectations inferable from announcement structure, issuing body norms, and domain conventions), and **estimated evaluator intent** (what the evaluator is likely optimizing for given program goals and funding context). Mixing these classes produces proposals that satisfy the letter but miss the scoring axis.

### Organizational Strategy Parameters

For proposal-driven generation, classify organizational strategy inputs as mandatory pre-generation parameters, not optional context. Required fields: **purpose** (why the org pursues this call), **focus item** (the specific technology, product, or capability being proposed), **emphasis axis** (the persuasion angle -- novelty, feasibility, market impact, policy alignment, etc.), and **roadmap position** (where this proposal sits in the org's multi-year plan). Development subject and persuasion axis must be captured as separate fields; conflating them produces proposals that describe work without arguing for it.

### Fact vs Design Boundary (Proposal)

Current holdings -- verified results, published metrics, granted patents, customer deployments, partnership agreements -- are **fact-class** and must not be generated or inflated without evidence. Future plans -- development stages, review milestones, persuasion structure, expected effects, market projections -- are **design-class** and may be generated within rational bounds. The business packet must tag each claim's class so downstream generators do not fabricate accomplishments or hedge real ones.

### Proposal Generation State Machine

For document generation pipeline architecture, refer to doc-auto reference.md and sw-spec reference.md § Constraint-Satisfaction Document Generator Architecture Extension. biz-sys owns the business rules and state machine for the proposal domain.

Proposal generation follows a strict dependency chain. Do not skip or reorder stages: **announcement interpretation** (decompose requirements per Announcement-as-Business-Rule-Source) -> **benchmark analysis** (prior art, competitor landscape, evaluation trend) -> **org background capture** (current holdings, team composition, infrastructure) -> **strategy axis determination** (lock purpose, focus, emphasis, roadmap position) -> **narrative structure design** (problem -> goal -> method -> effect dependency chain) -> **draft generation** -> **visualization integration** (figures, tables, diagrams that carry argument weight) -> **compression** (remove redundancy, trim decorative content, tighten to page/word limits). The narrative dependency chain `problem -> goal -> method -> effect` is load-bearing: each stage must logically necessitate the next.

### Document-Type Writing Stance

Proposals must use **plan-oriented, execution-specific language**: "will develop," "targets X metric by Y milestone," "applies method Z to achieve W." Completion-oriented assertions ("has achieved," "is proven," "was demonstrated") are invalid unless backed by fact-class evidence per the Fact vs Design Boundary rule. Mixing tenses or claiming future certainty as past accomplishment is a business-rule violation that undermines evaluator trust.

## Result Report Domain Rules

When the active task involves automated generation of R&D result reports (completion reports, final reports against a prior proposal or plan), apply the following domain-specific business rules in addition to the general workflow rules and R&D Proposal Domain Rules above.

### Plan-to-Report State Machine

For document generation pipeline architecture, refer to doc-auto reference.md. biz-sys owns the business rules and generation levels for the result report domain.

Result report generation follows a strict state sequence: **input capture** (proposal/plan + optional result references + template) -> **gap analysis** (compare available evidence against report sections) -> **adaptive content generation** (per Adaptive Generation Level) -> **text-first draft** -> **visualization review** (audit reference images, identify gaps) -> **visualization integration** (place reference images, generate conceptual diagrams for gaps) -> **compression/volume adjustment** (fit to page-count constraint) -> **template conformance check**. Page count is a hard output constraint equivalent to budget ceiling in event planning; exceeding it is a format violation, not a style choice.

### Adaptive Generation Level Rules

Automatically assess input richness and select generation level -- this is not a user toggle. **L1 (rich plan)**: when the source plan/proposal contains detailed methods, milestones, and technical specifics, summarize and reorganize into completion-oriented narrative without inventing content. **L2 (standard, default)**: when the source provides standard project structure but lacks execution detail, generate domain-standard process narrative (development steps, verification activities, iteration cycles) consistent with the project's technical domain. **L3 (sparse)**: when only a title, abstract, or skeleton exists, perform expert-level gap-filling by inferring plausible development process from domain knowledge, stated objectives, and deliverable type. Each level defines what the generator may infer; higher levels permit wider inference but never permit fabricated outcomes.

### Result Report Fact Fabrication Boundary

**Prohibited fabrication**: specific performance metrics, quantitative experiment results, test measurements, benchmark numbers, result images or screenshots that imply real system output. **Permitted generation**: development process narrative (per L1-L3 level), conceptual/explanatory diagrams, expected effects grounded in market context and technical rationale. The boundary is: process can be inferred from plan and domain knowledge; outcomes and measurements cannot. Any generated content that a reader could mistake for empirical evidence must be explicitly marked as projected or illustrative.

### Expected Effects Market Context

Expected effects sections must incorporate industry applicability, market scalability, and business significance -- not generic boilerplate ("will contribute to the field"). Ground expected effects in the project's specific technology domain, identifiable market segments, quantifiable adoption scenarios where possible, and competitive or regulatory landscape. Effects that cannot be tied to at least one concrete market or operational context are insufficiently specified and must be strengthened before the section passes review.

### Visualization Mandatory

A result report without visualizations is an incomplete business deliverable. Apply a two-source strategy: **reference images first** (use any result screenshots, system captures, or data visualizations provided in input materials), then **generated conceptual diagrams** for sections where no reference image exists but visual explanation would materially aid comprehension (system architecture, process flow, comparison frameworks). Visualization is not decorative; each figure must carry argument weight or clarify structure that prose alone handles poorly.

### Result Report Writing Stance

Result reports use a **mixed stance** distinct from proposal writing. **Body/process sections**: factual-report tone with completion-oriented language ("developed," "implemented," "verified," "constructed") -- asserting accomplished work, not future plans. **Effects/significance sections**: persuasive-emphasis tone arguing for the value and impact of completed work, using forward-looking language grounded in achieved capabilities. Do not apply proposal stance ("will develop," "targets X") to describe work that the report claims is finished. The stance boundary aligns with the Fact Fabrication Boundary: completed process uses assertion language; projected impact uses qualified persuasion.

## Schedule Planning Domain Rules

When the active task involves automated generation or validation of operational schedules (event timelines, team activity schedules, institutional program schedules), apply the following domain-specific business rules in addition to the general workflow rules above.

### Schedule-as-Execution-Control

Classify schedule purpose before generation: **operations-execution** (owner tracks tasks, status, dependencies), **participant-announcement** (attendee sees time, location, preparation), or **approval-submission** (decision-maker reviews feasibility, cost, risk). Purpose determines field density, required columns, tone, and output format. A schedule that mixes all three audiences into one surface is a defect, not a convenience.

### Hidden-Time Mandatory Constraint

Schedules must account for time categories invisible in naive timelines: **transit** (inter-location movement), **setup/teardown** (room prep, equipment, AV), **distribution** (material handout, registration), **entry/assembly** (gathering, seating, roll call), **equipment** (deployment, testing, removal), **approval-wait** (sign-off lead time), **response-wait** (vendor or participant confirmation), **cleanup** (post-event restoration). Omitting any applicable hidden-time category is a feasibility failure equivalent to ignoring a budget line item.

### Buffer-as-Mandatory-Constraint

Buffers are not optional padding; they are mandatory constraints at identified risk zones: **post-transit** (arrival variance absorption), **pre-transition** (activity changeover), **post-meal** (return and settle), **multi-person movement** (group assembly lag), **external-variable** (weather, vendor delay, equipment failure). Strategy selection -- distributed small buffers vs terminal large buffer -- must match the schedule's change-resilience requirement. Unbuffered risk zones are schedule defects.

### Audience-Version Separation

Every schedule deliverable requires minimum two versions: an **operations version** (includes owner, status, approval gates, location detail, prerequisites, contingency notes) and an **announcement version** (includes time, location, participant preparation items only). Merging both into a single document is a defect -- operations detail overwhelms participants, and announcement brevity leaves operators without execution control.

### Parallel Resource Conflict Detection

Before finalizing any schedule, validate against three conflict classes: **person duplication** (same individual assigned to overlapping time blocks), **equipment/venue collision** (same resource double-booked), **approval-prerequisite timing** (activity scheduled before its prerequisite approval or deliverable is available). Any unresolved conflict is a blocking defect.

### Fatigue and Concentration Rhythm

Schedule arrangement must respect cognitive and physical rhythm patterns: **early-morning peak** (high-concentration tasks), **post-lunch dip** (avoid demanding cognitive work 13:00-14:30), **post-transit recovery** (light activity after significant movement), **long-session fatigue** (break or format change required after 90-minute continuous blocks). Ignoring rhythm patterns produces schedules that are technically feasible but operationally degraded.

### Schedule Quality Gate

A schedule passes only when it satisfies four criteria simultaneously: **executable** (every block has sufficient time, resources, and prerequisites met), **unambiguous** (no block requires interpretation of who, where, or what), **change-resilient** (buffer strategy absorbs single-point delays without cascade), **hidden-time-complete** (all applicable hidden-time categories are accounted for). Failing any criterion blocks the schedule from final output.

### Schedule Auto-Writing State Machine

Schedule generation follows a strict dependency chain: **purpose classification** -> **audience identification** -> **constraint capture** (hard time boundaries, venue, personnel, equipment) -> **element arrangement** (sequencing with hidden-time and rhythm rules) -> **feasibility validation** (conflict detection, buffer adequacy) -> **version separation** (operations vs announcement) -> **compression** (remove redundant notes, tighten to required format). Validation gates take priority over generation speed; a fast but infeasible schedule is worse than a slow correct one.

### Change Management

Scale change-management overhead by schedule complexity. **Simple schedules** (single-day, few elements): ensure the final distributed version is unambiguously the latest, with clear date stamp. **Complex schedules** (multi-day, many stakeholders, iterative revisions): require version numbering, revision timestamps, modifier identity, change reason, and impact trace showing which downstream blocks were affected by each change.

### Tool and Format Selection

Select schedule format by comprehension speed for the target audience, not by convention or tool familiarity: **table** (dense parallel tracks, resource allocation), **timeline** (sequential flow, duration visibility), **Gantt** (dependency chains, critical path), **checklist** (execution verification, status tracking). Authoring tool and distribution format may differ -- a Gantt authored in project software may distribute as a simplified table or timeline for participants.

## Research Report Domain Rules

When the active task involves automated generation of research reports, technology survey reports, or patent landscape analyses, apply the following domain-specific business rules in addition to the general workflow rules above.

### Research Report State Machine

Research report generation follows a strict state sequence. Do not skip or reorder stages.

1. **Question lock** -- Fix the decision question, primary reader, and supported judgment before any source collection begins. A report without a locked question is a scope failure.
2. **Search strategy design** -- Decompose the question into independent concept axes, expand each axis with synonyms and domain terms, and produce per-source-type query plans (academic DB, patent DB, market/industry, standards). An unstructured keyword-only search is a strategy defect.
3. **Systematic search execution** -- Execute queries per the strategy; log database, date range, query string, and hit count for each run. Undocumented searches block audit trail completeness.
4. **Inclusion/exclusion filtering** -- Apply predefined gates (relevance, date, quality, language, duplication) and record accept/reject decisions with reasons. Missing gate logic is a methodology defect.
5. **Cross-source analysis** -- Synthesize findings across source families (papers, patents, market, standards) on the locked judgment axis rather than summarizing each family in isolation. Siloed summaries without cross-synthesis are a structural defect.
6. **Resequence for reader** -- Rebuild the analysis in reader decision order (answer first, supporting synthesis, uncertainty, trace) rather than mirroring the research chronology.
7. **Layered output generation** -- Produce decision summary, judgment-driving analysis body, evidence detail, and update-ready trace/appendix as distinct layers. A single-density report without layering is a structure defect.
8. **Compression** -- Remove redundancy, route appendix-grade material out of the body, and fit to volume targets without dropping traceability or uncertainty disclosure.

### Systematic Research Methodology Rules

- Anchor the methodology to an established framework: PRISMA-derived for literature surveys, Cochrane-derived for systematic reviews, WIPO-derived for patent landscape studies. Declare the framework before prose fill begins.
- For patent analysis, require structured search dimensions: CPC/IPC classification codes, key applicant filtering, patent-family grouping, legal-status filtering (active/expired/pending), and filing-date windowing. A patent section without these dimensions is a shallow-analysis defect.
- Define inclusion/exclusion criteria as explicit gates with binary or scored thresholds. Criteria must cover relevance, publication date range, source quality tier, language, and deduplication. Implicit or unstated filtering is a methodology gap.

### Multi-Source Evidence Classification

- Classify each cited paper by epistemic role: **foundational** (establishes core theory or method), **review/survey** (synthesizes existing knowledge), **critical/rebuttal** (challenges or limits prior claims), **application/case** (demonstrates real-world use). Maintain balance across roles; reliance on a single character class is a literature-character defect.
- Classify patent intelligence across five dimensions: technology classification, applicant landscape, temporal filing trends, geographic distribution, and legal status. A patent section covering fewer than three dimensions is shallow.
- Cross-source triangulation: when paper claims, patent filings, and market/product signals address the same sub-question, require explicit agreement/conflict/gap annotation. Unacknowledged cross-source contradiction is a synthesis defect.
- Track claim-evidence-uncertainty linkage: each substantive claim must cite its evidence source(s) and carry an uncertainty tag (confirmed, supported, inferred, unconfirmed, conflicting). Claims without tags are untracked.

### Audit Trail Requirement

- Maintain search logs: database, query string, date executed, result count, and filters applied per search run.
- Maintain source logs: each included source must carry citation, source family, epistemic role or patent dimension, and inclusion reason.
- Maintain inclusion/exclusion records: rejected sources must carry rejection reason traceable to a predefined gate.
- Maintain claim-evidence linkage: each body-section claim must map to one or more sources with strength tag. Unlinkable claims are audit failures.

### Uncertainty Reporting

- Every research report must include an explicit uncertainty disclosure section or integrated uncertainty markers throughout the body.
- Use evidence-strength indicators: **confirmed** (multiple independent sources agree), **supported** (credible evidence exists but limited), **inferred** (logically derived from available evidence), **unconfirmed** (plausible but without direct evidence), **conflicting** (sources disagree with no resolution).
- These evidence-strength indicators are the canonical cross-lane taxonomy from `CLAUDE.md`; do not invent a parallel confidence vocabulary for the same claim surface.
- When sources conflict on a material claim, present both positions with their evidence bases rather than silently choosing one side.
- Areas where the search strategy could not achieve adequate coverage must be disclosed as known gaps rather than omitted.
