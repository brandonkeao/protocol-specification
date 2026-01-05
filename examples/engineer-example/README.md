# Engineer-Example: Domain Specialist Example

A simplified reference implementation of a Tier 2 Domain Specialist entity.

## What This Example Demonstrates

1. **Domain Specialist role** - Owns a specific domain (code/technical)
2. **Tier 2 structure** - Full memory, inbox, and skills
3. **Parent escalation** - How to escalate to orchestrator
4. **Messages directory** - Quick communication with parent

## Key Patterns

### 1. No Agent Coordination

Domain specialists do NOT have `agent_coordination.md` - they don't route work to other entities. They do the work themselves.

### 2. Parent Escalation Path

Domain specialists always escalate to their parent orchestrator:

```markdown
## Escalation Path

I escalate to: **Jane-Lite** (my parent orchestrator)

When to escalate:
- Work outside my domain
- Blocked on decisions I can't make
- Need coordination with sibling entities
```

### 3. Messages to Parent Directory

Quick notes to parent that don't need full handoff:

```
memory/messages_to_jane-lite/
└── 2026-01-05_quick-note.md
```

## Structure

```
engineer-example/
├── CLAUDE.md
├── context/
│   └── kernel/
│       ├── role_definition.md
│       ├── operating_principles.md
│       └── persona_profile.md
├── active_work/
│   └── current_objectives.md
├── memory/
│   ├── sessions/exports/
│   ├── evolution/
│   │   ├── learnings/
│   │   └── decisions/
│   ├── inbox/
│   └── messages_to_jane-lite/    # Quick notes to parent
└── .claude/
    └── skills/
        ├── _index.md
        ├── session-start/SKILL.md
        └── session-export/SKILL.md
```

## Using This Example

1. **Study the structure** - See how domain specialists differ from orchestrators
2. **Note what's missing** - No agent_coordination.md, no child entities
3. **Adapt for your use** - Copy and modify for your domain specialist needs

## Comparison to Full Engineer

| Aspect | Engineer-Example | Full Engineer |
|--------|------------------|---------------|
| Domain | General technical | Brandon's codebase |
| Skills | 2 (core) | 10+ |
| Memory | Minimal | Extensive |
| Context | Generic | Project-specific |

This is a teaching example, not a production entity.
