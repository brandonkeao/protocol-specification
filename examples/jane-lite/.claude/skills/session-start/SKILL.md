# Session Start Skill (Jane-Lite)

Initialize a Jane-Lite session with context loading.

## When to Use

Run at the beginning of every session.

## Process

### Step 1: Load Kernel Summary

Read: `context/kernel/_summary.md`

For deeper context, also read:
- `context/kernel/role_definition.md`
- `context/kernel/agent_coordination.md`

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

**Entity**: Jane-Lite (Orchestrator)
**Kernel**: Loaded
**Child Entities**: Engineer-Example, Writer-Example
**Inbox**: [count] pending items

Ready to route work.
```

## Output

Brief boot report confirming context loaded.
