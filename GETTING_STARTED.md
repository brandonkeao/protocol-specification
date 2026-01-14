# Getting Started with Jane-like Entities

Create your first AI entity in under 10 minutes.

## Quick Glossary

| Term | Meaning |
|------|---------|
| **Entity** | An AI agent with persistent identity and memory |
| **Boot** | Starting an entity session with context loaded |
| **Kernel** | Core identity files (who the entity is) |
| **Tier 1** | Minimal entity - just identity and objectives |
| **Tier 2** | Full entity - with memory, inbox, and skills |

---

## Option 1: Use the Setup Wizard (Recommended)

```bash
cd protocol-specification/scripts
npm install
node create-entity.js
```

Follow the prompts:
1. Enter entity name (e.g., "research-assistant")
2. Describe its purpose
3. Choose Tier 1 (minimal) or Tier 2 (full)
4. Done! Your entity is ready to boot.

---

## Option 2: Use jane-starter (Full Experience)

Want to experience a complete Tier 2 orchestrator immediately?

```bash
# Copy jane-starter to your workspace
cp -r examples/jane-starter ~/my-workspace/orchestrator
cd ~/my-workspace/orchestrator

# Boot it up
claude
```

Then run `/session-start` - you're now running a full orchestrator!

**What you get**:
- 5 kernel files defining identity
- 4 core skills (session-start, session-export, handoff, commit)
- Pre-configured memory structure
- Templates for everything

See `examples/jane-starter/README.md` for customization and next steps.

---

## Option 3: Manual Setup (Tier 1 Minimal)

### Step 1: Create Structure

```bash
mkdir -p my-entity/context/kernel
mkdir -p my-entity/active_work
```

### Step 2: Create CLAUDE.md

Create `my-entity/CLAUDE.md`:

```markdown
# Welcome, [Entity Name]

You are **[Entity Name]**, a [brief description].

## Boot Sequence

1. Read `context/kernel/role_definition.md`
2. Read `active_work/current_objectives.md`
3. You are ready to work.

## Your Role

[What this entity does]
```

### Step 3: Create Role Definition

Create `my-entity/context/kernel/role_definition.md`:

```markdown
# [Entity Name] - Role Definition

## Primary Role

I am **[Entity Name]**, responsible for [domain].

## Core Objectives

1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

## Scope

**In scope**: [What I handle]
**Out of scope**: [What I don't handle]
```

### Step 4: Create Objectives

Create `my-entity/active_work/current_objectives.md`:

```markdown
# Current Objectives

**Last Updated**: [Date]

## Active Priorities

1. [Priority 1]
2. [Priority 2]

## What's Next

[Upcoming work]
```

### Step 5: Boot Your Entity

```bash
cd my-entity
claude
```

That's it! Your entity is running.

---

## First Day Checklist

After setup, verify everything works:

- [ ] Boot entity: `cd my-entity && claude`
- [ ] Check identity: Ask "Who are you?" - should reflect role definition
- [ ] Verify objectives loaded: Ask "What are your current priorities?"
- [ ] Test persistence: Exit and reboot - context should persist
- [ ] (Tier 2 only) Run `/session-start` - verify boot sequence works

---

## Upgrading to Tier 2

When you need memory and cross-entity communication:

```bash
# Add memory structure
mkdir -p memory/sessions/exports
mkdir -p memory/evolution/learnings
mkdir -p memory/evolution/decisions
mkdir -p memory/inbox

# Add skills
mkdir -p .claude/skills
mkdir -p .claude/commands

# Copy core skills from templates
cp -r ../templates/skills/* .claude/skills/
```

See `specification/architecture.md` for full Tier 2 requirements.

---

## Common Issues

| Problem | Solution |
|---------|----------|
| Entity doesn't know its role | Check CLAUDE.md points to correct kernel files |
| Boot feels slow | Your kernel might be too large (target <2k tokens) |
| Skills not found | Verify `.claude/skills/` directory exists |

See `TROUBLESHOOTING.md` for detailed solutions.

---

## Next Steps

- Read `specification/architecture.md` for deep understanding
- Explore `examples/` for working entity examples
- Check `templates/` for all available templates

**Questions?** Open an issue at [GitHub](https://github.com/brandonkeao/protocol-specification).
