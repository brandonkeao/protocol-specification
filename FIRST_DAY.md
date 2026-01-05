# First Day with Your Entity

What to do in your first session after creating an entity.

---

## Tier 1 Entity Checklist

### Immediate (First 5 minutes)

- [ ] **Boot the entity**: `cd [entity-name] && claude`
- [ ] **Verify identity**: Ask "Who are you?" - should match role_definition.md
- [ ] **Check objectives**: Ask "What are your current priorities?"
- [ ] **Test basic interaction**: Give it a simple task in its domain

### Validation (Next 5 minutes)

- [ ] **Exit and reboot**: Close and reopen to verify CLAUDE.md loads correctly
- [ ] **Check context persistence**: Identity should be retained
- [ ] **Review token usage**: Kernel should be <2k tokens

### Documentation

- [ ] Note any issues encountered
- [ ] Update CLAUDE.md if boot instructions need refinement

---

## Tier 2 Entity Checklist

### Immediate (First 10 minutes)

- [ ] **Boot the entity**: `cd [entity-name] && claude`
- [ ] **Run session-start**: `/session-start` - verify boot sequence completes
- [ ] **Check boot report**: Should show kernel loaded, objectives, inbox status
- [ ] **Verify identity**: Ask "Who are you?" with personality

### Session Continuity (Next 10 minutes)

- [ ] **Do some work**: Give the entity a task in its domain
- [ ] **Run session-end**: `/session-end` - verify export is created
- [ ] **Check export**: Look in `memory/sessions/exports/` for today's file
- [ ] **Verify export content**: Should have summary, decisions, context for next session

### Round-Trip Test (Next 5 minutes)

- [ ] **Exit Claude**
- [ ] **Reboot**: `claude`
- [ ] **Run session-start**: `/session-start`
- [ ] **Verify continuity**: Entity should reference previous session export
- [ ] **Check same-day loading**: Recent session should be surfaced

### Inbox Test (if cross-entity communication needed)

- [ ] **Create test inbox item**: Add a file to `memory/inbox/`
- [ ] **Reboot with session-start**: Item should be surfaced
- [ ] **Verify human-in-the-loop**: Entity should present item for acknowledgment

---

## Success Indicators

### Healthy Entity Shows:

```
Boot Status (Lightweight)
Kernel: Loaded (role_definition.md, operating_principles.md, ...)
Objectives: Current priorities loaded
Inbox: 0 pending items
Ready for work.
```

### Problems to Watch For:

| Symptom | Likely Cause |
|---------|--------------|
| "I don't know who I am" | CLAUDE.md missing or incorrect paths |
| Boot takes >5 seconds | Kernel too large, consider _summary.md |
| Skills not found | .claude/skills/ directory missing |
| No session export created | session-export skill not installed |
| Inbox items not surfaced | session-start not checking inbox |

---

## Day 1 Accomplishments

By end of first day, you should have:

1. **Working boot sequence** - Entity loads with correct identity
2. **Verified persistence** - Context survives restart
3. **Tested core workflow** - Basic task completion works
4. **(Tier 2) Session continuity** - Exports are created and loaded
5. **(Tier 2) Skills working** - /session-start and /session-end function

---

## What to Do Tomorrow

1. **Start with `/session-start`** - Verify same-day session loading
2. **Check inbox** - Process any pending items
3. **Do real work** - Give the entity actual tasks
4. **End with `/session-end`** - Build session history

---

## Getting Help

- **Troubleshooting**: See `TROUBLESHOOTING.md`
- **Full specification**: See `specification/architecture.md`
- **Examples**: See `examples/` directory
- **Issues**: Open at [GitHub](https://github.com/brandonkeao/protocol-specification)
