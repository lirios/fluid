# Commit Message Instructions

Generate commit messages using the **Conventional Commits** specification.

---

## Format

```
type(scope): description

[optional body]

[optional footers]
```

- `type` — required, lowercase, from the allowed list below.
- `scope` — optional, lowercase, in parentheses; omit when it adds no clarity.
- `description` — required; short, imperative, no trailing period.
- `body` — optional; include only when extra context genuinely helps readers.
- `footers` — optional; use for breaking changes, issue references, etc.

---

## Allowed Types

| Type       | When to use |
|------------|-------------|
| `feat`     | A new feature or capability visible to users or consumers of the API. |
| `fix`      | A bug fix — corrects incorrect behavior. |
| `refactor` | Internal restructuring that does not change external behavior or fix a bug. |
| `perf`     | A change whose primary purpose is improving performance. |
| `docs`     | Documentation only — no source code logic changed. |
| `test`     | Adding, updating, or fixing tests; no production logic changed. |
| `build`    | Changes to the build system, dependencies, or package management (CMake, vcpkg, npm, etc.). |
| `ci`       | Changes to CI/CD configuration or workflow files (GitHub Actions, GitLab CI, etc.). |
| `style`    | Formatting, whitespace, or code-style changes that have zero effect on logic. |
| `chore`    | Maintenance tasks that do not fit any other category (e.g., renaming files, updating tooling config). |
| `revert`   | Reverting a previous commit. Reference the reverted commit SHA in the body. |

Pick the **most accurate** type. When in doubt, prefer the more conservative type rather than inventing behavior not supported by the diff.

---

## Rules

1. **Type is always lowercase.** Never capitalize it.
2. **Description is imperative mood.** Write `add login validation`, not `added login validation` or `adds login validation`.
3. **Subject line length: 50–72 characters.** Shorter is better; never exceed 72.
4. **No period at the end of the subject line.**
5. **Scope is optional.** Only add a scope when it meaningfully narrows context (e.g., a subsystem, module, or component name). Drop it when the change is cross-cutting or the type alone is sufficient.
6. **Base the message only on staged changes or the visible diff.** Do not invent features or bugs not supported by the actual changes.
7. **If multiple files changed, summarize the main intent of the commit** — do not list every file.
8. **Do not wrap the commit message in markdown code fences.**
9. **Avoid vague messages.** The following are always wrong:
   - `update stuff`
   - `fix things`
   - `changes`
   - `misc cleanup`
   - `wip`
   - `minor fixes`

---

## Breaking Changes

When a commit introduces a breaking API or behavior change, signal it in one or both of these ways:

**Option 1 — Exclamation mark after type/scope:**

```
feat(controls)!: remove deprecated Theme singleton
```

**Option 2 — Footer:**

```
refactor(api): replace synchronous loader with async variant

BREAKING CHANGE: callers must now await the loader result; the old
synchronous overload has been removed.
```

Both options may be combined. The `BREAKING CHANGE` footer value must be a full sentence describing what breaks and why.

---

## Scope Guidance

Use a scope that reflects a meaningful subsystem or module in this repository:

| Scope        | Meaning |
|--------------|---------|
| `controls`   | Any change spanning multiple files in `src/controls/` (QML or C++, regardless of file type) |
| `gallery`    | Demo application in `src/gallery/` |
| `private`    | `Fluid.Private` module in `src/private/` |
| `tests`      | Test code under `tests/` |
| `build`      | CMake or build-system files |
| `docs`       | Documentation sources |
| `assets`     | Shaders, icons, or other static assets |

**Single-control commits:** When a commit targets a single QtQuick control — whether implemented as a QML file (e.g. `Button.qml`) or as a C++ class backing a QtQuick item (e.g. `ColorUtils`) — use the control's name in lowercase as the scope.

```
fix(button): prevent double-tap from firing two click events
feat(chip): add removable property with close icon
refactor(colorutils): simplify luminance calculation
perf(shadowimage): skip repaint when elevation is unchanged
```

**Multi-file commits inside `src/controls/`:** When a commit touches more than one control or mixes QML and C++ files within `src/controls/`, use `controls` as the scope regardless of file type.

```
refactor(controls): align property naming across all button variants
feat(controls): add DateRangePicker component
```

Omit the scope when the change touches multiple unrelated areas or when the type alone communicates the intent clearly enough.

---

## Good Examples

```
# Single control — QML
feat(iconbutton): add ripple animation on press
fix(button): prevent double-tap from firing two click events
docs(chip): add \brief and code example
style(navigationbar): normalize indentation
test(bottomsheet): add visual regression test for open animation

# Single control — C++ backing class
fix(colorutils): prevent null dereference in blend()
perf(shadowimage): cache shadow geometry between frames
refactor(navigationdrawer): extract header into separate delegate

# Multiple files in src/controls/ (QML, C++, or both)
feat(controls): add DateRangePicker component
refactor(controls): align property naming across all button variants

# Other subsystems — no control-name scope
build: require Qt >= 6.8 and drop Qt 6.7 support
ci: add ctest step to pull-request workflow
chore: remove obsolete fetch-symbols script

# Revert and breaking change
revert: revert "feat(iconbutton): add ripple animation on press"
feat(controls)!: remove deprecated Fluid.Theme singleton
```

---

## Bad Examples

```
# Too vague
update stuff
fix things
misc cleanup
wip

# Wrong mood (past tense instead of imperative)
added login validation
fixed crash on startup

# Capitalised type
Feat: add new button

# Trailing period
fix(colorutils): prevent null dereference in blend().

# Invented behavior not in the diff
feat: add dark mode support   ← only if dark mode was actually added

# Listing files instead of intent
refactor: update NavigationBar.qml, Chip.qml, and Button.qml
```

---

## Incomplete Context

When the diff is ambiguous or incomplete:

- Prefer the **most conservative accurate type** (e.g., `chore` over `feat` when unsure).
- Do not infer or invent functionality not visible in the changes.
- Prefer **clarity and correctness** over clever or compact wording.
- If staged changes span multiple unrelated concerns, pick the type that covers the dominant change.
