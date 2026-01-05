# Three-Layer Architecture

**Reference**: ENTITY_SPEC.md for complete specification

---

## Overview

The Entity Specification uses a three-layer architecture to separate concerns and enable token-conscious loading.

```
entity/
├── context/    # WHO I AM - Identity & Instructions
├── memory/     # WHAT I'VE LEARNED - Accumulated Experience
├── data/       # FACTS ABOUT THE WORLD - Reference Material
├── active_work/ # WHAT I'M DOING NOW - Current Focus
└── .claude/    # HOW I WORK - Skills & Configuration
```

---

## Layer Details

### 1. Context Layer (`context/`)

**Purpose**: Entity identity, instructions, and operating principles

**Contents**:
- `kernel/` - Core identity files (always loaded)
  - `role_definition.md` - Who is this entity
  - `operating_principles.md` - How it works
  - `persona_profile.md` - Personality/style
  - `[domain_specific].md` - Domain knowledge
- `conditional/` - Context loaded when relevant

**Loading**: Boot (always loaded)

**Token Budget**: Target <1000 lines for kernel (approximately 3-4k tokens)

**Key Principle**: This is the entity's "job description" - stable, authoritative, loaded every session.

---

### 2. Memory Layer (`memory/`)

**Purpose**: Accumulated experience, session history, learnings, decisions

**Contents**:
- `sessions/` - Session continuity
  - `exports/` - Synthesized summaries
  - `transcripts/` - Raw conversation logs
- `evolution/` - Entity growth over time
  - `learnings/` - Patterns discovered
  - `decisions/` - Architecture Decision Records (ADRs)
  - `agent_births/` - Agent creation records (orchestrator only)
  - `reviews/` - Weekly reviews
- `inbox/` - Cross-entity communication
- `system_health/` - Diagnostics, token budgets
- `raw_logs/` - Operational artifacts
- `archive/` - Legacy/historical content

**Loading**: On demand (selective)

**Key Principle**: This is the entity's "work journal" - grows over time, loaded selectively.

---

### 3. Data Layer (`data/`)

**Purpose**: External facts about the world (not entity's own experience)

**Contents**:
- `profiles/` - Information about people
- `[domain_specific]/` - Domain reference data
- `sources/` - Archived raw materials

**Loading**: On demand (when relevant)

**Key Principle**: This is the entity's "reference files" - external facts, loaded when needed.

---

### 4. Active Work (`active_work/`)

**Purpose**: Current focus and objectives

**Contents**:
- `current_objectives.md` - What the entity is working on now

**Loading**: Boot (always loaded)

**Key Principle**: This is the entity's "current task list" - changes frequently, loaded every session.

---

### 5. Skills & Configuration (`.claude/`)

**Purpose**: Entity capabilities and tool configuration

**Contents**:
- `skills/` - Reusable capability definitions
  - `session-start/` - Session initialization
  - `session-export/` - Session continuity
  - `handoff/` - Cross-entity communication
  - `entity-diagnostic/` - Self-assessment
- `commands/` - User-invocable commands
- `settings.json` - Claude Code configuration

**Loading**: On invocation

**Key Principle**: This is the entity's "toolbox" - capabilities available when needed.

---

## Semantic Distinctions

The three layers answer different questions:

| Question | Layer | Example |
|----------|-------|---------|
| "Who are you?" | `context/` | Role definition, principles |
| "What have you learned?" | `memory/` | Learnings, session exports |
| "What facts do you know?" | `data/` | Profiles, domain knowledge |
| "What are you doing?" | `active_work/` | Current objectives |
| "What can you do?" | `.claude/` | Skills, commands |

---

## Loading Strategy

### Boot (Always Load)
- `context/kernel/` - Core identity
- `active_work/current_objectives.md` - Current focus

### On Demand (Load When Needed)
- `context/conditional/` - Topic-specific context
- `memory/sessions/exports/` - Recent session context
- `memory/evolution/learnings/` - Relevant patterns
- `data/` - Reference material

### On Invocation (Load When Used)
- `.claude/skills/` - Individual skill files

---

## Token Budget Guidelines

| Component | Target | Notes |
|-----------|--------|-------|
| Kernel (always loaded) | <1000 lines | Core identity only |
| Boot load (total) | <2000 tokens | ~1% of context |
| Full session load | <8000 tokens | ~4% of context |
| On-demand additions | Variable | Load as needed |

**Principle**: Reserve 95%+ of context for actual work, not entity overhead.

---

## Anti-Patterns

### 1. Everything in Kernel
**Problem**: Loading all context at boot wastes tokens

**Solution**: Move reference material to `data/`, historical content to `memory/`

### 2. Overlapping Directories
**Problem**: Unclear where content belongs

**Solution**: Each directory has distinct purpose; use mental model questions

### 3. Loading "Just in Case"
**Problem**: Speculative loading fills context unnecessarily

**Solution**: Index files, load content on demand

### 4. Flat Memory Structure
**Problem**: Everything in memory/ root, hard to navigate

**Solution**: Use proper subdirectories: `sessions/`, `evolution/`, etc.

---

## References

- **ENTITY_SPEC.md**: Complete specification with all requirements
- **principles.md**: Design philosophy behind the architecture
- **birth_process.md**: How to create entities with this architecture
