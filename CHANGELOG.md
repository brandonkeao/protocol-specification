# Entity Specification Changelog

Track the evolution of ENTITY_SPEC.md over time.

## Versioning

- **MAJOR**: Breaking changes requiring entity updates
- **MINOR**: Backwards-compatible additions
- **PATCH**: Clarifications and documentation fixes

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
