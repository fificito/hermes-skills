# Article Illustrator Workflow

Adapted from baoyu-article-illustrator.

## When to Use
Trigger this skill when the user asks to illustrate an article, add images to an article, generate illustrations for content, or uses phrases like \"为文章配图\", \"illustrate article\", or \"add images\".

## Three Dimensions
- **Type**: infographic, scene, flowchart, comparison, framework, timeline
- **Style**: notion, warm, minimal, blueprint, watercolor, elegant
- **Palette**: macaron, warm, neon

## Workflow
1. **Detect Reference Images**: Use `vision_analyze` to extract traits.
2. **Analyze**: Read source and write to `analysis.md`.
3. **Confirm Settings**: Use `clarify` for Preset/Type, Density, Style, Palette, Language.
4. **Generate Outline**: Save to `outline.md`.
5. **Generate Prompts**: Save to `prompts/NN-type-slug.md` before generation.
6. **Generate Images**: `image_generate` $\rightarrow$ `curl` download to absolute path.
7. **Finalize**: Insert `![description](path)` into article.

## Pitfalls
- Visualize concepts, not metaphors.
- Data integrity is paramount.
- Strip secrets.
- Prompt files are mandatory.
