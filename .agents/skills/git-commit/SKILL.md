---
name: git-commit
description: >
  Create Conventional Commits-compliant Git commits by inspecting changes,
  staging intended files, and composing the message. Use when the user asks
  to commit changes or create a Git commit.
license: MIT
metadata:
  author: Pier Luigi Fiorini
  copyright: Copyright (c) 2026 Pier Luigi Fiorini
---

# Conventional Commits

Create commits directly using the Conventional Commits 1.0.0 format.
Honor user-specified scope, message wording, and file constraints.

## Format

```text
<type>[(<scope>)][!]: <description>

[body]

[footer(s)]
```

- **Type:** use `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
  `build`, `ci`, `chore`, or `revert`. Types are case-insensitive.
- **Scope:** optional noun describing the affected area, e.g. `feat(parser):`.
- **Description:** imperative summary immediately after `: `, shorter than
  72 characters.
- **Body:** optional free-form paragraphs separated from the subject by a
  blank line. Wrap lines at 72 characters.
- **Footers:** separate from the body (or subject when there is no body) by
  a blank line. Use `Token: value` or `Token #value`; use hyphens instead of
  spaces in tokens, except `BREAKING CHANGE`. A footer value ends when the
  next valid token/separator pair begins.
- **AI assistance:** add `Assisted-by: AGENT_NAME:MODEL_VERSION` when the
  commit was AI-assisted. Use the actual assistant and model identifiers
  available in the session; do not invent a model version.

## SemVer Mapping

| Commit | SemVer bump |
| --- | --- |
| `fix` | PATCH |
| `feat` | MINOR |
| Breaking change (any type) | MAJOR |

## Breaking Changes

Append `!` before `:` or add a `BREAKING CHANGE:` footer, or both:

```text
feat(api)!: drop XML support

BREAKING CHANGE: XML endpoints removed; use JSON equivalents.
```

`BREAKING-CHANGE` is synonymous with `BREAKING CHANGE` as a footer token.

## Revert

Use type `revert` and reference reverted SHAs in a `Refs` footer:

```text
revert: restore XML support

Refs: 676104e, a215868
```

## Workflow

1. Inspect `git status --porcelain`, `git diff --staged`, and `git diff` to
   understand staged and unstaged changes. Inspect relevant untracked files
   before staging them.
2. Select one logical change within the user's constraints. If unrelated
   changes are already staged, resolve the commit scope before proceeding;
   do not discard existing staging or include unrelated work silently.
3. Stage only intended files with `git add <files>`, or intended hunks with
   `git add -p` when interactive input is available. Never stage or commit
   secrets such as `.env` files, credentials, or private keys.
4. Review `git diff --staged` to confirm the exact commit contents. Choose
   the type, scope, and description from this diff.
5. Create the commit with `git commit`. For a multiline message, use separate
   `-m` arguments for the subject, body, and footers, or write the exact text
   to a temporary file and use `git commit -F <file>`.
6. Verify the resulting commit and `git status --porcelain`. Report the
   commit hash and subject, plus any remaining changes.

## Git Safety

- Never change Git configuration.
- Never force-push, use `--force`, or hard-reset without an explicit request.
  Never force-push `main` or `master`.
- Never bypass hooks with `--no-verify` unless explicitly asked.
- If a hook rejects the commit, fix the issue within the authorized scope,
  review the staged diff again, and create a new commit attempt; do not amend
  an existing commit.
