# Handoff Skill

Transition work to another entity with proper documentation.

## When to Use

Use this skill when:
- You've completed work that another entity needs to act on
- Research/analysis is done and needs review
- A project phase is complete and ready for handoff
- Work is blocked waiting on another entity's input

**Trigger phrases:**
- `/handoff` or `/handoff [entity]`
- "hand this off to [entity]"
- "transition this to [entity]"
- "send to [entity] for review"

## Entity Routing

| Entity | Receives | Location |
|--------|----------|----------|
| **[Orchestrator]** | Strategy, coordination, cross-domain | `/[orchestrator]/memory/inbox/` |
| **[Specialist 1]** | [Domain work] | `/[specialist1]/memory/inbox/` |
| **[Specialist 2]** | [Domain work] | `/[specialist2]/memory/inbox/` |

*Update this table as you add entities to your ecosystem.*

---

## Process: Sending a Handoff

### Step 1: Identify Recipient

Determine which entity should receive this work based on routing table.

If unclear, default to the orchestrator (hub) for routing decisions.

### Step 2: Gather Handoff Information

Before creating the handoff, determine:
- **Summary**: 1-2 sentence description
- **Priority**: High (blocking) / Medium (important) / Low (whenever)
- **What was done**: Your completed work
- **What's needed**: Specific actions for recipient
- **Success criteria**: How recipient knows they're done
- **Resources**: Links to relevant files

### Step 3: Create Handoff Document

**Location**: `/[recipient]/memory/inbox/YYYY-MM-DD_handoff-from-[sender]-[slug].md`

**Template**:
```markdown
---
type: handoff
from: [Your Entity Name]
to: [Recipient Entity]
status: pending
priority: high | medium | low
created: YYYY-MM-DD
---

# Handoff: [Title]

## Summary

[1-2 sentence description of what's being handed off]

## Context

[Background needed to understand this work]

## What Was Done

- [Completed item 1]
- [Completed item 2]

## What's Needed

[Specific actions the recipient should take]

## Success Criteria

- [ ] [Concrete deliverable 1]
- [ ] [Concrete deliverable 2]

## Resources

- [Link to file 1]
- [Link to file 2]

## Urgency/Deadline

[Time constraints, or "None - async"]

---

**Acknowledged**: | **Completed**:
```

### Step 4: Update Own Records

Note the handoff in your session export:
- What was handed off
- To whom
- Expected follow-up

### Step 5: Confirm

Output:
```
Handoff created for [Recipient]: [Title]
Location: [path to handoff file]
Priority: [priority]

[Recipient] will see this on their next session boot.
```

---

## Process: Receiving Handoffs (Boot Integration)

During boot (handled by `session-start` skill):

1. Check `memory/inbox/*.md` for files with `type: handoff`
2. Read each and check `status:` field
3. Surface any with `status: pending` in boot report

---

## Process: Acknowledging a Handoff

When you begin work on a received handoff:

1. Open the handoff file
2. Change `status: pending` to `status: acknowledged`
3. Add acknowledgment date: `**Acknowledged**: YYYY-MM-DD`
4. Begin work on the success criteria

---

## Process: Completing a Handoff

When all success criteria are met:

1. Check off all success criteria
2. Change `status: acknowledged` to `status: completed`
3. Add completion date: `**Completed**: YYYY-MM-DD`

Completed handoffs stay in place as a record.

---

## Quality Checklist

When sending:
- [ ] Recipient entity is correct
- [ ] Summary is clear and concise
- [ ] Success criteria are specific
- [ ] All relevant files linked
- [ ] Priority reflects urgency

When receiving:
- [ ] Status updated to `acknowledged` when starting
- [ ] Success criteria worked through
- [ ] Status updated to `completed` when done

---

## Notes

- **Handoffs are async**: Recipient sees them on next boot
- **Hub model**: Cross-entity coordination goes through orchestrator
- **Keep focused**: One topic per handoff
- **Resources matter**: Always link the files needed
