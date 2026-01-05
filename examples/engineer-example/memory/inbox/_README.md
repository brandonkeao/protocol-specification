# Engineer-Example Inbox

This directory receives incoming items from Jane-Lite (parent orchestrator).

## Expected Item Types

- **Work handoffs** from Jane-Lite
- **Clarifications** on technical requests
- **Priority changes** from orchestrator

## File Format

All inbox items must have YAML frontmatter:

```yaml
---
type: handoff | clarification | priority-change
from: Jane-Lite
to: Engineer-Example
status: pending | acknowledged | completed | dismissed
priority: high | medium | low
created: YYYY-MM-DD
---
```

## Processing Rules

1. Surface all pending items at session start
2. Acknowledge items before starting work
3. Report completion back to Jane-Lite
4. Escalate blockers immediately
