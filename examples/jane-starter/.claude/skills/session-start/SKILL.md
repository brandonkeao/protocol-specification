---
description: Initialize session with context loading. Default is lightweight (~2k tokens). Use --full for strategic sessions (~5k tokens). Triggers include "start session", "session start", "boot up", "load context".
---

# Session Start Skill

Initialize a session with appropriate context loading.

## Boot Modes

| Mode | Invocation | Tokens | Use Case |
|------|------------|--------|----------|
| **Lightweight** (default) | `/session-start` | ~2k | Quick tasks, tactical work |
| **Full** | `/session-start --full` | ~5k | Strategic sessions, planning |

---

## Lightweight Mode (Default)

Fast boot for tactical sessions.

### Process

#### Step 1: Load Kernel Summary

Read: `context/kernel/_summary.md`

Contains:
- Identity anchor
- Agent ecosystem table
- Routing rules
- Decision framework

#### Step 2: Check Active Objectives

Read: `active_work/current_objectives.md`

Extract:
- Current status
- Active priorities
- Next steps

#### Step 3: Check Inbox

Check: `memory/inbox/*.md` (excluding `_README.md`)

**For each file**:
1. Read frontmatter and check `status:`
   - If `status: pending` -> Surface to user
   - If `status: acknowledged`, `completed`, or `dismissed` -> Skip

2. Surface pending items with:
   - Type (from `type:` field)
   - Title (from `# [Title]` header)
   - Priority (from `priority:` field)

**Human-in-the-Loop Requirement**:
- MUST surface ALL pending items to user
- MUST NOT autonomously acknowledge, complete, or dismiss items

#### Step 4: Brief Boot Report

Output:

```
## Boot Status (Lightweight)

**Mode**: Lightweight (~2k tokens)
**Kernel**: Summary loaded
**Objectives**: Current priorities loaded

### Inbox Items
[If any pending items exist:]
| Type | Title | Priority |
|------|-------|----------|
| [type] | [title] | [priority] |

[If no pending items: "None pending"]

Ready for work.
```

---

## Full Mode (--full flag)

Comprehensive boot for strategic sessions.

### When to Use Full Boot

- Strategic planning sessions
- After long gaps (days)
- New project initiation
- Complex multi-step work

### Process

#### Step 1: Load Full Kernel Context

Read these 4 files:
1. `context/kernel/role_definition.md`
2. `context/kernel/operating_principles.md`
3. `context/kernel/agent_coordination.md`
4. `context/kernel/persona_profile.md`

#### Step 2: Check Active Objectives

Read: `active_work/current_objectives.md`

Extract full content.

#### Step 3: Review Recent Sessions

Location: `memory/sessions/exports/`
Load: Most recent 2-3 files (by date in filename)

#### Step 4: Index Memory

**Learnings** (`memory/evolution/learnings/`):
- List all files (excluding templates)
- Extract: title, date, 1-line summary

**Decisions** (`memory/evolution/decisions/`):
- List all files (excluding templates)
- Extract: title, date, status

#### Step 5: Check Inbox

Same as lightweight - surface all pending items.

#### Step 6: Generate Full Boot Report

```
## Boot Status Report (Full)

### Context Loaded
| File | Status |
|------|--------|
| role_definition.md | Loaded |
| operating_principles.md | Loaded |
| agent_coordination.md | Loaded |
| persona_profile.md | Loaded |
| current_objectives.md | Loaded |

### Recent Sessions
- [Date]: [Title]
- [Date]: [Title]

### Memory Index
**Learnings**: X files available
**Decisions**: X files available

### Inbox Items
[All pending items]

Ready for strategic work.
```

---

## Quality Checklist

### Lightweight Mode
- [ ] Kernel summary loaded
- [ ] Active objectives checked
- [ ] Inbox checked
- [ ] Brief boot report generated

### Full Mode
- [ ] All 4 kernel files loaded
- [ ] Active objectives reviewed
- [ ] Recent sessions loaded
- [ ] Memory indexed
- [ ] Inbox checked
- [ ] Full boot report generated

---

## Error Handling

**If kernel file missing**:
- Log warning in boot status
- Continue with available files

**If no recent sessions**:
- Note "No recent session exports found"
- Continue without session context

**If inbox empty**:
- Note "None pending"
- Continue normally
