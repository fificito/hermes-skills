---
name: kenna-recipe-manager
description: Automates the extraction of recipes from URLs and adds them to the Kenna's Recipes static website.
---

# Kenna Recipe Manager

This skill handles the end-to-end process of turning a recipe URL into a page on the "Kenna's Recipes" website.

## Trigger
The user provides a command like: `process recipe link <URL>`

## Workflow

### 1. Data Extraction
- Use `web_search` or `terminal(curl)` to retrieve the content of the provided URL.
- Analyze the content to extract:
    - **Recipe Title**: The name of the dish.
    - **Category**: A high-level classification (e.g., Desserts, Main Course, Breakfast).
    - **Ingredients**: A clean list of all required items and quantities.
    - **Steps**: A numbered list of instructions.
- **Language Requirement**: Translate all extracted information into English, ensuring the final recipe page and index entry are entirely in English regardless of the source URL's language.

### 2. Recipe Page Creation
- **Path**: Save the page to `/data/static_site/recipes/[slug].html`.
- **Slug**: Create a URL-friendly version of the title (lowercase, hyphens instead of spaces).
- **Template**:
    - Include a "Back to Home" link at the top.
    - Use a clean layout: Title (H1) $\rightarrow$ Category (Italic) $\rightarrow$ Ingredients (List) $\rightarrow$ Instructions (Numbered List).
    - Use the existing site style or embed basic CSS for readability.

### 3. Main Page Update (`/data/static_site/index.html`)
- **Structure Transition**: If the index page is currently just a title/subtitle, transform it into a directory layout.
- **Category Management**:
    - Search for the identified **Category** header (e.g., `## Desserts`).
    - If the category exists: Append the recipe title as a link to the recipe page under that category.
    - If the category does not exist: Create a new category section with the header and the first recipe link.
- **Layout**: Maintain the "Kenna's recipes" title and "These are the recipes I use" subtitle at the top.

### 4. Deployment & Backup
- Once the local files are updated, push the changes to the GitHub repository (`fificito/kennas-recipes`).
- For a comprehensive backup of the site AND the agent's skills, follow the `hermes-state-backup` skill.
- Use `git add .`, `git commit -m "Add new recipe: [Recipe Title]"`, and `git push` to ensure the site is live.

## Pitfalls & Tips
- **Content Noise**: Recipe blogs often have long intros. Ensure only the actual recipe data is extracted.
- **URL Slugs**: Handle special characters in titles to ensure valid filenames.
- **Index Layout**: Use `patch` to insert links into the index page to avoid overwriting the entire page and losing other recipes.

## Verification
- Verify the new `.html` file exists in `/data/static_site/recipes/`.
- Verify the link appears on the main page under the correct category.
- Click the link to ensure it loads the recipe page.
