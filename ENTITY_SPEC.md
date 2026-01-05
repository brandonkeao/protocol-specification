# Entity Specification Protocol

**Version**: 1.6
**Created**: January 2026
**Updated**: January 4, 2026
**Purpose**: Canonical specification for Jane-like entities

---

## Overview

### What is a "Jane-like Entity"?

A Jane-like entity is an AI agent with persistent identity, memory, and structured context. Unlike ephemeral assistants that reset each session, entities maintain continuity through a deliberate architecture that separates:

- **Who they are** (context)
- **What they've learned** (memory)
- **Facts about the world** (data)

### Design Philosophy

1. **Token-conscious**: Load only what's needed, when needed
2. **Semantic clarity**: Each directory has distinct purpose
3. **Progressive complexity**: Start minimal, grow as proven
4. **Portable**: Skills and structures work across entities

---

## Three-Layer Architecture

```
entity/
├── context/    # WHO I AM - Identity & Instructions
├── memory/     # WHAT I'VE LEARNED - Accumulated Experience
├── data/       # FACTS ABOUT THE WORLD - Reference Material
├── active_work/ # WHAT I'M DOING NOW - Current Focus
└── .claude/    # HOW I WORK - Skills & Configuration
```

### Semantic Distinctions

| Layer | Purpose | Changes When | Loading |
|-------|---------|--------------|---------|
| `context/` | Identity, instructions, operating principles | Role or behavior changes | Boot (always) |
| `memory/` | Session history, learnings, decisions | Every session | On demand |
| `data/` | External facts (people, domain info) | Facts change | On demand |
| `active_work/` | Current focus, objectives | Task changes | Boot (always) |
| `.claude/` | Skills, commands, configuration | Capabilities change | On invocation |

### Mental Model

| Directory | Analogy | Token Impact |
|-----------|---------|--------------|
| `context/` | Your job description | Loaded every session |
| `memory/` | Your work journal | Loaded selectively |
| `data/` | Your reference files | Loaded when relevant |
| `active_work/` | Your current task list | Loaded every session |
| `.claude/` | Your toolbox | Loaded on use |

---

## Entity Tiers

### Tier 1: Minimal Entity

For simple, ephemeral, or single-purpose agents.

**Required files:**
```
entity/
├── CLAUDE.md                           # System instructions
├── context/
│   └── kernel/
│       └── role_definition.md          # Who is this entity
└── active_work/
    └── current_objectives.md           # Current focus
```

**Characteristics:**
- No session continuity requirement
- No memory/ or data/ directories (can add later)
- No cross-entity communication
- Simple boot: load role + objectives

**Examples:** One-off research agent, utility bot, temporary task executor

---

### Tier 2: Full Entity

For persistent, domain-owning agents that maintain continuity.

**Required structure:**
```
entity/
├── CLAUDE.md                           # System instructions
├── context/
│   ├── kernel/
│   │   ├── role_definition.md          # Who is this entity
│   │   ├── operating_principles.md     # How it works
│   │   ├── persona_profile.md          # Personality/style
│   │   └── [domain_specific].md        # Domain knowledge (optional)
│   └── conditional/                    # Loaded when relevant
│       └── [topic].md
├── memory/
│   ├── sessions/                       # Session continuity
│   │   ├── exports/                    # Synthesized summaries
│   │   │   └── _template.md
│   │   └── transcripts/                # Raw conversation logs
│   ├── evolution/                      # Entity growth over time
│   │   ├── learnings/                  # Patterns discovered
│   │   │   └── _template.md
│   │   ├── decisions/                  # Architecture Decision Records
│   │   │   └── _template.md
│   │   ├── agent_births/               # Agent creation records (orchestrator)
│   │   └── reviews/                    # Weekly reviews
│   ├── inbox/                          # Cross-entity communication
│   │   └── _README.md
│   ├── system_health/                  # Diagnostics, token budgets
│   ├── raw_logs/                       # Operational artifacts
│   │   └── user_messages/              # Daily message archive
│   └── archive/                        # Legacy/historical content
├── data/
│   ├── profiles/                       # People
│   ├── [domain_specific]/              # Domain data
│   └── sources/                        # Archived raw materials
├── active_work/
│   └── current_objectives.md
└── .claude/
    ├── skills/
    │   ├── session-start/
    │   ├── session-export/
    │   ├── handoff/
    │   └── entity-diagnostic/
    ├── commands/
    └── settings.json
```

