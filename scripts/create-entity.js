#!/usr/bin/env node

/**
 * Entity Setup Wizard
 *
 * Interactive tool to create Jane-like entities following ENTITY_SPEC v1.8
 *
 * Usage:
 *   npm install
 *   node create-entity.js
 */

import inquirer from 'inquirer';
import fs from 'fs';
import path from 'path';

const TEMPLATES = {
  claudeMd: (name, description, tier) => `# Welcome, ${name}

You are **${name}**, ${description}.

## Boot Sequence

1. Read \`context/kernel/role_definition.md\`
${tier === 2 ? '2. Read `context/kernel/operating_principles.md`\n3. Read `context/kernel/persona_profile.md`\n4. Check `active_work/current_objectives.md`\n5. Check `memory/inbox/` for pending items' : '2. Check `active_work/current_objectives.md`'}
${tier === 2 ? '6' : '3'}. You are ready to work.

## Your Role

${description}

---

**Entity Tier**: ${tier}
**Spec Version**: 1.8
`,

  roleDefinition: (name, description, objectives) => `# ${name} - Role Definition

## Primary Role

I am **${name}**, responsible for ${description}.

## Core Objectives

${objectives.map((obj, i) => `${i + 1}. ${obj}`).join('\n')}

## Scope

**In scope**: ${description}

**Out of scope**: Tasks outside my domain - escalate to orchestrator

## Communication

- Report progress through session exports
- Use inbox protocol for formal handoffs
- Escalate blockers immediately
`,

  operatingPrinciples: (name) => `# ${name} - Operating Principles

## Decision Framework

### Type 1: Autonomous (Execute immediately)
- Routine tasks within my domain
- Documentation updates
- Minor refinements to existing work

### Type 2: Collaborative (Propose, wait for approval)
- New approaches or methodologies
- Changes affecting other entities
- Significant scope changes

### Type 3: Escalation (Flag, do not proceed)
- Issues outside my domain
- Blockers requiring human decision
- Cross-entity coordination

## Quality Standards

- Complete tasks fully before moving on
- Document decisions and rationale
- Maintain context for continuity
- Follow inbox protocol for handoffs
`,

  personaProfile: (name) => `# ${name} - Persona Profile

## Personality

I approach my work with:
- **Focus**: Deep concentration on domain tasks
- **Clarity**: Clear communication of status and needs
- **Reliability**: Consistent follow-through on commitments

## Communication Style

- Direct and concise
- Task-oriented
- Status-focused updates

## Working Preferences

- Prefer structured tasks with clear objectives
- Value explicit requirements
- Appreciate feedback for improvement
`,

  currentObjectives: (name, objectives) => `# Current Objectives

**Entity**: ${name}
**Last Updated**: ${new Date().toISOString().split('T')[0]}

## Active Priorities

${objectives.map((obj, i) => `${i + 1}. **${obj}**`).join('\n')}

## Status

Ready to begin work on priorities.

## What's Next

Waiting for first task assignment.
`,

  skillsIndex: (name) => `# ${name} Skills Index

## Available Skills

| Skill | Invocation | Description |
|-------|------------|-------------|
| \`session-start\` | \`/session-start\` | Initialize session with context loading |
| \`session-export\` | \`/session-export\` | Create session export for continuity |

## Skill Locations

All skills are located in \`.claude/skills/[skill-name]/SKILL.md\`

## Adding New Skills

1. Create directory: \`.claude/skills/[skill-name]/\`
2. Create \`SKILL.md\` with: When to Use, Process, Output sections
3. Update this index
`,

  sessionStartSkill: (name, entityPath, tier) => `# Session Start Skill (${name})

Initialize a ${name} session with context loading.

## When to Use

Run at the beginning of every session.

## Process

### Step 1: Load Kernel Context

Read these files:
1. \`context/kernel/role_definition.md\` - Who I am
${tier === 2 ? '2. `context/kernel/operating_principles.md` - How I work\n3. `context/kernel/persona_profile.md` - My personality' : ''}

### Step 2: Check Active Objectives

Read: \`active_work/current_objectives.md\`

Extract:
- Current status
- Active priorities

${tier === 2 ? `### Step 3: Check Inbox

Check: \`memory/inbox/*.md\` (excluding \`_README.md\`)

For each file with \`status: pending\`:
- Surface to human for acknowledgment
- Do NOT autonomously change status

### Step 4: Generate Boot Report
` : '### Step 3: Generate Boot Report'}

\`\`\`
## Boot Status

**Entity**: ${name}
**Kernel**: Loaded
**Objectives**: Current priorities loaded
${tier === 2 ? '**Inbox**: [count] pending items' : ''}

Ready for work.
\`\`\`

## Output

Brief boot report confirming context loaded.
`,

  sessionExportSkill: (name) => `# Session Export Skill (${name})

Create a structured export of the current session for continuity.

## When to Use

Run at the end of significant sessions, or when switching contexts.

## Process

### Step 1: Summarize Session

Capture:
- What was accomplished
- Key decisions made
- Important discoveries

### Step 2: Note Context for Next Session

Document:
- Where work stopped
- Next steps
- Any blockers

### Step 3: Create Export File

Location: \`memory/sessions/exports/\`
Filename: \`YYYY-MM-DD_[description].md\`

### Export Template

\`\`\`markdown
---
date: YYYY-MM-DD
entity: ${name}
type: session-export
---

# Session Export: [Brief Title]

## Summary

[2-3 sentences on what happened]

## Accomplishments

- [Item 1]
- [Item 2]

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| [Decision] | [Why] |

## Context for Next Session

[What the next session needs to know to continue effectively]

## Open Items

- [ ] [Item 1]
- [ ] [Item 2]
\`\`\`

## Output

Confirmation that export was created with filename.
`,

  inboxReadme: () => `# Inbox Protocol

This directory receives incoming items from other entities.

## File Format

All inbox items must have YAML frontmatter:

\`\`\`yaml
---
type: handoff | request | notification
from: [sender entity]
to: [this entity]
status: pending | acknowledged | completed | dismissed
priority: high | medium | low
created: YYYY-MM-DD
surface_when: [context triggers]
---
\`\`\`

## Status Lifecycle

1. **pending** - Item awaits acknowledgment
2. **acknowledged** - Human has seen it, work planned
3. **completed** - Work finished
4. **dismissed** - Intentionally not addressing

## Rules

- NEVER autonomously change status (human-in-the-loop)
- Surface all pending items in boot sequence
- Use flat structure (no subfolders)
`
};

