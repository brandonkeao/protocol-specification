# Entity Specification Protocol

**Build AI agents that remember everything.**

Regular Claude forgets between conversations. Entities built to this spec maintain identity, accumulate expertise, and genuinely know you over time.

---

## Quick Start (60 seconds)

### Option 1: Copy a Working Example (Recommended)

```bash
git clone https://github.com/brandonkeao/protocol-specification.git
cp -r protocol-specification/examples/jane-starter ~/my-entity
cd ~/my-entity
claude
```

Then type `/session-start`. You're running a full AI entity with memory and skills!

### Option 2: Use the Setup Wizard

```bash
cd protocol-specification/scripts
npm install
node create-entity.js
```

Follow the prompts to create a customized entity.

### Option 3: Start Minimal

```bash
cp -r protocol-specification/examples/sample-entity ~/my-entity
cd ~/my-entity
claude
```

A bare-bones entity - just identity and objectives, no memory.

---

## What You Get

| | jane-starter | sample-entity |
|---|---|---|
| Ready to use | Yes | Yes |
| Memory | Full (sessions, learnings) | None |
| Skills | 4 built-in | None |
| Best for | Real projects | Learning the basics |

---

## Prerequisites

- [Claude Code](https://claude.ai/download) - Anthropic's CLI for agentic coding
- A terminal (Mac/Linux) or WSL (Windows)

---

## Learn More

| Resource | Description |
|----------|-------------|
| [Getting Started](./GETTING_STARTED.md) | Detailed walkthrough with all options |
| [Full Specification](./ENTITY_SPEC.md) | Complete reference (tiers, structure, protocols) |
| [Examples](./examples/) | jane-starter, sample-entity, and more |
| [Architecture](./specification/architecture.md) | How the three-layer model works |

---

## How It Works

```
my-entity/
├── CLAUDE.md           # Who I am (loaded automatically by Claude Code)
├── context/kernel/     # Identity files (role, principles, personality)
├── memory/             # What I've learned (sessions, decisions)
└── active_work/        # Current focus (objectives)
```

Claude Code reads `CLAUDE.md` on startup. Your entity loads its identity, checks its objectives, and picks up where it left off.

---

## FAQ

**Do I need Claude Code?**
Yes. This spec is designed for [Claude Code](https://claude.ai/download), which reads `CLAUDE.md` as system instructions.

**What's the difference between jane-starter and sample-entity?**
jane-starter is a full entity with memory, skills, and session continuity. sample-entity is the minimum viable structure for learning.

**Can I use this with other AI models?**
The architecture is model-agnostic, but the implementation assumes Claude Code conventions.

---

## Version

**Current**: 1.8 | [Changelog](./CHANGELOG.md) | [License](./LICENSE)

---

**Questions?** [Open an issue](https://github.com/brandonkeao/protocol-specification/issues)
