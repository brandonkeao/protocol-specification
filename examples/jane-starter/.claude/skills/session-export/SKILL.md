---
description: Generate session exports for continuity. Use at end of significant sessions to capture decisions, learnings, and context for future sessions. Triggers include "end session", "session end", "export session", "save session".
---

# Session Export Skill

Generate structured session exports for continuity across sessions.

## When to Use

Use this skill when:
- Important decisions were made
- New learnings or patterns discovered
- Work needs to continue in future sessions
- Multiple artifacts were created
- User requests session end/export

## Process

### Step 1: Gather Session Information

Review the current session for:
- **Decisions made**: What was decided and why
- **Learnings discovered**: Patterns, insights, calibrations
- **Artifacts created**: Files written or modified
- **Open threads**: Incomplete work, follow-ups needed
- **Context for next session**: Key info to preserve

### Step 2: Create Export Document

**Location**: `memory/sessions/exports/YYYY-MM-DD_[slug].md`

**Template**:

```markdown
# Session Export: [Title]

**Date**: YYYY-MM-DD
**Duration**: [Approximate]
**Focus**: [Main topic/project]

---

## Summary

[2-3 sentence overview of what was accomplished]

## Decisions Made

| Decision | Rationale | Impact |
|----------|-----------|--------|
| [Decision 1] | [Why] | [What it affects] |
| [Decision 2] | [Why] | [What it affects] |

## Learnings

### [Learning Title]
- **Insight**: [What was learned]
- **Evidence**: [How we know this]
- **Application**: [When to apply this]

## Artifacts Created/Modified

- `[path/to/file1]` - [Description]
- `[path/to/file2]` - [Description]

## Open Threads

- [ ] [Incomplete item 1]
- [ ] [Incomplete item 2]

## Context for Next Session

[Key information the next session needs to know to continue effectively]

---

**Next Steps**:
1. [Specific next action]
2. [Specific next action]
```

### Step 3: Extract Standalone Learnings (Optional)

If significant learnings were discovered, create standalone learning files:

**Location**: `memory/evolution/learnings/YYYY-MM-DD_[slug].md`

```markdown
---
date: YYYY-MM-DD
tags: [relevant, tags]
surface_when: [contexts where this should surface]
---

# [Learning Title]

## Summary

[1-2 sentence summary]

## Insight

[Detailed explanation of the learning]

## Evidence

[How we know this / what led to this insight]

## Application

[When and how to apply this learning]

## Surface When

- [Context 1 where this is relevant]
- [Context 2 where this is relevant]
```

### Step 4: Update Objectives (If Needed)

If priorities shifted during the session, update `active_work/current_objectives.md`.

### Step 5: Confirm Export

Output:

```
Session exported:
- Export: memory/sessions/exports/[filename].md
- Learnings: [X learnings extracted, if any]
- Objectives: [Updated / No changes]

Context preserved for next session.
```

---

## Quality Checklist

- [ ] Summary captures session essence
- [ ] Key decisions documented with rationale
- [ ] Learnings extracted (if significant)
- [ ] Open threads listed for follow-up
- [ ] Context for next session is clear
- [ ] Next steps are specific and actionable

---

## Notes

- **Frequency**: Not every session needs an export. Use for significant sessions.
- **Brevity**: Keep exports scannable. Details live in the artifacts themselves.
- **Continuity**: The "Context for Next Session" is the most important section.
- **Learnings**: Only extract standalone learnings for truly reusable insights.
