# Entity Specification Protocol

A specification for building persistent AI entities with structured identity, memory, and context.

## What is this?

This specification defines how to create "Jane-like entities" - AI agents that maintain continuity across sessions through deliberate architecture. Unlike ephemeral assistants that reset each conversation, entities built to this spec preserve:

- **Who they are** (context)
- **What they've learned** (memory)
- **Facts about the world** (data)

## Core Concepts

### Three-Layer Architecture

```
entity/
├── context/    # WHO I AM - Identity & Instructions
├── memory/     # WHAT I'VE LEARNED - Accumulated Experience
├── data/       # FACTS ABOUT THE WORLD - Reference Material
├── active_work/ # WHAT I'M DOING NOW - Current Focus
└── .claude/    # HOW I WORK - Skills & Configuration
```

### Entity Tiers

| Tier | Use Case | Complexity |
|------|----------|------------|
| **Tier 1** | Simple, single-purpose agents | Minimal structure |
| **Tier 2** | Persistent, domain-owning agents | Full structure with memory |

### Entity Roles

- **Orchestrator**: Coordinates other entities, routes work
- **Domain Specialist**: Focused on a single domain, reports to orchestrator
- **Meta-Entity**: Owns specifications or infrastructure

## Quick Start

1. Read [`ENTITY_SPEC.md`](./ENTITY_SPEC.md) for the complete specification
2. Use templates in [`templates/`](./templates/) to scaffold your entity
3. Follow [`specification/birth_process.md`](./specification/birth_process.md) to create a new entity

## Repository Structure

```
protocol-specification/
├── ENTITY_SPEC.md          # The complete specification
├── CHANGELOG.md            # Version history
│
├── templates/              # Entity scaffolding templates
│   ├── kernel/             # Core identity templates
│   ├── memory/             # Memory structure templates
│   └── skills/             # Skill definition templates
│
├── specification/          # Supplementary documentation
│   ├── architecture.md     # Three-layer model explained
│   ├── principles.md       # Design philosophy
│   └── birth_process.md    # How to create entities
│
├── patterns/               # Best practices discovered
│   └── *.md                # Individual pattern files
│
├── validation/             # Quality assurance
│   └── checklist.md        # Entity validation checklist
│
└── examples/               # Reference implementations
    └── sample-entity/      # Minimal working example
```

## Design Principles

1. **Token-conscious**: Load only what's needed, when needed
2. **Semantic clarity**: Each directory has distinct purpose
3. **Progressive complexity**: Start minimal, grow as proven
4. **Portable**: Skills and structures work across entities
5. **Human-in-the-loop**: Cross-entity communication requires human oversight

## Version

Current specification version: **1.6**

See [`CHANGELOG.md`](./CHANGELOG.md) for version history.

## License

MIT License - See [`LICENSE`](./LICENSE)

## Contributing

This specification is open to contributions. If you've implemented an entity and discovered patterns worth sharing, consider contributing to the patterns library.
