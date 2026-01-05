# Entity Validation Report

**Entity**: [Entity Name]
**Workspace**: [Path to workspace]
**Validated**: [YYYY-MM-DD]
**Validated By**: Protocol
**Spec Version**: [ENTITY_SPEC version used]

---

## Entity Profile

| Attribute | Value |
|-----------|-------|
| **Tier** | [1 / 2] |
| **Role** | [Orchestrator / Domain Specialist / Meta-Entity] |
| **Parent** | [Parent entity, if applicable] |
| **Created** | [Birth date, if known] |

---

## Executive Summary

**Overall Status**: [COMPLIANT / NEEDS ATTENTION / NON-COMPLIANT]

| Severity | Count |
|----------|-------|
| CRITICAL | [X] |
| MEDIUM | [X] |
| LOW | [X] |

**Key Findings**:
- [1-3 sentence summary of most important findings]

**Recommended Priority**:
1. [Most urgent remediation]
2. [Second priority]
3. [Third priority]

---

## Section 1: Structure Validation

### 1.1 Required Files

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 1.1.1 | CLAUDE.md exists | [ ] | |
| 1.1.2 | role_definition.md exists | [ ] | |
| 1.1.3 | current_objectives.md exists | [ ] | |

### 1.2 Tier 2 Structure (if applicable)

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 1.2.1 | operating_principles.md | [ ] | |
| 1.2.2 | persona_profile.md | [ ] | |
| 1.2.3 | memory/sessions/exports/ | [ ] | |
| 1.2.4 | exports/_template.md | [ ] | |
| 1.2.5 | memory/evolution/learnings/ | [ ] | |
| 1.2.6 | memory/evolution/decisions/ | [ ] | |
| 1.2.7 | memory/inbox/ | [ ] | |
| 1.2.8 | inbox/_README.md | [ ] | |
| 1.2.9 | .claude/skills/ | [ ] | |

### 1.3 Optional Structure

| Item | Check | Present | Conformant | Notes |
|------|-------|---------|------------|-------|
| 1.3.1 | _summary.md | [ ] | [ ] | |
| 1.3.2 | context/conditional/ | [ ] | [ ] | |
| 1.3.3 | data/ structure | [ ] | [ ] | |

---

## Section 2: Skill Verification

### 2.1 Core Skills

| Skill | Present | Path Correct | Sections Complete |
|-------|---------|--------------|-------------------|
| session-start | [ ] | [ ] | [ ] |
| session-export | [ ] | [ ] | [ ] |
| handoff | [ ] | [ ] | [ ] |
| entity-diagnostic | [ ] | [ ] | [ ] |

### 2.2 Path Issues Found

```
[List any problematic paths found, e.g.:]
- handoff/SKILL.md:42 contains /jane/ reference
```

---

## Section 3: Protocol Alignment

### 3.1 Inbox Protocol

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 3.1.1 | Flat structure | [ ] | |
| 3.1.2 | YAML frontmatter | [ ] | |
| 3.1.3 | Required fields | [ ] | |
| 3.1.4 | Human-in-the-loop | [ ] | |

### 3.2 Session Continuity

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 3.2.1 | Boot loads kernel | [ ] | |
| 3.2.2 | Boot checks inbox | [ ] | |
| 3.2.3 | Export creates structure | [ ] | |

### 3.3 File Naming

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 3.3.1 | Inbox naming | [ ] | |
| 3.3.2 | Export naming | [ ] | |
| 3.3.3 | Learnings naming | [ ] | |

---

## Section 4: Operational Health

### 4.1 Activity

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 4.1.1 | Recent session export | [ ] | Last: [date] |
| 4.1.2 | Objectives current | [ ] | Last updated: [date] |
| 4.1.3 | No stale inbox | [ ] | Oldest pending: [date] |

### 4.2 Token Metrics

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| Kernel total lines | [X] | <1000 | [ ] |
| Lightweight boot est. | [X]k | ~2k | [ ] |
| Full boot est. | [X]k | ~13k | [ ] |

---

## Section 5: Role-Specific

### [Role Name] Validation

| Item | Check | Status | Notes |
|------|-------|--------|-------|
| 5.X.1 | [Role-specific check] | [ ] | |
| 5.X.2 | [Role-specific check] | [ ] | |

---

## Section 6: Semantic Clarity

### Layer Separation

| Layer | Contents Appropriate | Issues Found |
|-------|---------------------|--------------|
| context/ | [ ] | |
| memory/ | [ ] | |
| data/ | [ ] | |
| active_work/ | [ ] | |

---

## Findings Summary

### CRITICAL Issues

| # | Issue | Location | Remediation |
|---|-------|----------|-------------|
| 1 | [Issue description] | [Path/file] | [What to do] |

### MEDIUM Issues

| # | Issue | Location | Remediation |
|---|-------|----------|-------------|
| 1 | [Issue description] | [Path/file] | [What to do] |

### LOW Issues

| # | Issue | Location | Remediation |
|---|-------|----------|-------------|
| 1 | [Issue description] | [Path/file] | [What to do] |

---

## Remediation Plan

### Immediate (CRITICAL)

1. **[Issue]**: [Specific steps to resolve]
2. **[Issue]**: [Specific steps to resolve]

### Near-Term (MEDIUM)

1. **[Issue]**: [Specific steps to resolve]

### When Convenient (LOW)

1. **[Issue]**: [Specific steps to resolve]

---

## Validation Notes

[Any additional observations, context, or recommendations not captured above]

---

## Sign-off

| Role | Entity | Date |
|------|--------|------|
| Validator | Protocol | [Date] |
| Acknowledged | [Entity owner] | [Date] |
| Remediation Complete | [Entity] | [Date] |

---

**Checklist Used**: docs/validation_checklist.md v1.0
**Spec Reference**: ENTITY_SPEC.md v[X.X]
