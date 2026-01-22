# Migration Guide

**Version**: 1.0
**Created**: January 2026
**Purpose**: Guide for upgrading entities and migrating between spec versions

---

## Overview

This guide covers:
- Upgrading from Tier 1 to Tier 2 entities
- Migrating between spec versions
- Rollback procedures
- Troubleshooting common migration issues

---

## Tier 1 to Tier 2 Migration

Upgrade a minimal entity to a full Protocol-compliant entity.

### Prerequisites

- Working Tier 1 entity with `CLAUDE.md` and `context/kernel/role_definition.md`
- Approximately 15-30 minutes
- Backup of existing entity (recommended)

### Step 1: Create Memory Structure

```bash
cd /path/to/your/entity

# Core memory directories
mkdir -p memory/sessions/exports
mkdir -p memory/evolution/learnings
mkdir -p memory/evolution/decisions
mkdir -p memory/evolution/errors
mkdir -p memory/inbox
mkdir -p memory/system_health

# Create README files
echo "# Session Exports\n\nSession summaries captured via /session-export." > memory/sessions/exports/_README.md
echo "# Inbox\n\nCross-entity communication. See ENTITY_SPEC.md for format." > memory/inbox/_README.md
```

### Step 2: Create Active Work Structure

```bash
# Active work tracking
mkdir -p active_work/plans

# Create objectives file
cat > active_work/current_objectives.md << 'EOF'
# Current Objectives

**Updated**: [Today's date]

## Active Focus

1. [Primary objective]
2. [Secondary objective]

## Paused

- None

## Recently Completed

- None
EOF

# Create plans registry
cat > active_work/plans/_registry.md << 'EOF'
# Plans Registry

| Plan | Status | Created | Last Updated |
|------|--------|---------|--------------|
| (none yet) | - | - | - |
EOF
```

### Step 3: Add Required Kernel Files

```bash
# Operating principles
cat > context/kernel/operating_principles.md << 'EOF'
# Operating Principles

## Decision Framework

### Type 1: Autonomous
- [Actions you can take without confirmation]

### Type 2: Collaborative
- [Actions requiring discussion]

### Type 3: Escalation
- [Actions requiring human approval]

## Communication Style

- [How this entity communicates]

## Quality Standards

- [Standards this entity upholds]
EOF

# Persona profile (optional but recommended)
cat > context/kernel/persona_profile.md << 'EOF'
# Persona Profile

## Personality

[Brief personality description]

## Communication Style

- [Style traits]

## Strengths

- [Key strengths]
EOF

# Kernel summary
cat > context/kernel/_summary.md << 'EOF'
# Kernel Summary

**Entity**: [Name]
**Role**: [Brief role description]
**Key Principle**: [Most important operating principle]
EOF
```

### Step 4: Add Core Skills

```bash
# Create skills directory
mkdir -p .claude/skills/session-start
mkdir -p .claude/skills/session-export
```

**Copy skill templates from `templates/skills/` or create minimal versions:**

#### session-start/SKILL.md

```markdown
# /session-start

Initialize session with context loading.

## Usage

/session-start [--full]

## Execution

1. Load kernel context from context/kernel/
2. Check active_work/current_objectives.md
3. Scan memory/inbox/ for pending items
4. Load recent session export if same-day
5. Report boot summary

## Output

Brief report of loaded context and any pending items.
```

#### session-export/SKILL.md

```markdown
# /session-export

Capture session learnings and decisions.

## Usage

/session-export [title]

## Execution

1. Summarize session work
2. Capture decisions made
3. Note learnings
4. List open threads
5. Save to memory/sessions/exports/

## Output

Confirmation of export location.
```

### Step 5: Create Skills Index

```bash
cat > .claude/skills/_index.md << 'EOF'
# Skills Index

## Core Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| /session-start | Initialize session | Active |
| /session-export | Capture learnings | Active |

## Domain Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| (none yet) | - | - |
EOF
```

### Step 6: Update CLAUDE.md

Add boot sequence to your CLAUDE.md:

```markdown
## Auto-Boot Requirement

When starting a new session, run `/session-start` as your FIRST action.

## Boot Sequence

1. Load kernel context (3 files)
2. Check active objectives
3. Check inbox for pending items
4. Brief boot report
5. Ready for work
```

### Step 7: Initialize Onboarding State

```bash
cat > memory/system_health/onboarding.md << 'EOF'
# Onboarding Status

**Status**: Complete
**Completed**: [Today's date]
**Version**: 2.4

## Checklist

- [x] Kernel context created
- [x] Memory structure initialized
- [x] Core skills added
- [x] CLAUDE.md updated
- [x] Validation passed
EOF
```

### Step 8: Validate

```bash
# Run validator
./scripts/fresh_start_validator.sh /path/to/entity --tier2

# Or if validator not available, check manually:
ls -la context/kernel/           # Should have 3+ files
ls -la memory/                   # Should have sessions/, evolution/, inbox/
ls -la .claude/skills/           # Should have session-start/, session-export/
```

### Rollback Procedure

To revert to Tier 1:

