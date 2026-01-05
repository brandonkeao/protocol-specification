# Entity Specification Protocol

A specification for building persistent AI entities with structured identity, memory, and context.

## Why This Exists

Most AI assistants are ephemeral - they forget everything between conversations. This specification defines how to build **persistent entities** that maintain:

- **Identity** - Who they are, how they work, their personality
- **Memory** - What they've learned, decisions made, session history
- **Context** - Facts about the world, reference material, domain knowledge

The result: AI agents that feel continuous, accumulate expertise, and genuinely know you over time.

---

## Prerequisites

- [Claude Code](https://claude.com/claude-code) (Anthropic's CLI tool)
- A workspace directory for your entity

---

## Installation

### Option 1: Clone the Repository

```bash
git clone https://github.com/yourusername/protocol-specification.git
cd protocol-specification
```

### Option 2: Download Files Directly

Download the repository as a ZIP and extract to your preferred location.

---

## Quick Start: Create Your First Entity

### Step 1: Create Your Entity Directory

```bash
mkdir my-entity
cd my-entity
```

### Step 2: Copy the Minimal Structure

For a **Tier 1 (Minimal) Entity**, you need just 3 files:

```bash
# Create directory structure
mkdir -p context/kernel active_work

# Copy from the examples
cp /path/to/protocol-specification/examples/sample-entity/CLAUDE.md .
cp /path/to/protocol-specification/examples/sample-entity/context/kernel/role_definition.md context/kernel/
cp /path/to/protocol-specification/examples/sample-entity/active_work/current_objectives.md active_work/
```

Or create them manually:

**`CLAUDE.md`** (System instructions - loaded by Claude Code):
```markdown
# Welcome, [Entity Name]

## Who You Are
You are **[Entity Name]**, a [description of purpose].

## Core Context to Load
1. `context/kernel/role_definition.md` - Your role and purpose
2. `active_work/current_objectives.md` - Current focus

## Boot Sequence
On session start:
1. Load kernel context
2. Check objectives
3. Ready for work
```

**`context/kernel/role_definition.md`**:
```markdown
# Role Definition

**Entity**: [Entity Name]
**Purpose**: [What this entity does]

## Scope
### I Own
- [Responsibility 1]
- [Responsibility 2]

### I Don't Own
- [Out of scope]
```

**`active_work/current_objectives.md`**:
```markdown
# Current Objectives

**Status**: Active

## Primary Focus
[What the entity is currently working on]

## Next Actions
- [ ] Action 1
- [ ] Action 2
```

### Step 3: Open in Claude Code

```bash
cd my-entity
claude
```

Claude will automatically read your `CLAUDE.md` and understand its identity.

### Step 4: Start a Session

Your entity is now running! It will:
- Load its role definition
- Check current objectives
- Be ready to work within its defined scope

---

## Entity Tiers

### Tier 1: Minimal Entity

For simple, single-purpose agents. Start here.

```
my-entity/
├── CLAUDE.md                    # System instructions
├── context/
│   └── kernel/
│       └── role_definition.md   # Who is this entity
└── active_work/
    └── current_objectives.md    # Current focus
```

**Use when**: Single-purpose tasks, experiments, temporary agents

### Tier 2: Full Entity

For persistent, domain-owning agents that accumulate knowledge.

```
my-entity/
├── CLAUDE.md
├── context/
│   ├── kernel/
│   │   ├── role_definition.md
│   │   ├── operating_principles.md
│   │   └── persona_profile.md
│   └── conditional/              # Context loaded when relevant
├── memory/
│   ├── sessions/
│   │   └── exports/              # Session summaries
│   ├── evolution/
│   │   ├── learnings/            # Patterns discovered
│   │   └── decisions/            # Architecture decisions
│   └── inbox/                    # Cross-entity messages
├── data/                         # Reference material
├── active_work/
│   └── current_objectives.md
└── .claude/
    └── skills/                   # Reusable capabilities
```

**Use when**: Long-running projects, domain expertise, multi-session work

See [`ENTITY_SPEC.md`](./ENTITY_SPEC.md) for complete Tier 2 requirements.

---

## Core Concepts

### Three-Layer Architecture

```
entity/
├── context/    # WHO I AM - Identity & Instructions (loaded at boot)
├── memory/     # WHAT I'VE LEARNED - Accumulated Experience (loaded on demand)
├── data/       # FACTS ABOUT THE WORLD - Reference Material (loaded on demand)
├── active_work/ # WHAT I'M DOING NOW - Current Focus (loaded at boot)
└── .claude/    # HOW I WORK - Skills & Configuration (loaded on use)
```

| Layer | Question | Token Impact |
|-------|----------|--------------|
| `context/` | "Who are you?" | Always loaded |
| `memory/` | "What have you learned?" | Loaded selectively |
| `data/` | "What facts do you know?" | Loaded when relevant |
| `active_work/` | "What are you doing?" | Always loaded |
| `.claude/` | "What can you do?" | Loaded on use |

### Entity Roles

| Role | Purpose | Example |
|------|---------|---------|
| **Orchestrator** | Coordinates other entities, routes work | "Jane" - manages multiple specialists |
| **Domain Specialist** | Focused expertise in one area | "Engineer" - handles implementation |
| **Meta-Entity** | Owns infrastructure or specifications | "Protocol" - maintains this spec |

---

## Using Templates

Templates are in [`templates/`](./templates/). Copy and customize:

```bash
# Copy a kernel template
cp templates/kernel/role_definition.md.template context/kernel/role_definition.md

# Edit with your entity's details
```

Available templates:
- `CLAUDE.md.template` - System instructions
- `kernel/*.template` - Core identity files
- `memory/*.template` - Memory structure files
- `skills/SKILL.md.template` - Skill definition

---

## Adding Memory (Upgrading to Tier 2)

When your entity needs to remember things between sessions:

### 1. Add Session Continuity

```bash
mkdir -p memory/sessions/exports
```

Create a session export at end of each session with:
- Key decisions made
- Context for next session
- Open questions

### 2. Add Learnings

```bash
mkdir -p memory/evolution/learnings
```

When patterns emerge, document them:
```markdown
# Learning: [Pattern Name]

**Category**: [category]

## What I Learned
[Description]

## Application
[When to apply this]
```

### 3. Add Skills

```bash
mkdir -p .claude/skills/session-start
```

Skills are reusable capabilities. See [`templates/skills/SKILL.md.template`](./templates/skills/SKILL.md.template).

---

## Validation

Use the [validation checklist](./validation/checklist.md) to verify your entity:

```bash
# Run through the 66-item checklist
cat validation/checklist.md
```

Key checks:
- [ ] CLAUDE.md exists and loads correctly
- [ ] Kernel files are present
- [ ] Directories follow semantic model
- [ ] Token budget is reasonable (<1000 lines in kernel)

---

## Best Practices

### Token Consciousness

Your entity's context window is precious. Follow the "index, don't load" pattern:

- **Boot**: Load only identity + current objectives
- **On demand**: Pull full content when needed
- **Target**: <1000 lines in kernel (always-loaded content)

### Semantic Clarity

Each directory has ONE purpose:
- Confused about where something goes? Check the [architecture guide](./specification/architecture.md)
- Use YAML frontmatter for metadata, not folder names

### Progressive Complexity

1. Start with Tier 1 (minimal)
2. Add memory when you need continuity
3. Add skills when you need reusable capabilities
4. Upgrade to Tier 2 when proven necessary

---

## Repository Structure

```
protocol-specification/
├── ENTITY_SPEC.md          # Complete specification
├── CHANGELOG.md            # Version history
│
├── templates/              # Copy these to start
│   ├── CLAUDE.md.template
│   ├── kernel/             # Identity templates
│   ├── memory/             # Memory templates
│   └── skills/             # Skill templates
│
├── specification/          # Deep dives
│   ├── architecture.md     # Three-layer model
│   ├── principles.md       # Design philosophy
│   └── birth_process.md    # Creating entities
│
├── patterns/               # Best practices
│   ├── avoid-folder-based-encoding.md
│   └── index-dont-load.md
│
├── validation/
│   └── checklist.md        # 66-item validation
│
└── examples/
    └── sample-entity/      # Working minimal example
```

---

## Design Principles

1. **Token-conscious**: Load only what's needed, when needed
2. **Semantic clarity**: Each directory has distinct purpose
3. **Progressive complexity**: Start minimal, grow as proven
4. **Portable**: Skills and structures work across entities
5. **Human-in-the-loop**: Cross-entity communication requires human oversight

---

## Version

Current specification version: **1.6**

See [`CHANGELOG.md`](./CHANGELOG.md) for version history.

---

## FAQ

### How is this different from just using Claude?

Regular Claude forgets everything between conversations. Entities built to this spec:
- Maintain consistent identity across sessions
- Accumulate learnings and decisions
- Have structured memory they can reference
- Can coordinate with other entities

### Do I need Claude Code?

Yes, this specification is designed for [Claude Code](https://claude.com/claude-code), which reads the `CLAUDE.md` file as system instructions.

### Can I use this with other AI models?

The architecture concepts are model-agnostic, but the implementation assumes Claude Code's conventions (CLAUDE.md, .claude/ directory, etc.).

### How many entities should I have?

Start with one. Add more only when you have:
- 20+ sessions in a domain
- Clear, bounded scope
- Distinct expertise needed

---

## License

MIT License - See [`LICENSE`](./LICENSE)

---

## Contributing

This specification is open to contributions:

1. **Patterns**: Discovered a best practice? Add to `patterns/`
2. **Templates**: Improved a template? Submit a PR
3. **Spec changes**: Propose via issue first

---

## Getting Help

- Read the [full specification](./ENTITY_SPEC.md)
- Check the [architecture guide](./specification/architecture.md)
- Review the [sample entity](./examples/sample-entity/)
- Validate with the [checklist](./validation/checklist.md)