**Characteristics:**
- Session continuity (session-start, session-export skills)
- Cross-entity communication via inbox
- Memory accumulation over time
- Full boot sequence with context loading

**Examples:** Jane (orchestrator), Personal Branding, Engineer

---

## Entity Roles

### Orchestrator

A full entity with coordination capabilities.

**Additional requirements:**
- `context/kernel/agent_coordination.md` - Routing rules
- `context/kernel/_summary.md` - Lightweight boot summary
- `memory/evolution/agent_births/` - Records of spawned entities

**Responsibilities:**
- Routes requests to appropriate entities
- Spawns and manages other entities
- Owns cross-domain coordination
- Maintains hub-and-spoke architecture

**Example:** Jane

---

### Domain Specialist

A full entity scoped to a single domain.

**Characteristics:**
- No coordination file (reports to orchestrator)
- Focused kernel on domain expertise
- Communicates via inbox/handoffs

**Examples:** Personal Branding, Engineer

---

### Meta-Entity

A full entity that owns specification or infrastructure rather than a work domain.

**Additional requirements:**
- `context/kernel/specification_philosophy.md` - Core beliefs guiding the spec
- `docs/` - Canonical documentation owned by this entity
- `birth_protocol/` - Process documentation (if owns entity creation)

**Characteristics:**
- Peer relationship with orchestrator (not child)
- Owns standards, not work routing
- Coordinates via `messages_to_[peer]/` rather than escalating
- Maintains version history of owned specifications

**Responsibilities:**
- Maintains canonical specification(s)
- Validates entity conformance
- Evolves patterns based on ecosystem feedback
- Prepares specifications for broader distribution

**Relationship to other entities:**
- Does NOT report to orchestrator
- Orchestrator references Meta-Entity's specifications
- Communicates as peer, not through hierarchy

**Example:** Protocol (Entity Specification Authority)

---

## Required Files Detail

### CLAUDE.md

System instructions loaded every session. Contains:
- Entity identity and purpose
- Boot sequence instructions
- Pointers to key context files
- Core behaviors and constraints

### context/kernel/role_definition.md

- Primary role and purpose
- Core objectives
- Domain ownership
- Scope boundaries
- Success metrics

### context/kernel/operating_principles.md

- Decision-making framework (Type 1/2/3)
- Collaboration protocols
- Session memory system
- Quality standards
- Learning and adaptation

### context/kernel/persona_profile.md

- Personality traits (e.g., Enneagram type)
- Communication style
- Working relationships
- Strengths and growth areas

### context/kernel/_summary.md (optional)

A condensed version of kernel context for lightweight boot sessions.

**Purpose:** Reduce token load during tactical sessions by providing essential identity in ~200 lines instead of loading all 4 kernel files (~800+ lines).

**Required sections:**
- Entity name and role (1-2 lines)
- Core purpose (2-3 sentences)
- Key behaviors (3-5 bullet points)
- Decision framework summary (Type 1/2/3 quick reference)
- Current focus pointer (reference to `current_objectives.md`)

**When to use:**
- Lightweight boot (`/session-start` without `--full` flag)
- Quick tactical sessions
- When context window is constrained

**When to skip:**
- Full boot sessions (load all kernel files instead)
- Strategic planning sessions
- First session with new entity

**Loading rule:**
```
IF _summary.md exists AND lightweight mode:
  Load _summary.md (~200 lines)
ELSE:
  Load role_definition.md (~150 lines minimum)
```

**Token target:** ~1,500 tokens (vs ~6,000 for full kernel)

### active_work/current_objectives.md

- Current status
- Active priorities
- Recent milestones
- What's next

### context/conditional/ (Optional)

Context files loaded only when relevant to the current task.

#### Purpose

Conditional context reduces boot token load by separating "always needed" (kernel) from "sometimes needed" (conditional) context. Files here are indexed at boot but only loaded when contextually relevant.

#### What Goes Here

| Content Type | Example | Load When |
|--------------|---------|-----------|
| Domain deep-dives | `agent_birth_protocol.md` | Entity creation tasks |
| Process documentation | `weekly_review_process.md` | Review sessions |
| Reference material | `api_conventions.md` | Integration work |
| Historical context | `migration_notes.md` | Legacy discussions |

#### Loading Rules

