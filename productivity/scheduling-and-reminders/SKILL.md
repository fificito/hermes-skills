---
name: scheduling-and-reminders
description: Manages user reminders and scheduled tasks using the cronjob tool with a focus on timezone accuracy.
---

# Scheduling and Reminders

This skill governs the creation and management of scheduled tasks and reminders to ensure they fire at the correct local time for the user.

## Workflow

### 1. Timezone Verification
Before scheduling any `cronjob`, always:
1. Check the user's timezone in memory (e.g., "User is in CST timezone (UTC-6)").
2. If the timezone is unknown, ask the user for their city or timezone before proceeding.

### 2. Creating the Schedule
When using `cronjob(action='create')` or `update`:
- **Avoid bare ISO strings**: Never use `YYYY-MM-DDTHH:mm:ss` without an offset, as this defaults to UTC.
- **Use Explicit Offsets**: Always append the correct UTC offset to the schedule string (e.g., `2026-07-13T18:00:00-06:00` for 6 PM CST).
- **Relative Times**: For relative schedules (e.g., '30m', 'every 2h'), be aware that the underlying scheduler may operate on system time; verify if the user expects a specific local-time trigger.

### 3. Managing Existing Jobs
- **Verify IDs**: Before attempting an `update`, `pause`, or `remove`, call `cronjob(action='list')` to obtain the current `job_id`. Do not rely on IDs from previous turns as they may have changed or the job may have expired.
- **Confirmation**: When a reminder is set, explicitly state the time and timezone (e.g., "I've set your reminder for 6:00 PM CST").

## Pitfalls

- **The UTC Trap**: Setting a time without an offset (e.g., `2026-07-13T18:00:00`) will cause the reminder to fire at the wrong local time for users not in the UTC zone. This is a common source of user frustration.
- **Silent Expiration**: One-shot cron jobs are removed after they run. If an update fails with "Job not found", the job has likely already executed or was deleted.

## Verification
After creating a job, check the `next_run_at` field in the tool output to confirm the offset is correctly applied.
