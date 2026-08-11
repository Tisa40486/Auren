# Design System

## Name

**Auren** — from the Latin *Aurum* ("gold"). Reflects a premium, refined identity while staying short and memorable.

## Theme

**Luxury finance**, inspired by Swiss private banking, wealth management platforms, and minimalist editorial design.

## Color palette

| Element | Color |
|---|---|
| Background | `#0A0A0B` |
| Surface / Cards | `#131315` |
| Border | `#232326` |
| Primary text | `#EDEBE6` |
| Secondary text | `#8A867D` |
| Gold accent | `#C9A667` |
| Bronze accent | `#B8946A` |
| Positive (income) | `#6B9080` |
| Negative (expense) | `#A8564F` |

Only **one** accent color (gold) is used across the app, kept sparse to preserve its premium feel.

## Typography

| Use | Font |
|---|---|
| Brand & headings | Fraunces |
| Body / interface | Inter |
| Numbers & currency | IBM Plex Mono (tabular figures) |

## UI Components

```text
AUButton
AUCard
AUInput
AUText
AUAmount
AUBadge
AUSection
AUChart
AUNavigationBar
```

## Visual language

- Minimal density, generous whitespace
- Ultra-thin borders (0.5–1px), max 4px corner radius
- No heavy shadows, flat surfaces
- Icons: 1px thin stroke (Phosphor Thin style)
- Financial values right-aligned, tabular formatting

## Design principles

- **Minimalism** — clean interfaces, generous whitespace
- **Modularity** — every feature independent and scalable
- **Maintainability** — architecture built to scale past 100k+ lines without major refactor
- Luxury through restraint, not excess — no saturated colors, no unnecessary decoration