1. **Boot**: Index files (list names, don't load content)
2. **During session**: Load when topic arises
3. **Trigger**: User mentions topic, or task matches `surface_when` in frontmatter

#### File Format

```markdown
---
surface_when: [keyword triggers]
token_estimate: [approximate tokens]
---

# [Topic]

[Content...]
```

#### Examples

**`context/conditional/agent_birth_protocol.md`**:
- Loaded when: User asks about entity creation, birth process
- Not loaded: Normal operational sessions

**`context/conditional/domain_knowledge.md`**:
- Loaded when: Deep domain questions arise
- Not loaded: Routine task execution

#### Anti-patterns

- Don't put frequently-needed content here (move to kernel)
- Don't create conditional files < 100 lines (just add to kernel)
- Don't duplicate content between kernel and conditional

### data/ Directory

Facts about the world that the entity references but doesn't create.

#### Structure

```
data/
├── profiles/                    # People
│   ├── [person_name].md
│   └── [team_name]/
│       └── [member].md
├── [domain_specific]/           # Domain data
│   └── [topic].md
└── sources/                     # Archived raw materials
    └── [source_name]/
```

#### File Formats

| Directory | Format | Required Fields |
|-----------|--------|-----------------|
| `profiles/` | Markdown | Name, role, relationship, contact |
| `[domain]/` | Markdown or JSON | Domain-dependent |
| `sources/` | Original format | Source attribution, date archived |

**Profile template:**
```markdown
# [Name]

**Role**: [Their role]
**Relationship**: [How they relate to entity's domain]
**Contact**: [Email, Slack, etc.]

## Context

[Relevant background for this entity's work]

## Preferences

[Working style, communication preferences]
```

#### Nesting Guidelines

| Depth | Use Case | Example |
|-------|----------|---------|
| 1 level | Simple categorization | `profiles/brandon.md` |
| 2 levels | Grouped items | `profiles/team/alice.md` |
| 3+ levels | Avoid - use flat with metadata | Use frontmatter tags instead |

#### Shared vs Private Data

| Location | Access | Use When |
|----------|--------|----------|
| `shared_memory/` | All entities read | Facts needed by multiple entities |
| `[entity]/data/` | This entity only | Domain-specific facts |

**Rule**: Don't duplicate shared data. Reference `shared_memory/` instead.

#### Retention

| Content Type | Retention | Archive Process |
|--------------|-----------|-----------------|
| Active profiles | Indefinite | Update as facts change |
| Domain data | Indefinite | Archive when obsolete |
| Sources | 1 year | Move to `archive/sources/` |

---

## Core Skills

Full entities must have these skills in `.claude/skills/`:

| Skill | Purpose | Portability |
|-------|---------|-------------|
| `session-start` | Initialize session, load context | Requires path updates |
| `session-export` | Generate session summaries for continuity | Requires path updates |
| `handoff` | Transition work to other entities | Requires path updates |
| `entity-diagnostic` | Self-assessment for health | Portable (no path changes) |

**Documentation maintenance skills** (recommended for orchestrators):

| Skill | Purpose | Portability |
|-------|---------|-------------|
| `infra-review` | Update INFRASTRUCTURE_OVERVIEW.md | Requires path updates |
| `update-protocol` | Update ENTITY_SPEC.md and skills index | Portable |

### Skill Structure

Each skill lives in its own directory under `.claude/skills/`:

```
.claude/skills/
├── session-start/
│   └── SKILL.md          # Skill definition and instructions
├── session-export/
│   └── SKILL.md
└── handoff/
    └── SKILL.md
```

#### SKILL.md Format

Every skill must have a `SKILL.md` file with these sections:

```markdown
# [Skill Name]

[One-line description of what this skill does]

## When to Use

[Triggers or contexts that invoke this skill]

## Process

[Step-by-step instructions the agent follows]

## Arguments (optional)

[If skill accepts arguments, document them here]

## Output

[What the skill produces - files created, reports generated, etc.]
```

**Required elements:**
- Clear process steps (numbered or bulleted)
- File paths use entity-relative references where possible
- Explicit output expectations

**Portability markers:**
- Skills containing hardcoded paths (e.g., `/jane/`) require updates during birth
- Skills using only relative paths or spec references are portable

#### Commands vs Skills

| Component | Location | Purpose |
|-----------|----------|---------|
| **Skills** | `.claude/skills/` | Full process definitions with detailed instructions |
| **Commands** | `.claude/commands/` | Short wrappers that invoke skills (e.g., `/session-start`) |

**Command wrapper example** (`.claude/commands/session-start.md`):
```markdown
Run the session-start skill from .claude/skills/session-start/SKILL.md
```

Commands provide the user-facing interface; skills contain the implementation.

### Skill Portability - Detailed Procedure

When copying skills during entity birth:

#### Step 1: Identify Skills to Copy

**Always copy these core skills**:
- `session-start/` - Requires path updates
- `session-export/` - Requires path updates
- `handoff/` - Requires path updates
- `entity-diagnostic/` - Portable (no path changes needed)

#### Step 2: Copy Skill Directories

```bash
cp -r /jane/.claude/skills/session-start/ /[newagent]/.claude/skills/
cp -r /jane/.claude/skills/session-export/ /[newagent]/.claude/skills/
cp -r /jane/.claude/skills/handoff/ /[newagent]/.claude/skills/
cp -r /jane/.claude/skills/entity-diagnostic/ /[newagent]/.claude/skills/
```

#### Step 3: Replace Paths in SKILL.md Files

**Search patterns**:
- `/jane/` → `/[newagent]/`
- `/Users/brandonkeao/AI Workspaces v4/jane/` → `/Users/brandonkeao/AI Workspaces v4/[newagent]/`

**Files to update**:
- `session-start/SKILL.md`
- `session-export/SKILL.md`
- `handoff/SKILL.md`

#### Step 4: Remove Jane-Specific Content

In `session-start/SKILL.md`, remove or adapt:
- Agent ecosystem table (Jane-specific)
- Quick wins surfacing (orchestrator-only)
- Family context loading (Jane-specific)
- Inbox items from other entities

#### Step 5: Copy Command Wrappers

```bash
cp /jane/.claude/commands/session-start.md /[newagent]/.claude/commands/
cp /jane/.claude/commands/session-end.md /[newagent]/.claude/commands/
```

Update paths in command files if they contain absolute references.

#### Step 6: Test

1. Start session with new agent
2. Run `/session-start` - verify boot works
3. Run `/session-end` - verify export created
4. Check no errors about missing paths

---

## Boot Sequence

### Lightweight Boot (default)

Token target: ~2k tokens (~1% of 200k)

1. Load `context/kernel/_summary.md` (if exists) OR `role_definition.md`
2. Load `active_work/current_objectives.md`
3. Check `memory/inbox/` for pending items
4. Brief boot report

### Full Boot (--full flag)

Token target: ~13k tokens (~6.5% of 200k)

1. Load all kernel files (4 files)
2. Load current objectives
3. Load recent session exports (2-3)
4. Check for same-day sessions (load if found)
5. Surface relevant learnings
6. Check inbox
7. Full boot report with context summary

---

## Inbox Protocol

### Structure

Flat folder with YAML frontmatter (no nested subfolders):

```
memory/inbox/
├── _README.md
├── 2026-01-03_handoff-from-engineer-topic.md
├── 2026-01-03_follow-up-review.md
└── 2026-01-03_skill-proposal-new-skill.md
```

**Important**: All inbox items go directly in `memory/inbox/`. No subfolders (e.g., no `handoffs/`, `skill_proposals/`). Use the `type` field in frontmatter for categorization.

### Frontmatter Format

```yaml
---
type: handoff | follow_up | skill_proposal
from: [source entity]
to: [target entity]
status: pending | acknowledged | completed | dismissed
priority: high | medium | low
created: YYYY-MM-DD
completed: YYYY-MM-DD  # when applicable
surface_when: [context triggers]  # optional
---
```

### Why Flat Structure?

- Metadata belongs in files, not folder names
- Single glob pattern for scanning
- Easier to query and process
- No multi-path scanning complexity

### Message Examples

See `docs/templates/inbox_message_examples.md` for concrete YAML examples of:
- `type: handoff` - Work transitions
- `type: follow_up` - Self-reminders
- `type: skill_proposal` - Capability requests

### Human-in-the-Loop Requirement

**Critical**: Inbox items require human operator acknowledgment.

| Action | Entity Can Do? | Human Required? |
|--------|----------------|-----------------|
| Surface pending items | Yes (mandatory) | - |
| Acknowledge items | No | Yes |
| Complete items | No | Yes |
| Dismiss items | No | Yes |

**Rationale**: Inbox is a cross-entity communication channel. Humans must see all messages to maintain oversight of agent coordination.

**Process**:
1. Entity surfaces ALL pending items during boot (no filtering)
2. Entity presents item to human with summary
3. Human decides: acknowledge, complete, or dismiss
4. Entity updates status ONLY after human authorization

**Enforcement**: Session-start skills MUST surface all pending inbox items. Entities MUST NOT autonomously change inbox item status.

### Inbox Lifecycle

#### Status Transitions

```
pending → acknowledged → completed
                      ↘ dismissed
```

| Status | Meaning | Next States |
|--------|---------|-------------|
| **pending** | New, unread item | acknowledged |
| **acknowledged** | Human has seen and accepted | completed, dismissed |
| **completed** | Work finished successfully | (terminal) |
| **dismissed** | Declined or no longer relevant | (terminal) |

#### Completed vs Dismissed

| Use `completed` when... | Use `dismissed` when... |
|-------------------------|-------------------------|
| Handoff work was done | Request is no longer needed |
| Follow-up was addressed | Duplicate of another item |
| Proposal was implemented | Decision made not to proceed |
| Task finished successfully | Item was created in error |

#### Retention and Cleanup

| Status | Retention Period | Action After |
|--------|------------------|--------------|
| pending | Indefinite | Stays until processed |
| acknowledged | Indefinite | Stays until completed/dismissed |
| completed | 14 days | Move to `memory/archive/inbox/` |
| dismissed | 7 days | Delete |

**Stale item warning**: Items pending > 14 days should trigger WARN in entity-diagnostic.

---

## Escalation Protocol

### Child-to-Parent Communication

Domain specialists communicate with their parent (orchestrator) through two channels:

#### 1. messages_to_[parent]/ (Informal, Quick)

**Location**: `memory/messages_to_jane/` (or appropriate parent)
**Purpose**: Quick notes, questions, status updates
**Format**: Simple markdown, no YAML required

**File naming**: `YYYY-MM-DD_[slug].md`

**Template**:
```markdown
# [Topic]

**Date**: [Date]
**From**: [This entity]
**Type**: Question | Status Update | Action Item

---

[Content]

---

**Status**: Pending
```

**When to use**:
- Quick status updates
- Questions needing parent input
- Action items for parent
- Non-blocking requests

#### 2. Inbox Handoff (Formal, Tracked)

**Location**: `/[parent]/memory/inbox/`
**Purpose**: Formal work transitions requiring tracking
**Format**: YAML frontmatter with status lifecycle

**When to use**:
- Completing work phase needing review
- Blocking issues requiring architectural decision
- Cross-domain coordination needs
- Formal deliverables

### Escalation SLAs and Handling

#### Checking Frequency

| Channel | Check Frequency | Responsibility |
|---------|-----------------|----------------|
| `messages_to_[parent]/` | Each parent session boot | Parent entity |
| Inbox handoffs | Each session boot | Receiving entity |

**Note**: Parents check child message directories during their own boot sequence, not continuously.

#### Priority Handling

| Priority | Expected Response | Use Case |
|----------|-------------------|----------|
| **high** | Same session if possible | Blocking issues, urgent decisions |
| **medium** | Within 1-2 sessions | Normal workflow transitions |
| **low** | When convenient | FYI items, non-blocking updates |

#### Cleanup and Archival

| Item Type | Retention | Archive Process |
|-----------|-----------|-----------------|
| `messages_to_[parent]/` | Until acknowledged | Parent moves to `archive/` or deletes after processing |
| Inbox items (completed) | 14 days | Move to `memory/archive/inbox/` after 14 days |
| Inbox items (dismissed) | 7 days | Delete after 7 days |

**Cleanup responsibility**: Each entity manages its own inbox cleanup. Parents manage their `messages_from_[child]/` cleanup.

### Setup During Birth

When birthing a Tier 2 entity:

1. Create `memory/messages_to_jane/` directory (or appropriate parent)
2. Document escalation path in CLAUDE.md "Relationship" section
3. Add to operating_principles.md: when to escalate

---

## Token Budget Guidelines

### Thresholds

| Mode | Target | Warning | Alarm |
|------|--------|---------|-------|
| Lightweight | ~2k | 2.5k | 3.5k |
| Full | ~13k | 15k | 20k |

### Estimation

- ~7.5 tokens per line (markdown average)
- Measure with `wc -l` on relevant files

### Tracked in

`memory/system_health/token_budget.md`

---

## Diagnostic Criteria

Run `/entity-diagnostic` to check:

### 1. Structure Validation
- Required files present
- Required directories present
- Templates in place

### 2. Skill Verification
- Core skills present
- Paths point to correct entity
- Skills registered in index

### 3. Protocol Alignment
- Inbox uses flat structure
- Items have YAML frontmatter
- Session continuity implemented

### 4. Operational Health
- Recent session activity
- No stale inbox items (>14 days)
- Objectives current

### 5. Entity-Specific
- Orchestrator: routing rules, agent ecosystem
- Domain Specialist: domain context present
- Meta-Entity: specification ownership, docs/ directory

### Diagnostic Examples

#### Example 1: Structure Validation

```
Structure Validation
├── CLAUDE.md                    [PASS]
├── context/kernel/
│   ├── role_definition.md       [PASS]
│   ├── operating_principles.md  [PASS]
│   └── persona_profile.md       [WARN] Missing - using role_definition only
├── memory/sessions/exports/     [PASS]
├── memory/inbox/                [PASS]
└── .claude/skills/              [FAIL] Directory missing
```

**Remediation for FAIL**:
```bash
mkdir -p .claude/skills
# Copy core skills from parent entity
```

#### Example 2: Inbox Health

```
Inbox Health
├── Flat structure               [PASS]
├── YAML frontmatter             [PASS]
├── Stale items check
│   ├── 2026-01-01_old-handoff   [WARN] Pending 18 days
│   └── 2025-12-15_ancient-item  [FAIL] Pending 34 days
```

**Remediation for stale items**:
1. Review each stale item with human operator
2. Acknowledge, complete, or dismiss as appropriate
3. If no longer relevant, dismiss with note explaining why

#### Example 3: Skill Verification

```
Skill Verification
├── session-start/SKILL.md       [PASS]
├── session-export/SKILL.md      [PASS]
├── handoff/SKILL.md             [WARN] Contains /jane/ paths
└── entity-diagnostic/SKILL.md   [PASS]
```

**Remediation for path issues**:
1. Search for `/jane/` in skill files
2. Replace with correct entity path
3. Verify skill works with `/session-start` test

#### Example 4: Entity-Specific (Orchestrator)

```
Orchestrator Checks
├── agent_coordination.md        [PASS]
├── Agent ecosystem current      [WARN] 2 entities not in coordination file
└── Routing rules defined        [PASS]
```

**Remediation for missing entities**:
1. Add missing entities to agent_coordination.md
2. Define routing rules for each
3. Update agent ecosystem table

### Status Definitions

| Status | Meaning | Action |
|--------|---------|--------|
| PASS | Check succeeded | None required |
| WARN | Minor issue | Address when convenient, within 2-3 sessions |
| FAIL | Critical issue | Address immediately, blocks healthy operation |

---

## Evolution

### Upgrading Tier 1 → Tier 2

When a minimal entity needs persistence:

1. Add `memory/` structure
2. Add `data/` structure
3. Copy core skills from parent
4. Update paths in skills
5. Add inbox for communication

### Entity Birth Process

See `birth_protocol/agent_birth_protocol.md` for:
- When to propose birth
- Pre-birth checklist
- File ownership rules
- Birth ceremony steps

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | January 3, 2026 | Initial specification |
| 1.1 | January 3, 2026 | Added documentation maintenance skills (infra-review, update-protocol) |
| 1.2 | January 3, 2026 | Added detailed skill portability procedure, escalation protocol, inbox message examples reference |
| 1.3 | January 3, 2026 | Added human-in-the-loop requirement for inbox processing |
| 1.4 | January 4, 2026 | Protocol standardization: confirmed `memory/sessions/exports/` path, `current_objectives.md` naming, flat inbox for all types including skill proposals and handoffs |
| 1.5 | January 4, 2026 | Added Meta-Entity role (Tier 2 variant), defined `_summary.md` format and template, fixed path references to `birth_protocol/` |
| 1.6 | January 4, 2026 | Gap completion: skill structure, escalation SLAs, inbox lifecycle, conditional context, data directory, diagnostic examples, 6 new templates, memory transfer review in birth |

---

**This specification defines what it means to be a Jane-like entity. All entities in the ecosystem should conform to these standards for interoperability and maintainability.**
