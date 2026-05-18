---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/mockup-to-component/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# Reference Material
## Step 1 — HTML Structure Example
```html
<header data-component="Header">
  <nav data-component="Navigation">...</nav>
</header>
<section data-component="Hero">
  <h1 data-slot="title">...</h1>
  <button data-component="Button" data-variant="primary">...</button>
</section>
```
## Step 2 — CSS Structure Example
```
styles/base/variables.css      ← CSS custom properties → design tokens (see: design-system-tokens skill)
styles/components/button.css   ← one file per component
styles/pages/home.css
```
## Step 3 — Component Mapping Table Example
| Mockup File | Component (e.g., .tsx / .vue) | Props |
|---|---|---|
| `components/button.html` | `ui/Button` | variant, size, disabled |
| `components/card.html` | `ui/Card` | title, description, image |
| `components/header.html` | `layout/Header` | user, navigation |
## Step 4 — Data and Interface Examples
```json
// data/hero.json
{ "title": "...", "description": "...", "cta": { "label": "Go", "href": "/" }, "image": "/hero.png" }
```
```typescript
interface HeroProps { title: string; description: string; cta: { label: string; href: string }; image: string; }
```
## Transition Example
```html
<!-- mockup: feature-card.html -->
<div data-component="FeatureCard">
  <div data-slot="icon">🚀</div>
  <h3 data-slot="title">Fast Speed</h3>
  <p data-slot="description">Optimized performance.</p>
</div>
```
```tsx
// e.g., Next.js/React: components/FeatureCard.tsx
interface FeatureCardProps { icon: string; title: string; description: string; }
export function FeatureCard({ icon, title, description }: FeatureCardProps) {
  return <div className="feature-card"><span>{icon}</span><h3>{title}</h3><p>{description}</p></div>;
}
```
## UI/UX Trend Research
These sources, tools, and trend labels are examples.
Current-practice authority requires current evidence.
When tool choice, current UI practice, licensing, accessibility, or production adoption is material, ground the choice in current evidence, benchmark research, official docs, or an `external-tool-bridge` path before treating it as a recommendation.
**Reference Sources**: Dribbble (trends/palettes), Awwwards (web), Mobbin (mobile patterns), Godly (landing pages)
**Quick Tools**: v0.dev (AI UI generation), Tailwind UI (components), Coolors (palette), Heroicons / Lucide (icons)
**Pre-Mockup Checklist**:
- [ ] Benchmark basis recorded through `benchmark-simulation` when external comparison is material; otherwise cite supplied mockup/reference or `not-material:<basis>`
- [ ] Color palette decided (Primary / Secondary / Accent)
- [ ] Typography selected (Heading / Body fonts)
- [ ] Layout pattern chosen (Bento Grid, standard grid, etc.)
**Trend Reference Examples** (apply selectively with current evidence): Bento Grid, Glassmorphism, Dark Mode First, Skeleton Loading.
**Accessibility Baseline** (not selective): WCAG 2.1 applies to every operator-facing UI deliverable; ground compliance in current evidence per the line above.
## JSON Data Simulation
JSON mock files serve dual purpose: power dynamic content in the HTML mockup and define the API schema contract for backend implementation.
```javascript
// scripts/app.js
const products = await fetch('./data/products.json').then(r => r.json());
```
```json
// data/products.json → API schema bridge
{ "data": [{ "id": 1, "name": "...", "price": 10000, "image": "..." }], "pagination": { "page": 1, "limit": 10, "total": 50 } }
```

## Resolve Next Owner And Action
- Return mockup structure, component boundaries, data schema, and production-evidence gaps to the active mockup-to-component workflow.
- If current UI practice, licensing, accessibility, or backend contract affects implementation, refresh evidence or route the gap before conversion continues.
