# Pattern: Index, Don't Load

**Category**: context-engineering, token-efficiency

## Summary

For memory categories that might be "nice to have," show what exists (metadata + summary) rather than loading full content. This preserves awareness without consuming tokens on content that may not be needed. The agent can pull full details on-demand when actually required.

## Evidence

Full memory loading during boot consumed excessive tokens. By switching to indexing approach (frontmatter + first paragraph only), achieved a 40% reduction while maintaining full awareness of available context.

**Indexing extracts**:
- Frontmatter metadata (date, title, type)
- First paragraph or summary line
- File path for on-demand access

**What it enables**: Agent knows what learnings, decisions, and sessions exist, and can pull any of them when contextually relevant.

## Application

When designing context loading:
1. Ask: "Does the agent need full content, or just awareness?"
2. If awareness is sufficient, index rather than load
3. Include file path so full content is one Read away
4. Reserve full loading for frequently-needed content (kernel, current objectives)

**Pattern**:
- Boot: Load indices (what exists)
- During session: Pull full content when topic arises
- Result: Lower boot cost, no loss of capability

## Surface When

- Designing boot sequences
- Optimizing token usage
- Adding new memory categories
- Context feels bloated
