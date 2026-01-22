# /context-diagnostic

Diagnose context loading issues and report what was loaded during session boot.

---

## Usage

```
/context-diagnostic [--verbose] [--json]
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--verbose` | No | Show detailed token estimates per file |
| `--json` | No | Output as machine-readable JSON |

---

## When to Use

- After session boot to verify context loaded correctly
- When experiencing unexpected behavior
- To debug missing context or conditional triggers
- During entity validation and troubleshooting
- When token budget seems exceeded

## When NOT to Use

- During normal operation (adds overhead)
- When context is loading correctly

---

## Execution

1. **Scan Kernel Context**
   - List all files in `context/kernel/`
   - Verify required files exist (role_definition.md, operating_principles.md)
   - Estimate token count per file
   - Flag any missing required files

2. **Analyze Conditional Context**
   - List all files in `context/conditional/`
   - For each file, identify trigger conditions
   - Report which conditions triggered (and why)
   - Report which conditions did NOT trigger

3. **Check Session Context**
   - Find most recent session export
   - Report if same-day session was loaded
   - List inbox items processed
   - Note any session continuity gaps

4. **Assess Memory Indexes**
   - Check for index files in memory directories
   - Report index freshness (fresh <7 days, stale >14 days)
   - Flag missing indexes

5. **Calculate Token Budget**
   - Sum estimated tokens from all loaded context
   - Compare against target budget
   - Identify largest files
   - Warn if over budget

6. **Generate Report**
   - Compile findings into structured output
   - Include recommendations if issues found

---

## Output

### Standard Output

```
=== Context Diagnostic Report ===

Entity: [Entity Name]
Boot Time: 2026-01-22 14:30:00
Spec Version: 2.4

--- Kernel Context ---

Loaded (4 files, ~2,147 tokens):
  [OK] role_definition.md (412 tokens)
  [OK] operating_principles.md (389 tokens)
  [OK] persona_profile.md (156 tokens)
  [OK] _summary.md (89 tokens)

Missing (0 files):
  None

--- Conditional Context ---

Triggered (2 files, ~1,203 tokens):
  [OK] product_team_context.md
       Trigger: "product" keyword detected
  [OK] engineering_standards.md
       Trigger: code-related session

Not Triggered (3 files):
  [ ] churn_analysis.md
      Reason: No churn-related keywords
  [ ] sales_context.md
      Reason: No sales-related keywords
  [ ] archived_project.md
      Reason: Project marked archived

--- Session Context ---

Latest Export: 2026-01-21_afternoon-session.md (loaded)
Same-Day Session: No
Inbox Items: 2 pending, 0 acknowledged
Continuity: Normal

--- Memory Indexes ---

  [OK] sessions/_index.md (updated 2 days ago)
  [WARN] evolution/_index.md (updated 14 days ago) - STALE
  [OK] inbox/ - flat structure verified

--- Token Budget ---

Target: 4,000 tokens (lightweight boot)
Actual: 3,350 tokens (84% of target)
Status: Within budget

Largest Files:
  1. role_definition.md (412 tokens)
  2. operating_principles.md (389 tokens)
  3. product_team_context.md (312 tokens)

--- Summary ---

Status: HEALTHY
Issues: 1 warning (stale index)

Recommendations:
  1. Update evolution/_index.md (14 days stale)

=== End Report ===
```

### JSON Output (--json)

```json
{
  "entity": "Jane",
  "boot_time": "2026-01-22T14:30:00Z",
  "spec_version": "2.4",
  "kernel_context": {
    "loaded": [
      {"file": "role_definition.md", "tokens": 412, "status": "ok"},
      {"file": "operating_principles.md", "tokens": 389, "status": "ok"}
    ],
    "missing": [],
    "total_tokens": 2147
  },
  "conditional_context": {
    "triggered": [
      {"file": "product_team_context.md", "reason": "product keyword detected"}
    ],
    "not_triggered": [
      {"file": "churn_analysis.md", "reason": "no churn keywords"}
    ]
  },
  "session_context": {
    "latest_export": "2026-01-21_afternoon-session.md",
    "same_day": false,
    "inbox_pending": 2
  },
  "token_budget": {
    "target": 4000,
    "actual": 3350,
    "percentage": 84,
    "within_budget": true
  },
  "status": "healthy",
  "warnings": 1,
  "errors": 0
}
```

---

## Error Handling

| Error | Cause | Recovery |
|-------|-------|----------|
| Cannot read kernel context | Missing context/kernel/ directory | Report CRITICAL, suggest entity validation |
| Token count unavailable | File read error | Skip file, continue with others, note in report |
| Session export not found | No exports exist | Note as expected for new entity |
| Index missing | Index file not created | Report as WARN, suggest creating index |

---

## Examples

### Basic Usage

```
/context-diagnostic
```

Result: Standard report showing all context loading status

### Verbose Mode

```
/context-diagnostic --verbose
```

Result: Detailed report with per-file token breakdowns and full trigger analysis

### Machine-Readable

```
/context-diagnostic --json
```

Result: JSON output for programmatic processing

---

## Related Skills

- `/entity-diagnostic` - Full entity health check
- `/session-start` - Initial context loading
- `/list-skills` - Available skills listing

---

**Skill Type**: informational
**Spec Reference**: ENTITY_SPEC.md v2.4
**Version**: 1.0
**Last Updated**: 2026-01-22
