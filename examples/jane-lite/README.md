# Jane-Lite: Orchestrator Example

A simplified reference implementation of a Tier 2 Orchestrator entity.

## What This Example Demonstrates

1. **Orchestrator role** - Routes work to child entities
2. **Tier 2 structure** - Full memory, inbox, and skills
3. **Agent coordination** - How to define routing rules
4. **Birth tracking** - How to record spawned entities

## Key Patterns

### 1. Agent Coordination File

See `context/kernel/agent_coordination.md` - this is what makes an entity an "orchestrator":

```markdown
## Routing Rules

| Domain | Route To | Example Triggers |
|--------|----------|------------------|
| Code implementation | Engineer | "build", "fix bug", "refactor" |
| Content writing | Writer | "write post", "draft email" |
```

### 2. Summary File for Large Kernels

Orchestrators often have large kernels. The `_summary.md` pattern keeps boot fast:

```markdown
# Quick reference to kernel files
- role_definition.md: I am Jane, the orchestrator
- agent_coordination.md: Routes work to 3 child entities
```

### 3. Birth Records

Track spawned entities in `memory/evolution/agent_births/`:

```markdown
# Engineer Birth Record
- Spawned: 2026-01-01
- Domain: Code implementation
- Parent: Jane
```

## Structure

```
jane-lite/
├── CLAUDE.md                    # Boot instructions
├── context/
│   └── kernel/
│       ├── role_definition.md   # Orchestrator identity
│       ├── operating_principles.md
│       ├── persona_profile.md
│       ├── agent_coordination.md # Routes to child entities
│       └── _summary.md          # Quick kernel reference
├── active_work/
│   └── current_objectives.md
├── memory/
│   ├── sessions/exports/
│   ├── evolution/
│   │   ├── learnings/
│   │   ├── decisions/
│   │   └── agent_births/        # Tracks spawned entities
│   └── inbox/
└── .claude/
    └── skills/
        ├── _index.md
        ├── session-start/SKILL.md
        └── session-export/SKILL.md
```

## Using This Example

1. **Study the structure** - See how orchestrator-specific files are organized
2. **Adapt for your use** - Copy and modify for your orchestrator needs
3. **Don't copy verbatim** - Paths and identities need customization

## Comparison to Full Jane

| Aspect | Jane-Lite | Full Jane |
|--------|-----------|-----------|
| Child entities | 2 (example) | 4+ |
| Skills | 2 (core) | 15+ |
| Memory files | Minimal | Extensive |
| Complexity | Reference | Production |

This is a teaching example, not a production entity.
