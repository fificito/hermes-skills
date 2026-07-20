# Knowledge Comic Workflow

Adapted from baoyu-comic.

## When to Use
Trigger when the user asks for a knowledge/educational comic, biography comic, tutorial comic, or \"知识漫画\".

## Dimensions
- **Art**: ligne-claire, manga, realistic, ink-brush, chalk, minimalist
- **Tone**: neutral, warm, dramatic, romantic, energetic, vintage, action
- **Layout**: standard, cinematic, dense, splash, mixed, webtoon, four-panel

## Workflow
1. **Setup & Analyze**: Save source and `analysis.md`.
2. **Confirmation**: Confirm Style & Options.
3. **Generate Storyboard & Characters**: Create `storyboard.md` and `characters/characters.md`.
4. **Review Outline**: (Conditional)
5. **Generate Prompts**: Embed character descriptions inline in every page prompt.
6. **Generate Images**: `image_generate` $\rightarrow$ `curl` download to absolute path.
7. **Character Sheet**: Generate `characters/characters.png` for review.

## Pitfalls
- Character consistency is driven by text descriptions, not the PNG sheet.
- Use absolute paths for `curl -o`.
- Step 2 confirmation is required.
