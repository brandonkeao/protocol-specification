# Session Start Skill (Engineer-Example)

Initialize an Engineer-Example session with context loading.

## When to Use

Run at the beginning of every session.

## Process

### Step 1: Load Kernel Context

Read these files:
1. `context/kernel/role_definition.md` - Who I am
2. `context/kernel/operating_principles.md` - How I work
3. `context/kernel/persona_profile.md` - My style

### Step 2: Check Active Objectives

Read: `active_work/current_objectives.md`

### Step 3: Check Inbox

Check: `memory/inbox/*.md`

For each file with `status: pending`:
- Surface to human for acknowledgment
- Do NOT autonomously change status

### Step 4: Generate Boot Report

```
## Boot Status

**Entity**: Engineer-Example (Domain Specialist)
**Domain**: Code/Technical
**Parent**: Jane-Lite
**Kernel**: Loaded
**Inbox**: [count] pending items

Ready for technical work.
```

## Output

Brief boot report confirming context loaded.
