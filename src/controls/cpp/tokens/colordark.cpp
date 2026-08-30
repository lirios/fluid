// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "colordark.h"
#include "palette.h"

namespace Fluid {

// Mappings from ColorDarkTokens.kt, VERSION: v0_210, in the pinned AndroidX directory:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/
#define FLUID_COLOR_TOKEN(name, paletteName)  \
    QColor ColorDarkTokens::name() const      \
    {                                         \
        return PaletteTokens().paletteName(); \
    }

FLUID_COLOR_TOKEN(background, neutral6)
FLUID_COLOR_TOKEN(error, error80)
FLUID_COLOR_TOKEN(errorContainer, error30)
FLUID_COLOR_TOKEN(inverseOnSurface, neutral20)
FLUID_COLOR_TOKEN(inversePrimary, primary40)
FLUID_COLOR_TOKEN(inverseSurface, neutral90)
FLUID_COLOR_TOKEN(onBackground, neutral90)
FLUID_COLOR_TOKEN(onError, error20)
FLUID_COLOR_TOKEN(onErrorContainer, error90)
FLUID_COLOR_TOKEN(onPrimary, primary20)
FLUID_COLOR_TOKEN(onPrimaryContainer, primary90)
FLUID_COLOR_TOKEN(onPrimaryFixed, primary10)
FLUID_COLOR_TOKEN(onPrimaryFixedVariant, primary30)
FLUID_COLOR_TOKEN(onSecondary, secondary20)
FLUID_COLOR_TOKEN(onSecondaryContainer, secondary90)
FLUID_COLOR_TOKEN(onSecondaryFixed, secondary10)
FLUID_COLOR_TOKEN(onSecondaryFixedVariant, secondary30)
FLUID_COLOR_TOKEN(onSurface, neutral90)
FLUID_COLOR_TOKEN(onSurfaceVariant, neutralVariant80)
FLUID_COLOR_TOKEN(onTertiary, tertiary20)
FLUID_COLOR_TOKEN(onTertiaryContainer, tertiary90)
FLUID_COLOR_TOKEN(onTertiaryFixed, tertiary10)
FLUID_COLOR_TOKEN(onTertiaryFixedVariant, tertiary30)
FLUID_COLOR_TOKEN(outline, neutralVariant60)
FLUID_COLOR_TOKEN(outlineVariant, neutralVariant30)
FLUID_COLOR_TOKEN(primary, primary80)
FLUID_COLOR_TOKEN(primaryContainer, primary30)
FLUID_COLOR_TOKEN(primaryFixed, primary90)
FLUID_COLOR_TOKEN(primaryFixedDim, primary80)
FLUID_COLOR_TOKEN(scrim, neutral0)
FLUID_COLOR_TOKEN(secondary, secondary80)
FLUID_COLOR_TOKEN(secondaryContainer, secondary30)
FLUID_COLOR_TOKEN(secondaryFixed, secondary90)
FLUID_COLOR_TOKEN(secondaryFixedDim, secondary80)
FLUID_COLOR_TOKEN(surface, neutral6)
FLUID_COLOR_TOKEN(surfaceBright, neutral24)
FLUID_COLOR_TOKEN(surfaceContainer, neutral12)
FLUID_COLOR_TOKEN(surfaceContainerHigh, neutral17)
FLUID_COLOR_TOKEN(surfaceContainerHighest, neutral22)
FLUID_COLOR_TOKEN(surfaceContainerLow, neutral10)
FLUID_COLOR_TOKEN(surfaceContainerLowest, neutral4)
FLUID_COLOR_TOKEN(surfaceDim, neutral6)
FLUID_COLOR_TOKEN(surfaceTint, primary80)
FLUID_COLOR_TOKEN(surfaceVariant, neutralVariant30)
FLUID_COLOR_TOKEN(tertiary, tertiary80)
FLUID_COLOR_TOKEN(tertiaryContainer, tertiary30)
FLUID_COLOR_TOKEN(tertiaryFixed, tertiary90)
FLUID_COLOR_TOKEN(tertiaryFixedDim, tertiary80)

#undef FLUID_COLOR_TOKEN

} // namespace Fluid
