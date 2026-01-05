# Agent Birth Protocol

**Purpose**: Clear rules for creating permanent agents and transferring context
**Load When**: Preparing to birth a new agent
**Reference**: See `ENTITY_SPEC.md` for the full entity specification (Tier 2: Full Entity)
**Templates**: See `templates/` for CLAUDE.md template and birth checklist

---

## When to Propose Birth

A domain is ready for dedicated agent when:

- [ ] **20+ sessions** of accumulated history in the domain
- [ ] **Clear, bounded scope** - distinct from other domains
- [ ] **Ongoing specialized context** - needs long-term memory
- [ ] **Frequent recurring work** - not just occasional tasks

**Process**: Orchestrator notices pattern → proposes to human → human approves → execute birth

---

## Pre-Birth Checklist

Before creating the new agent:

- [ ] Domain meets criteria above
- [ ] User explicitly approves birth
- [ ] Clear scope boundaries defined
- [ ] Routing rules drafted
- [ ] Agent directory location decided
- [ ] Persona/personality identified

---

## File Ownership Rules

### Sessions (`memory/sessions/exports/`)

**Rule**: Session moves if >50% of content is about the new domain

| Session Content | Action |
|-----------------|--------|
| Primarily about new domain | Move to new agent |
| Mixed (new domain + other) | Manual review - consider copying or summarizing |
| Not about new domain | Stay with parent |

**Example**: Session about "marketing strategy analysis" → moves to Marketing entity

### Learnings (`memory/learnings/`)

**Rule**: Learning moves if primary subject is the new domain

| Learning Subject | Action |
|------------------|--------|
| Domain-specific pattern | Move |
| Cross-domain or general system | Stay with parent |
| About new agent's tools/workflow | Move |

**Example**: "Content optimization pattern" → moves to Content entity

### Decisions (`memory/decisions/`)

**Rule**: Architectural decisions for domain move; operational decisions stay

| Decision Type | Action |
|---------------|--------|
| Domain architecture | Move |
| Domain-specific process | Move |
| System-wide operational | Stay with parent |
| Cross-domain coordination | Stay with parent |

**Example**: "API Architecture" → moves to Engineering entity (domain architecture)

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
| Parent's `data/profiles/` | Read access, don't duplicate |
| Domain-specific data | Move or create in new agent |

### Data Directory (`data/`)

**Rule**: Domain-specific data moves; shared data stays referenced

| Content Type | Action |
|--------------|--------|
| Domain-specific profiles | Move to new agent's `data/profiles/` |
| Domain data | Move to new agent's `data/[domain]/` |
| Shared profiles | Keep in shared_memory, reference |
| Shared facts | Keep in shared_memory, reference |

**Example (Household domain birth)**:
- `parent/data/household/` → moves to `[entity_name]/data/household/`
- `parent/data/profiles/family/` → moves to `[entity_name]/data/profiles/family/`
- `parent/data/profiles/user.md` → stays, new agent references shared_memory

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
│   └── messages_to_[parent]/   # Escalation channel to parent
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
| **Copy** | Primarily about new entity's domain | Domain pattern learning → New entity |
| **Reference** | Mentions domain but belongs to parent | Cross-domain workflow decision |
| **Skip** | Not relevant to new entity | System-wide operational learning |

4. **Transfer selected files**:
   - Copy to new entity's memory
   - Optionally add note: "Transferred from [parent] during birth on [date]"

### Step 3: Configure Skills

For each copied skill:
1. Search for parent's paths
2. Replace with new agent's paths
3. Test skill invocation works

### Step 4: Update Routing

Edit parent's `context/kernel/agent_coordination.md`:
1. Add new agent to ecosystem table
2. Add routing rules for new domain
3. Define handoff patterns

### Step 5: Log Birth Event

Create: `parent/memory/agent_births/YYYY-MM-DD_[agent-name].md`

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
- Scope boundaries: [what agent owns vs. what stays with parent]

### Relationship
- Parent: [parent_name] (orchestrator)
- Child: [agent_name] (domain specialist)
- Model: Loose linkage - "I knew all this, now go become your own thing"
```

### Step 6: Verify

**Structure verification**:
- [ ] All required directories exist
- [ ] CLAUDE.md loads correctly (use template from `templates/`)
- [ ] Kernel files are in place
- [ ] Templates are in place

**Skill verification**:
- [ ] New agent can run `/session-start`
- [ ] New agent can run `/session-end`
- [ ] Paths in skills point to new agent (not parent)

**Escalation verification**:
- [ ] `messages_to_[parent]/` directory exists
- [ ] Escalation path documented in CLAUDE.md
- [ ] operating_principles.md includes when to escalate

**Operational verification**:
- [ ] Inbox configured for receiving handoffs
- [ ] First session boot works

---

## Post-Birth Relationship

**"Giving Birth" Philosophy**:
> "I knew all this up until I gave birth to you. Go become your own thing."

- **Independence**: New agent evolves its own context and learnings
- **Coordination**: Hub-and-spoke via parent orchestrator (no direct agent-to-agent)
- **Escalation**: Agent escalates to parent when blocked or cross-domain
- **Memory**: Agent maintains its own memory; parent doesn't duplicate

---

## Common Mistakes to Avoid

1. **Incomplete file sweep**: Always do a final check for stragglers
2. **Path not updated in skills**: Skills will fail if paths point to parent
3. **Missing handoff infrastructure**: New agent needs inbox configured
4. **Scope creep**: Keep boundaries clear from day 1
5. **Over-transferring**: Only move what's truly domain-specific

---

## Example Birth Scenarios

### Marketing Entity Birth

**Domain**: Brand & Marketing (content, social media, thought leadership)

**Transferred**:
- 2-3 sessions (voice analysis, content strategy)
- 2 learnings (voice patterns, workflow)
- Core skills (session-start, session-export)

**Routing**: Content creation, brand voice, marketing strategy → Marketing entity

### Engineering Entity Birth

**Domain**: Software Development (implementation, code, deployment)

**Transferred**:
- Started fresh (clean slate approach)
- Core skills only
- First project: Implementation handoff from parent

**Routing**: Implementation handoffs, technical work → Engineering entity

---

**Reference**: ENTITY_SPEC.md for full structure requirements
