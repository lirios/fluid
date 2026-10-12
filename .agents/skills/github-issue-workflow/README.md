# GitHub Issue Workflow

Implement any GitHub issue through approved planning, parallel implementation, independent review, deferred validation, and a local Conventional Commit.

## Install and invoke

Copy the complete folder, including `references/`, into:

- **Claude Code:** `.claude/skills/github-issue-workflow/`
- **Codex:** `.agents/skills/github-issue-workflow/`

Start the host in **Plan Mode**, then invoke using its supported mechanism:

```text
# Claude Code
/github-issue-workflow https://github.com/OWNER/REPO/issues/123

# Codex
$github-issue-workflow https://github.com/OWNER/REPO/issues/123
```

Alternatively, select the skill in the host UI and pass the issue URL. Invocation and approval mechanisms depend on the host.

## Dependencies

- GitHub issue access through an integration, authenticated `gh`, or repository-supported means.
- Clean-context subagents supporting the three concurrent implementation roles, dependency waves, and nested parallel review agents.
- Installed, invocable Matt Pocock `code-review` and `git-commit` skills.
- Runtime model/effort controls where available; unsupported preferences use disclosed fallbacks/defaults.

## Workflow

```mermaid
flowchart TD
    P[Plan Mode: issue, baseline, Implementation Brief] --> A[Plan approval and execution authorization]
    A --> B[Optional B0: only for Code or Tests sharding]
    B --> C[Concurrent Code + Tests + Docs: planned shards and waves]
    C --> I[Consolidate all implementation work]
    I --> R[code-review: parallel Standards and Spec]
    R --> F[Review remediation]
    F --> V[Orchestrator: staged checks]
    V --> G{Required validation passes?}
    G -- No --> D[Debugging agent or report blocker]
    D -- Fixed --> V
    G -- Yes --> K[Final commit gate]
    K -- Clear --> Q[Orchestrator: git-commit and report]
    K -- Blocked --> S[Report without commit]
```

## Authoritative instructions

- [SKILL.md](SKILL.md): operating contract, planning brief, and phase order.
- [Agent contracts](references/agent-contracts.md): responsibilities, handoffs, complexity/model profiles, sharding, and B0.
- [Validation](references/validation.md): review, remediation, checks, commit gates, and reporting.

Push and PR creation require an explicit request.
