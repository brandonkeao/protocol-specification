# /entity-diagnostic

Comprehensive health check for entity compliance and operational status.

---

## Usage

```
/entity-diagnostic [--entity <path>] [--tier <1|2>] [--memory] [--ecosystem] [--json]
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--entity` | No | Path to entity (default: current directory) |
| `--tier` | No | Expected tier level (default: 2) |
| `--memory` | No | Deep dive on memory health |
| `--ecosystem` | No | Cross-entity validation |
| `--json` | No | Machine-readable output |

---

## When to Use

- After creating a new entity
- Before major updates
- When experiencing unexpected behavior
- During periodic health checks
- After spec version upgrades

## When NOT to Use

- During time-critical operations
- When simple issue is already known

---

## Execution

### Standard Diagnostic

1. **Validate Structure**
   - Check CLAUDE.md exists
   - Verify context/kernel/ structure
   - Verify memory/ structure (Tier 2)
   - Check .claude/skills/ (Tier 2)

2. **Check Configuration**
   - CLAUDE.md references correct files
   - Boot sequence defined
   - Token budget reasonable

3. **Verify Skills**
   - Core skills present
   - SKILL.md files valid
   - Skills index exists

4. **Assess Compliance**
   - Compare against spec version
   - Flag deprecations
   - Note warnings vs. failures

### Memory Diagnostic (--memory)

5. **Session Export Analysis**
   - Count exports
   - Calculate total size
   - Identify oldest/newest
   - Check for gaps

6. **Index Freshness**
   - Check all index files
   - Calculate age
   - Flag stale indexes (>7 days = WARN, >14 days = STALE)

7. **Inbox Health**
   - Count by status
   - Age distribution
   - Circular handoff detection
   - Overload check (>20 pending)

8. **Archive Candidates**
   - Identify old session exports (>30 days)
   - Identify resolved inbox items (>14 days)
   - Calculate potential space savings

### Ecosystem Diagnostic (--ecosystem)

9. **Cross-Entity Validation**
   - Find related entities
   - Check inbox connectivity
   - Validate shared context maps
   - Detect orphaned references

---

## Output

### Standard Output

```
=== Entity Diagnostic Report ===

Entity: Jane (Work)
Path: /Users/brandon/rebrandly/jane
Tier: 2
Spec Version: 2.4

--- Structure Validation ---

  [PASS] T1-01: CLAUDE.md exists
  [PASS] T1-02: Kernel context directory
  [PASS] T1-03: Role definition exists
  [PASS] T2-04: Memory directory
  [PASS] T2-05: Sessions directory
  [WARN] T2-16: Skills index (recommended)

--- Configuration ---

  [PASS] Boot sequence defined
  [PASS] Token budget: 2,847 tokens (within target)
  [WARN] No persona_profile.md (optional)

--- Skills ---

  [PASS] /session-start present
  [PASS] /session-export present
  [PASS] 3 domain skills found

--- Compliance ---

  Spec Version: 2.4
  Deprecations: 0
  Breaking Changes: 0

=== Summary ===

  PASS: 15
  WARN: 2
  FAIL: 0

Status: HEALTHY (2 recommendations)

Recommendations:
  1. Create .claude/skills/_index.md for skill discovery
  2. Consider adding context/kernel/persona_profile.md
```

### Memory Output (--memory)

```
=== Memory Health Report ===

--- Session Exports ---

Total: 45 files
Size: 127 KB
Oldest: 2025-12-01 (52 days ago)
Newest: 2026-01-22 (today)

Distribution:
  Last 7 days:   8 files
  Last 30 days: 23 files
  Older:        14 files

--- Index Freshness ---

  [PASS] sessions/_index.md
         Updated: 2 days ago
         Status: Fresh

  [WARN] evolution/_index.md
         Updated: 14 days ago
         Status: STALE

  [PASS] evolution/learnings/_index.md
         Updated: 5 days ago
         Status: Fresh

--- Inbox Health ---

Total Items: 7
  Pending: 2 (oldest: 5 days)
  Acknowledged: 1
  Completed: 3
  Dismissed: 1

Status: HEALTHY
  No overload (< 20 pending)
  No stale items (< 30 days)
  No circular handoffs detected

--- Archive Candidates ---

Session Exports (>30 days old):
  14 files, 45 KB potential savings

  Oldest candidates:
    - 2025-12-01_morning-session.md
    - 2025-12-02_afternoon-session.md
    - 2025-12-05_weekly-review.md

Completed Inbox Items (>14 days):
  2 items eligible for archive

--- Recommendations ---

  1. Update evolution/_index.md (14 days stale)
  2. Consider archiving 14 old session exports
  3. Archive 2 completed inbox items

=== Memory Health: GOOD (1 warning) ===
```

