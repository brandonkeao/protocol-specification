# Entity Specification Changelog

Track the evolution of ENTITY_SPEC.md over time.

## Versioning

- **MAJOR**: Breaking changes requiring entity updates
- **MINOR**: Backwards-compatible additions
- **PATCH**: Clarifications and documentation fixes

---

## [1.8] - 2026-01-12

### Added
- Memory Maintenance section documenting:
  - Weekly reviews (RECOMMENDED) with template and cadence guidance
  - Index maintenance with freshness guidelines (Fresh <7 days, Stale >14 days)
  - Deprecation protocol with archive structure and README template
- Portability validation guidance in Skill Portability section
- T2-30 validation check: Memory index freshness (>7 days = WARN)

### Notes
- Based on ecosystem friction analysis
- Validation checklist updated to v1.3 (38 items, was 37)
- All additions are backwards-compatible (MINOR version)

---

## [1.7.1] - 2026-01-08

### Added
- Orchestrator token budget clarification: Higher lightweight boot targets (~3-4k tokens) acceptable for orchestrators due to coordination context
- Project documentation pattern (optional): `data/projects/` structure example
- Meeting records pattern (optional): `data/meetings/` structure example
- Session export path validation check (T2-29) in validation_checklist.md

### Fixed
- Example entity: Corrected session-export path references across skill files

### Notes
- Based on ecosystem audit findings
- Validation checklist updated to v1.2 (37 items, was 36)

---

## [1.7] - 2026-01-05

### Added
- Context Graph schema (optional) - Machine-readable relationship representation
  - Node types: entity, skill, memory, person, project
  - Edge types: parent_child, peer, routes_to, owns, surface_when, references
  - Located in `memory/graph/` if implemented
- Expert review skill pattern - Configurable expert perspectives via `--lens` parameter
  - Replaces deprecated "execution lens" approach
  - `/expert-review --lens=security|architecture|product`
- Enhanced `entity-diagnostic` skill:
  - `--entity [path]` parameter for validating any entity
  - `--ecosystem` mode for cross-entity validation
  - `--json` output for machine-readable results

### Deprecated
- Execution lenses (`.claude/agents/` lens files) - Use `expert-review` skill instead
  - Migration: Create `/expert-review` skill with `--lens` parameter

### Notes
- All additions are backwards-compatible (MINOR version)
- Context Graph is explicitly OPTIONAL - entities without graphs remain compliant

---

## [1.6] - 2026-01-04

### Added
- Skill structure specification (SKILL.md format, commands vs skills)
- Escalation SLAs and handling (frequency, priority, cleanup)
- Inbox lifecycle (status transitions, completed vs dismissed, retention)
- Conditional context loading rules and use cases
- Data directory guidance (formats, nesting, shared vs private)
- Diagnostic examples with PASS/WARN/FAIL and remediation steps
- Memory Transfer Review step in birth protocol (from Jane's proposal)

### Templates Added
- `docs/templates/kernel/role_definition.md.template`
- `docs/templates/kernel/operating_principles.md.template`
- `docs/templates/kernel/persona_profile.md.template`
- `docs/templates/memory/learnings.md.template`
- `docs/templates/memory/decisions.md.template`
- `docs/templates/skills/SKILL.md.template`

### Notes
- Completes Project 1B: Gap Completion
- All 6 specification gaps now documented
- Birth protocol enhanced with memory transfer review

---

## [1.5] - 2026-01-04

### Added
- Meta-Entity role definition (Tier 2 variant for spec-owning entities)
- `context/kernel/_summary.md` format specification
- `_summary.md.template` in `docs/templates/kernel/`

### Fixed
- Path references: `context/conditional/agent_birth_protocol.md` → `birth_protocol/agent_birth_protocol.md`
- Path consistency: `session_exports/` → `sessions/exports/` in birth protocol

### Notes
- First spec version produced by Protocol entity
- Meta-Entity role formalizes Protocol's position in ecosystem

---

## [1.4] - 2026-01-04

### Changed
- Ownership transferred from Jane to Protocol entity
- Protocol now canonical owner of specification

### Notes
- This version was inherited from Jane
- First review as Protocol pending

---

## [1.3] - 2026-01-03

### Added
- Inbox flat structure requirement (YAML frontmatter)
- Human-in-the-loop requirement for cross-entity actions
- Entity diagnostic skill

### Changed
- Removed nested inbox folders (handoffs/, follow_ups/, etc.)

---

## [1.2] - 2025-12-31

### Added
- Session continuity protocol
- Same-day session loading
- Skill index requirement

---

## [1.1] - 2025-12-30

### Added
- Token budget guidelines
- Contextual surfacing for learnings

---

## [1.0] - 2025-12-23

### Added
- Initial specification
- Three-layer architecture (context, memory, data)
- Tier 1/2/3 entity classification
- Birth process documentation

---

**Maintained by**: Protocol
