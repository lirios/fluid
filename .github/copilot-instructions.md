# Fluid – Copilot Instructions

Fluid is a Qt/QML component library implementing [Material Design](https://material.io/guidelines/) for use with QtQuick. It ships a C++-backed `Fluid` QML module, a `Private` module, and a gallery demo app.

## Architecture

| Path | Purpose |
|------|---------|
| `src/controls/` | Main `Fluid` QML module — C++ backing library (`libFluid`) + QML components |
| `src/controls/cpp/` | C++ sources: `core/`, `datetime/`, `scenegraph/`, `style/` |
| `src/controls/qml/` | QML components organised by category (buttons, dialogs, navigation, …) |
| `src/private/` | `Fluid.Private` QML module for internal/platform helpers |
| `src/gallery/` | Demo application (`fluid-gallery`) |
| `tests/auto/controls/` | Qt Quick Test autotests (`tst_*.qml` + `controls.cpp` harness) |
| `cmake/` | Custom CMake helpers (e.g. `QtInstallQmlModule.cmake`) |
| `assets/shaders/` | GLSL shaders for scene-graph effects |

## Build & Test

```sh
# First time
git submodule update --init
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=/usr/local
cmake --build build
cmake --install build   # sudo if needed

# Incremental (existing build dir)
cmake --build build
```

Key CMake options (all `ON` by default):

| Option | Effect |
|--------|--------|
| `FLUID_WITH_QML_MODULES` | Build the QML modules (core deliverable) |
| `FLUID_WITH_GALLERY` | Build the demo application |
| `FLUID_WITH_DOCUMENTATION` | Build Doxygen HTML docs (requires Doxygen) |
| `FLUID_USE_SYSTEM_LCS` | Use system-installed LiriCMakeShared instead of bundled |
| `BUILD_TESTING` | Build and enable autotests |

```sh
# Build + run tests
cmake -S . -B build -DBUILD_TESTING=ON
cmake --build build
ctest --test-dir build --output-on-failure
```

Tests require `Qt6::QuickTest`. If it isn't found, the test target is skipped silently.

## Code Conventions

### C++
- Follow [Qt Coding Conventions](https://wiki.qt.io/Coding_Conventions) and [Qt Coding Style](https://wiki.qt.io/Qt_Coding_Style).
- Standard: **C++23** (`set(CMAKE_CXX_STANDARD 23)`).
- Use `#pragma once` — no traditional include guards.
- Register QML types with `QML_ELEMENT` / `QML_NAMED_ELEMENT`; avoid manual `qmlRegisterType`.
- Use `Q_SIGNALS` / `Q_SLOTS` / `Q_EMIT` (not `signals` / `slots` / `emit`). There is a TODO to migrate remaining `emit` usages.
- License header required on every source file (MPL-2.0 block starting `$BEGIN_LICENSE:MPL2$`). CMake files use SPDX one-liners.
- Treat warnings as errors (`-Wall -Wextra -Werror`). Fix all warnings before committing.
- Deprecated Qt ≤5.15 API is disabled (`QT_DISABLE_DEPRECATED_UP_TO=0x050F00`).

### QML
- Follow [Liri QML Conventions](https://liri-dev.readthedocs.io/en/latest/contributing/coding-conventions/qml-conventions/).
- Import the module with a namespace: `import Fluid as MD`, `import QtQuick.Templates as T`.
- Keep components in the matching category subdirectory under `src/controls/qml/`.
- Add a `\brief` doc comment and a short `\code` example to new public components.

## Git Workflow
- Branch model: **git flow** — `develop` for active work, `master` for releases.
- Commit messages: follow [tbaggery's guide](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) (subject ≤ 72 chars, imperative mood).
- Sign the [Liri CLA](https://liri.io/org/cla/) for non-trivial contributions.

## Pitfalls
- `cmake-shared` (LiriCMakeShared) must be available (bundled as submodule) unless `FLUID_USE_SYSTEM_LCS=ON`.
- On Arch Linux, `Qt6::GuiPrivate` is in a separate package and must be found explicitly — `features.cmake` already handles this.
- The QML output directory is `${CMAKE_BINARY_DIR}/qml_modules`; pass `-import <build>/bin` when running tests manually.
- Qt >= 6.8 is required; Qt 6.7 support was dropped.
