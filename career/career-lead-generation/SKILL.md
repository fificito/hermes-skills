---
name: career-lead-generation
description: Framework for identifying and qualifying remote contractor job leads for high-skill technical roles.
---

# Remote Job Lead Generation

This skill governs the process of acting as a career agent to find high-quality, remote technical roles. It emphasizes strict filtering for contract types and currency, and manages the known pitfalls of subagent tool hallucination during web searches.

## 🎯 Trigger Conditions
- Acting as a "career agent" or "headhunter" for a user.
- Tasked with finding daily/weekly job leads.
- Filtering for specific tech stacks (e.g., Snowflake + dbt) and payment constraints (USD/EUR Contractor).

## 🛠️ Workflow

### 1. Lead Definition & Filtering
Define the "High-Interest" criteria clearly before searching:
- **Primary Target:** Explicitly labeled 'Contract', 'Freelance', or 'Consultant' roles.
- **The Currency Exception:** Include 'Full Time' roles ONLY IF they are Remote and specify payment in a foreign currency (USD, EUR, GBP, etc.), as this usually indicates an international contractor relationship.
- **Exclusion:** Discard roles that are clearly local payroll (e.g., "Mexican Full-Time Payroll / IMSS") unless specifically requested.

### 2. Search Execution (via Delegation)
Use `delegate_task` with `web` and `browser` toolsets. 

**CRITICAL TOOLING PITFALL:** 
Subagents frequently hallucinate tools named `web_search` or `search` when they intend to use `google_search`. To prevent "invalid tool call" loops and `max_iterations` failures:
- **Explicitly Forbid:** In the `context` field, explicitly state: "DO NOT use tools named `web_search` or `search`. These do not exist."
- **Explicitly Mandate:** State: "Use ONLY `google_search` for finding leads and `browser_navigate`/`browser_get_content` for verifying details."

### 3. Qualification & Verification
A lead is only "verified" if the agent uses the `browser` toolset to confirm:
- **Recency:** Posted within the last 30 days.
- **Stack Match:** All "Core" skills are explicitly mentioned.
- **Payment/Type:** Confirmed as Contractor or International USD/EUR pay.

### 4. Reporting: The 'Daily Career Briefing'
Format the output as a professional briefing:
1. **Market Intelligence:** Summary of search queries used and general market sentiment (e.g., "High competition for X stack").
2. **Top Leads:** (3-5 roles)
   - Title, Company, Link.
   - **Match Explanation:** Specifically explain why it fits the tech stack AND the payment/contract preference.
   - **Key Requirements:** Bullet points of must-have skills.
3. **Drafts for Review:** 
   - Tailored outreach messages for the identified leads.
   - If no leads are found: Provide a "Cold Outreach" template targeting companies using the core stack.

## ⚠️ Pitfalls & Lessons
- **Hallucination Loops:** Avoid generic "Search for jobs" goals. Use strict "Search using `google_search` only" constraints.
- **False Positives:** Many "Remote" roles are "Remote within [Country]". Always verify the geographical constraint via the browser.
- **Silent Failures:** If subagents return empty content or fail, rotate the search query or simplify the constraints (e.g., search for "Snowflake" first, then filter for "dbt" manually).
