---
name: git-commit
description: >
  Execute git commit with conventional commit message analysis, intelligent staging, message generation, and an
  `Assisted-by: <agent-name>:<model-id>` trailer disclosing AI involvement. Use when the user asks to commit
  changes, create a git commit, or mentions "/commit". Also trigger on any git commit activity visible in the
  session — commits you make yourself, or commits the user makes outside your tool calls that surface in the
  conversation — even without an explicit request, so the trailer stays attached. Also trigger when the user
  explicitly asks to tag existing commits in a branch (e.g. "add assisted-by to commits in this branch").
license: MIT
allowed-tools: Bash
---

# Git Commit with Conventional Commits

## Overview

Create standardized, semantic git commits using the Conventional Commits specification, each carrying an
`Assisted-by: <agent-name>:<model-id>` trailer that discloses AI involvement. Analyze the actual diff to determine
appropriate type, scope, and message.

`<agent-name>` and `<model-id>` identify the AI assistant (CLI/harness) and LLM version that **authored the code
changes being committed** — not necessarily the model executing this skill. If this skill runs under a different
agent or model than the one that wrote the diff (e.g. a dedicated commit subagent pinned to a smaller model), the
caller must pass the authoring session's agent-name/model-id through explicitly. Never default to this skill's own
runtime identity — that would misattribute the disclosure to the wrong model.

## Conventional Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

| Type       | Purpose                        |
| ---------- | ------------------------------ |
| `feat`     | New feature                    |
| `fix`      | Bug fix                        |
| `docs`     | Documentation only             |
| `style`    | Formatting/style (no logic)    |
| `refactor` | Code refactor (no feature/fix) |
| `perf`     | Performance improvement        |
| `test`     | Add/update tests               |
| `build`    | Build system/dependencies      |
| `ci`       | CI/config changes              |
| `chore`    | Maintenance/misc               |
| `revert`   | Revert commit                  |

## Breaking Changes

```
# Exclamation mark after type/scope
feat!: remove deprecated endpoint

# BREAKING CHANGE footer
feat: allow config to extend other configs

BREAKING CHANGE: `extends` key behavior changed
```

## Workflow

### 1. Analyze Diff

```bash
# If files are staged, use staged diff
git diff --staged

# If nothing staged, use working tree diff
git diff

# Also check status
git status --porcelain
```

### 2. Stage Files (if needed)

If nothing is staged or you want to group changes differently:

```bash
# Stage specific files
git add path/to/file1 path/to/file2

# Stage by pattern
git add *.test.*
git add src/components/*

# Interactive staging
git add -p
```

**Never commit secrets** (.env, credentials.json, private keys).

### 3. Generate Commit Message

Analyze the diff to determine:

- **Type**: What kind of change is this?
- **Scope**: What area/module is affected?
- **Description**: One-line summary of what changed (present tense, imperative mood). Aim for 50 characters,
  hard cap at 72.

### 4. Execute Commit

Pass the `Assisted-by` trailer directly on the commit command — this is the clean path and avoids amend noise.
Never use `Co-authored-by:` for AI assistance; that convention is reserved for human collaborators, `Assisted-by:`
is the correct semantic.

```bash
# Single line
git commit -m "<type>[scope]: <description>" --trailer "Assisted-by: <agent-name>:<model-id>"

# Multi-line with body/footer
git commit -m "$(cat <<'EOF'
<type>[scope]: <description>

<optional body>

<optional footer>
EOF
)" --trailer "Assisted-by: <agent-name>:<model-id>"
```

## When a Commit Lands Outside This Workflow

Sometimes a commit lands on HEAD that you did not run yourself — the user invoked git via a shell escape (e.g.
Claude Code's `! git commit ...`) or a separate terminal. Your only window is after the fact, and the trailer
still needs to land.

Run the bundled safety-check script before amending. It prints `safe`, or `skip:<reason>` if HEAD is already
pushed, already trailered, a merge, or has a rebase/cherry-pick/revert/bisect in progress.

Invoke it with the script's full path — resolve `scripts/safety-check.sh` against the directory this SKILL.md was
loaded from, not the current working directory (the two are almost never the same):

```
<skill-dir>/scripts/safety-check.sh
```

Only when the output is exactly `safe`, amend:

```bash
git commit --amend --no-edit --trailer "Assisted-by: <agent-name>:<model-id>"
```

Follow up with one short line so the user knows the hash moved, e.g. "Amended HEAD to add Assisted-by trailer." If
the output starts with `skip:`, tell the user why the commit was skipped.

## Tagging an Entire Branch

Triggered by phrases like "add assisted-by to commits in this branch", "tag the commits on this branch", or
"backfill the trailer". This is the **only** mode that rewrites more than HEAD, and only because the explicit
request authorizes it. Never enter this mode on autopilot.

### Pick the base

Default to `@{u}` — it guarantees the range is only unpushed commits, which removes the force-push question
entirely. If the branch has no upstream, ask the user for an explicit base ref rather than guessing. If the user
names a base themselves ("from the last release tag"), honor it.

### Show the plan, then confirm

1. `git log --oneline <base>..HEAD` so the user can see the commits that will be rewritten.
2. If `<base>` is anything other than `@{u}`, run `git rev-list <base>..@{u} 2>/dev/null`. If non-empty, those
   commits are already on the remote — warn the user that after the rebase they will need to force-push to publish
   the rewrite, and confirm before proceeding.
3. If the range contains merge commits, stop and ask how to handle them. Default rebase linearizes merges
   (destructive), and `--rebase-merges` with `--exec` on merges is fragile — not worth the risk without the user's
   judgment.

### Run it

The exec short-circuits on commits that already carry the trailer, so the pass is idempotent:

```bash
git rebase <base> --exec 'git log -1 --format=%B | git interpret-trailers --parse | grep -qi "^Assisted-by:" || git commit --amend --no-edit --trailer "Assisted-by: <agent-name>:<model-id>"'
```

Afterwards, report how many commits were tagged vs skipped. If the branch was already pushed, tell the user they
will need to run `git push --force-with-lease` themselves to publish the rewrite.

If the rebase hits a conflict, do not try to resolve it. Surface the conflict to the user and let them choose
`--continue` vs `--abort`.

## Best Practices

- One logical change per commit
- Present tense: "add" not "added"
- Imperative mood: "fix bug" not "fixes bug"
- Reference issues: `Closes #123`, `Refs #456`
- Never fabricate or prettify the `<agent-name>:<model-id>` token — use the actual agent/CLI/harness name and
  model ID/version

## Git Safety Protocol

- NEVER update git config
- NEVER run destructive commands (--force, hard reset) without explicit request
- NEVER skip hooks (--no-verify) unless user asks
- NEVER force push to main/master
- NEVER run `git push` yourself in any mode, even after a rebase or amend — publishing new or rewritten history is
  the user's call; surface the state and let them decide
- If commit fails due to hooks, fix and create a NEW commit (don't amend)
