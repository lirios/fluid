// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QtCore/qobject.h>
#include <QtGui/qcolor.h>
#include <QtQml/qqmlregistration.h>

namespace Fluid {

struct ColorLightTokens
{
    Q_GADGET
    QML_ANONYMOUS

#define FLUID_COLOR_PROPERTY(name) Q_PROPERTY(QColor name READ name CONSTANT FINAL)
    FLUID_COLOR_PROPERTY(background)
    FLUID_COLOR_PROPERTY(error)
    FLUID_COLOR_PROPERTY(errorContainer)
    FLUID_COLOR_PROPERTY(inverseOnSurface)
    FLUID_COLOR_PROPERTY(inversePrimary)
    FLUID_COLOR_PROPERTY(inverseSurface)
    FLUID_COLOR_PROPERTY(onBackground)
    FLUID_COLOR_PROPERTY(onError)
    FLUID_COLOR_PROPERTY(onErrorContainer)
    FLUID_COLOR_PROPERTY(onPrimary)
    FLUID_COLOR_PROPERTY(onPrimaryContainer)
    FLUID_COLOR_PROPERTY(onPrimaryFixed)
    FLUID_COLOR_PROPERTY(onPrimaryFixedVariant)
    FLUID_COLOR_PROPERTY(onSecondary)
    FLUID_COLOR_PROPERTY(onSecondaryContainer)
    FLUID_COLOR_PROPERTY(onSecondaryFixed)
    FLUID_COLOR_PROPERTY(onSecondaryFixedVariant)
    FLUID_COLOR_PROPERTY(onSurface)
    FLUID_COLOR_PROPERTY(onSurfaceVariant)
    FLUID_COLOR_PROPERTY(onTertiary)
    FLUID_COLOR_PROPERTY(onTertiaryContainer)
    FLUID_COLOR_PROPERTY(onTertiaryFixed)
    FLUID_COLOR_PROPERTY(onTertiaryFixedVariant)
    FLUID_COLOR_PROPERTY(outline)
    FLUID_COLOR_PROPERTY(outlineVariant)
    FLUID_COLOR_PROPERTY(primary)
    FLUID_COLOR_PROPERTY(primaryContainer)
    FLUID_COLOR_PROPERTY(primaryFixed)
    FLUID_COLOR_PROPERTY(primaryFixedDim)
    FLUID_COLOR_PROPERTY(scrim)
    FLUID_COLOR_PROPERTY(secondary)
    FLUID_COLOR_PROPERTY(secondaryContainer)
    FLUID_COLOR_PROPERTY(secondaryFixed)
    FLUID_COLOR_PROPERTY(secondaryFixedDim)
    FLUID_COLOR_PROPERTY(surface)
    FLUID_COLOR_PROPERTY(surfaceBright)
    FLUID_COLOR_PROPERTY(surfaceContainer)
    FLUID_COLOR_PROPERTY(surfaceContainerHigh)
    FLUID_COLOR_PROPERTY(surfaceContainerHighest)
    FLUID_COLOR_PROPERTY(surfaceContainerLow)
    FLUID_COLOR_PROPERTY(surfaceContainerLowest)
    FLUID_COLOR_PROPERTY(surfaceDim)
    FLUID_COLOR_PROPERTY(surfaceTint)
    FLUID_COLOR_PROPERTY(surfaceVariant)
    FLUID_COLOR_PROPERTY(tertiary)
    FLUID_COLOR_PROPERTY(tertiaryContainer)
    FLUID_COLOR_PROPERTY(tertiaryFixed)
    FLUID_COLOR_PROPERTY(tertiaryFixedDim)
#undef FLUID_COLOR_PROPERTY

public:
#define FLUID_COLOR_GETTER(name) QColor name() const;
    FLUID_COLOR_GETTER(background)
    FLUID_COLOR_GETTER(error)
    FLUID_COLOR_GETTER(errorContainer)
    FLUID_COLOR_GETTER(inverseOnSurface)
    FLUID_COLOR_GETTER(inversePrimary)
    FLUID_COLOR_GETTER(inverseSurface)
    FLUID_COLOR_GETTER(onBackground)
    FLUID_COLOR_GETTER(onError)
    FLUID_COLOR_GETTER(onErrorContainer)
    FLUID_COLOR_GETTER(onPrimary)
    FLUID_COLOR_GETTER(onPrimaryContainer)
    FLUID_COLOR_GETTER(onPrimaryFixed)
    FLUID_COLOR_GETTER(onPrimaryFixedVariant)
    FLUID_COLOR_GETTER(onSecondary)
    FLUID_COLOR_GETTER(onSecondaryContainer)
    FLUID_COLOR_GETTER(onSecondaryFixed)
    FLUID_COLOR_GETTER(onSecondaryFixedVariant)
    FLUID_COLOR_GETTER(onSurface)
    FLUID_COLOR_GETTER(onSurfaceVariant)
    FLUID_COLOR_GETTER(onTertiary)
    FLUID_COLOR_GETTER(onTertiaryContainer)
    FLUID_COLOR_GETTER(onTertiaryFixed)
    FLUID_COLOR_GETTER(onTertiaryFixedVariant)
    FLUID_COLOR_GETTER(outline)
    FLUID_COLOR_GETTER(outlineVariant)
    FLUID_COLOR_GETTER(primary)
    FLUID_COLOR_GETTER(primaryContainer)
    FLUID_COLOR_GETTER(primaryFixed)
    FLUID_COLOR_GETTER(primaryFixedDim)
    FLUID_COLOR_GETTER(scrim)
    FLUID_COLOR_GETTER(secondary)
    FLUID_COLOR_GETTER(secondaryContainer)
    FLUID_COLOR_GETTER(secondaryFixed)
    FLUID_COLOR_GETTER(secondaryFixedDim)
    FLUID_COLOR_GETTER(surface)
    FLUID_COLOR_GETTER(surfaceBright)
    FLUID_COLOR_GETTER(surfaceContainer)
    FLUID_COLOR_GETTER(surfaceContainerHigh)
    FLUID_COLOR_GETTER(surfaceContainerHighest)
    FLUID_COLOR_GETTER(surfaceContainerLow)
    FLUID_COLOR_GETTER(surfaceContainerLowest)
    FLUID_COLOR_GETTER(surfaceDim)
    FLUID_COLOR_GETTER(surfaceTint)
    FLUID_COLOR_GETTER(surfaceVariant)
    FLUID_COLOR_GETTER(tertiary)
    FLUID_COLOR_GETTER(tertiaryContainer)
    FLUID_COLOR_GETTER(tertiaryFixed)
    FLUID_COLOR_GETTER(tertiaryFixedDim)
#undef FLUID_COLOR_GETTER
};

} // namespace Fluid