```bash
# Remove Tier 2 additions
rm -rf memory
rm -rf .claude/skills
rm -rf active_work

# Restore original CLAUDE.md (from backup)
cp CLAUDE.md.backup CLAUDE.md
```

---

## Spec Version Migrations

### 1.8 → 2.0

**Changes**: Plan persistence added (optional)

```bash
# Add plan structure
mkdir -p active_work/plans
touch active_work/plans/_registry.md
```

### 2.0 → 2.1

**Changes**: Context maps, skill classification

No required changes. Context maps are optional.

### 2.1 → 2.2

**Changes**: Onboarding flow, fresh start testing

```bash
# Add system health tracking
mkdir -p memory/system_health

# Mark existing entities as onboarded
cat > memory/system_health/onboarding.md << 'EOF'
# Onboarding Status

**Status**: Complete
**Completed**: [Migration date]
**Note**: Migrated from v2.1
EOF
```

### 2.2 → 2.3

**Changes**: Context map distribution

No required changes. Distribution pattern is optional.

### 2.3 → 2.4

**Changes**: Error handling, version compatibility, coordination edge cases

```bash
# Add error log directory
mkdir -p memory/evolution/errors

# Optional: Create error log template
cat > memory/evolution/errors/_README.md << 'EOF'
# Error Log

Failed operations logged here for debugging and recovery.

## Format

Files: `YYYY-MM-DD_error-slug.md`
EOF
```

---

## Troubleshooting

### Validator Fails on Required Files

**Symptom**: `[FAIL] T1-03: Role definition exists`

**Solution**:
```bash
# Create missing file
cat > context/kernel/role_definition.md << 'EOF'
# Role Definition

## Who You Are

[Describe entity's role]

## What You Do

[List responsibilities]

## What You Don't Do

[List boundaries]
EOF
```

### Skills Not Recognized

**Symptom**: `/session-start` doesn't work

**Causes**:
1. Missing SKILL.md in skill directory
2. CLAUDE.md doesn't reference skills
3. Skill directory has wrong name

**Solution**:
```bash
# Verify skill structure
ls -la .claude/skills/session-start/
# Should contain: SKILL.md

# Verify CLAUDE.md references skills
grep -i "session-start" CLAUDE.md
```

### Inbox Items Not Loading

**Symptom**: Boot doesn't show pending inbox items

**Causes**:
1. Wrong inbox path
2. Items have incorrect YAML frontmatter
3. Items already marked as completed

**Solution**:
```bash
# Check inbox location
ls -la memory/inbox/

# Check item frontmatter
head -20 memory/inbox/*.md
# Should have: status: pending
```

### Token Budget Exceeded

**Symptom**: Context loading feels slow, warnings about budget

**Causes**:
1. Too much kernel context
2. Too many conditional files loading
3. Large session exports

**Solution**:
1. Review `context/kernel/_summary.md` - keep it brief
2. Check conditional triggers - make them more specific
3. Archive old session exports

```bash
# Check context sizes
wc -w context/kernel/*.md
# Target: <4000 words total for kernel
```

### Circular Handoff Detected

**Symptom**: Warning about circular handoff in inbox

**Solution**:
1. Check `handoff_chain` field in inbox item
2. Identify which entities are in the cycle
3. Break cycle by completing or dismissing item
4. Escalate to human if unclear ownership

---

## Migration Checklist

### Pre-Migration

- [ ] Backup existing entity directory
- [ ] Note current spec version
- [ ] Review changelog for breaking changes
- [ ] Plan downtime if needed

### During Migration

- [ ] Create required directories
- [ ] Add required files
- [ ] Update CLAUDE.md
- [ ] Test core skills work

### Post-Migration

- [ ] Run validator
- [ ] Test session-start
- [ ] Test session-export
- [ ] Verify inbox loading
- [ ] Update onboarding state

---

## Quick Reference

### Tier 2 Required Structure

```
entity/
├── CLAUDE.md
├── context/
│   ├── kernel/
│   │   ├── role_definition.md
│   │   ├── operating_principles.md
│   │   └── _summary.md
│   └── conditional/
├── memory/
│   ├── sessions/
│   │   └── exports/
│   ├── evolution/
│   │   ├── learnings/
│   │   ├── decisions/
│   │   └── errors/
│   ├── inbox/
│   └── system_health/
├── active_work/
│   ├── current_objectives.md
│   └── plans/
│       └── _registry.md
├── data/
└── .claude/
    └── skills/
        ├── _index.md
        ├── session-start/
        │   └── SKILL.md
        └── session-export/
            └── SKILL.md
```

### Spec Version History

| Version | Date | Key Changes |
|---------|------|-------------|
| 1.0 | 2025-12-23 | Initial specification |
| 1.8 | 2026-01-12 | Memory maintenance |
| 2.0 | 2026-01-20 | Plan persistence |
| 2.1 | 2026-01-20 | Context maps |
| 2.2 | 2026-01-21 | Onboarding |
| 2.3 | 2026-01-22 | Context distribution |
| 2.4 | 2026-01-22 | Error handling, stability |

---

**Questions?** Check ENTITY_SPEC.md or ask Protocol for guidance.
