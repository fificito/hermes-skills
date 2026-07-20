# Infographic Workflow

Adapted from baoyu-infographic.

## When to Use
Trigger when user asks for an infographic, visual summary, or \"信息图\".

## Dimensions
- **Layout**: 21 options (e.g., bento-grid, iceberg, linear-progression).
- **Style**: 21 options (e.g., craft-handmade, cyberpunk-neon, technical-schematic).

## Workflow
1. **Analyze Content**: Save source and `analysis.md`.
2. **Generate Structured Content**: Create `structured-content.md` (verbatim data).
3. **Recommend Combo**: Based on data structure and tone.
4. **Confirm Options**: Use `clarify` for Combination, Aspect, Language.
5. **Generate Prompt**: Combine layout def + style def + structured content.
6. **Generate Image**: `image_generate` $\rightarrow$ `curl` download to absolute path.

## Pitfalls
- Data integrity is paramount.
- Strip secrets.
- Map custom aspect ratios to nearest `image_generate` enum.
