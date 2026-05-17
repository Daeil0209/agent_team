---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "domain-rule-catalog.md routed Event Planning Domain Rules"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# Event Planning Workflow Rules

## Contents
- Purpose
- Authority Boundary
- Business-Rule Checkpoints
- Organizational Parameters
- Element Necessity
- Physical Constraints
- Priority Resolution
- Repeatability And Sustainability
- Hidden-Criteria Question Set
- Overlap Discipline
- Resolve Next Owner And Action

## Purpose
Use this reference for automated event-planning document generation, institutional events, team retreats, and operational gatherings.

## Authority Boundary
business-workflow owns purpose definition, feasibility criteria, element necessity validation, constraint modeling, and priority resolution rules.
document-automation owns document-generation pipeline stages, structure, formatting, compression, and template conformance.
software-architecture owns constraint-satisfaction generator architecture when a generation pipeline is implemented.

## Business-Rule Checkpoints
For event-planning document generation stages, use `.claude/skills/document-automation/references/event-planning-document.md` `Generation Stage Sequence`.
For generator architecture, use `.claude/skills/software-architecture/references/architecture-extensions.md` `Constraint-Satisfaction Document Generator Architecture Extension`.
business-workflow owns the business rules and domain constraints consumed by document-generation stages.
Event planning business-rule checkpoints are hidden-criteria elicitation, purpose definition and constraint capture, element selection and necessity validation, operational feasibility check, and repeatability and sustainability validation.
These checkpoints gate generation while document-automation remains the generation-stage owner.
Hidden-criteria elicitation surfaces hidden review criteria through the Hidden-Criteria Question Set before generation begins.
Critical hidden inputs must be captured before generation when omission would cause data loss, authority conflict, or unsafe delivery.
Purpose definition establishes why the event exists, what outcome is required, and who the audience is before selecting any operational element.
Element selection uses the event element model in `## Element Necessity`.
Each selected element must pass the necessity gate.
Operational feasibility validates venue constraints, movement constraints, schedule density, participant burden, and budget.
Document-generation compression belongs to document-automation; business-workflow supplies the rejection basis for elements that failed necessity or feasibility gates.
Repeatability validation checks whether the plan can be repeated next cycle with proportional cost and effort.

## Organizational Parameters
Event planning parameters have three layers.
Hard constraints include budget ceiling, date, mandatory attendees, regulatory requirements, policy requirements, and venue capacity.
Soft preferences include atmosphere, program density, meal style, and free-time ratio.
Derived constraints emerge from hard constraints plus venue and logistics reality.
Parameter override chain is `org-culture defaults -> event-type defaults -> event-specific overrides`.
Each layer can narrow the layer above.
Each layer preserves the constraints above it.
Institution culture profile records formality level, approval conservatism, typical event patterns, and hierarchy sensitivity.
Decision-maker preference profile records preferences for length, style, expenditure comfort, education components, and informal elements.
Formality level governs document tone, program rigidity, and the boundary between formal ceremony and operational convenience.
Decision-maker preference conflicts with participant welfare become explicit decision points.
Senior authority comfort constraints are processed before general participant preferences in hierarchical-group events.
Authority preference and participant satisfaction conflicts become explicit human-resolution points.

## Element Necessity
Operational elements are composable building blocks.
Element model examples include education or training, meals or catering, recognition or awards, networking or social time, free time or rest, site tours, presentations, Q&A, logistics or transport, opening or closing ceremonies, team activities, guest speakers, and breakout sessions.
Purpose alignment checks whether the element directly serves the stated event purpose.
Necessity gate checks whether removal would make the event fail its purpose.
Secondary benefits must outweigh burden when an element is not strictly necessary.
Burden assessment records participant cost in time, fatigue, attention, and discomfort.
Substitution check identifies a simpler lower-burden alternative when one can achieve the same purpose contribution.
Total participant burden must remain compatible with positive reception and willingness to attend future events.
Education components must be proportional to total event duration.
Meals are core operational elements that affect atmosphere, social interaction, schedule buffering, and overall satisfaction.

## Physical Constraints
Venue type determines feasible activities, meal options, noise tolerance, group space, individual space, and weather contingency.
Travel time, parking, assembly points, inter-location transit, and arrival variance consume schedule time.
Movement planning is an independent operational item.
Preparation complexity, equipment needs, weather dependency, vendor coordination, and cleanup overhead determine controllability.
A mandatory operational element opens a concrete feasibility checklist before the element is accepted as viable.
Personal-vehicle transport requires a transport assignment data model.
Transport assignment fields include operator, capacity, assigned participants, departure, assembly point, estimated arrival, parking, and logistics details.

## Priority Resolution
Education scope is reduced or reformatted when education burden exceeds sustainability threshold.
Decision-maker preferences shape style and emphasis.
Decision-maker preferences do not override necessity validation.
An element requested by a decision-maker that fails necessity validation becomes an explicit justification point.
An element that passes necessity validation but conflicts with decision-maker style is adapted in form.
Minimum required formality is preserved.
Added formality must produce proportional institutional value.
Repeatable standard structures are preferred over ambitious one-off designs that cannot survive the next approval cycle.
Unresolved conflicts open `team-lead` planning decision.

## Repeatability And Sustainability
Repeatability checks whether the plan can run again next quarter or year with similar effort and cost.
Preparation effort must fit normal staff capacity.
Budget must be proportional to institutional importance and organizational spending norms.
The plan must match the institution's approval pattern.
The designated organizer must be able to execute the plan without expert assistance.
Plans that fail repeatability validation must be simplified or restructured before final output.

## Hidden-Criteria Question Set
Critical questions block generation only when the non-derivable gap would cause data loss, authority conflict, or unsafe delivery.
Secondary missing answers become explicit assumptions.
Critical questions:
1. What is the primary purpose of this event?
2. What operational elements are mandatory?
3. What decision-maker preferences or sensitivities constrain style, formality, or elements?
4. What is the venue situation?
5. What is the budget level?
Secondary questions:
1. What is the participant burden tolerance?
2. Is education or training a component?
3. What is the movement or transportation situation?
4. What is the meal expectation?
5. What is the formality level?
6. What is the balance between structured program and free time?
7. Are weather or seasonal constraints material?
8. Is this event expected to be repeatable?

## Overlap Discipline
instructional-design owns pedagogical design when education is a component.
business-workflow owns education weight and necessity within the event workflow.

## Resolve Next Owner And Action
- Complete event rule packet opens document-automation or software-architecture when those owners are needed.
- Missing critical event criteria opens blocker-clear or explicit assumption only under the Hidden-Criteria Question Set.
- Failed feasibility, necessity, or repeatability opens event rule correction before generation continues.
