// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "colorlight.h"
#include "palette.h"

namespace Fluid {

// Mappings from ColorLightTokens.kt, VERSION: v0_210, in the pinned AndroidX directory:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
#define FLUID_COLOR_TOKEN(name, paletteName)  \
    QColor ColorLightTokens::name() const     \
    {                                         \
        return PaletteTokens().paletteName(); \
    }

FLUID_COLOR_TOKEN(background, neutral98)
FLUID_COLOR_TOKEN(error, error40)
FLUID_COLOR_TOKEN(errorContainer, error90)
FLUID_COLOR_TOKEN(inverseOnSurface, neutral95)
FLUID_COLOR_TOKEN(inversePrimary, primary80)
FLUID_COLOR_TOKEN(inverseSurface, neutral20)
FLUID_COLOR_TOKEN(onBackground, neutral10)
FLUID_COLOR_TOKEN(onError, error100)
FLUID_COLOR_TOKEN(onErrorContainer, error10)
FLUID_COLOR_TOKEN(onPrimary, primary100)
FLUID_COLOR_TOKEN(onPrimaryContainer, primary10)
FLUID_COLOR_TOKEN(onPrimaryFixed, primary10)
FLUID_COLOR_TOKEN(onPrimaryFixedVariant, primary30)
FLUID_COLOR_TOKEN(onSecondary, secondary100)
FLUID_COLOR_TOKEN(onSecondaryContainer, secondary10)
FLUID_COLOR_TOKEN(onSecondaryFixed, secondary10)
FLUID_COLOR_TOKEN(onSecondaryFixedVariant, secondary30)
FLUID_COLOR_TOKEN(onSurface, neutral10)
FLUID_COLOR_TOKEN(onSurfaceVariant, neutralVariant30)
FLUID_COLOR_TOKEN(onTertiary, tertiary100)
FLUID_COLOR_TOKEN(onTertiaryContainer, tertiary10)
FLUID_COLOR_TOKEN(onTertiaryFixed, tertiary10)
FLUID_COLOR_TOKEN(onTertiaryFixedVariant, tertiary30)
FLUID_COLOR_TOKEN(outline, neutralVariant50)
FLUID_COLOR_TOKEN(outlineVariant, neutralVariant80)
FLUID_COLOR_TOKEN(primary, primary40)
FLUID_COLOR_TOKEN(primaryContainer, primary90)
FLUID_COLOR_TOKEN(primaryFixed, primary90)
FLUID_COLOR_TOKEN(primaryFixedDim, primary80)
FLUID_COLOR_TOKEN(scrim, neutral0)
FLUID_COLOR_TOKEN(secondary, secondary40)
FLUID_COLOR_TOKEN(secondaryContainer, secondary90)
FLUID_COLOR_TOKEN(secondaryFixed, secondary90)
FLUID_COLOR_TOKEN(secondaryFixedDim, secondary80)
FLUID_COLOR_TOKEN(surface, neutral98)
FLUID_COLOR_TOKEN(surfaceBright, neutral98)
FLUID_COLOR_TOKEN(surfaceContainer, neutral94)
FLUID_COLOR_TOKEN(surfaceContainerHigh, neutral92)
FLUID_COLOR_TOKEN(surfaceContainerHighest, neutral90)
FLUID_COLOR_TOKEN(surfaceContainerLow, neutral96)
FLUID_COLOR_TOKEN(surfaceContainerLowest, neutral100)
FLUID_COLOR_TOKEN(surfaceDim, neutral87)
FLUID_COLOR_TOKEN(surfaceTint, primary40)
FLUID_COLOR_TOKEN(surfaceVariant, neutralVariant90)
FLUID_COLOR_TOKEN(tertiary, tertiary40)
FLUID_COLOR_TOKEN(tertiaryContainer, tertiary90)
FLUID_COLOR_TOKEN(tertiaryFixed, tertiary90)
FLUID_COLOR_TOKEN(tertiaryFixedDim, tertiary80)

#undef FLUID_COLOR_TOKEN

} // namespace Fluid
