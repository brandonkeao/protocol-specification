# Agent Birth Checklist

**Purpose**: Copy-paste operational checklist for executing an agent birth
**Reference**: See `ENTITY_SPEC.md` (v1.8) for full entity specification
**Reference**: See `specification/birth_process.md` for birth protocol
**Updated**: January 2026

---

## Pre-Birth Checklist

### Criteria Validation

- [ ] **20+ sessions** of accumulated history in the domain
- [ ] **Clear, bounded scope** - distinct from other domains
- [ ] **Ongoing specialized context** - needs long-term memory
- [ ] **Frequent recurring work** - not just occasional tasks

### Approval & Planning

- [ ] User explicitly approved birth
- [ ] Scope boundaries defined
- [ ] Routing rules drafted (what gets routed to this agent)
- [ ] Agent directory location decided
- [ ] Persona/personality identified

---

## Birth Ceremony

### Step 1: Create Directory Structure

```bash
# Create base directory
mkdir -p "[WORKSPACE]/[AGENT_NAME]"
cd "[WORKSPACE]/[AGENT_NAME]"

# Create context structure
mkdir -p context/kernel
mkdir -p context/conditional

# Create active work
mkdir -p active_work

# Create memory structure
mkdir -p memory/sessions/exports
mkdir -p memory/sessions/transcripts
mkdir -p memory/evolution/learnings
mkdir -p memory/evolution/decisions
mkdir -p memory/inbox
mkdir -p memory/messages_to_[PARENT]
mkdir -p memory/archive           # v1.8: For deprecated content

# Create data structure (customize for domain)
mkdir -p data/profiles
mkdir -p data/[domain_specific]

# Create .claude structure
mkdir -p .claude/skills
mkdir -p .claude/commands
```

**Files to create**:
- [ ] `CLAUDE.md` - Use template from `templates/CLAUDE.md.template`
- [ ] `context/kernel/role_definition.md`
- [ ] `context/kernel/operating_principles.md`
- [ ] `context/kernel/persona_profile.md`
- [ ] `context/kernel/[domain_knowledge].md` (optional)
- [ ] `active_work/current_objectives.md`

**Copy templates from parent or examples**:
```bash
# Copy session export template
cp "[PARENT]/memory/sessions/exports/_template.md" \
   "[AGENT_NAME]/memory/sessions/exports/"

# Copy learnings template
cp "[PARENT]/memory/evolution/learnings/_template.md" \
   "[AGENT_NAME]/memory/evolution/learnings/"

# Copy decisions template
cp "[PARENT]/memory/evolution/decisions/_template.md" \
   "[AGENT_NAME]/memory/evolution/decisions/"

# Copy inbox README (includes lifecycle documentation)
cp "[PARENT]/memory/inbox/_README.md" \
   "[AGENT_NAME]/memory/inbox/"
```

**Verify templates created**:
- [ ] `memory/sessions/exports/_template.md`
- [ ] `memory/evolution/learnings/_template.md`
- [ ] `memory/evolution/decisions/_template.md`
- [ ] `memory/inbox/_README.md`

### Step 2: Transfer Context

**Sessions** (`memory/sessions/exports/`):
- [ ] Identify sessions where >50% content is about new domain
- [ ] Move qualifying sessions to new agent's `memory/sessions/exports/`
- [ ] Leave mixed or non-domain sessions with parent

**Learnings** (`memory/evolution/learnings/`):
- [ ] Identify domain-specific learnings
- [ ] Move qualifying learnings to new agent's `memory/evolution/learnings/`
- [ ] Leave cross-domain or general system learnings with parent

**Decisions** (`memory/evolution/decisions/`):
- [ ] Identify domain architecture decisions
- [ ] Move qualifying decisions to new agent's `memory/evolution/decisions/`
- [ ] Leave system-wide operational decisions with parent

**Data** (`data/`):
- [ ] Identify domain-specific data to move
- [ ] Move domain data to new agent's `data/` structure
- [ ] Leave shared data in shared_memory (new agent references it)

### Step 3: Copy and Configure Skills

**Copy core skills**:
```bash
# From parent's skills directory (or from examples/jane-starter)
cp -r [PARENT]/.claude/skills/session-start/ [AGENT_NAME]/.claude/skills/
cp -r [PARENT]/.claude/skills/session-export/ [AGENT_NAME]/.claude/skills/
cp -r [PARENT]/.claude/skills/handoff/ [AGENT_NAME]/.claude/skills/
cp -r [PARENT]/.claude/skills/entity-diagnostic/ [AGENT_NAME]/.claude/skills/
```

**Update paths in each copied skill**:
- [ ] `session-start/SKILL.md` - Replace parent paths with new agent paths
- [ ] `session-export/SKILL.md` - Replace parent paths with new agent paths
- [ ] `handoff/SKILL.md` - Replace parent paths with new agent paths

**Remove parent-specific content from session-start**:
- [ ] Agent ecosystem table (if parent-specific)
- [ ] Quick wins surfacing (orchestrator-only)
- [ ] Parent-specific context loading

