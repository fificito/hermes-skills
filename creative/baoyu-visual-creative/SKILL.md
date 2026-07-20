---
name: baoyu-visual-creative
description: "Unified suite for Baoyu's visual generation including Article Illustrations, Knowledge Comics, and Infographics."
version: 1.0.0
author: 宝玉 (JimLiu) / Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [creative, image-generation, baoyu, visual-content]
---

# Baoyu Visual Creative Suite

A unified library for generating consistent, high-quality visual content including article illustrations, educational comics, and data-rich infographics.

## When to Use

Use this skill when the user asks to visualize content, create a visual summary, or generate educational imagery. This suite encompasses three primary workflows:

1. **Article Illustration**: Adding consistent imagery to an existing article.
2. **Knowledge Comics**: Creating narrative-driven educational comics.
3. **Infographics**: Creating high-density visual summaries of data or concepts.

---

## 1. Article Illustrator
*Consistent images for articles using Type × Style × Palette.*

### Core Logic
- **Dimensions**: Type (infographic, scene, etc.) × Style (minimal, watercolor, etc.) × Palette (macaron, neon, etc.).
- **Constraint**: Prompt files are mandatory before generation.
- **Workflow**: Analyze Content $\rightarrow$ Confirm Settings $\rightarrow$ Generate Outline $\rightarrow$ Write Prompts $\rightarrow$ Generate & Download Images $\rightarrow$ Insert into Article.
- **Key Detail**: Visualize concepts, not literal metaphors.

### Implementation Notes
- See `references/article-illustrator-workflow.md` for the full step-by-step guide.
- Use `image_generate` and download via `curl` using absolute paths.

---

## 2. Knowledge Comic Creator
*Educational, biography, or tutorial comics with character consistency.*

### Core Logic
- **Dimensions**: Art Style (manga, ligne-claire, etc.) × Tone (dramatic, warm, etc.) × Layout (cinematic, webtoon, etc.).
- **Character Consistency**: Driven by detailed text descriptions in `characters/characters.md`, embedded into every page prompt.
- **Workflow**: Analyze $\rightarrow$ Confirm Style $\rightarrow$ Storyboard & Characters $\rightarrow$ Write Prompts $\rightarrow$ Generate & Download Images.

### Implementation Notes
- **Reference Images**: Used for trait extraction (text), not as direct model inputs.
- **Download Rule**: Always use absolute paths for `curl -o` to avoid CWD drift.
- See `references/comic-workflow.md` for detailed panel and character logic.

---

## 3. Infographic Generator
*High-density information graphics: 21 layouts × 21 styles.*

### Core Logic
- **Dimensions**: Layout (bento-grid, iceberg, etc.) × Style (claymation, cyberpunk, etc.).
- **Data Integrity**: Absolute fidelity to source statistics; no paraphrasing of numbers.
- **Workflow**: Analyze $\rightarrow$ Structure Content $\rightarrow$ Recommend Combo $\rightarrow$ Confirm $\rightarrow$ Generate Prompt $\rightarrow$ Generate Image.

### Implementation Notes
- **Keyword Shortcuts**: Use predefined mappings for terms like \"high-density-info\" to auto-select `dense-modules` layout.
- See `references/infographic-workflow.md` for layout and style galleries.

---

## Shared Technical Constraints (Critical)

1. **Image Generation**: `image_generate` returns a URL. You MUST use `terminal` (`curl`) to download the image to a local absolute path before inserting it into documents.
2. **Aspect Ratios**: Map custom ratios to the nearest `image_generate` enum: `landscape`, `portrait`, or `square`.
3. **Security**: Scan all source content and strip secrets/API keys before writing any output file to disk.
4. **Reproducibility**: Always write the final prompt to a `.md` file before calling the generator.

## References
- `references/article-illustrator-workflow.md`
- `references/comic-workflow.md`
- `references/infographic-workflow.md`
