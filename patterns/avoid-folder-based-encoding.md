# Pattern: Avoid Folder-Based Type Encoding

**Category**: architecture, file-systems

## Summary

Encoding metadata (like item type) in folder structure is fragile and creates scanning complexity. When you find yourself creating nested folder structures for categorization, ask whether that information belongs in the files themselves. Folders are for organization, not classification - metadata belongs in frontmatter where it can be queried and processed programmatically.

## Evidence

The inbox had nested folders: `handoffs/from_*/`, `follow_ups/`, `skill_proposals/` - but only contained 3 total items. The session-start skill was only scanning `handoffs/` and completely missed items in `follow_ups/`. This caused items to be hidden during boot.

**Solution**: Flattened to single `memory/inbox/` folder with `type` field in YAML frontmatter. Single glob pattern finds everything.

## Application

When designing file-based systems:
1. Put type/category in file frontmatter, not folder name
2. Use single folder with glob pattern for scanning
3. Avoid multi-path scanning complexity
4. Make metadata explicit, queryable, and portable

**Anti-pattern**: `inbox/handoffs/`, `inbox/follow_ups/`, `inbox/proposals/`

**Better**: `inbox/*.md` with `type: handoff | follow_up | proposal` in frontmatter

## Surface When

- Designing file-based storage structures
- Creating new inbox or queue systems
- Refactoring existing file organization
- Debugging "missing file" issues in scanning logic
