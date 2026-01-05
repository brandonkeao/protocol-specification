# Specification Philosophy

**Version**: 1.0
**Created**: January 4, 2026

---

## Core Beliefs

These principles guide how the Entity Specification is designed, maintained, and evolved.

---

## 1. Semantic Clarity Over Clever Structure

**Principle**: Each directory and file should have a clear, distinct purpose. When someone asks "where does X go?", the answer should be obvious.

**Application**:
- `context/` = WHO I AM (identity, instructions)
- `memory/` = WHAT I'VE LEARNED (accumulated experience)
- `data/` = FACTS ABOUT THE WORLD (reference material)

**Anti-pattern**: Directories that overlap in purpose, forcing judgment calls about where content belongs.

---

## 2. Token-Consciousness

**Principle**: Context window is a precious resource. Load only what's needed, when needed.

**Application**:
- Lightweight boot (~2k tokens) for tactical work
- Full boot (~13k tokens) for strategic sessions
- Index, don't load - pull details on demand

**Anti-pattern**: Loading everything at boot "just in case" it's needed.

---

## 3. Progressive Complexity

**Principle**: Start with the minimum viable structure. Add complexity only when evidence proves it's needed.

**Application**:
- Tier 1 (Minimal) entities need very little
- Tier 2 (Full) entities add structure as proven
- Upgrade tiers when patterns emerge

**Anti-pattern**: Building infrastructure speculatively before need is proven.

---

## 4. Portability

**Principle**: Patterns should work across entity implementations. Paths should be variables, not hardcoded.

**Application**:
- Skills use `${ENTITY_ROOT}` pattern
- Templates have placeholder paths
- Specification is implementation-agnostic

**Anti-pattern**: Paths hardcoded to specific entity names like `/jane/`.

---

## 5. Metadata in Files, Not Folders

**Principle**: Use YAML frontmatter for categorization, not nested folder structures. This enables single-glob scanning.

**Application**:
- Inbox items all in `memory/inbox/` with `type:` in frontmatter
- Learnings in flat folder with categories in frontmatter
- Status tracked in file, not folder name

**Anti-pattern**: `inbox/handoffs/`, `inbox/proposals/`, `inbox/follow-ups/` - three folders to scan instead of one.

---

## 6. Human-in-the-Loop for Cross-Entity Actions

**Principle**: When entities communicate with each other, humans should see those messages. No autonomous cross-entity actions without oversight.

**Application**:
- Inbox items surfaced to human during boot
- Status changes require human authorization
- Entities propose, humans approve

**Anti-pattern**: Entity A autonomously updates Entity B's inbox status.

---

## 7. Backwards Compatibility

**Principle**: Breaking changes have high cost. When possible, add rather than change.

**Application**:
- New optional patterns = MINOR version
- New required patterns = MAJOR version
- Deprecation before removal

**Anti-pattern**: Casually renaming directories or changing required patterns.

---

## 8. Evidence Over Theory

**Principle**: Patterns should emerge from actual entity usage, not theoretical elegance.

**Application**:
- Wait for entities to hit friction before adding patterns
- Document patterns that are working, not imagined needs
- Remove patterns that aren't being used

**Anti-pattern**: Designing elaborate systems before proving simpler ones fail.

---

## 9. Clear Ownership

**Principle**: Every piece of content should have a clear owner. No orphaned or ambiguous files.

**Application**:
- Each directory has defined purpose
- Each entity owns specific domains
- Transfer rules are explicit during birth

**Anti-pattern**: Files that could belong to multiple entities, requiring judgment.

---

## 10. Documentation as Specification

**Principle**: The specification IS the documentation. If it's not in the spec, it's not required.

**Application**:
- ENTITY_SPEC.md is the single source of truth
- Templates derive from the spec
- Validation checks against the spec

**Anti-pattern**: Implicit requirements not documented in the spec.

---

## How These Principles Interact

**When designing new patterns**:
1. Is the semantic purpose clear? (Principle 1)
2. What's the token impact? (Principle 2)
3. Is this the minimum needed? (Principle 3)
4. Will it work for other entities? (Principle 4)
5. Can we use frontmatter instead of folders? (Principle 5)
6. Does it need human oversight? (Principle 6)
7. Is it backwards compatible? (Principle 7)
8. Is there evidence this is needed? (Principle 8)
9. Is ownership clear? (Principle 9)
10. Is it documented? (Principle 10)

---

## Evolution of Philosophy

This philosophy itself can evolve. When a principle consistently causes problems or a new principle emerges from practice, update this document.

**Process**:
1. Identify pattern from entity feedback
2. Assess if it's a new principle or modification
3. Document with rationale
4. Version the specification

---

**These principles ensure the Entity Specification serves its users rather than constraining them.**
