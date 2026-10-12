# Agent Contracts and Focused Handoffs

Read during planning and when preparing agent launches. This reference owns role responsibilities, model configuration, sharding, and handoffs; review and verification procedures live in [validation.md](validation.md).

## Shared compact handoff

Start each new agent with a clean, focused context. Pass repository location, links/paths, and concise verified findings rather than source trees, raw diffs, or lengthy logs. Exclude private secrets. Include:

- Issue URL, requirement summary, assigned acceptance criteria, and relevant repository conventions.
- Fixed baseline SHA, scope, pre-existing changes to protect, deliverable, owned files/interfaces, and dependency assumptions.
- For shards: id, role, contract reference/subset, and the exploration boundary: owned files, direct dependencies, and the contract; expand only when clearly needed.
- The operating contract's prohibition on checks during implementation, review, and review remediation.

Request a **200–400 word** completion report: changed paths, decisions, risks, and status, without pasted diffs or complete files.

## Complexity and model configuration

Classify during Plan Mode; default to **Standard** when uncertain:

- **Simple:** localized changes, straightforward logic, minimal dependencies.
- **Standard:** multiple related changes, moderate complexity, or meaningful regression risk.
- **Complex:** architectural changes, concurrency, advanced DSP, numerical algorithms, realtime processing, or significant cross-module interactions.

Record the classification/rationale, runtime, requested families/efforts, review delegation, and resolution/fallback policy in the Implementation Brief. Planning settings are provisional; resolve actual settings at launch. Model selection adds no separate approval gate.

### Model-family preferences

These are logical preferences, not literal launch identifiers or pinned versions:

| Agent | Claude Code | Codex |
| --- | --- | --- |
| Code | Latest available Sonnet | Latest available Sol |
| Tests | Latest available Sonnet | Latest available Sol |
| Documentation | Latest available Haiku | Latest available Luna |
| Code Review | Managed by code-review skill | Managed by code-review skill |
| Review Remediation | Latest available Sonnet | Latest available Sol |
| Test Remediation | Latest available Sonnet | Latest available Sol |

Requested effort, where supported:

| Complexity | Code | Tests | Documentation |
| --- | --- | --- | --- |
| Simple | Medium | Medium | Low |
| Standard | High | Medium | Low |
| Complex | High | High | Medium |

Both remediation roles **always request High effort**. Every shard uses its role's family/effort profile. Complexity changes configuration and permitted shard counts, never role responsibilities or coverage.

### Dynamic resolution at agent creation

Apply to every new implementation or remediation agent. The review wrapper uses runtime defaults; the installed review skill controls its internal agents.

1. Detect Claude Code or Codex and inspect exposed launch controls, model catalog, alias semantics, and effort levels. Reuse current runtime/catalog information; avoid unnecessary web searches.
2. Resolve the preferred family with a native version-independent alias only if documented to select the latest compatible member. Otherwise use verified catalog identifiers and release/version metadata or documented ordering. Neither unversioned names nor display names prove recency. If latest status is unverifiable, disclose it and choose a suitable supported option without claiming it is newest.
3. If the family is unavailable, choose a suitable supported fallback for the role/complexity and disclose the reason and actual model. If explicit selection is unsupported, use runtime defaults and disclose the limitation. Preserve quality and coverage.
4. Set effort through supported controls/values. If the requested level is unavailable, prefer a supported level at least as high; otherwise use the supported default and disclose it.
5. Use the runtime's clean-context mechanism. In Codex, use `fork_turns="none"` when required for model/effort overrides, with a focused handoff; invent no parameters or equivalents.
6. Record requested and actual model/effort, resolution source, fallback reason, and unsupported/unverifiable settings in launch summaries and the final report. Mark unexposed actual settings **unknown** rather than claiming requested settings were used.

Use existing runtime mechanisms, without lookup scripts, new dependencies, or custom configuration files. Explicit user configuration takes precedence; report departures from preferences. Resolve at every new launch using still-current evidence; reused agents retain their actual configuration.

## Three implementation roles

- **Code:** implement production behavior within repository architecture and required compatibility, avoiding unrelated changes. Leave tests/docs to their owners unless coordination requires a shared interface tweak; communicate contract changes.
- **Tests:** independently derive expectations from the issue and contract, covering acceptance criteria, edge cases, and regressions. Write tests without executing them; coordinate on public interfaces and leave production code to Code.
- **Documentation:** update pertinent user/developer docs and examples for the intended public behavior, then reconcile with the final implementation. Leave production code/tests to their owners.

Use distinct ownership wherever possible. The orchestrator resolves unavoidable overlaps after all shards finish.

### Sharding and work units

Each role starts with one agent. Plan additional shards only when its estimated footprint exceeds **about 200k tokens per agent**, using the fewest that fit. Estimate from files, LOC to read/write, dependencies, tests, and fixtures; split by module/package/layer rather than arbitrary file counts.

- **Work-unit table:** id, owned files/modules (disjoint across units), criteria covered, contract subset, dependencies, footprint estimate, shard counts per role, and waves.
- **Shard limits:** Simple 1 Code / 1 Tests / 1 Docs; Standard up to 3 Code and 3 Tests; Complex up to 6 Code and 6 Tests. Docs stays at 1 unless its own footprint exceeds the budget. Stay within the approved plan's shard counts.
- **Pairing:** pair each Code shard with a Tests shard covering the same criteria. Tests use issue/contract expectations, not Code output.
- **Concurrency:** launch Code, Tests, and Docs concurrently, with at most **6 implementation agents** active. Use and disclose a lower runtime cap only if it permits all three roles concurrently; otherwise stop with a blocker. Queue additional shards in concurrent waves ordered by dependencies.
- **Test harness:** extract conventions, fixtures, and helpers once during planning into a brief shared by all Tests shards.
- **Spill:** near its budget, an agent stops at a clean boundary and returns completed/remaining work, touched paths, and open decisions. Start a fresh continuation for the same role/ownership from that handoff.
- **Integration:** consolidate every wave's reports, inspect overlaps/contract drift, and resolve conflicts or unfinished work with the owning shard or continuation before review, rather than duplicate generic agents.

### Phase B0: interface skeleton

If **Code or Tests are sharded**, one short Code agent or the planner in execution creates shared public signatures, types, and file layout: stubs only, without behavior or checks. Complete B0 before role fan-out and reference the frozen contract in every handoff. Shards report needed contract changes to the orchestrator instead of editing the skeleton. Skip B0 when neither Code nor Tests is sharded, including documentation-only sharding.
