# Fluid

Qt/QML Material Design 3 library providing public and private QML modules plus a gallery.

Directory rules:

- `src/controls/cpp/`: C++ backing code and tokens.
- `src/controls/qml/`: public QML controls and delegates.

## Architecture

```text
public QML control
  ├─ API, template integration, sizing, themed colors
  ├─ bound delegates for complex visuals and geometry
  ├─ MD.Tokens.<component> → immutable C++ metrics
  └─ control.MD.Style      → theme-dependent colors
```

C++ token gadgets own numeric visual metrics; the global token singleton exposes them to QML.
Attached Style owns colors so theme overrides propagate. QML owns composition and calculations,
not a duplicate specification. Public templates own input, focus, accessibility, directionality,
defaults, and implicit size; delegates receive state explicitly.

Key directories:

- `src/controls/cpp/style/`: theme, color, palette, elevation.
- `src/controls/cpp/tokens/`: global and component token gadgets.
- `src/controls/qml/`: public controls and delegates.
- `src/private/`: internal helpers.
- `src/gallery/`: showcases.
- `tests/auto/controls/`: Qt Quick Tests.

## Material 3 Expressive

Use the official component specification for behavior, official generated tokens for values, and
official platform styles only to resolve ambiguity.

Always:

1. Inventory variants, sizes, states, input modes, orientations, and layout directions.
2. Add missing numeric metrics to C++ tokens before writing QML.
3. Keep colors in Style and public color defaults semantic.
4. Extract complex visuals into bound delegates with explicit inputs.
5. Add only specified effects; never assume ripple, halo, focus ring, or elevation.
6. Cover variants in the gallery and assert tokens, geometry, and interaction.
7. Introduce no component-specific lint diagnostics.

## Build and test

```sh
# Update git submodules
git submodule update --init

# Configure after cloning or changing CMake files
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON

# Build all configured targets
cmake --build build

# Run tests
ctest --test-dir build --output-on-failure

# Install all configured targets
cmake --install build
```

Qt >= 6.8 and `cmake-shared` are required. Built QML modules are in `build/qml_modules`.
Run an isolated test with:

```sh
QT_QPA_PLATFORM=offscreen build/tests/auto/controls/tst_fluid_controls \
    -import build/qml_modules -input tests/auto/controls/<test>.qml
```

If CTest registration is unavailable, use the direct executable while diagnosing it separately.

## Conventions

- New C++, header, and QML files use the MPL-2.0 SPDX header.
- Active work targets `develop`; releases use `master`.
- Use Conventional Commits; use a lowercase component scope or `controls` for cross-control work.
- Add public controls to the gallery and tests.
- Sign the Liri CLA for non-trivial contributions.
- With `FLUID_USE_SYSTEM_LCS=OFF`, initialize the `cmake-shared` submodule.
- Manual QML tests require `-import build/qml_modules`.
