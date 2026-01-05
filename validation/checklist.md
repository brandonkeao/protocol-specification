# Entity Validation Checklist

**Version**: 1.0
**Derived From**: ENTITY_SPEC.md v1.6
**Purpose**: Systematic validation of entities against specification

---

## How to Use This Checklist

1. **Determine entity tier and role** (Tier 1/2, Orchestrator/Domain Specialist/Meta-Entity)
2. **Run applicable sections** based on tier and role
3. **Record status** for each item: PASS / WARN / FAIL
4. **Document findings** in validation report template
5. **Prioritize remediation** by severity

### Severity Definitions

| Severity | Impact | Timeline |
|----------|--------|----------|
| **CRITICAL** | Blocks core functionality, breaks spec compliance | Immediate (same session) |
| **MEDIUM** | Degrades functionality, causes friction | Within 2-3 sessions |
| **LOW** | Minor deviation, cosmetic issue | When convenient |

---

## Section 1: Structure Validation

### 1.1 Required Files (All Tiers)

| Item | Check | Tier 1 | Tier 2 | Severity |
|------|-------|--------|--------|----------|
| 1.1.1 | `CLAUDE.md` exists at workspace root | REQ | REQ | CRITICAL |
| 1.1.2 | `context/kernel/role_definition.md` exists | REQ | REQ | CRITICAL |
| 1.1.3 | `active_work/current_objectives.md` exists | REQ | REQ | CRITICAL |

### 1.2 Tier 2 Required Structure

| Item | Check | Severity |
|------|-------|----------|
| 1.2.1 | `context/kernel/operating_principles.md` exists | MEDIUM |
| 1.2.2 | `context/kernel/persona_profile.md` exists | MEDIUM |
| 1.2.3 | `memory/sessions/exports/` directory exists | CRITICAL |
| 1.2.4 | `memory/sessions/exports/_template.md` exists | LOW |
| 1.2.5 | `memory/evolution/learnings/` directory exists | MEDIUM |
| 1.2.6 | `memory/evolution/decisions/` directory exists | MEDIUM |
| 1.2.7 | `memory/inbox/` directory exists | CRITICAL |
| 1.2.8 | `memory/inbox/_README.md` exists | LOW |
| 1.2.9 | `.claude/skills/` directory exists | CRITICAL |

### 1.3 Optional Structure (Check if Present)

| Item | Check | When Required | Severity if Missing |
|------|-------|---------------|---------------------|
| 1.3.1 | `context/kernel/_summary.md` | Orchestrator role | LOW |
| 1.3.2 | `context/conditional/` directory | Has conditional content | LOW |
| 1.3.3 | `data/` directory structure | Has domain data | LOW |
| 1.3.4 | `memory/evolution/reviews/` | Conducts reviews | LOW |

---

## Section 2: Skill Verification

### 2.1 Core Skills Present

| Item | Check | Severity |
|------|-------|----------|
| 2.1.1 | `session-start/SKILL.md` exists in `.claude/skills/` | CRITICAL |
| 2.1.2 | `session-export/SKILL.md` exists in `.claude/skills/` | CRITICAL |
| 2.1.3 | `handoff/SKILL.md` exists in `.claude/skills/` | MEDIUM |
| 2.1.4 | `entity-diagnostic/SKILL.md` exists in `.claude/skills/` | MEDIUM |

### 2.2 Skill Path Verification

| Item | Check | Severity |
|------|-------|----------|
| 2.2.1 | No `/jane/` paths in skills (unless this IS Jane) | CRITICAL |
| 2.2.2 | No parent entity paths in skills | CRITICAL |
| 2.2.3 | Paths reference correct entity workspace | CRITICAL |
| 2.2.4 | SKILL.md files have required sections (When to Use, Process, Output) | MEDIUM |

### 2.3 Command Wrappers

| Item | Check | Severity |
|------|-------|----------|
| 2.3.1 | `.claude/commands/` directory exists (if using commands) | LOW |
| 2.3.2 | Command files reference correct skill paths | MEDIUM |

---

## Section 3: Protocol Alignment

### 3.1 Inbox Protocol

| Item | Check | Severity |
|------|-------|----------|
| 3.1.1 | Inbox uses flat structure (no subfolders like `handoffs/`) | CRITICAL |
| 3.1.2 | All inbox items have YAML frontmatter | CRITICAL |
| 3.1.3 | Frontmatter includes: type, status, priority, created | MEDIUM |
| 3.1.4 | No autonomous status changes (human-in-the-loop) | CRITICAL |

### 3.2 Session Continuity

| Item | Check | Severity |
|------|-------|----------|
| 3.2.1 | Session-start skill loads kernel context | CRITICAL |
| 3.2.2 | Session-start skill checks inbox | CRITICAL |
| 3.2.3 | Session-export skill creates structured exports | MEDIUM |
| 3.2.4 | Exports follow template format | LOW |

### 3.3 File Naming Conventions

| Item | Check | Severity |
|------|-------|----------|
| 3.3.1 | Inbox items: `YYYY-MM-DD_[slug].md` | MEDIUM |
| 3.3.2 | Session exports: `YYYY-MM-DD_[slug].md` | MEDIUM |
| 3.3.3 | Learnings: `YYYY-MM-DD_[slug].md` | LOW |
| 3.3.4 | No spaces in filenames (use hyphens) | LOW |

