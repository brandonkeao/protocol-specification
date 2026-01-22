# /list-skills

List all available skills with descriptions and categories.

---

## Usage

```
/list-skills [--category <name>] [--verbose]
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--category` | No | Filter by category (core, domain, coordination, diagnostic) |
| `--verbose` | No | Show full descriptions and usage examples |

---

## When to Use

- To discover available skills
- When unsure which skill to use for a task
- During onboarding to learn entity capabilities
- To check if a specific skill exists

## When NOT to Use

- When you already know the skill you need
- During time-sensitive operations

---

## Execution

1. **Scan Skills Directory**
   - Read `.claude/skills/` directory
   - Find all subdirectories with SKILL.md files
   - Parse skill metadata from each file

2. **Categorize Skills**
   - Core: session-start, session-export (spec-required)
   - Domain: Entity-specific workflows
   - Coordination: Cross-entity communication
   - Diagnostic: Health checks and troubleshooting

3. **Format Output**
   - Group by category
   - Show name and brief description
   - If verbose, include full details

4. **Apply Filters**
   - If `--category` specified, filter results
   - If `--verbose`, expand descriptions

---

## Output

### Standard Output

```
=== Available Skills ===

CORE (required by spec):
  /session-start     Initialize session with context loading
  /session-export    Capture session learnings and decisions

DOMAIN (entity-specific):
  /create-prd        Create product requirements document
  /query-warehouse   Execute data warehouse queries
  /deploy-verify     Verify deployment status

COORDINATION (cross-entity):
  /orchestrate       Route work to appropriate entity
  /handoff           Transfer work to another entity
  /escalate          Escalate issue to human

DIAGNOSTIC (health & debug):
  /entity-diagnostic Check overall entity health
  /context-diagnostic Debug context loading
  /list-skills       List available skills (this skill)

---
Total: 10 skills (2 core, 3 domain, 3 coordination, 3 diagnostic)

Run `/skill-name --help` for details on any skill.
```

### Verbose Output (--verbose)

```
=== Available Skills (Verbose) ===

CORE (required by spec):

  /session-start
  Initialize session with context loading

  Usage: /session-start [--full]

  Loads kernel context, checks inbox, establishes session continuity.
  Use --full for strategic sessions requiring complete context.

  ---

  /session-export
  Capture session learnings and decisions

  Usage: /session-export [title]

  Creates structured export of current session including decisions,
  learnings, and open threads. Saves to memory/sessions/exports/.

  ---

DOMAIN (entity-specific):

  /create-prd
  Create product requirements document

  Usage: /create-prd <feature-name> [--template <name>]

  Generates a structured PRD using configured templates.
  Supports multiple templates for different product types.

  ---

[...continues for all skills...]
```

### Filtered Output (--category diagnostic)

```
=== Diagnostic Skills ===

  /entity-diagnostic   Check overall entity health
  /context-diagnostic  Debug context loading
  /list-skills         List available skills (this skill)

---
3 diagnostic skills found.
```

---

## Output Format

When outputting the skill list:

1. **Group by category** (CORE → DOMAIN → COORDINATION → DIAGNOSTIC)
2. **Consistent formatting**: `/skill-name` aligned with description
3. **Total count** at end
4. **Help hint** for learning more about individual skills

---

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| No skills found | Empty .claude/skills/ directory | Report as warning, entity may be Tier 1 |
| Invalid SKILL.md | Malformed skill file | Skip file, note in output, continue |
| Category not found | Invalid --category value | Show valid categories, list all |

---

## Examples

### Basic Usage

```
/list-skills
```

Result: Categorized list of all available skills

### Filter by Category

```
/list-skills --category core
```

Result: Only core skills (session-start, session-export)

### Verbose Mode

```
/list-skills --verbose
```

Result: Full descriptions with usage examples for all skills

### Combined

```
/list-skills --category domain --verbose
```

Result: Detailed view of domain-specific skills only

---

## Skill Discovery Index

If the entity maintains a skill index at `.claude/skills/_index.md`, this skill will read from it for faster lookups. The index format:

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

## Related Skills

- `/context-diagnostic` - Debug context loading
- `/entity-diagnostic` - Full entity health check
- `/session-start` - Initialize session

---

**Skill Type**: informational
**Spec Reference**: ENTITY_SPEC.md v2.4
**Version**: 1.0
**Last Updated**: 2026-01-22
