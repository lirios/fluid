# Fluid

Qt/QML Material Design 3 library providing public and private QML modules plus a gallery.

## Scoped instructions

- For C++ backing code, tokens, or Style, read [src/controls/cpp/AGENTS.md](src/controls/cpp/AGENTS.md).
- For public QML controls, delegates, or their gallery/test coverage, read
  [src/controls/qml/AGENTS.md](src/controls/qml/AGENTS.md).
- For documentation or component usage examples, including source comments, read
  [doc/AGENTS.md](doc/AGENTS.md).

Component changes spanning tokens and QML require both controls guides.

Internal helpers live in `src/private/`, showcases in `src/gallery/`, and Qt Quick Tests in
`tests/auto/controls/`.

## Shared architecture

C++ token gadgets own immutable system, reference, and component values. QML owns composition and
derived geometry. Public templates own input, focus, accessibility, directionality, defaults, and
implicit size. Attached Style resolves the active semantic scheme so theme overrides propagate.

Use the official component specification for behavior, official generated tokens for values, and
official platform styles only to resolve ambiguity.

System groups are `MD.Tokens.shape`, `.elevation`, `.state`, `.motion`, `.measurement`, `.palette`,
`.light`, and `.dark`. Use `MD.Tokens.measurement` for generic layout padding, margins, and gaps;
keep component-specific metrics in `MD.Tokens.<component>`. Do not introduce `MD.Tokens.system`,
flat system-token aliases, legacy spacing aliases, or another ad hoc spacing scale.

## Build and test

Run `Fluid_qmllint` and unit tests to validate changes.

```sh
# Update git submodules
git submodule update --init

# Configure after cloning or changing CMake files
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON

# Build all configured targets
cmake --build build

# Run QML lint
cmake --build build --target Fluid_qmllint

# Run unit tests
ctest --test-dir build --output-on-failure

# Install all configured targets
cmake --install build
```

Built QML modules are in `build/qml_modules`.
Run an isolated test with:

```sh
QT_QPA_PLATFORM=offscreen build/tests/auto/controls/tst_fluid_controls \
    -import build/qml_modules -input tests/auto/controls/<test>.qml
```

If CTest registration is unavailable, use the direct executable while diagnosing it separately.

## Conventions

- New C++, header, and QML files use the MPL-2.0 SPDX header.
- Use Conventional Commits; use a lowercase component scope or `controls` for cross-control work.
- Add public controls to the gallery and tests.
- Sign the Liri CLA for non-trivial contributions.
- With `FLUID_USE_SYSTEM_LCS=OFF`, initialize the `cmake-shared` submodule.