**Verify flat inbox structure in skills** (per ENTITY_SPEC v1.8):
- [ ] handoff skill uses `memory/inbox/YYYY-MM-DD_handoff-from-*.md` (NOT nested folders)
- [ ] session-export uses `memory/inbox/YYYY-MM-DD_skill-proposal-*.md` (NOT skill_proposals/)

**Copy command wrappers**:
```bash
cp [PARENT]/.claude/commands/session-start.md [AGENT_NAME]/.claude/commands/
cp [PARENT]/.claude/commands/session-end.md [AGENT_NAME]/.claude/commands/
```

### Step 4: Update Parent's Routing

Edit parent's `context/kernel/agent_coordination.md`:

- [ ] Add new agent to ecosystem table
- [ ] Add routing rules for new domain
- [ ] Define handoff patterns (when to route to this agent)

### Step 5: Log Birth Event

Create: `[PARENT]/memory/evolution/agent_births/YYYY-MM-DD_[agent-name].md`

```markdown
# Agent Birth Event: [Agent Name]

**Date**: [Date]
**Parent Agent**: [Parent Name]
**Child Agent**: [Agent Name]
**Location**: [workspace path]

---

## Domain Transferred

**[Domain Name]** including:
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

---

## Context Transferred

### Sessions (Moved)
- `YYYY-MM-DD_session-name.md` - [Brief description]

### Learnings (Moved)
- `YYYY-MM-DD_learning-name.md` - [Brief description]

### Decisions (Moved)
- `YYYY-MM-DD_decision-name.md` - [Brief description]

### Data (Moved)
- `data/[subdirectory]/` - [What was moved]

### Skills Copied
- session-start
- session-export
- handoff
- entity-diagnostic

---

## Routing Rules

**Route to [Agent Name] when**:
- [Trigger 1]
- [Trigger 2]
- [Trigger 3]

**Keep with Parent when**:
- [Exception 1]
- [Exception 2]

---

## Relationship Model

- **Parent-child with independence** - Parent gave birth, [Agent Name] evolves independently
- **Hub-spoke coordination** - Parent orchestrates, [Agent Name] executes in domain
- **Escalation path** - [Agent Name] escalates to parent when blocked
- **Communication** - Via messages_to_[parent]/ and inbox handoffs
```

### Step 6: Run Entity Diagnostic

Before declaring birth complete, validate compliance:

```bash
# Start a session with the new agent
cd "[WORKSPACE]/[AGENT_NAME]"
claude
# Run: /entity-diagnostic
```

**Diagnostic should show**:
- [ ] All required directories: PASS
- [ ] All required files: PASS
- [ ] Skills configured correctly: PASS
- [ ] Paths point to correct entity (not parent): PASS
- [ ] Inbox uses flat structure: PASS

### Step 7: Verify

**Structure verification**:
- [ ] All required directories exist
- [ ] CLAUDE.md loads correctly
- [ ] Kernel files are in place
- [ ] Templates are in place

**Skill verification**:
- [ ] New agent can run `/session-start`
- [ ] New agent can run `/session-end`
- [ ] Paths in skills point to new agent (not parent)

**Communication verification**:
- [ ] `messages_to_[parent]/` directory exists
- [ ] Escalation path documented in CLAUDE.md
- [ ] Inbox configured for receiving handoffs

**Operational verification**:
- [ ] First session boot works correctly
- [ ] Agent understands its scope boundaries

**Path verification** (common issues from ENTITY_SPEC v1.8):
- [ ] Uses `memory/sessions/exports/` (NOT `session_exports/`)
- [ ] Uses `active_work/current_objectives.md` (NOT `README.md`)
- [ ] Inbox is flat with YAML frontmatter (NO subfolders)

### Step 8: Set Up Memory Maintenance (v1.8)

**Archive directory ready**:
- [ ] `memory/archive/` directory exists

**Handle non-transferred content in parent**:
- [ ] Content evaluated but not transferred is documented
- [ ] Add notes: "Considered for [agent_name] birth, retained because [reason]"

**Initialize maintenance expectations**:
- [ ] Document weekly review cadence in operating_principles.md
- [ ] Plan for memory index creation (first session or manual)
- [ ] Establish archive triggers specific to domain

**Parent cleanup**:
- [ ] Transferred content removed from parent (not duplicated)
- [ ] Parent's memory index updated to remove transferred items

---

## Post-Birth

- [ ] Run `/entity-diagnostic` on new agent
- [ ] Verify parent's memory no longer contains moved domain content
- [ ] Monitor first few sessions for any issues
- [ ] Update documentation if significant changes

---

## Quick Reference: What Moves vs. Stays

| Content Type | Moves to New Agent | Stays with Parent |
|--------------|-------------------|-----------------|
| Sessions | >50% domain content | Mixed or non-domain |
| Learnings | Domain-specific patterns | Cross-domain patterns |
| Decisions | Domain architecture | System-wide operational |
| Data | Domain-specific | Shared (reference only) |
| Skills | Core skills (copied) | Orchestrator skills |
