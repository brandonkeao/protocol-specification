# Skills Index

Available skills for this entity.

## Core Skills

| Skill | Command | Description |
|-------|---------|-------------|
| **session-start** | `/session-start` | Initialize session with context loading |
| **session-export** | `/session-export` | Generate session exports for continuity |
| **handoff** | `/handoff [entity]` | Send work to another entity |
| **commit** | `/commit` | Create git commits using Conventional Commits |

## Usage

Skills are invoked via slash commands or natural language:
- `/session-start` or "start session"
- `/session-start --full` for strategic sessions
- `/handoff Engineer` or "hand this off to Engineer"
- `/commit` or "commit these changes"

## Adding New Skills

To add a skill:
1. Create directory: `.claude/skills/[skill-name]/`
2. Create `SKILL.md` with frontmatter and process
3. Update this index

See [ENTITY_SPEC](../../ENTITY_SPEC.md) for skill specification format.
