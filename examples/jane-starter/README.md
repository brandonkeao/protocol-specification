# Jane Starter

A **ready-to-use** Tier 2 orchestrator entity based on ENTITY_SPEC v1.8.

## What This Is

Jane Starter is a fully functional orchestrator entity that you can use immediately after cloning. Unlike the minimal `sample-entity` or the teaching-focused `jane-lite`, this example is designed to be **used**, not just studied.

### Comparison

| Example | Purpose | Use Case |
|---------|---------|----------|
| `sample-entity` | Minimal Tier 1 template | Starting from scratch |
| `jane-lite` | Teaching reference | Understanding patterns |
| **`jane-starter`** | Ready-to-use orchestrator | Getting started fast |

## Quick Start

### 1. Copy to Your Workspace

```bash
cp -r examples/jane-starter ~/my-workspace/orchestrator
cd ~/my-workspace/orchestrator
```

### 2. Boot It Up

```bash
claude
```

Then run:
```
/session-start
```

### 3. You're Running!

The entity will:
- Load its kernel context
- Check for active objectives
- Surface any inbox items
- Report ready for work

## What's Included

### Core Structure

```
jane-starter/
├── CLAUDE.md                     # System instructions
├── context/kernel/               # Identity (5 files)
├── active_work/                  # Current objectives
├── memory/                       # Sessions, learnings, inbox
└── .claude/skills/               # 4 core skills
```

### Skills Out of the Box

| Skill | Command | Purpose |
|-------|---------|---------|
| session-start | `/session-start` | Boot with context |
| session-export | `/session-export` | Save session continuity |
| handoff | `/handoff [entity]` | Send work to others |
| commit | `/commit` | Git commits |

## Customization

This is a **starter** - customize it to fit your needs:

1. **Rename**: Change "AI Chief of Staff" to your entity's name
2. **Personality**: Edit `context/kernel/persona_profile.md`
3. **Add Routing**: Update `agent_coordination.md` as you create child entities
4. **Add Skills**: Create new skills in `.claude/skills/`

See `CUSTOMIZATION.md` for detailed guidance.

## First Session Walkthrough

After your first boot:

1. **Review objectives** in `active_work/current_objectives.md`
2. **Customize your identity** - update the name and personality
3. **Try a session export** - run `/session-export` at session end
4. **Create your first handoff** - test the handoff workflow

## Growing Your Ecosystem

Jane Starter supports the full entity lifecycle:

### Creating Child Entities

When a domain matures (20+ sessions, clear scope), create a specialist:

1. Notice the pattern
2. Propose to user: "Ready to create [Domain] entity?"
3. On approval: Create structure, transfer context
4. Update routing in `agent_coordination.md`

### Hub-and-Spoke Model

```
        [User]
           |
    [Orchestrator] (you)
      /    |    \
[Writer] [Engineer] [etc.]
```

You are the hub. Child entities are spokes. User always talks to you first.

## Differences from Production Jane

This starter is simplified from a production orchestrator:

| Feature | Production | Starter |
|---------|------------|---------|
| Kernel files | 4 + profiles | 5 core files |
| Skills | 10+ | 4 core |
| Boot modes | Lightweight + Full with profiles | Lightweight + Full |
| Memory | Rich history | Templates only |
| Integrations | Trello, external tools | None (add your own) |

The patterns are the same; the complexity is reduced for clarity.

## Next Steps

1. **Run `/session-start`** to experience the boot
2. **Read through the kernel files** to understand the patterns
3. **Customize** your entity's identity
4. **Build** - add skills, create child entities as needed

---

**This is a working entity, not just documentation. Use it.**
