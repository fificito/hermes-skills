---
name: autonomous-coding-agents
description: \"Orchestrate autonomous coding agents (Claude Code, Codex, OpenCode) for features, refactoring, and PR reviews.\"
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Coding-Agent, Autonomous, Refactoring, Code-Review, PTY, Automation]
    related_skills: [subagent-driven-development, hermes-agent]
---

# Autonomous Coding Agents

## Overview

This skill provides a unified framework for delegating high-level coding tasks to autonomous agent CLIs. Use this when a task requires an agent that can autonomously read files, write code, run shell commands, and manage git workflows.

## Agent Comparison & Selection

| Agent | Primary Strength | Integration Mode | Best For |
| :--- | :--- | :--- | :--- |
| **Claude Code** | Deep reasoning, sophisticated TUI, native MCP | Print (`-p`) or tmux-PTY | Complex features, deep refactors, high-precision reviews |
| **Codex** | Fast execution, OpenAI ecosystem | PTY / Background | Batch issue fixing, rapid prototyping, PR reviews |
| **OpenCode** | Provider-agnostic, open-source, flexible | `run` or Background-PTY | General-purpose autonomous coding, multi-provider tests |

## Core Orchestration Patterns

### 1. The One-Shot (Print/Run Mode)
**Use for:** Simple fixes, single-file changes, or structured analysis.
- **Claude:** `claude -p 'task' --max-turns 10`
- **Codex:** `codex exec 'task'`
- **OpenCode:** `opencode run 'task'`

### 2. The Iterative Session (Interactive PTY)
**Use for:** Multi-turn refactors, explorative coding, or human-in-the-loop work.
- **Claude:** Requires **tmux** orchestration to manage the TUI and capture output.
- **Codex/OpenCode:** Use `background=true, pty=true` and the `process` tool (`poll`, `log`, `submit`).

### 3. The PR Review Workflow
**Use for:** Auditing changes before merge.
- **Quick Review:** Pipe `git diff` into print mode.
- **Deep Review:** Use an isolated git worktree/temp clone to avoid polluting the main workspace.
- **Built-in Tools:** Use `claude --from-pr <num>` or `opencode pr <num>`.

### 4. Parallel Execution (Worktree Pattern)
To avoid collisions when fixing multiple issues:
1. Create isolated git worktrees: `git worktree add -b fix/issue-1 /tmp/issue-1 main`.
2. Launch independent agents in each directory.
3. Monitor processes in parallel using `process(action='list')`.

## Implementation Guides

### Claude Code Deep Dive
Refer to `references/claude-code.md` for:
- tmux orchestration patterns and dialog handling.
- Print mode structured JSON output and session continuation.
- CLAUDE.md project memory management.
- MCP integration and Hook configuration.

### Codex Deep Dive
Refer to `references/codex.md` for:
- Auth requirements and PTY necessity.
- `full-auto` vs `yolo` modes.
- Batch PR review patterns.

### OpenCode Deep Dive
Refer to `references/opencode.md` for:
- Binary resolution and provider configuration.
- TUI keybindings and session resumption.
- `opencode stats` for cost/token tracking.

## Rules for Hermes Agents

1. **Prefer Print Mode** for single tasks to avoid TUI overhead and dialog hangs.
2. **Always set `workdir`** to keep the agent focused on the correct project.
3. **Isolate long-running work** using temporary directories or git worktrees.
4. **Set loop limits** (`--max-turns`) in print mode to prevent runaway costs.
5. **Verify outcomes** by checking file changes and running the test suite after the agent exits.
6. **Clean up resources** (tmux sessions, temp directories) immediately after completion.
