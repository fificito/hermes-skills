---
name: github-toolkit
description: "Complete toolkit for GitHub operations: auth, repo management, issues, PRs, code review, and codebase inspection."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [GitHub, Git, gh-cli, Automation, Project-Management, Code-Review, Analysis]
---

# GitHub Toolkit

A comprehensive class-level skill for managing the entire GitHub lifecycle. This toolkit integrates authentication, repository administration, issue tracking, pull request workflows, and code analysis.

## 🔐 1. Authentication & Setup
Ensures the agent can interact with GitHub via `git` (HTTPS/SSH) or the `gh` CLI.

### Detection & Setup
Run this check first to determine the available auth method:
```bash
git --version
gh --version 2>/dev/null || echo "gh not installed"
gh auth status 2>/dev/null || echo "gh not authenticated"
```

### Auth Methods
- **GH CLI**: Use `gh auth login` (interactive) or `echo "TOKEN" | gh auth login --with-token` (headless).
- **Git HTTPS**: Use Personal Access Tokens (PAT) with `git config --global credential.helper store`.
- **Git SSH**: Generate ed25519 keys and add the public key to GitHub settings.

*See `scripts/gh-env.sh` for environment setup helpers.*

---

## 📦 2. Repository Management
Handling the creation, cloning, and configuration of repositories.

### Core Operations
- **Clone**: `git clone <<urlurl>` or `gh repo clone <<reporepo>`.
- **Create**: `gh repo create <<namename> --public --clone` or via API `POST /user/repos`.
- **Fork & Sync**: `gh repo fork <<reporepo> --clone` and `gh repo sync <<reporepo>`.
- **Secrets**: Manage GitHub Actions secrets using `gh secret set <<KEYKEY>`.
- **Releases**: Create and manage releases with `gh release create <<tagtag>`.

*Reference: `references/github-api-cheatsheet.md`*

---

## 🎫 3. Issue Management
Triage, tracking, and organizing work via GitHub Issues.

### Workflow
- **View/Search**: `gh issue list` or `gh issue view <<idid>`.
- **Create**: `gh issue create --title "..." --body "..." --label "bug"`.
- **Triage**: Use `gh issue edit <<idid> --add-label "priority:high"`.
- **Linking**: Use keywords like `Closes #42` in PR bodies to automate closing.

*Templates: `templates/bug-report.md`, `templates/feature-request.md`*

---

## 🚀 4. Pull Request Workflow
Managing the full lifecycle from branch creation to merge.

### Lifecycle
1. **Branch**: `git checkout -b feat/description`.
2. **Commit**: Use Conventional Commits (e.g., `feat(auth): add JWT support`).
3. **Open**: `gh pr create --title "..." --body "..."`.
4. **CI Monitoring**: `gh pr checks --watch`.
5. **Merge**: `gh pr merge --squash --delete-branch`.

*References: `references/ci-troubleshooting.md`, `references/conventional-commits.md`*
*Templates: `templates/pr-body-bugfix.md`, `templates/pr-body-feature.md`*

---

## 🔍 5. Code Review & Quality
Performing pre-push local reviews and formal PR reviews.

### Local Review (Pre-Push)
Use `git diff main...HEAD` to analyze changes. Check for:
- Debug statements (`print`, `console.log`)
- Hardcoded secrets/tokens
- Merge conflict markers

### PR Review
- **Checkout**: `gh pr checkout <<idid>`.
- **Comment**: `gh pr comment <<idid> --body "..."` or use `gh api` for inline comments.
- **Verdict**: Use `gh pr review <<idid> --approve` or `--request-changes`.

*Reference: `references/review-output-template.md`*

---

## 📊 6. Codebase Inspection
Analyzing repository metrics and composition using `pygount`.

### Key Commands
```bash
# General summary (excluding noise)
pygount --format=summary --folders-to-skip=".git,node_modules,venv" .
```

### Use Cases
- **LOC Counting**: Get total lines of code, comments, and blanks.
- **Language Breakdown**: Identify the primary languages used in a project.
- **Project Size**: Rapidly assess the scale of a new repository.

---

## 🛠️ Troubleshooting & Tips
- **Permission Denied**: Check token scopes (ensure `repo` and `workflow` are enabled).
- **GH CLI Missing**: Fall back to `curl` + `GITHUB_TOKEN` for API calls.
- **Large Repos**: Use `--depth 1` for shallow clones to save time/space.
