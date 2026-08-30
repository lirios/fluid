# C++ conventions

Applies to the backing library for the public QML module.

## Style

- Use the root SPDX rule, `#pragma once`, C++23, and the repository formatter.
- Keep lines within 100 columns; use `Type *name` and namespace closing comments.
- Use `Q_SIGNALS`, `Q_SLOTS`, and `Q_EMIT`.
- Fix all warnings; the build enables `-Wall -Wextra -Werror`.
- Put Qt/system includes before local includes; group them semantically.
- Put new types in `namespace Fluid`; legacy exceptions are not examples.

## QML-facing patterns

1. **Component tokens:** `Q_GADGET`, `QML_ANONYMOUS`, and immutable properties using `qreal` for
   scalar metrics and `ShapeValue` for shape tokens.
2. **System/reference tokens:** immutable gadgets grouped beneath the token singleton; colors use
   `QColor`, and reusable compound values use named QML value types. `ShapeValue` fields match QML
   Rectangle's physical `topLeft`, `topRight`, `bottomLeft`, and `bottomRight` radius names.
3. **Singleton:** `QObject`, `QML_ELEMENT`, `QML_SINGLETON`, static factory.
4. **Attached state:** `QQuickAttachedPropertyPropagator` and attached registration macros.

The singleton exposes `shape`, `elevation`, `state`, `motion`, `palette`, `light`, and `dark`
directly beneath `MD.Tokens`; never add a `system` level or flat aliases. System gadgets own shared
metrics and reference values. Component gadgets own component-specific numeric metrics and
delegate to system getters when the generated AndroidX tokens specify a system reference. Attached
Style selects the active light/dark semantic scheme. QML owns derived geometry.

## Component tokens

1. Add a header/source pair under `cpp/tokens/`.
2. Aggregate the gadget in the global token singleton.
3. Add both files to the controls source list.
4. Consume it as `MD.Tokens.<component>.<token>`.
5. Assert every value through QML.

Use `qreal` for dimensions, gaps, padding, scalar corner radii, opacity, and visual timing. Every
component property named `*Shape` uses `ShapeValue` and delegates to the corresponding system shape
getter when applicable. Match official token names. Do not retain compatibility aliases for
replaced system-token or component-token properties unless a separate compatibility requirement
explicitly calls for them.

For Material 3 Expressive, expose all required targets, size-specific geometry, state metrics,
content metrics, and component-specific animation values before implementing QML. Generated
tokens provide values; specifications provide behavior; platform styles resolve ambiguous
application.

Never put palette colors in component gadgets, approximate a missing component token with a
generic token, or leave visual constants in QML. Palette values belong in `PaletteTokens`; semantic
light/dark getters must reference that palette instead of duplicating RGB literals. Algebraic
factors, normalized constants, indices, and sentinels may remain in QML.

Expose AndroidX motion easing as exact cubic-Bezier control points and springs as exact physical
damping/stiffness values. Qt-specific `QEasingCurve` and duration approximations are private
animation adapters, not Material system tokens.

## APIs and verification

- Immutable tokens use `READ <getter> CONSTANT FINAL`; never `WRITE` or `NOTIFY`.
- Stateful APIs use `READ`/`WRITE`/`NOTIFY`/`FINAL`, plus `RESET` when needed.
- Use PascalCase types, camelCase methods/properties, and `m_` members.
- Keep enums in their owner and expose them with `Q_ENUM`.
- Prefer precise official names over generic names.

After changes, build, verify C++ values through their QML exposure, run the affected direct Qt
Quick Test, and run `Fluid_qmllint`. A C++-only build is insufficient.

Use `/*! \brief ... */` for public types. Aggregators need a short QML example and relevant
Material link; token gadgets need only a concise brief. Every value-bearing system, palette,
typography, and Material component-token implementation cites the pinned AndroidX token directory,
relevant `.kt` filenames, and version marker.

Pinned token directory:
<https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/>
