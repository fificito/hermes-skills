---
name: hermes-state-backup
description: Workflow for backing up the agent's persistent state, including custom skills, configurations, and user-specific project files to GitHub.
---

# Hermes State Backup

This skill governs the process of ensuring that the agent's "intelligence" (skills) and work artifacts are durably stored in a remote repository.

## Trigger
The user asks to "backup everything", "save state to GitHub", "sync skills", or requests a "recurring backup".

## Workflow

### 1. Identification of Backup Targets
Identify all directories and files that constitute the agent's state and the user's projects.
- **Agent State**: `/data/.hermes/skills/` (The primary target).
- **User Projects**: Any project directories created for the user (e.g., `/data/static_site/`).
- **Configurations**: User-defined profile settings (excluding secrets).

### 2. Repository Orchestration
- **Repo Selection**: Determine if the backup goes to a single "Hermes-State" repo or separate repos per project.
- **Authentication**: Use the `github-toolkit` or `gh` CLI with a stored token.
- **Initialization**: 
    - `git init` in the target directory.
    - Configure `user.name` and `user.email`.
    - Create a `.gitignore` to prevent leaking sensitive data (e.g., `.env`, `config.yaml`, `.hermes/logs`).

### 3. Execution of Backup
- **Staging**: `git add .`
- **Committing**: Use descriptive commit messages (e.g., "Backup: [Date] - Added [New Skill Name]").
- **Pushing**: `git push origin main`.
- **Verification**: Use `gh repo view` or check the remote file list to confirm the backup succeeded. Do not assume `git push` without errors means the files are visible to the user.

### 4. Recurring Automation
When the user requests a schedule (e.g., "Every Friday at 6 PM"):
- Use the `cronjob` tool.
- **Prompt**: The cron prompt must be self-contained. It should:
    1. Load `hermes-state-backup`.
    2. Run the push sequence for all identified targets.
    3. Notify the user of success/failure.
- **Verification**: Immediately run the cron job once via `cronjob(action='run', ...)` to verify the schedule and script work before exiting the session.

## Pitfalls & Tips
- **Secret Leakage**: NEVER commit raw tokens or passwords. Always check the `.gitignore` before the first push.
- **Monolith vs. Split**: For large projects, prefer separate repositories. For skills and configs, a single "Agent-State" repo is more manageable.
- **Missing Files**: Users often report "not seeing" files after a backup. This is usually due to:
    - Pushing to the wrong branch.
    - Missing files in the `git add` stage.
    - Shallow clones or `.gitignore` rules being too aggressive.
    - **Fix**: Always list the files pushed in the final report.

## Verification
- [ ] Remote repository contains the expected directory structure.
- [ ] `.gitignore` is present and protecting secrets.
- [ ] (If scheduled) `cronjob(action='list')` shows the job active with the correct schedule.
