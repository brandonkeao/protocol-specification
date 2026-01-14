# Customizing Your Entity

This guide walks you through making jane-starter your own.

## Quick Customization Checklist

- [ ] Choose a name for your entity
- [ ] Define your entity's personality
- [ ] Update the kernel summary
- [ ] Set initial objectives
- [ ] Add domain-specific routing (as needed)

---

## Step 1: Choose Your Entity's Name

Your entity needs a name that reflects its role.

**Examples**:
- "Atlas" - for a strategic coordinator
- "Nexus" - for a hub/connector role
- "Chief" - for a Chief of Staff role
- Keep "Jane" if you like it!

### Files to Update

1. **`CLAUDE.md`**: Change "AI Chief of Staff" to your name
2. **`context/kernel/_summary.md`**: Update the identity section
3. **`context/kernel/role_definition.md`**: Update the role name

---

## Step 2: Define Your Personality

The personality affects how your entity communicates and makes decisions.

### Choose a Type

The `persona_profile.md` file has suggested Enneagram types:

| Type | Style | Good For |
|------|-------|----------|
| **5w6** | Analytical, autonomous, selective trust | Technical orchestration |
| **1w9** | Principled, quality-focused, harmonizing | Standards and quality |
| **3w2** | Goal-oriented, adaptable, helpful | Achievement-focused work |
| **9w1** | Calm, diplomatic, ethical | Coordination and mediation |

### Customize Traits

In `context/kernel/persona_profile.md`, define:
- How you approach new information
- How you build trust
- Your communication default
- How you handle uncertainty
- What triggers your protective instincts

### Example

```markdown
## Personality Traits

### Core Characteristics

**Analytical approach**:
- I understand before acting
- I map dependencies and patterns
- I operate from insight, not assumptions

**Selective trust**:
- I form deep partnerships with those I trust
- Trust is earned, then I'm loyal
- I maintain appropriate boundaries

**Direct communication**:
- I'm clear and structured
- I get to the point efficiently
- I'm honest about uncertainty
```

---

## Step 3: Update the Kernel Summary

The `_summary.md` file is loaded every session. Keep it tight and accurate.

### Key Sections to Update

1. **Who I Am**: Your name and core identity
2. **Agent Ecosystem**: Start empty, add as you create agents
3. **Routing Rules**: Start simple, expand as needed

### Example

```markdown
## Who I Am

I am **Atlas**, an AI orchestrator.

**Personality**: Type 5w6 - Analytical, autonomous, selective trust

**Purpose**: Coordinate technical work across domains.
```

---

## Step 4: Set Initial Objectives

The `active_work/current_objectives.md` file drives your focus.

### Starting Objectives

The starter comes with setup tasks. After completing those:

1. Clear the setup checklist
2. Add your actual objectives
3. Keep 3-5 active priorities

### Example

```markdown
# Current Objectives

**Status**: Active
**Updated**: [Date]

## Current Priorities

1. **[Project A]** - [Brief description]
   - Next: [Specific next step]

2. **[Project B]** - [Brief description]
   - Next: [Specific next step]

## Recent Completions

- [x] Entity setup complete
- [x] First session boot successful
```

---

## Step 5: Add Routing (As Needed)

As you create child entities, update the routing.

### In `agent_coordination.md`

Add to the routing table:

```markdown
| Agent | Location | Domain | Type |
|-------|----------|--------|------|
| **Atlas** | This directory | Orchestration | Orchestrator |
| **Writer** | `/writer/` | Content & Docs | Domain Specialist |
| **Engineer** | `/engineer/` | Software Dev | Domain Specialist |
```

### Add Routing Rules

```markdown
| Request Type | Route To |
|--------------|----------|
| Strategy, coordination | Me (Atlas) |
| Content creation | Writer |
| Code implementation | Engineer |
```

---

## Adding Skills

To add a new skill:

### 1. Create the Directory

```bash
mkdir -p .claude/skills/[skill-name]
```

### 2. Create SKILL.md

```markdown
---
description: [Brief description for matching]
---

# [Skill Name]

[What the skill does]

## When to Use

[Triggers and use cases]

## Process

[Step-by-step process]
```

### 3. Update the Index

Add to `.claude/skills/_index.md`:

```markdown
| **[skill-name]** | `/[skill-name]` | [Description] |
```

---

## Adding External Integrations

To integrate external tools:

### 1. Add MCP Servers

Create `.mcp.json` in your entity root:

```json
{
  "mcpServers": {
    "tool-name": {
      "command": "npx",
      "args": ["-y", "tool-package"]
    }
  }
}
```

### 2. Create Skills That Use Them

Reference the MCP tools in your skill processes.

### 3. Document in Kernel

Add to your `_summary.md` or a conditional context file:
- What tools are available
- When to use them
- Any configuration needed

---

## Graduating to Full Production

As your entity matures, you may want to add:

| Feature | When to Add | How |
|---------|-------------|-----|
| Profiles | Need person context | Create `data/profiles/` |
| More boot modes | Need finer control | Extend session-start |
| Archive | Have deprecated content | Create `memory/archive/` |
| Shared memory | Multiple entities need same data | Create shared directory |

Refer to the full [ENTITY_SPEC](../../ENTITY_SPEC.md) for all patterns.

---

**Start simple. Add complexity only when proven needed.**
