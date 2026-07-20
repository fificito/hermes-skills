---
name: kanban-framework
description: "Complete operations manual for Hermes Kanban: orchestration, worker lifecycles, and specialized implementation lanes."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Kanban, Multi-Agent, Orchestration, Workflow, Autonomous-Agents]
---

# Kanban Framework

The definitive guide for operating the Hermes Kanban system. This framework covers the entire lifecycle from high-level decomposition to individual task execution and specialized agent lanes.

## 🧭 1. Orchestration & Decomposition
Guidelines for the Orchestrator profile routing work through the board.

### The Core Mandate: Route, Don't Execute
- **Decompose, don't implement**: Create Kanban tasks for every concrete workstream.
- **Profile Discovery**: Always run `hermes profile list` before assigning tasks to ensure the assignee exists.
- **Task Graphing**: Map independent lanes in parallel and gate synthesis/review tasks using `parents=[...]`.
- **Goal Mode**: Use `goal_mode=True` for open-ended tasks that require iterative progress.

---

## 🛠️ 2. Worker Execution Lifecycle
Operational standards for agents spawned as Kanban workers.

### Workspace Standards
- **Scratch**: Fresh tmp dir for one-off work.
- **Dir**: Shared persistent directory for long-lived state.
- **Worktree**: Isolated git worktree for implementation.

### Handoff & Metadata
- **Review-Required**: Use `kanban_block(reason="review-required: ...")` and provide structured metadata in a comment.
- **Completion**: Use `kanban_complete` only for terminal tasks. Include `created_cards` for newly spawned subtasks.
- **Heartbeats**: Send progress-based heartbeats (e.g., "epoch 12/50") every few minutes for long tasks.

---

## ⚡ 3. Specialized Lanes: Codex Integration
Using Codex as an isolated implementation lane while Hermes retains ownership.

### The Codex Lane Convention
- **Isolation**: Always run Codex in a separate git worktree/branch (`codex/t_id/...`).
- **Ownership**: Hermes is the task owner; Codex is an input lane.
- **Reconciliation**: Hermes must review `git diff` and independently rerun tests before accepting any Codex output.
- **Safety Constraints**: For sensitive repos (e.g., PMB), mandatory safety blocks must be included in the Codex prompt.

*Template: `templates/pmb-codex-lane-prompt.md`*

---

## ⚠️ Common Pitfalls & Recovery
- **Phantom IDs**: Never invent task IDs in `kanban_complete`; only use captured return values.
- **Silent Blocks**: Never use `clarify` in a worker run; use `kanban_block` + `kanban_comment`.
- **Recovery**: Use `hermes kanban reclaim` or `reassign` when workers are stuck or hallucinating.
