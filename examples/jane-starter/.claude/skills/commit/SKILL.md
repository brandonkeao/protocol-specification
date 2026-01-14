---
description: Create git commits using Conventional Commits format. Use when committing code changes, after completing work, or when user requests a commit.
---

# Commit Skill

Create structured git commits following the Conventional Commits specification.

## When to Use

- User runs `/commit` command
- User says "commit changes", "commit this", "make a commit"
- After completing a coding task (if user requests)

## Conventional Commits Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Commit Types

| Type | When to Use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only changes |
| `style` | Formatting, whitespace, no code change |
| `refactor` | Code restructuring without behavior change |
| `test` | Adding or updating tests |
| `chore` | Maintenance, dependencies, tooling |

### Scope (Optional)

Brief word describing the area affected:
- `(auth)` - authentication related
- `(api)` - API changes
- `(ui)` - user interface
- `(skills)` - entity skills
- `(context)` - context changes

## Process

### Step 1: Analyze Changes

```bash
git status              # See all untracked and modified files
git diff --staged       # See staged changes
git diff                # See unstaged changes
```

### Step 2: Determine Commit Type

- **New functionality?** -> `feat`
- **Bug fixed?** -> `fix`
- **Only docs changed?** -> `docs`
- **Code restructured?** -> `refactor`
- **Tests added?** -> `test`
- **Build/deps/tooling?** -> `chore`

### Step 3: Draft Commit Message

1. **Type**: Choose from table above
2. **Scope**: (Optional) Area affected
3. **Description**: Imperative mood, lowercase, no period
   - Good: "add user authentication flow"
   - Bad: "Added user authentication flow."
4. **Body**: (Optional) Explain *why* if needed

### Step 4: Stage Files

```bash
git add [specific files]    # Preferred: stage specific files
git add .                   # Or: stage all if related
```

**Never commit**:
- `.env` files or credentials
- Generated files (unless intentional)
- Large binary files

### Step 5: Execute Commit

Use HEREDOC for proper formatting:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

<optional body>
EOF
)"
```

### Step 6: Confirm Success

Run `git status` to verify commit succeeded.

## Examples

### New Feature

```bash
git commit -m "$(cat <<'EOF'
feat(skills): add session-start skill

Adds structured boot workflow with lightweight and full modes.
EOF
)"
```

### Bug Fix

```bash
git commit -m "$(cat <<'EOF'
fix(auth): resolve token refresh race condition

The refresh token was being cleared before the new token arrived.
EOF
)"
```

### Documentation

```bash
git commit -m "$(cat <<'EOF'
docs: update README with setup instructions
EOF
)"
```

### Chore

```bash
git commit -m "$(cat <<'EOF'
chore(deps): update dependencies
EOF
)"
```

## Quality Checklist

- [ ] Changes analyzed with `git status` and `git diff`
- [ ] Appropriate commit type selected
- [ ] Description is imperative mood, lowercase, no period
- [ ] No secrets or credentials staged
- [ ] Commit succeeded (verified with `git status`)

## Notes

- **One commit = one logical change**: Don't batch unrelated changes
- **Keep descriptions concise**: Under 50 characters ideal
- **Body for context**: When "what" isn't enough, explain "why"
