# Agent Birth Protocol

**Created**: 2026-01-03
**Updated**: 2026-01-08
**Purpose**: Clear rules for creating permanent agents and transferring context
**Load When**: Preparing to birth a new agent
**Reference**: See `docs/ENTITY_SPEC.md` for the full entity specification (Tier 2: Full Entity)
**Templates**: See `docs/templates/` for CLAUDE.md template and birth checklist

---

## When to Propose Birth

A domain is ready for dedicated agent when:

- [ ] **20+ sessions** of accumulated history in the domain
- [ ] **Clear, bounded scope** - distinct from other domains
- [ ] **Ongoing specialized context** - needs long-term memory
- [ ] **Frequent recurring work** - not just occasional tasks

**Process**: Jane notices pattern → proposes to Brandon → Brandon approves → execute birth

---

## Pre-Birth Checklist

Before creating the new agent:

### Domain Readiness
- [ ] Domain meets criteria above
- [ ] User explicitly approves birth
- [ ] Clear scope boundaries defined
- [ ] Routing rules drafted
- [ ] Agent directory location decided
- [ ] Persona/personality identified

### Infrastructure Verification (One-Time)

Verify ecosystem infrastructure is in place. These are user-level and only need to be set up once:

- [ ] **Cortex installed** (optional but recommended)
  - Check: `/cortex:stats` returns data
  - If not: See `/shared_memory/tools/claude-code-setup.md`
  - Note: User-level install automatically applies to ALL entity workspaces

- [ ] **Shared memory accessible**
  - Check: `/shared_memory/` directory exists with `keao_family.md`, `projects/`, `tools/`

---

## File Ownership Rules

### Sessions (`memory/sessions/exports/`)

**Rule**: Session moves if >50% of content is about the new domain

| Session Content | Action |
|-----------------|--------|
| Primarily about new domain | Move to new agent |
| Mixed (new domain + other) | Manual review - consider copying or summarizing |
| Not about new domain | Stay with Jane |

**Example**: Session about "LinkedIn voice analysis" → moves to Personal Branding

### Learnings (`memory/learnings/`)

**Rule**: Learning moves if primary subject is the new domain

| Learning Subject | Action |
|------------------|--------|
| Domain-specific pattern | Move |
| Cross-domain or general system | Stay with Jane |
| About new agent's tools/workflow | Move |

**Example**: "Voice calibration from evidence" → moves to Personal Branding

### Decisions (`memory/decisions/`)

**Rule**: Architectural decisions for domain move; operational decisions stay

| Decision Type | Action |
|---------------|--------|
| Domain architecture | Move |
| Domain-specific process | Move |
| System-wide operational | Stay with Jane |
| Cross-domain coordination | Stay with Jane |

**Example**: "CIQ Architecture" → moves to Engineer (domain architecture)

### Skills (`.claude/skills/`)

**Core skills to COPY** (always):
- `session-start/` - Session initialization
- `session-export/` - Session continuity
- `handoff/` - Cross-entity communication
- `entity-diagnostic/` - Self-assessment (portable, no path changes needed)

**Domain-specific skills**: Create fresh for new agent

**Note**: Copied skills need path customization (see Skill Portability Pattern)

### Shared Resources

| Resource | Access |
|----------|--------|
| `shared_memory/` | Read access, don't duplicate |
| `jane/data/profiles/` | Read access, don't duplicate |
| Domain-specific data | Move or create in new agent |

### Data Directory (`data/`)

**Rule**: Domain-specific data moves; shared data stays referenced

| Content Type | Action |
|--------------|--------|
| Domain-specific profiles (e.g., household members) | Move to new agent's `data/profiles/` |
| Domain data (e.g., Trello conventions) | Move to new agent's `data/[domain]/` |
| Shared profiles (Brandon) | Keep in shared_memory, reference |
| Shared facts | Keep in shared_memory, reference |

**Example (Keao Household birth)**:
- `jane/data/household/` → moves to `keao_household/data/household/`
- `jane/data/profiles/family/` → moves to `keao_household/data/profiles/family/`
- `jane/data/profiles/brandon_keao.md` → stays, new agent references shared_memory

---

## Birth Ceremony

### Step 1: Create Directory Structure

```
/[agent_name]/
├── CLAUDE.md                    # System instructions
├── context/
│   └── kernel/
│       ├── role_definition.md
│       ├── operating_principles.md
│       ├── persona_profile.md
│       └── [domain_specific].md
├── active_work/
│   └── current_objectives.md
├── memory/
│   ├── sessions/
│   │   └── exports/
│   │       └── _template.md
│   ├── learnings/
│   │   └── _template.md
│   ├── decisions/
│   │   └── _template.md
│   ├── inbox/                  # Flat structure with YAML frontmatter
│   │   └── _README.md
│   └── messages_to_jane/       # Escalation channel to parent
└── .claude/
    ├── skills/
    │   ├── session-start/
    │   ├── session-export/
    │   ├── handoff/
    │   └── entity-diagnostic/
    └── commands/
        └── session-start.md
```

### Step 2: Transfer Context

1. Identify files using ownership rules above
2. Move qualifying sessions to new agent's `sessions/exports/`
3. Move qualifying learnings to new agent's `learnings/`
4. Move qualifying decisions to new agent's `decisions/`
5. Copy core skills and customize paths