---

## Section 4: Operational Health

### 4.1 Recent Activity

| Item | Check | Severity |
|------|-------|----------|
| 4.1.1 | At least one session export in last 30 days | WARN if missing |
| 4.1.2 | `current_objectives.md` updated in last 14 days | MEDIUM |
| 4.1.3 | No stale inbox items (pending > 14 days) | MEDIUM |

### 4.2 Token Consciousness

| Item | Check | Severity |
|------|-------|----------|
| 4.2.1 | Kernel files total < 1000 lines | MEDIUM |
| 4.2.2 | Boot sequence respects token targets | LOW |
| 4.2.3 | No duplicate content across kernel files | LOW |

### 4.3 Clean State

| Item | Check | Severity |
|------|-------|----------|
| 4.3.1 | No orphaned files at workspace root (except CLAUDE.md) | LOW |
| 4.3.2 | No empty directories in required structure | LOW |
| 4.3.3 | Templates present for recurring file types | LOW |

---

## Section 5: Role-Specific Validation

### 5.1 Orchestrator Requirements

*Run only for entities with Orchestrator role*

| Item | Check | Severity |
|------|-------|----------|
| 5.1.1 | `context/kernel/agent_coordination.md` exists | CRITICAL |
| 5.1.2 | `context/kernel/_summary.md` exists | MEDIUM |
| 5.1.3 | `memory/evolution/agent_births/` exists | MEDIUM |
| 5.1.4 | All spawned entities listed in coordination file | MEDIUM |
| 5.1.5 | Routing rules defined for each entity | MEDIUM |

### 5.2 Domain Specialist Requirements

*Run only for entities with Domain Specialist role*

| Item | Check | Severity |
|------|-------|----------|
| 5.2.1 | No coordination file (defers to parent) | LOW |
| 5.2.2 | `memory/messages_to_[parent]/` exists | MEDIUM |
| 5.2.3 | Parent escalation path documented in CLAUDE.md | MEDIUM |
| 5.2.4 | Domain-specific context files present | MEDIUM |

### 5.3 Meta-Entity Requirements

*Run only for entities with Meta-Entity role*

| Item | Check | Severity |
|------|-------|----------|
| 5.3.1 | `context/kernel/specification_philosophy.md` exists | CRITICAL |
| 5.3.2 | `docs/` directory exists at workspace root | CRITICAL |
| 5.3.3 | Canonical specification maintained in `docs/` | CRITICAL |
| 5.3.4 | Version history tracked (CHANGELOG.md) | MEDIUM |
| 5.3.5 | Peer communication path defined (not escalation) | MEDIUM |

---

## Section 6: Semantic Clarity

### 6.1 Three-Layer Separation

| Item | Check | Severity |
|------|-------|----------|
| 6.1.1 | `context/` contains only identity/instructions | MEDIUM |
| 6.1.2 | `memory/` contains only accumulated experience | MEDIUM |
| 6.1.3 | `data/` contains only external facts | MEDIUM |
| 6.1.4 | No bleed between layers (e.g., profiles in context/) | MEDIUM |

### 6.2 Directory Purpose

| Item | Check | Severity |
|------|-------|----------|
| 6.2.1 | Each directory has clear, distinct purpose | LOW |
| 6.2.2 | No overlapping directories serving same function | MEDIUM |
| 6.2.3 | Readme files explain directory purpose where needed | LOW |

---

## Common Issues Reference

### Frequently Found Issues

| Issue | Typical Cause | Remediation |
|-------|---------------|-------------|
| `/jane/` paths in skills | Copied without update | Search/replace entity paths |
| Nested inbox folders | Pre-v1.3 structure | Flatten to single folder, add frontmatter |
| Missing persona_profile.md | Birth oversight | Create from template |
| Stale objectives | Inactive period | Update with current focus |
| Extra root directories | Organic growth | Move to appropriate layer or archive |

### Quick Diagnostic Commands

```bash
# Check for wrong paths in skills
grep -r "/jane/" .claude/skills/

# Count kernel file lines
wc -l context/kernel/*.md

# List inbox structure
find memory/inbox -type f -name "*.md"

# Check for stale inbox items
find memory/inbox -name "*.md" -mtime +14
```

---

## Validation Workflow

```
1. Identify entity tier and role
   │
   ├─→ Tier 1: Sections 1.1, 2 (basic), 4.3
   │
   └─→ Tier 2: All sections
         │
         ├─→ Orchestrator: + Section 5.1
         ├─→ Domain Specialist: + Section 5.2
         └─→ Meta-Entity: + Section 5.3

2. Run checks, record results

3. Aggregate findings:
   - Count CRITICAL items
   - Count MEDIUM items
   - Count LOW items

4. Generate validation report

5. Prioritize remediation:
   - CRITICAL first (blocking)
   - MEDIUM next (friction)
   - LOW as time permits
```

---

**Maintained by**: Protocol (Meta-Entity)
**Spec Reference**: ENTITY_SPEC.md v1.6
