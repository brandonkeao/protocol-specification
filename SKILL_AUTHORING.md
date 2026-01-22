# Skill Authoring Guide

**Version**: 1.0
**Created**: January 2026
**Purpose**: Guide for creating and maintaining entity skills

---

## Overview

Skills are repeatable workflows that entities can execute. This guide covers when to create skills, how to structure them, and best practices for skill development.

---

## When to Create a Skill

### Create a Skill When

- Workflow is repeated **3+ times**
- Workflow has **clear trigger and completion criteria**
- Multiple steps should **execute together**
- Needs to be **discoverable** via `/list-skills`
- Would benefit from **consistent execution**

### Don't Create a Skill When

- One-time procedure (document it instead)
- Simple query or lookup (just answer directly)
- Highly variable workflow (too many branches)
- Already covered by existing skill
- Would rarely be used (<1x/month)

### Decision Tree

```
Is this workflow repeated?
├─ No → Document as process, not skill
└─ Yes → Does it have clear steps?
         ├─ No → Too variable for skill
         └─ Yes → Does it need consistency?
                  ├─ No → Just do it
                  └─ Yes → CREATE SKILL
```

---

## Skill Categories

| Category | Examples | Autonomy Level | Description |
|----------|----------|----------------|-------------|
| **Core** | session-start, session-export | Spec-owned | Required for all Tier 2 entities |
| **Stateless** | create-prd, summarize | Can execute fully | No persistent state changes |
| **Stateful** | persist-plan, orchestrate | Must checkpoint | Modifies entity state |
| **Coordination** | handoff, route | Requires confirmation | Cross-entity communication |
| **Informational** | list-skills, context-diagnostic | Read-only | Reports without changes |

### Category Guidelines

**Core Skills**:
- Behavior defined by spec
- Only paths should change between entities
- All Tier 2 entities must have these

**Stateless Skills**:
- Generate output without side effects
- Can be safely re-run
- No state to manage

**Stateful Skills**:
- Create/modify files
- Should checkpoint progress
- May need recovery procedures

**Coordination Skills**:
- Interact with other entities
- Require human confirmation
- Track communication chains

**Informational Skills**:
- Read-only operations
- Safe to run anytime
- No confirmation needed

---

## Skill Structure

```
.claude/skills/[skill-name]/
├── SKILL.md          # Required: Skill definition
├── examples/         # Optional: Usage examples
│   ├── basic.md
│   └── advanced.md
└── tests/            # Optional: Test cases
    └── test-scenarios.md
```

### File Naming

- Skill directory: `kebab-case` (e.g., `session-export`, `create-prd`)
- SKILL.md: Always uppercase
- Examples: Descriptive names

---

## SKILL.md Template

```markdown
# /skill-name

Brief description of what this skill does (1-2 sentences).

---

## Usage

```
/skill-name [--flag] [argument]
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--flag` | No | What this flag does |
| `argument` | Yes | What this argument is |

---

## When to Use

- Trigger condition 1
- Trigger condition 2
- User explicitly requests

## When NOT to Use

- Condition where this skill is wrong choice
- Alternative to suggest instead

---

## Execution

1. **Step one**
   - Detail about step one
   - What to check

2. **Step two**
   - Detail about step two

3. **Step three**
   - Final step

---

## Output

Describe what the skill produces:
- Files created/modified
- Reports generated
- State changes

## Output Format

```
[Example output format]
```

---

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| X fails | Reason | Do Y |
| Z missing | Reason | Do W |

---

## Examples

### Basic Usage

```
/skill-name --basic
```

Result: [what happens]

### Advanced Usage

```
/skill-name --flag argument
```

Result: [what happens]

---

## Related Skills

- `/related-skill-1` - How it relates
- `/related-skill-2` - How it relates

---

**Skill Type**: [core | stateless | stateful | coordination | informational]
**Spec Reference**: ENTITY_SPEC.md v2.4
```

---

## Autonomy Guidelines

### Can Do Autonomously

- Read any context file
- Create files in `memory/`
- Update indexes in `memory/`
- Generate reports and summaries
- Execute informational queries
- Create draft plans

### Requires Human Confirmation

- Modify kernel context (`context/kernel/`)
- Send inbox items to other entities
- Change skill definitions
- Delete any files
- Change plan status
- Execute external commands

### Never Do Autonomously

- Modify CLAUDE.md without explicit request
- Auto-approve inbox status changes
- Execute destructive operations
- Send without confirmation
- Skip required checkpoints

---

## Error Handling Patterns

### Graceful Degradation

```markdown
## Error Handling

If [required file] is missing:
1. Log warning
2. Continue with available data
3. Note gap in output

If [critical resource] is unavailable:
1. Report error to user
2. Offer alternatives
3. Do not proceed without resolution
```

### Recovery Procedures

```markdown
## Recovery

If skill fails mid-execution:
1. Check `memory/evolution/errors/` for state
2. Identify last successful step
3. Resume from checkpoint
4. Or restart with `--force`
```

---

## Testing Skills

### Manual Testing

1. Run skill with typical inputs
2. Run skill with edge cases
3. Run skill with missing dependencies
4. Verify output matches expectations
5. Check no unintended side effects

### Test Scenarios Document

Create `tests/test-scenarios.md`:

```markdown
# Test Scenarios: /skill-name

## Happy Path

**Input**: [typical input]
**Expected**: [expected output]
**Verify**: [how to verify]

## Edge Cases

### Empty Input
**Input**: [empty/minimal input]
**Expected**: [graceful handling]

### Missing Dependencies
**Input**: [input with missing file]
**Expected**: [error message, recovery]

## Regression Tests

- [ ] Bug #123 - Specific scenario
- [ ] Bug #456 - Another scenario
```

---

## Skill Versioning

### When to Version

- Breaking changes to parameters
- Significant behavior changes
- New required dependencies

### How to Version

Add version to SKILL.md header:

```markdown
# /skill-name

**Version**: 1.2
**Last Updated**: 2026-01-22
```

### Changelog in Skill

```markdown
## Changelog

### 1.2 (2026-01-22)
- Added --verbose flag
- Fixed edge case with empty input

### 1.1 (2026-01-15)
- Initial release
```

---

## Best Practices

### Naming

- Use verbs for action skills: `create-`, `update-`, `generate-`
- Use nouns for info skills: `list-`, `show-`, `diagnostic`
- Be specific: `/create-prd` not `/create-document`

### Documentation

- First line should explain skill completely
- Include concrete examples
- Document all parameters
- List error conditions

### Execution

- Validate inputs before executing
- Checkpoint long operations
- Provide progress feedback
- Clean up on failure

### Portability

- Avoid hardcoded paths
- Use relative references
- Document path dependencies
- Test on fresh entities

---

## Skill Discovery

Entities should have a skill index at `.claude/skills/_index.md`:

```markdown
# Skills Index

## Core Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| /session-start | Initialize session | Active |
| /session-export | Capture learnings | Active |

## Domain Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| /create-prd | Product requirements | Active |

## Custom Skills

| Skill | Purpose | Added |
|-------|---------|-------|
| /my-workflow | Custom workflow | 2026-01-20 |
```

---

## Reference

- [ENTITY_SPEC.md](ENTITY_SPEC.md) - Full entity specification
- [Core Skills](ENTITY_SPEC.md#core-skills) - Required skill definitions
- [templates/](templates/) - Skill templates

---

**Questions?** Check the spec or ask Protocol for guidance.
