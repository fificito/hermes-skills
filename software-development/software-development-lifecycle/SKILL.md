---
name: software-development-lifecycle
description: "The unified framework for autonomous software development: from exploration and planning to implementation, debugging, and verification."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [sdlc, planning, tdd, debugging, code-review, implementation, workflow]
    related_skills: [autonomous-coding-agents]
---

# Software Development Lifecycle (SDLC)

## Overview

This skill defines the gold-standard discipline for developing software autonomously. It replaces guesswork and "quick fixes" with a systematic, verifiable pipeline. 

**The Core Pipeline:**
`Spike (Explore)` $\rightarrow$ `Plan (Design)` $\rightarrow$ `TDD (Implement)` $\rightarrow$ `Systematic Debugging (Fix)` $\rightarrow$ `Verification (Review)`

## The Lifecycle Phases

### 1. Exploration: The Spike
**Goal:** Validate feasibility and surface unknowns before committing to a build.
- **When:** Use when the approach is unproven or multiple libraries are candidates.
- **Method:** Decompose into feasibility questions $\rightarrow$ Research $\rightarrow$ Build throwaway prototype $\rightarrow$ Verdict.
- **Detail:** See `references/spike.md`.

### 2. Planning: Implementation Plans
**Goal:** Make implementation obvious. If an implementer has to guess, the plan is incomplete.
- **When:** Always before multi-step features or delegating to subagents.
- **Method:** Bite-sized tasks (2-5 min) $\rightarrow$ Exact file paths $\rightarrow$ Complete code examples $\rightarrow$ Verification steps.
- **Plan Mode:** Use `.hermes/plans/` for non-executing planning sessions.
- **Detail:** See `references/planning.md`.

### 3. Implementation: Test-Driven Development (TDD)
**Goal:** Zero-defect implementation through the Red-Green-Refactor cycle.
- **When:** All new features, bug fixes, and refactors.
- **Method:** Write failing test (RED) $\rightarrow$ Minimal code to pass (GREEN) $\rightarrow$ Clean up (REFACTOR).
- **Iron Law:** No production code without a failing test first.
- **Detail:** See `references/tdd.md`.

### 4. Debugging: Systematic Root Cause Analysis
**Goal:** Fix the root cause, not the symptom.
- **When:** Any technical issue or test failure.
- **Method:** 4-Phase approach: Root Cause Investigation $\rightarrow$ Pattern Analysis $\rightarrow$ Hypothesis Testing $\rightarrow$ Implementation.
- **Iron Law:** No fixes without root cause investigation first.
- **Detail:** See `references/debugging.md`.

### 5. Verification: Pre-Commit Review
**Goal:** Independent verification of quality and security before code lands.
- **When:** After implementation, before `git commit` or `git push`.
- **Method:** Static security scan $\rightarrow$ Baseline test comparison $\rightarrow$ Independent reviewer subagent $\rightarrow$ Auto-fix loop.
- **Detail:** See `references/verification.md`.

## Orchestration: Subagent-Driven Development

The entire lifecycle is typically executed via **Subagent-Driven Development**, which ensures fresh context and objective review:

1. **Dispatch Implementer:** Provide the specific task from the Plan, enforcing TDD.
2. **Spec Review:** A fresh subagent verifies the implementation matches the Plan.
3. **Quality Review:** A fresh subagent verifies the code meets security and quality standards.
4. **Iterate:** Fix gaps $\rightarrow$ Re-review $\rightarrow$ Proceed.

**Detail:** See `references/subagent-orchestration.md`.

## Summary Table

| Phase | Trigger | Key Deliverable | Primary Tool/Skill |
| :--- | :--- | :--- | :--- |
| **Spike** | "Is this possible?" | Verdict (Validated/Invalidated) | `spike` |
| **Plan** | "How do we build this?" | `docs/plans/feature.md` | `writing-plans` / `plan` |
| **Implement** | "Build the feature" | Passing Tests + Code | `test-driven-development` |
| **Debug** | "It's broken" | Root Cause $\rightarrow$ Fix | `systematic-debugging` |
| **Verify** | "Is it ready to ship?" | Reviewer Approval | `requesting-code-review` |
| **Orchestrate** | "Execute the plan" | Verified Implementation | `subagent-driven-development` |