### Ecosystem Output (--ecosystem)

```
=== Ecosystem Diagnostic ===

Workspace: rebrandly
Entities Found: 3

--- Entity Map ---

  Jane (Orchestrator) - /rebrandly/jane
  Protocol (Meta-Entity) - /rebrandly/protocol
  Engineer (Specialist) - /rebrandly/engineer

--- Inbox Connectivity ---

  Jane → Protocol: 2 items (1 pending)
  Jane → Engineer: 1 item (completed)
  Protocol → Jane: 0 items
  Engineer → Jane: 1 item (pending)

--- Shared Context ---

  epd_context (GitLab):
    Consumers: Jane, Protocol
    Last sync: 2026-01-20

--- Issues ---

  [WARN] Engineer has orphaned reference to "DataAnalyst" entity
  [INFO] Jane has unacknowledged item from Engineer (3 days)

=== Ecosystem: HEALTHY (1 warning) ===
```

### JSON Output (--json)

```json
{
  "entity": {
    "name": "Jane",
    "path": "/Users/brandon/rebrandly/jane",
    "tier": 2,
    "spec_version": "2.4"
  },
  "validation": {
    "pass": 15,
    "warn": 2,
    "fail": 0,
    "checks": [
      {"id": "T1-01", "status": "pass", "description": "CLAUDE.md exists"},
      {"id": "T2-16", "status": "warn", "description": "Skills index missing"}
    ]
  },
  "memory": {
    "session_exports": {"count": 45, "size_kb": 127},
    "indexes": [
      {"path": "sessions/_index.md", "age_days": 2, "status": "fresh"}
    ],
    "inbox": {"pending": 2, "acknowledged": 1, "completed": 3}
  },
  "status": "healthy",
  "recommendations": [
    "Create skills index",
    "Update evolution/_index.md"
  ]
}
```

---

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| Entity not found | Invalid path | Verify path exists |
| Cannot determine tier | Missing structure | Assume Tier 1, warn user |
| Permission denied | File access issue | Check file permissions |
| Malformed YAML | Invalid inbox item | Report specific file, continue |

---

## Examples

### Basic Check

```
/entity-diagnostic
```

Result: Standard health check of current entity

### Check Another Entity

```
/entity-diagnostic --entity /path/to/other-entity --tier2
```

Result: Validate another entity as Tier 2

### Deep Memory Analysis

```
/entity-diagnostic --memory
```

Result: Standard check plus detailed memory health report

### Full Ecosystem Check

```
/entity-diagnostic --ecosystem
```

Result: Cross-entity validation for entire workspace

### Machine-Readable

```
/entity-diagnostic --json --memory
```

Result: JSON output including memory analysis

---

## Integration with Validator Script

This skill complements `scripts/fresh_start_validator.sh`:

| Tool | Purpose | When to Use |
|------|---------|-------------|
| `fresh_start_validator.sh` | Quick validation | CI/CD, pre-commit |
| `/entity-diagnostic` | Comprehensive check | Regular health checks |
| `/entity-diagnostic --memory` | Memory deep dive | Performance issues |
| `/entity-diagnostic --ecosystem` | Cross-entity check | Coordination issues |

---

## Related Skills

- `/context-diagnostic` - Debug context loading specifically
- `/list-skills` - Discover available skills
- `/session-start` - Initialize session properly

---

**Skill Type**: diagnostic
**Spec Reference**: ENTITY_SPEC.md v2.4
**Version**: 2.0
**Last Updated**: 2026-01-22

## Changelog

### 2.0 (2026-01-22)
- Added `--memory` flag for deep memory analysis
- Added `--ecosystem` flag for cross-entity validation
- Added archive candidate detection
- Enhanced index freshness reporting

### 1.0 (2026-01-04)
- Initial release with basic validation
