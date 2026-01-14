# Inbox Message Examples

**Purpose**: Concrete YAML frontmatter examples for cross-entity communication
**Reference**: See `ENTITY_SPEC.md` Section "Inbox Protocol" for full specification
**Spec Version**: 1.8

---

## Inbox Structure

```
memory/inbox/
├── _README.md                           # Inbox documentation
├── 2026-01-03_handoff-from-jane.md      # Example handoff
└── 2026-01-03_follow-up-review.md       # Example follow-up
```

**Key principles**:
- Flat folder (no nested subfolders)
- YAML frontmatter for metadata
- File naming: `YYYY-MM-DD_[slug].md`
- Metadata in files, not folder names

---

## Message Types

### Type: handoff

Work transition from one entity to another.

```yaml
---
type: handoff
from: Jane
to: Engineer
status: pending
priority: high
created: 2026-01-03
acknowledged:
completed:
surface_when: session start
---

# CIQ Cloud Function Deployment

## Summary

Deploy the CIQ sync architecture to Google Cloud Functions with Cloud Scheduler trigger.

## Context

Architecture was designed in earlier session. The sync script (`src/sync.ts`) works correctly - tested manually. Need to deploy Cloud Function for automated daily sync.

## What's Needed

1. Create GCP project (or use existing)
2. Enable Cloud Functions API
3. Deploy function from `cloud-function/` directory
4. Set up Cloud Scheduler for daily trigger

## Success Criteria

- [ ] Cloud Function deployed and responding
- [ ] Cloud Scheduler configured for daily run
- [ ] First successful sync logged
- [ ] Events appearing in Supabase

## Resources

- `/repos/ciq-mcp-server/cloud-function/README.md` - Deployment guide
- `/repos/ciq-mcp-server/cloud-function/.env.yaml` - Credentials (in .gitignore)

## Urgency

High - Hookdeck has 3-day retention, need sync running before events age out.
```

**Status lifecycle**:
- `pending` → Waiting for acknowledgment
- `acknowledged` → In progress
- `completed` → Work finished
- `dismissed` → Not needed (with reason)

---

### Type: follow_up

Self-generated reminder or item to revisit.

```yaml
---
type: follow_up
status: pending
priority: medium
created: 2026-01-03
surface_when: strategic session, family coordination
---

# Family Context Architecture Review

## Summary

Revisit the family coordination context flow architecture to validate it's working and identify improvements.

## What Was Done

1. Architecture decision: Trello = source of truth for tasks, Jane = source of truth for context
2. Cached digest model: `data/household/trello_digest.md` stores processed events
3. Skill updates: `/logistics-prep` queries CIQ and writes digest

## To Revisit

1. Has the digest been useful in practice?
2. Is 24h freshness sufficient?
3. Profile staleness: Family profiles may need updates
4. Calendar integration: Not yet connected

## Reference Files

- `data/household/trello_digest.md`
- `data/household/trello_conventions.md`
```

---

### Type: skill_proposal

Request for new skill or capability.

```yaml
---
type: skill_proposal
from: Engineer
to: Jane
status: pending
priority: low
created: 2026-01-03
surface_when: strategic session, skill review
---

# Skill Proposal: Deploy Verification

## Summary

Create a skill for verifying deployments are successful across different platforms (GCP, Vercel, etc.).

## Problem

After deploying Cloud Functions, need to manually verify:
- Function is responding
- Logs show no errors
- Scheduled trigger is working

This could be automated with a verification skill.

## Proposed Skill

`/deploy-verify` - Run post-deployment checks

### Features

1. Check function health endpoint
2. Query recent logs for errors
3. Verify scheduler is configured
4. Report status summary

### Portability

Would work for Engineer primarily, but could be shared.

## Evidence of Need

Had to manually verify CIQ Cloud Function deployment 3 times during iteration.

## Effort Estimate

~2 hours to build initial version

## Decision Requested

Should I build this, or is it over-engineering for current needs?
```

---

## Frontmatter Reference

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `type` | string | `handoff`, `follow_up`, or `skill_proposal` |
| `status` | string | `pending`, `acknowledged`, `completed`, or `dismissed` |
| `priority` | string | `high`, `medium`, or `low` |
| `created` | date | YYYY-MM-DD format |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `from` | string | Source entity (for handoffs, skill proposals) |
| `to` | string | Target entity (for handoffs, skill proposals) |
| `acknowledged` | date | When status changed to acknowledged |
| `completed` | date | When status changed to completed |
| `surface_when` | string | Context triggers for surfacing during boot |

### Valid `surface_when` Values

| Trigger | When it surfaces |
|---------|------------------|
| `session start` | Every session boot |
| `strategic session` | Full boot (`--full` flag) |
| `family coordination` | When discussing family/household |
| `weekly review` | During weekly review sessions |
| `name:[person]` | When person is mentioned |
| `domain:[topic]` | When topic is discussed |

---

## Processing Inbox Items

### During Session Start

1. Scan `memory/inbox/*.md` (excluding `_README.md`)
2. Read YAML frontmatter
3. If `status: pending` → Surface in boot report
4. If `status: acknowledged` or later → Skip (already processed)

### Acknowledging Items

Update frontmatter:
```yaml
status: acknowledged
acknowledged: 2026-01-04
```

### Completing Items

Update frontmatter:
```yaml
status: completed
completed: 2026-01-04
```

Add completion notes to body if relevant.

### Dismissing Items

Update frontmatter:
```yaml
status: dismissed
completed: 2026-01-04
```

Add dismissal reason to body:
```markdown
## Dismissed

**Reason**: No longer relevant - problem resolved via different approach.
```

---

## messages_to_jane/ (Informal Channel)

For quick notes that don't need formal tracking:

**Location**: `memory/messages_to_jane/`
**Format**: Simple markdown, no YAML required
**File naming**: `YYYY-MM-DD_[slug].md`

### Example

```markdown
# CIQ Deployment Status Update

**Date**: 2026-01-03
**From**: Engineer
**Type**: Status Update

---

Deployed CIQ Cloud Function successfully. Scheduler is configured for daily runs at 6 AM UTC.

First sync ran and captured 21 new events.

---

**Status**: Pending (waiting for Jane to acknowledge)
```

**When to use informal vs. formal**:
- **Informal** (`messages_to_jane/`): Quick updates, questions, non-blocking
- **Formal** (`inbox/`): Work transitions, blocking issues, formal deliverables
