# Inbox

This directory contains messages from other entities.

## How It Works

1. Other entities create files here using the handoff skill
2. During boot, pending items are surfaced to the user
3. User decides how to handle each item
4. Status is updated as items are processed

## File Naming

`YYYY-MM-DD_[type]-from-[sender]-[slug].md`

Examples:
- `2026-01-15_handoff-from-engineer-api-review.md`
- `2026-01-15_proposal-from-writer-content-strategy.md`

## Frontmatter Format

```yaml
---
type: handoff | proposal | notification | follow-up
from: [Sender Entity]
to: [This Entity]
status: pending | acknowledged | completed | dismissed
priority: high | medium | low
created: YYYY-MM-DD
surface_when: [optional - contexts where this should surface]
---
```

## Status Lifecycle

```
pending → acknowledged → completed
                     ↘ dismissed
```

- **pending**: Not yet seen/acted on
- **acknowledged**: Work has started
- **completed**: Work is done
- **dismissed**: Intentionally skipped

## Human-in-the-Loop

**Important**: Only the human user can change status. The entity surfaces items but does not autonomously acknowledge, complete, or dismiss them.

## Retention

- **Completed/Dismissed**: Keep for 30 days, then archive or delete
- **Pending/Acknowledged**: Keep until resolved
