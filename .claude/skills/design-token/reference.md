# Reference Material

## Platform Implementation Tools

| Platform | Recommended Libraries | Token Method |
|----------|----------------------|--------------|
| Web (React / Next.js) | shadcn/ui, Radix UI | CSS Variables |
| Web (Vue) | Vuetify, PrimeVue | CSS Variables |
| Flutter | Material 3, Custom Theme | ThemeData constants |
| iOS (SwiftUI) | Native Components | Asset Catalog / Color Set |
| Android (Compose) | Material 3 | MaterialTheme |
| React Native | NativeBase, Tamagui | StyleSheet + Theme object |

## CSS Variables Token Definitions (Web Example)

```css
/* globals.css — Layer 1 tokens */
@layer base {
  :root {
    /* Colors (HSL channel values for Tailwind compatibility) */
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 221.2 83.2% 53.3%;
    --primary-foreground: 210 40% 98%;
    --secondary: 210 40% 96.1%;
    --destructive: 0 84.2% 60.2%;
    --muted-foreground: 215.4 16.3% 46.9%;

    /* Typography */
    --font-sans: 'Inter', system-ui, sans-serif;
    --font-mono: 'JetBrains Mono', monospace;

    /* Spacing (rem) */
    --spacing-xs: 0.25rem;   /* 4px */
    --spacing-sm: 0.5rem;    /* 8px */
    --spacing-md: 1rem;      /* 16px */
    --spacing-lg: 1.5rem;    /* 24px */
    --spacing-xl: 2rem;      /* 32px */

    /* Border Radius */
    --radius-sm: 0.25rem;
    --radius:    0.5rem;
    --radius-lg: 0.75rem;
    --radius-full: 9999px;

    /* Shadows */
    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
    --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --primary: 217.2 91.2% 59.8%;
    /* ... remaining dark overrides */
  }
}
```

## Tailwind Config Integration (Web Example)

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary:     'hsl(var(--primary))',
        secondary:   'hsl(var(--secondary))',
        destructive: 'hsl(var(--destructive))',
        background:  'hsl(var(--background))',
      },
      fontFamily: {
        sans: ['var(--font-sans)'],
        mono: ['var(--font-mono)'],
      },
      spacing: {
        xs: 'var(--spacing-xs)', sm: 'var(--spacing-sm)',
        md: 'var(--spacing-md)', lg: 'var(--spacing-lg)',
      },
      borderRadius: {
        sm: 'var(--radius-sm)', DEFAULT: 'var(--radius)',
        lg: 'var(--radius-lg)', full: 'var(--radius-full)',
      },
    },
  },
}
```

## Cross-Platform Token JSON

Define tokens once in a platform-neutral format, then convert per platform:

```json
// tokens/design-tokens.json
{
  "color": {
    "primary":     { "value": "#3B82F6" },
    "secondary":   { "value": "#64748B" },
    "destructive": { "value": "#EF4444" }
  },
  "spacing": {
    "xs": { "value": "4px" }, "sm": { "value": "8px" },
    "md": { "value": "16px" }, "lg": { "value": "24px" }
  },
  "radius": {
    "sm": { "value": "4px" }, "md": { "value": "8px" }, "lg": { "value": "12px" }
  },
  "font": {
    "family": { "value": "Inter" },
    "size": { "sm": { "value": "14px" }, "md": { "value": "16px" } }
  }
}
```

Use **Style Dictionary** (`npx style-dictionary build`) to emit platform outputs:
CSS variables (web), `.dart` constants (Flutter), `.swift` enums (iOS), `.kt` objects (Android).

## Design System Checklist

**Layer 1 — Design Tokens**
- [ ] Colors defined: Primary, Secondary, Semantic (destructive, muted, background)
- [ ] Typography: font family, size scale, weights
- [ ] Spacing scale: xs / sm / md / lg / xl
- [ ] Border radius set: sm / default / lg / full
- [ ] Shadows / elevation levels defined

**Layer 2 — Core Components**
- [ ] Button (variants: primary, secondary, outline, destructive; loading state)
- [ ] Input / TextField
- [ ] Card
- [ ] Dialog / Modal
- [ ] Avatar
- [ ] Badge

**Layer 3 — Composite Components**
- [ ] Form (with validation feedback)
- [ ] Navigation (header, sidebar, or bottom nav as relevant)
- [ ] Data display (table or list)

**Cross-Platform**
- [ ] Token JSON source-of-truth file created
- [ ] Style Dictionary or equivalent conversion configured (if multi-platform)
- [ ] Dark mode overrides verified on all target platforms
- [ ] Component catalog / usage guidelines documented
