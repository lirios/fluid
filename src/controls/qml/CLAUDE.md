# QML conventions

Applies to public components under `src/controls/qml/`.

## Placement

- Put public controls and reusable visuals in `components/`.
- Put low-level items in `internal/`, visual effects in `effects/`, and bases/helpers in `core/`.
- QML/JavaScript files are globbed; only singletons need explicit CMake marking.

## Public controls

1. Use the root SPDX header and `pragma ComponentBehavior: Bound` when nested components access
   outer IDs.
2. Import only what is used and root the control in the appropriate Qt Quick Template. Never use
   `QtQuick.Controls`; build on `QtQuick.Templates` directly.
3. Document public APIs and derive implicit size from content, background, insets, padding,
   minimum target, and reserved indicator space.
4. Read system metrics from `MD.Tokens.shape`, `.elevation`, `.state`, `.motion`, or
   `.measurement`; component metrics from `MD.Tokens.<component>`; and active colors from
   `control.MD.Style`.
5. Derive state from template properties, orientation, and direction.
6. Extract complex geometry into bound delegates; bind every dependency explicitly.
7. Add ripple, halo, focus treatment, or elevation only when specified.
8. Use `MD.Tokens.motion` durations for color/opacity. Physical spring tokens expose damping and
   stiffness; when Qt requires a curve/duration animation, use the private motion adapter rather
   than publishing or inventing a system-token approximation.

## Tokens and literals

Add missing component metrics to C++ first. Keep colors in Style and public color defaults
semantic. QML literals are allowed only for algebra, normalized positions, indices,
enum/sentinel logic, and formatting precision. Dimensions, gaps, padding, radii, opacity, and
visual timing in controls must be tokenized. Use `MD.Tokens.measurement` for generic layout
padding, margins, and gaps, but never approximate a missing component token with it or create
another ad hoc spacing scale. Gallery pages may use named local semantic layout constants that
alias measurement tokens for showcase composition.

Apply system and component `*Shape` values to Rectangle through `topLeftRadius`, `topRightRadius`,
`bottomLeftRadius`, and `bottomRightRadius`. Use the corresponding system `cornerValue*` property
only when an API requires one scalar radius rather than a `ShapeValue`.

## Material 3 Expressive

- Inventory every variant, size, state, input mode, orientation, and layout direction.
- Use one coordinate model for segments, content, interaction geometry, and tests.
- Measure gaps from visible edges, suppress empty geometry, and clamp endpoint radii.
- Treat start/end logically; mirror horizontal geometry for RTL and place cross-axis content on
  the correct layout-direction side.
- Render optional content only for supported variants with sufficient token-required space.
- Preserve minimum targets independently of visible geometry.
- Use template focus for keyboard treatment and template pressed state for dragging.
- Reserve label space only for containment or persistent visibility.
- Use locale-aware defaults while allowing caller bindings to override them.
- Never invent effects to imply interactivity.

## Delegates and testing

A bound delegate receives orientation, mirroring, enabled/interaction state, metrics, colors,
opacity, values/range, and public content explicitly. It must not discover its control through
`parent` or depend on undocumented hierarchy.

Keep stable `objectName` values where tests inspect geometry. Test tokens, targets, endpoints,
states, non-divisible ranges, directionality, optional-content eligibility, formatting, and
containment. Cover variants, sizes, RTL, orientation, and disabled state in the gallery.

Register Qt Quick Tests explicitly, run them against `build/qml_modules`, and run
`Fluid_qmllint`. Existing warnings never justify new component-specific diagnostics.

The project relies on Qt Quick Templates' implicit accessibility. Do not add ad hoc
`Accessible.*` bindings without a library-wide policy.