#### Memory Transfer Review (Critical)

Parent entity memory often contains learnings and decisions that belong with the new entity. This step ensures domain-relevant knowledge transfers properly.

**Process**:

1. **Scan parent's learnings** (`memory/evolution/learnings/`):
   - List all learnings with titles and categories
   - For each, assess domain relevance

2. **Scan parent's decisions** (`memory/evolution/decisions/`):
   - List all ADRs with titles and status
   - For each, assess domain ownership

3. **For each item, decide**:

| Action | Criteria | Example |
|--------|----------|---------|
| **Copy** | Primarily about new entity's domain | Voice pattern learning → Personal Branding |
| **Reference** | Mentions domain but belongs to parent | Cross-domain workflow decision |
| **Skip** | Not relevant to new entity | System-wide operational learning |

4. **Transfer selected files**:
   - Copy to new entity's memory
   - Optionally add note: "Transferred from [parent] during birth on [date]"

**Evidence-based addition**: This step was added after Protocol's birth revealed that 2 learnings (`avoid-folder-based-type-encoding`, `index-dont-load-pattern`) should have transferred from Jane but were nearly missed without explicit review.

### Step 3: Configure Skills

For each copied skill:
1. Search for Jane's paths
2. Replace with new agent's paths
3. Test skill invocation works

### Step 4: Update Routing

Edit Jane's `context/kernel/agent_coordination.md`:
1. Add new agent to ecosystem table
2. Add routing rules for new domain
3. Define handoff patterns

### Step 4.5: Configure Trello Label

**Note**: Family entity uses existing household boards. Other entities use the shared "Entity Tasks" board.

1. **Create entity label** on "Entity Tasks" board:
   - Label name: `[entity-id]` (e.g., `finance`, `personal-branding`)
   - Choose color that's not already used by another entity
   - Current colors: jane (blue), engineer (green), personal-branding (purple), protocol (gray), finance (yellow)

2. **Document label** in birth event log (Step 5)

3. **Verify CIQ captures** the new label in Trello events

### Step 5: Log Birth Event

Create: `jane/memory/agent_births/YYYY-MM-DD_[agent-name].md`

```markdown
## Agent Birth Event

**Date**: [Date]
**Child Agent**: [agent_name]
**Domain**: [domain description]

### Context Transfer
- Sessions moved: [list]
- Learnings moved: [list]
- Decisions moved: [list]
- Skills copied: [list]

### Routing Update
- When to route: [triggers]
- Scope boundaries: [what agent owns vs. what stays with Jane]

### Relationship
- Parent: Jane (orchestrator)
- Child: [agent_name] (domain specialist)
- Model: Loose linkage - "I knew all this, now go become your own thing"
```

### Step 6: Verify

**Structure verification**:
- [ ] All required directories exist
- [ ] CLAUDE.md loads correctly (use template from `docs/templates/`)
- [ ] Kernel files are in place
- [ ] Templates are in place

**Skill verification**:
- [ ] New agent can run `/session-start`
- [ ] New agent can run `/session-end`
- [ ] Paths in skills point to new agent (not Jane)

**Escalation verification**:
- [ ] `messages_to_jane/` directory exists
- [ ] Escalation path documented in CLAUDE.md
- [ ] operating_principles.md includes when to escalate

**Operational verification**:
- [ ] Inbox configured for receiving handoffs
- [ ] First session boot works

**Trello verification** (if not Family entity):
- [ ] Entity label created on "Entity Tasks" board
- [ ] Label color doesn't conflict with existing entities
- [ ] CIQ receives Trello events for new entity's cards

---

## Post-Birth Relationship

**"Giving Birth" Philosophy**:
> "I knew all this up until I gave birth to you. Go become your own thing."

- **Independence**: New agent evolves its own context and learnings
- **Coordination**: Hub-and-spoke via Jane (no direct agent-to-agent)
- **Escalation**: Agent escalates to Jane when blocked or cross-domain
- **Memory**: Agent maintains its own memory; Jane doesn't duplicate

---

## Common Mistakes to Avoid

1. **Incomplete file sweep**: Always do a final check for stragglers
2. **Path not updated in skills**: Skills will fail if paths point to Jane
3. **Missing handoff infrastructure**: New agent needs inbox configured
4. **Scope creep**: Keep boundaries clear from day 1
5. **Over-transferring**: Only move what's truly domain-specific

---

## Examples

### Personal Branding Birth (Dec 30, 2025)

**Domain**: Brand & Marketing (LinkedIn, website, thought leadership)

**Transferred**:
- 2 sessions (voice analysis, content strategy)
- 2 learnings (voice patterns, workflow)
- Core skills (session-start, session-export)

**Routing**: LinkedIn, content, brand voice → Personal Branding

### Engineer Birth (Dec 30, 2025)

**Domain**: Software Development (implementation, code, deployment)

**Transferred**:
- Started fresh (clean slate approach)
- Core skills only
- First project: CIQ handoff from Jane

**Routing**: Implementation handoffs → Engineer

---

**Last Updated**: 2026-01-26

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-01-03 | Initial protocol |
| 1.1 | 2026-01-08 | Added Trello label configuration, memory transfer review |
| 1.2 | 2026-01-26 | Added Infrastructure Verification (Cortex check) in pre-birth checklist |
