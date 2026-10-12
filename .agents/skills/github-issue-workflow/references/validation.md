# Review, Verification and Commit

Read before review; follow these phases in order. Agent launches use the clean-context handoff and [model resolution policy](agent-contracts.md#dynamic-resolution-at-agent-creation). Both remediation roles use the High-effort profile defined there; supported model fallbacks/defaults are disclosed, not additional approval gates.

## C. Independent review

Spawn **one dedicated review agent** using runtime-default model/effort. Require the actual installed Matt Pocock `code-review` skill with this request:

> Use Matt Pocock's `code-review` skill to review the changes since the fixed Git baseline [SHA], along both axes: Standards (documented repository coding standards) and Spec (the originating GitHub issue/spec). Run both reviews in parallel sub-agents and report findings side by side.

Supply the issue, baseline, relevant standards, Implementation Brief, and current working-tree status identifying protected pre-existing changes. Include committed, staged, unstaged, and relevant new/untracked issue changes; exclude unrelated work from remediation and commit. Inspect surrounding dependencies when material, not just the diff. Appropriate inspection commands include `git status --short`, `git diff <sha>`, and `git ls-files --others --exclude-standard`.

Let the installed skill control its process and internal model selection. If unavailable or not invocable, stop and report the blocker instead of substituting generic review. Require side-by-side findings with severity, file/location, evidence, remediation guidance, and a consolidated actionable queue. **No checks yet.**

## D. Review remediation

Spawn one fresh-context remediation agent with the findings and relevant paths. For a large queue, split into disjoint ownership groups with one agent per group, within the implementation concurrency cap. Verify each finding, fix valid ones, update tests/docs as needed, and justify dismissals. Finish all remediation before checks.

## E. Deferred verification

The **orchestrator** runs discovered repository commands, in increasing scope:

1. Lightweight build/type/static/lint checks where applicable.
2. Focused tests for issue-modified modules.
3. Complete relevant unit suite.
4. Relevant integration/end-to-end suite and other mandatory project checks.

Stop early when a failed prerequisite makes later checks uninformative. Capture verbose output in temporary log files; report commands, exit codes, concise failure signatures, and log paths rather than full logs.

On failure, spawn **one clean-context debugging agent** with precise errors, failed commands/exit codes, log paths, and relevant changed files. Fix root causes without disabling useful checks or weakening valid assertions. Reuse the agent for related iterations when efficient; use a fresh compact handoff when its context becomes bloated.

The orchestrator reruns affected checks, then final required validation. Avoid redundant checks or a second full review unless changes or unresolved concerns justify them. Continue until required validation passes or a specific blocker is documented; unresolved failures prevent commit. Never report unrun checks as passed.

## F. Commit gate and final report

Require assessed issue acceptance criteria, resolved or justified review findings, passing required checks, and reviewed final diff/status. Ensure staging includes only validated issue changes, excluding unrelated pre-existing work and secrets.

Invoke the installed **`git-commit` skill directly in the main orchestrator session**, following its own workflow to create an appropriate Conventional Commit based on the validated changes and issue. Use neither a commit subagent nor a manual imitation. If the skill is unavailable, required validation fails, or blockers remain, leave changes uncommitted and explain why. Do not amend unrelated commits. Push or open a PR only when explicitly requested.

Finish with a concise report:

- **Configuration:** complexity, requested families/efforts, actual settings, resolution sources, fallbacks, and runtime limitations or unknowns.
- **Implementation:** completed behavior and major modified files.
- **Review:** Standards and Spec findings and their resolutions/dismissals.
- **Validation:** exact commands/outcomes, explicitly marking unrun checks.
- **Commit:** hash and Conventional Commit subject, or reason not committed.
- **Remaining issues:** concrete blockers or risks only.
