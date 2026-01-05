# Jane-Lite Inbox

This directory receives incoming items from child entities and external sources.

## Expected Item Types

- **Completion reports** from Engineer-Example and Writer-Example
- **Escalations** from child entities
- **New work requests** from human operator

## File Format

All inbox items must have YAML frontmatter:

```yaml
---
type: handoff | escalation | completion
from: [sender]
to: Jane-Lite
status: pending | acknowledged | completed | dismissed
priority: high | medium | low
created: YYYY-MM-DD
---
```

## Processing Rules

1. Surface all pending items at session start
2. Acknowledge items before routing/acting
3. Track completions for active work updates
4. Escalate ambiguous items to human
