# Backup Target Registry

This document tracks the typical paths that should be included in a full state backup for this environment.

## Agent Internals
| Path | Description | Priority |
| :--- | :--- | :--- |
| `/data/.hermes/skills/` | All custom agent skills | Critical |
| `/data/.hermes/profiles/` | Profile-specific settings (minus secrets) | High |

## User Project Artifacts
| Path | Description | Priority |
| :--- | :--- | :--- |
| `/data/static_site/` | Kenna's Recipes website | High |
| `/data/user_profile.md` | Durable user profile record | High |

## Exclusion List (.gitignore)
- `**/.env`
- `**/config.yaml`
- `**/.hermes/logs/`
- `**/.git/` (nested)
- `**/node_modules/`
- `**/__pycache__/`
