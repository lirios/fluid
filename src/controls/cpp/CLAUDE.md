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

1. **Component tokens:** `Q_GADGET`, `QML_ANONYMOUS`, immutable
   `Q_PROPERTY(qreal name READ name CONSTANT FINAL)`.
2. **Singleton:** `QObject`, `QML_ELEMENT`, `QML_SINGLETON`, static factory.
3. **Attached state:** `QQuickAttachedPropertyPropagator` and attached registration macros.

Global tokens own shared metrics, motion, shapes, and type scales. Component gadgets own
component-specific numeric metrics. Attached Style owns colors. QML owns derived geometry.

## Component tokens

1. Add a header/source pair under `cpp/tokens/`.
2. Aggregate the gadget in the global token singleton.
3. Add both files to the controls source list.
4. Consume it as `MD.Tokens.<component>.<token>`.
5. Assert every value through QML.

Use `qreal` for dimensions, gaps, padding, radii, opacity, and visual timing. Match official
token names. Keep compatibility aliases only when necessary and delegate them to canonical
getters.

For Material 3 Expressive, expose all required targets, size-specific geometry, state metrics,
content metrics, and component-specific animation values before implementing QML. Generated
tokens provide values; specifications provide behavior; platform styles resolve ambiguous
application.

Never put palette colors in component gadgets, approximate a missing component token with a
generic token, or leave visual constants in QML. Algebraic factors, normalized constants, indices,
and sentinels may remain in QML.

## APIs and verification

- Immutable tokens use `READ <getter> CONSTANT FINAL`; never `WRITE` or `NOTIFY`.
- Stateful APIs use `READ`/`WRITE`/`NOTIFY`/`FINAL`, plus `RESET` when needed.
- Use PascalCase types, camelCase methods/properties, and `m_` members.
- Keep enums in their owner and expose them with `Q_ENUM`.
- Prefer precise official names over generic names.

After changes, build, verify C++ values through their QML exposure, run the affected direct Qt
Quick Test, and run `Fluid_qmllint`. A C++-only build is insufficient.

Use `/*! \brief ... */` for public types. Aggregators need a short QML example and relevant
Material link; token gadgets need only a concise brief.
