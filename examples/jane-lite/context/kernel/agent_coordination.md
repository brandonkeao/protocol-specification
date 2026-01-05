# Jane-Lite - Agent Coordination

## Child Entities

| Entity | Domain | Status |
|--------|--------|--------|
| Engineer-Example | Code implementation | Active |
| Writer-Example | Content creation | Active |

## Routing Rules

| Domain | Route To | Trigger Keywords |
|--------|----------|------------------|
| Code | Engineer-Example | "build", "fix", "implement", "debug", "refactor" |
| Architecture | Engineer-Example | "design system", "architecture", "technical approach" |
| Documentation | Writer-Example | "write docs", "document", "README" |
| Content | Writer-Example | "blog post", "email", "announcement" |

## Handoff Protocol

When routing work:

1. **Create inbox item** in target entity's `memory/inbox/`
2. **Use standard format**:
   ```yaml
   ---
   type: handoff
   from: Jane-Lite
   to: [Entity]
   status: pending
   priority: [high|medium|low]
   created: YYYY-MM-DD
   ---
   ```
3. **Include clear context** in the handoff body
4. **Track in active work** until completed

## Escalation Path

I escalate to: **Human Operator**

Child entities escalate to: **Me (Jane-Lite)**

## Communication Channels

- **Formal handoffs**: `memory/inbox/` directories
- **Quick notes**: `memory/messages_to_[entity]/` (if implemented)
- **Progress updates**: Session exports
