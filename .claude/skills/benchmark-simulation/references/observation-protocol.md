---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Multi-Modal Observation Protocol
For every external reference inspected during benchmarking, capture evidence per modality. Use what the source supplies and record `not-observed` for modalities not applicable.

## Text-Document Modality
- design rationale (the WHY explained by the source)
- principle articulation (the rule the source applies)
- user-research evidence (cited usability findings, A/B results, observational studies)
- anti-pattern callouts (the source's "what not to do" list)
- glossary: name each pattern with stable terminology to enable cross-reference

## Image / Screenshot Modality
- full-layout capture: entire screen / page / component
- isolated component capture: hero, navigation, table, form, chart, modal
- before/after pairs when iteration is documented
- density-state captures: empty, sparse, typical, dense, overflow
- viewport variants: desktop, tablet, mobile when responsive design is in scope
- per captured image: source URL, capture date, claimed pattern name

## Quantitative Measurement Modality
- font-size ratio: heading-1 vs heading-2 vs body, primary-action vs secondary-action
- image-to-text ratio: pixel area of visual elements vs text area per region
- whitespace ratio: padding / margin allocation vs content area
- color count: distinct hues used per surface (signal vs noise)
- grid module count: column system, gutter, baseline grid
- action-density-per-region: interactive controls per visual area
- record numerically; vague observations ("feels balanced") must be backed by measurement

## Structural Form Modality
- table: column count, header treatment, row alignment, separator weight, hover/selection state
- grid: column system (12 / 8 / 16 / fluid), gutter pattern, breakpoint count
- navigation: top-bar / side-rail / hamburger / breadcrumb / tab; depth limit; current-state cue
- form-flow: input order, validation timing, default-value strategy, multi-step progress cue
- hierarchy: visual weight gradient (color, size, position, density)

## Color, Spacing, Typography Modality
- color semantic mapping: alert (red / amber spectrum), success (green spectrum), neutral, brand
- spacing rhythm: base unit (4 / 8 / 12 / 16 px), allowed multiples
- typographic scale: ratio (1.125 / 1.25 / 1.333 / 1.5 / golden), weight progression
- contrast ratio: text-on-background, control-on-surface (accessibility floor)

## Interactive / Behavioral Modality
- animation: easing, duration, motion language
- transition: state-change visualization (loading, success, error)
- micro-interaction: hover, focus, active, drag
- when source is static, document inferred motion from documented behavior or demo videos when available

A reference observation is incomplete if it documents only one modality on a multi-modal decision. Re-open observation with the missing modalities before downstream synthesis.

## Image-Aware Evidence Handling
`WebFetch` and `WebSearch` may return image references, screenshots, or visual content. Multi-modal observation requires inspecting these, not skipping them.

Required image-handling rules:
- when a reference URL is known to contain visual evidence, use `WebFetch` and parse for image references
- when `WebFetch` returns image links, follow up with image-content fetch when the host permits, OR document the URL plus claimed pattern for downstream visual inspection
- when the user-facing image cannot be retrieved, record as `image-evidence-blocked` and downgrade confidence accordingly
- image evidence must be cited with: source URL, image URL or selector, capture date, claimed pattern name

Quantitative observation from images:
- font ratios: estimate by visual comparison when measurement tooling is unavailable; record as `estimated-ratio` not `measured-ratio`
- color: name the hue with stable vocabulary when palette is not explicitly documented
- whitespace: estimate as `tight / balanced / generous` when measurement is unavailable
- when available, prefer cited specs from design system docs over visual estimation

Subjective observation discipline: "feels clean", "looks professional", and "appears balanced" are valid first impressions, not acceptable evidence. Subjective observations must be backed by measurable criteria before they enter synthesis.
