---
name: career-strategy
description: "Comprehensive framework for professional growth: gap analysis, autonomous job hunting, and specialized high-tier outreach."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Career, Job-Hunting, CV, Professional-Development, Outreach, Gap-Analysis]
---

# Career Strategy Framework

This skill provides an end-to-end pipeline for professional advancement, from identifying skill gaps to executing high-impact outreach for specialized roles.

## 📊 1. Career Gap Analysis
A structured framework for evaluating a professional's background against real-time industry trends to identify "Strongholds," "Bridges," and "Gaps."

### Workflow
1. **Extract Background**: Clean markdown extraction of CV/Resume.
2. **Research Market Trends**: Use `delegate_task` to find must-have tools, architectural patterns, and high-premium skills.
3. **Mapping**: Categorize into Strongholds (direct matches), Bridges (adjacent skills), and Opportunity Gaps (critical missing skills).
4. **Tactical Plan**: Prioritize Quick Wins, Strategic Learning, and Positioning changes.

---

## 🔍 2. Autonomous Job Hunting
Searching, verifying, and reporting high-quality job opportunities based on strict professional constraints.

### Workflow
1. **Constraint Mapping**: Define Employment Type, Location, Stack, Rate/Salary, and Domain.
2. **Targeted Search**: Use precise Google search operators (e.g., `site:linkedin.com/jobs "snowflake" "contract" remote`).
3. **Verification (Critical)**: Browser-verify every lead to confirm employment type and geographic remote accessibility.
4. **Daily Briefing**: Format matches into Top Matches (all constraints pass) and Potential Leads.

*Pro Tip: Use temporary files (`/data/career_leads.txt`) for subagent handoffs to ensure 100% data retention.*

---

## 🎯 3. Specialized Career Outreach (Purple Squirrel)
A "Consultant's Pitch" approach for high-tier companies where the user has a rare intersection of domain and technical skills.

### The Strategy
- **Rare Intersection**: `[Deep Domain Expertise] + [Modern Technical Stack] = [Unique Value Proposition]`.
- **Target Plumbing Pods**: Avoid general HR/Leadership; target specific pods (e.g., `Issuing`, `Treasury`, `Core Infra`).
- **High-Impact Pitch**: 
  - Hook with the rare intersection.
  - Define the specific technical bottleneck solved.
  - Emphasize technical rigor and first principles.
  - Position contractor status as a "Force Multiplier."

*Reference: `references/stripe-strategy.md`*