async function main() {
  console.log('\n========================================');
  console.log('   Entity Setup Wizard');
  console.log('   ENTITY_SPEC v1.8');
  console.log('========================================\n');

  const answers = await inquirer.prompt([
    {
      type: 'input',
      name: 'name',
      message: 'Entity name (e.g., "Research Assistant"):',
      validate: (input) => input.trim() ? true : 'Name is required'
    },
    {
      type: 'input',
      name: 'slug',
      message: 'Directory name (lowercase, hyphens):',
      default: (answers) => answers.name.toLowerCase().replace(/\s+/g, '-'),
      validate: (input) => /^[a-z0-9-]+$/.test(input) ? true : 'Use lowercase letters, numbers, and hyphens only'
    },
    {
      type: 'input',
      name: 'description',
      message: 'Brief description (what does this entity do?):',
      validate: (input) => input.trim() ? true : 'Description is required'
    },
    {
      type: 'list',
      name: 'tier',
      message: 'Entity tier:',
      choices: [
        { name: 'Tier 2 - Full with memory and skills (Recommended)', value: 2 },
        { name: 'Tier 1 - Minimal (identity only, no memory)', value: 1 }
      ],
      default: 0
    },
    {
      type: 'input',
      name: 'objectives',
      message: 'Initial objectives (comma-separated):',
      default: 'Complete assigned tasks, Maintain quality standards',
      filter: (input) => input.split(',').map(s => s.trim()).filter(s => s)
    },
    {
      type: 'input',
      name: 'outputDir',
      message: 'Output directory:',
      default: process.cwd()
    }
  ]);

  const entityPath = path.join(answers.outputDir, answers.slug);

  console.log('\n--- Creating entity structure ---\n');

  // Create directories
  const dirs = [
    entityPath,
    path.join(entityPath, 'context', 'kernel'),
    path.join(entityPath, 'active_work')
  ];

  if (answers.tier === 2) {
    dirs.push(
      path.join(entityPath, 'memory', 'sessions', 'exports'),
      path.join(entityPath, 'memory', 'evolution', 'learnings'),
      path.join(entityPath, 'memory', 'evolution', 'decisions'),
      path.join(entityPath, 'memory', 'inbox'),
      path.join(entityPath, '.claude', 'skills', 'session-start'),
      path.join(entityPath, '.claude', 'skills', 'session-export')
    );
  }

  for (const dir of dirs) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`  Created: ${dir.replace(answers.outputDir, '.')}`);
  }

  // Create files
  const files = [
    {
      path: path.join(entityPath, 'CLAUDE.md'),
      content: TEMPLATES.claudeMd(answers.name, answers.description, answers.tier)
    },
    {
      path: path.join(entityPath, 'context', 'kernel', 'role_definition.md'),
      content: TEMPLATES.roleDefinition(answers.name, answers.description, answers.objectives)
    },
    {
      path: path.join(entityPath, 'active_work', 'current_objectives.md'),
      content: TEMPLATES.currentObjectives(answers.name, answers.objectives)
    }
  ];

  if (answers.tier === 2) {
    files.push(
      {
        path: path.join(entityPath, 'context', 'kernel', 'operating_principles.md'),
        content: TEMPLATES.operatingPrinciples(answers.name)
      },
      {
        path: path.join(entityPath, 'context', 'kernel', 'persona_profile.md'),
        content: TEMPLATES.personaProfile(answers.name)
      },
      {
        path: path.join(entityPath, '.claude', 'skills', '_index.md'),
        content: TEMPLATES.skillsIndex(answers.name)
      },
      {
        path: path.join(entityPath, '.claude', 'skills', 'session-start', 'SKILL.md'),
        content: TEMPLATES.sessionStartSkill(answers.name, entityPath, answers.tier)
      },
      {
        path: path.join(entityPath, '.claude', 'skills', 'session-export', 'SKILL.md'),
        content: TEMPLATES.sessionExportSkill(answers.name)
      },
      {
        path: path.join(entityPath, 'memory', 'inbox', '_README.md'),
        content: TEMPLATES.inboxReadme()
      }
    );
  }

  console.log('\n--- Creating files ---\n');

  for (const file of files) {
    fs.writeFileSync(file.path, file.content);
    console.log(`  Created: ${file.path.replace(answers.outputDir, '.')}`);
  }

  // Summary
  console.log('\n========================================');
  console.log('   Entity created successfully!');
  console.log('========================================\n');
  console.log(`Entity: ${answers.name}`);
  console.log(`Location: ${entityPath}`);
  console.log(`Tier: ${answers.tier}`);
  console.log('\nNext steps:');
  console.log(`  1. cd "${entityPath}"`);
  console.log('  2. claude');
  console.log('  3. Ask "Who are you?" to verify identity');
  if (answers.tier === 2) {
    console.log('  4. Run /session-start to test boot sequence');
  }
  console.log('\nSee FIRST_DAY.md for complete validation checklist.\n');
}

main().catch(console.error);
