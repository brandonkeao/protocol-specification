# Troubleshooting Guide

Common issues and solutions when working with Jane-like entities.

---

## Boot Issues

### Entity doesn't know its identity

**Symptom**: When asked "Who are you?", the entity gives a generic response or doesn't reflect the role definition.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| CLAUDE.md missing | Create CLAUDE.md in entity root directory |
| CLAUDE.md has wrong paths | Verify paths point to actual files (check for typos) |
| Kernel files don't exist | Create `context/kernel/role_definition.md` |
| Role definition is empty | Add identity content to role_definition.md |

**Verification**:
```bash
# Check CLAUDE.md exists
ls -la CLAUDE.md

# Check kernel directory
ls -la context/kernel/

# Verify role_definition.md has content
head -20 context/kernel/role_definition.md
```

---

### Boot feels slow (>5 seconds)

**Symptom**: Starting a session takes noticeably longer than expected.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Kernel too large | Target <2k tokens total for kernel files |
| Too many files in boot sequence | Use `_summary.md` pattern for large directories |
| Loading unnecessary context | Review CLAUDE.md boot sequence |

**Measuring kernel size**:
```bash
# Count lines in kernel files (rough token estimate: lines * 7)
wc -l context/kernel/*.md
```

**Token budget guidance**:
| Component | Target | Max |
|-----------|--------|-----|
| Kernel (all files) | 1,500 tokens | 2,000 tokens |
| Single kernel file | 400 tokens | 600 tokens |
| Full boot (Tier 2) | 4,000 tokens | 8,000 tokens |

---

### Skills not found

**Symptom**: `/skill-name` commands don't work or return "skill not found".

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Skills directory missing | Create `.claude/skills/` directory |
| Skill not in correct location | Move skill to `.claude/skills/[skill-name]/SKILL.md` |
| SKILL.md filename wrong | Rename to exactly `SKILL.md` (case-sensitive) |
| Skill not in _index.md | Add skill to `.claude/skills/_index.md` |

**Verification**:
```bash
# Check skills directory exists
ls -la .claude/skills/

# Check specific skill
ls -la .claude/skills/session-start/SKILL.md
```

---

## Session Continuity Issues

### No session export created

**Symptom**: After running `/session-end`, no export file appears in `memory/sessions/exports/`.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Exports directory missing | Create `memory/sessions/exports/` |
| session-export skill missing | Install session-export skill |
| Skill paths incorrect | Verify skill points to correct export location |

**Verification**:
```bash
# Check exports directory exists
ls -la memory/sessions/exports/

# Check session-export skill exists
ls -la .claude/skills/session-export/
```

---

### Previous session not loaded

**Symptom**: On reboot, entity doesn't reference previous session context.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| session-start skill not loading exports | Review session-start skill, ensure it reads from exports |
| Export file malformed | Check export file has "Context for Next Session" section |
| Wrong file naming | Exports should be named `YYYY-MM-DD_*.md` |

---

## Inbox Issues

### Inbox items not surfacing

**Symptom**: Items in `memory/inbox/` don't appear in boot report.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Inbox directory missing | Create `memory/inbox/` |
| Item status not "pending" | Check YAML frontmatter has `status: pending` |
| Missing YAML frontmatter | Add frontmatter with `---` delimiters |
| session-start not checking inbox | Review session-start skill |

**Correct inbox item format**:
```markdown
---
type: handoff
from: [sender]
to: [recipient]
status: pending
priority: high
created: YYYY-MM-DD
surface_when: [context triggers]
---

# Title

Content...
```

---

### Inbox items stuck as pending

**Symptom**: Items remain pending even after being addressed.

**Solution**: Manually update the item's `status` field:

| Status | Meaning |
|--------|---------|
| `pending` | Not yet addressed |
| `acknowledged` | Seen, will address later |
| `completed` | Work finished |
| `dismissed` | Intentionally not addressing |

---

## Structure Issues

### Entity missing required directories

**Tier 1 Required Structure**:
```
entity/
├── CLAUDE.md
├── context/
│   └── kernel/
│       └── role_definition.md
└── active_work/
    └── current_objectives.md
```

**Tier 2 Required Structure** (in addition to Tier 1):
```
entity/
├── memory/
│   ├── sessions/
│   │   └── exports/
│   ├── evolution/
│   │   ├── learnings/
│   │   └── decisions/
│   └── inbox/
└── .claude/
    └── skills/
        └── _index.md
```

**Quick fix**:
```bash
# Create Tier 1 structure
mkdir -p context/kernel active_work

# Upgrade to Tier 2
mkdir -p memory/sessions/exports
mkdir -p memory/evolution/learnings memory/evolution/decisions
mkdir -p memory/inbox
mkdir -p .claude/skills
```

---

## Validation Issues

### Entity fails diagnostic

Run `/entity-diagnostic` and address issues by category:

**Critical failures** (must fix):
- Missing CLAUDE.md
- Missing kernel files
- No role definition

**Warnings** (should fix):
- Missing optional directories
- Empty memory directories
- No recent session exports

**Info** (optional):
- Skill improvements
- Documentation suggestions

---

## Cross-Entity Issues

### Handoffs not received

**Symptom**: Entity A sends handoff, Entity B never sees it.

**Causes & Solutions**:

| Cause | Solution |
|-------|----------|
| Wrong inbox path | Verify path: `[target-entity]/memory/inbox/` |
| Filename doesn't match pattern | Use `YYYY-MM-DD_description.md` |
| Target entity not checking inbox | Ensure target runs `/session-start` |

---

### Routing confusion between entities

**Symptom**: Work goes to wrong entity or falls through cracks.

**Solution**: Check orchestrator's routing table (usually in Jane's `context/kernel/agent_coordination.md`).

Verify:
- Domain ownership is clear
- No overlapping domains
- No gaps in coverage

---

## Performance Issues

### Context window filling up fast

**Symptom**: Getting "context limit" warnings during session.

**Solutions**:

1. **Use lightweight boot**: Default `/session-start` instead of `/session-start --full`
2. **Summarize kernel**: Create `_summary.md` files for large directories
3. **Archive old sessions**: Move old exports to `memory/sessions/archive/`
4. **Be selective**: Don't load all memory in every session

---

### Entity feels "forgetful"

**Symptom**: Entity doesn't remember things from earlier in session or previous sessions.

**Solutions**:

1. **Check session exports**: Ensure "Context for Next Session" captures key decisions
2. **Use learnings**: Record important discoveries in `memory/evolution/learnings/`
3. **Update objectives**: Keep `active_work/current_objectives.md` current
4. **Reference explicitly**: Point entity to specific memory files when needed

---

## Getting More Help

- **Specification**: See `specification/architecture.md` for full architecture details
- **Examples**: See `examples/` for working entity examples
- **Templates**: See `templates/` for starter files
- **Issues**: Report at [GitHub](https://github.com/brandonkeao/protocol-specification)

---

## Quick Diagnostic Checklist

Run through this checklist when something isn't working:

- [ ] Does CLAUDE.md exist in entity root?
- [ ] Do paths in CLAUDE.md point to real files?
- [ ] Is `context/kernel/role_definition.md` populated?
- [ ] Is `active_work/current_objectives.md` present?
- [ ] (Tier 2) Does `memory/` directory structure exist?
- [ ] (Tier 2) Does `.claude/skills/` exist with _index.md?
- [ ] (Tier 2) Are inbox items formatted with YAML frontmatter?
- [ ] (Tier 2) Is session-start/session-end skill installed?
