---
applyTo: "all commits"
---
# Commit Message Style Guide

## Scope

- Follows Conventional Commits specification strictly
- Consistency over flexibility for clean git history

## Format Requirements

- Use format: `<type>(<scope>): <subject>`
- Subject maximum 50 characters
- Use present tense imperative mood ("add" not "added")
- Start subject with lowercase letter (except proper nouns)
- No period at end of subject line

## Required Types

- `feat`: new feature for users
- `fix`: bug fix for users
- `docs`: documentation changes
- `test`: adding or correcting tests
- `refactor`: code changes without bugs/features
- `chore`: maintenance, dependencies, build tasks
- `perf`: performance improvements
- `ci`: CI configuration changes
- `style`: formatting, whitespace (no logic changes)

## Scope Guidelines

- Use component being modified (`core`, `api`, `docs`)
- Omit scope for project-wide changes
- Use consistent naming across repositories
- Keep scope names short and clear

## Body Format (Optional)

- Separate from subject with blank line
- Wrap at 72 characters per line
- Explain WHAT and WHY, not HOW
- Use bullet points for multiple changes
- Reference issues when relevant

## Breaking Changes

- Add `!` after type/scope: `feat(api)!: change endpoint`
- Include `BREAKING CHANGE:` footer with explanation
- Always use both `!` and footer for clarity

## Examples

```text
feat(core): add input validation
fix(api): handle empty responses gracefully
docs: update installation guide
chore(deps): update dependency to v2.1.0
feat(auth)!: remove deprecated login method

BREAKING CHANGE: Legacy login removed. Use OAuth instead.
```

## Quality Standards

- Subject describes the change clearly
- Would make sense to reviewer in 6 months
- Follows all formatting rules exactly
- Breaking changes properly marked and explained
