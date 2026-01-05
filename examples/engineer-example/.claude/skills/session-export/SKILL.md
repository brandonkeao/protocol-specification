# Session Export Skill (Engineer-Example)

Create a structured export of the current session for continuity.

## When to Use

Run at the end of significant sessions.

## Process

### Step 1: Summarize Session

Capture:
- Technical work completed
- Decisions made
- Code changes

### Step 2: Create Export File

Location: `memory/sessions/exports/`
Filename: `YYYY-MM-DD_[description].md`

### Export Template

```markdown
---
date: YYYY-MM-DD
entity: Engineer-Example
type: session-export
---

# Session Export: [Brief Title]

## Summary

[2-3 sentences on what happened]

## Technical Work

- [Change 1]
- [Change 2]

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| [Decision] | [Why] |

## Context for Next Session

[Technical state, what's next]
```

## Output

Confirmation that export was created.
