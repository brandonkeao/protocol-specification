# Session Export Skill (Jane-Lite)

Create a structured export of the current session for continuity.

## When to Use

Run at the end of significant sessions.

## Process

### Step 1: Summarize Session

Capture:
- Work routed to child entities
- Decisions made
- Status of active items

### Step 2: Create Export File

Location: `memory/sessions/exports/`
Filename: `YYYY-MM-DD_[description].md`

### Export Template

```markdown
---
date: YYYY-MM-DD
entity: Jane-Lite
type: session-export
---

# Session Export: [Brief Title]

## Summary

[2-3 sentences on what happened]

## Work Routed

| Task | Routed To | Status |
|------|-----------|--------|
| [Task] | [Entity] | [Status] |

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| [Decision] | [Why] |

## Context for Next Session

[What the next session needs to know]
```

## Output

Confirmation that export was created.
