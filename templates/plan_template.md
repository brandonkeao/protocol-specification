# Plan Template

**Purpose**: Template for multi-session work tracking
**Reference**: See `ENTITY_SPEC.md` Section "Plan Persistence" for full specification
**Spec Version**: 2.4

---

## Template

```markdown
# Plan: [Title]

**Status**: draft
**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD
**Owner**: [Entity name]
**Target Completion**: [Optional - estimated completion]

---

## Objective

[Clear, concise statement of what this plan achieves. 1-2 sentences.]

---

## Context

[Background information. Why is this plan needed? What problem does it solve?]

---

## Phases

### Phase 1: [Name]

**Status**: pending | in_progress | completed
**Dependencies**: None | [List dependencies]

- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

**Completion Criteria**: [What must be true for this phase to be complete]

### Phase 2: [Name]

**Status**: pending
**Dependencies**: Phase 1

- [ ] Task 1
- [ ] Task 2

**Completion Criteria**: [What must be true for this phase to be complete]

### Phase 3: [Name]

**Status**: pending
**Dependencies**: Phase 2

- [ ] Task 1
- [ ] Task 2

**Completion Criteria**: [What must be true for this phase to be complete]

---

## Success Criteria

Overall plan success requires:

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | Low/Medium/High | Low/Medium/High | [How to address] |
| [Risk 2] | Low/Medium/High | Low/Medium/High | [How to address] |

---

## Resources

- [Link or path to relevant resource 1]
- [Link or path to relevant resource 2]

---

## Status History

| Date | Status | Notes |
|------|--------|-------|
| YYYY-MM-DD | draft | Plan created |

---

## Notes

[Any additional context, decisions made, or open questions]
```

---

## Status Lifecycle

```
draft → active → completed
         ↓
       paused → active (resumed)
         ↓
      abandoned
```

| Status | Meaning | Human Approval Required |
|--------|---------|------------------------|
| `draft` | Plan being developed | No |
| `active` | Work in progress | Yes (to activate) |
| `paused` | Temporarily stopped | Yes |
| `completed` | All phases done | Yes |
| `abandoned` | Plan cancelled | Yes |

---

## Registry Entry

When creating a plan, add to `active_work/plans/_registry.md`:

```markdown
| Plan | Status | Created | Last Updated |
|------|--------|---------|--------------|
| [plan-title.md](plan-title.md) | draft | 2026-01-22 | 2026-01-22 |
```

---

## Examples

### Minimal Plan

```markdown
# Plan: Add User Authentication

**Status**: draft
**Created**: 2026-01-22
**Owner**: Engineer

---

## Objective

Add OAuth2 authentication to the API service.

---

## Phases

### Phase 1: Research

- [ ] Review OAuth2 providers
- [ ] Select provider
- [ ] Document decision

### Phase 2: Implementation

- [ ] Add OAuth2 library
- [ ] Implement login flow
- [ ] Add tests

---

## Success Criteria

- [ ] Users can log in via OAuth2
- [ ] All tests passing
```

### Comprehensive Plan

See the full template above for a comprehensive example with all sections.

---

## When to Use Plans vs. Session Exports

| Scenario | Use Plan | Use Session Export |
|----------|----------|-------------------|
| Single-session work | No | Yes |
| Multi-session work | Yes | Also (for each session) |
| Multiple phases | Yes | No |
| Needs progress tracking | Yes | No |
| Capturing learnings | No | Yes |
| Coordinating entities | Yes | Sometimes |

**Rule of thumb**: If work will span more than one session and has distinct phases, create a plan.
