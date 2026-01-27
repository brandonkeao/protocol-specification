# Entity Specification Changelog

Track the evolution of ENTITY_SPEC.md over time.

## Versioning

- **MAJOR**: Breaking changes requiring entity updates
- **MINOR**: Backwards-compatible additions
- **PATCH**: Clarifications and documentation fixes

---

## [2.6] - 2026-01-26

### Added
- **Recommended Infrastructure** section:
  - Cortex session memory as optional but recommended tooling
  - Explains relationship between Cortex (automatic capture) and entity memory (curated)
  - Configuration presets (full, essential, minimal)
  - Verification checklist

### New Files
- `birth_protocol/agent_birth_protocol.md` - Complete entity birth process with infrastructure verification

### Notes
- Cortex is user-level (applies to all entity workspaces automatically)
- `projectScope: true` keeps memories separated per entity
- Complements, doesn't replace, the existing entity memory system

---

## [2.5] - 2026-01-25

### Added
- **Claude Product Compatibility** requirements:
  - Self-contained identity in CLAUDE.md lines 1-30
  - Graceful degradation across Claude products (Code, Cowork, API)
  - Portability testing requirements
  - Product-specific CLAUDE.md sections

### Notes
- Critical for Claude Cowork compatibility (no hooks/skills, only CLAUDE.md loaded)
- entity-diagnostic should WARN if lines 1-30 don't contain identity keywords

---

## [2.4] - 2026-01-22

### Added
- **Error Handling & Recovery** section:
  - Error categories (Structural, Runtime, Coordination, Data)
  - Recovery procedures for common failure modes
  - Graceful degradation guidelines
  - Human escalation triggers
- **Version Compatibility** section:
  - Compatibility matrix for all versions
  - Migration guide links
  - Deprecation policy
- **Coordination Edge Cases** in Inbox Protocol:
  - Entity deletion mid-coordination
  - Circular handoff detection with `handoff_chain`
  - Inbox overload handling (>20 pending)
  - Stale item management (>30 days)
- **Context Map Lifecycle** in Context Maps:
  - When to create context maps
  - Maintenance guidelines
  - Deprecation and conflict resolution
- **Plan vs. Session Export guidance** in Plan Persistence:
  - Decision tree for choosing between plans and exports
  - Retrofitting plans to existing entities

### New Files
- `SKILL_AUTHORING.md` - Complete guide for skill development
- `MIGRATION.md` - Tier 1 → Tier 2 and version migration guide
- `scripts/fresh_start_validator.sh` - Entity validation script
- `templates/plan_template.md` - Plan file template
- `templates/skills/context-diagnostic/SKILL.md` - Context loading diagnostic
- `templates/skills/list-skills/SKILL.md` - Skill discovery
- `templates/skills/entity-diagnostic/SKILL.md` - Enhanced with `--memory` flag

### Updated
- `templates/inbox_message_examples.md` - Added notification type, handoff_chain, circular detection

### Notes
- Backwards-compatible (MINOR version)
- Comprehensive stability and UX improvements for new users
- All validation checks updated to v2.4

---

## [2.3] - 2026-01-22

### Added
- **Context Map Distribution** subsection in Context Maps:
  - Pull flow for consuming shared context from Git repositories
  - Push flow for sharing local context to remotes
  - Registry pattern (`context_repos/_registry.md`) for tracking repos
  - Example architecture diagram showing workspace layout
  - Enables portable, shareable knowledge across agentic systems

### Notes
- Backwards-compatible (MINOR version)
- Documents existing pattern validated in Rebrandly workspace (epd_context repo)

---

## [2.2] - 2026-01-21

### Added
- **Onboarding** section for Tier 2 orchestrators:
  - First-boot detection using state file (`memory/system_health/onboarding.md`)
  - Progressive disclosure flow (6 steps)
  - Skip/reset escape hatches
  - Integration with session-start skill
- **Fresh Start Testing** section:
  - Automated validation via `fresh_start_validator.sh`
  - Testing scenarios for new entities, first-boot, continuity
  - Integration with protocol reviews

### Notes
- Backwards-compatible (MINOR version)
- Onboarding pattern validated with Jane (Work) orchestrator

---

## [2.1] - 2026-01-20

### Added
- **Context Maps** (new section): Optional pattern for loadable knowledge modules
  - Structured context collections that complement entities
  - Loading via dedicated skills (`/load-[domain]-context`)
  - Skill template for context loading
  - Relationship matrix (Entity vs Context Map)
- **Skill Classification** framework in Core Skills section:
  - Core Skills: Required for all Tier 2, spec-owned
  - Domain Skills: Entity-specific workflows, entity-owned
  - Custom Skills: User-requested additions, user-owned

### Notes
- All additions backwards-compatible (MINOR version)
- Context Maps pattern already validated in production (leadership/team context maps)
- Skill classification reflects emerging patterns across workspaces

---

## [2.0] - 2026-01-20

### Added
- **Plan Persistence** section for multi-session work tracking:
  - Plan lifecycle: draft → active → paused → completed
  - Human-in-the-loop approval for status changes
  - Registry pattern for tracking plans
  - `/persist-plan` skill specification

### Notes
- Major version bump due to significant new capability
- Backwards-compatible - plans are optional
- Validation checklist updated

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
