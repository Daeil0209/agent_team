---
name: ui-mockup
description: Mockup-to-component conversion methodology with 4-step transition strategy for UI mockup conversion projects.
user-invocable: false
---

# ui-mockup Skill

## Structural Contract
- Section order: Activation → 4-Step Strategy → Transition Example → UI/UX Research → JSON Simulation → Deliverables
- PRIMARY-OWNER: developer | SECONDARY-CONSUMER: reviewer (mockup-to-component quality review)
- Complement note: extends developer lane capability; does not replace reviewer acceptance gate.

## Activation Criteria
Load this skill when a UI mockup exists and component conversion to a framework is needed.

**Backup authorization (team-lead directed):**
```
SKILL-AUTH: lane=developer:<lane-id>; surface=ui-mockup-conversion; skill=ui-mockup
```

## 4-Step Mockup → Component Strategy

### Step 1: HTML Structure in Component Units
Mark component boundaries with `data-component` and `data-slot` attributes for direct mapping to framework components.
```html
<header data-component="Header">
  <nav data-component="Navigation">...</nav>
</header>
<section data-component="Hero">
  <h1 data-slot="title">...</h1>
  <button data-component="Button" data-variant="primary">...</button>
</section>
```

### Step 2: CSS Separated by Component
Mirror the future component structure. CSS variables in `base/variables.css` serve as the design token bridge.
```
styles/base/variables.css      ← CSS custom properties → design tokens (see: design-token skill)
styles/components/button.css   ← one file per component
styles/pages/home.css
```
> Cross-reference: `variables.css` CSS custom properties become Layer 1 tokens in the `design-token` skill.

### Step 3: Component Mapping Document
| Mockup File | Component (e.g., .tsx / .vue) | Props |
|---|---|---|
| `components/button.html` | `ui/Button` | variant, size, disabled |
| `components/card.html` | `ui/Card` | title, description, image |
| `components/header.html` | `layout/Header` | user, navigation |

### Step 4: Data Structure as Props
JSON mock files define the prop contract; each JSON key maps to a typed interface field.
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

**Reference Sources**: Dribbble (trends/palettes), Awwwards (award-winning web), Mobbin (mobile patterns), Godly (landing pages)

**Quick Tools**: v0.dev (AI UI generation), Tailwind UI (components), Coolors (palette), Heroicons / Lucide (icons)

**Pre-Mockup Checklist**:
- [ ] 3+ similar services analyzed; reference screenshots collected
- [ ] Color palette decided (Primary / Secondary / Accent)
- [ ] Typography selected (Heading / Body fonts)
- [ ] Layout pattern chosen (Bento Grid, standard grid, etc.)

**2025–2026 Trend Reference** (apply selectively): Bento Grid, Glassmorphism, Dark Mode First, Skeleton Loading, WCAG 2.1.

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

## Deliverables Checklist
- [ ] HTML component units with `data-component` / `data-slot` attributes throughout
- [ ] CSS organized by component; `variables.css` defines the design token bridge
- [ ] JSON mock data files created (one file per data domain)
- [ ] Component mapping document complete (mockup file → component name → props)
- [ ] TypeScript interfaces drafted from JSON mock structure
- [ ] UI research: 3+ references collected, palette and typography decisions recorded
