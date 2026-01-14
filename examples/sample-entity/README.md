# Sample Entity

**Spec Version**: 1.8

This is a minimal working example of a Tier 1 entity following the Entity Specification Protocol.

## What This Demonstrates

- **Minimal required structure** for a functional entity
- **CLAUDE.md** with boot sequence and context loading
- **Role definition** in kernel
- **Current objectives** for focus

## Structure

```
sample-entity/
├── CLAUDE.md                    # System instructions
├── context/
│   └── kernel/
│       └── role_definition.md   # Who is this entity
├── active_work/
│   └── current_objectives.md    # Current focus
└── README.md                    # This file
```

## To Upgrade to Tier 2

A Tier 1 entity can upgrade when it needs:
- Session continuity (add `memory/sessions/`)
- Accumulated learnings (add `memory/evolution/`)
- Cross-entity communication (add `memory/inbox/`)
- Reference data (add `data/`)
- Skills (add `.claude/skills/`)

See `ENTITY_SPEC.md` for complete Tier 2 requirements.

## Usage

1. Copy this directory as starting point
2. Customize `CLAUDE.md` with entity name and instructions
3. Update `role_definition.md` with entity's purpose
4. Set initial objectives in `current_objectives.md`
5. Open the directory in Claude Code
