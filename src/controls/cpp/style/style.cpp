// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QPalette>

#include <QtGui/private/qguiapplication_p.h>
#include <QtGui/qpa/qplatformtheme.h>

#include "../tokens/colordark.h"
#include "../tokens/colorlight.h"
#include "../tokens/palette.h"
#include "style.h"

// Active theme colors resolve the AndroidX Material 3 ColorLightTokens.kt and
// ColorDarkTokens.kt mappings (VERSION: v0_210) from the pinned token set:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/

using namespace Qt::StringLiterals;

// These are the default values used when no value was inherited from a parent
// or explicitly set on the instance
static FluidStyle::Theme globalTheme = FluidStyle::Light;
static int globalElevation = 0;

FluidStyle::FluidStyle(QObject *parent)
    : QQuickAttachedPropertyPropagator(parent)
    , m_systemTheme(globalTheme == FluidStyle::System)
    , m_theme(effectiveTheme(globalTheme))
{
    QQuickAttachedPropertyPropagator::initialize();
}

FluidStyle::Theme FluidStyle::theme() const
{
    return m_theme;
}

void FluidStyle::setTheme(Theme theme)
{
    // Keep track that the theme was explicitly set on this instance
    m_explicitTheme = true;

    // System theme:
    //   m_theme is set to system's theme (Dark/Light)
    // Non-system theme:
    //   m_theme is set to the specified theme (Dark/Light)
    //   and m_systemTheme is false

    m_theme = effectiveTheme(theme);
    m_systemTheme = (theme == System);

    propagateTheme();
    Q_EMIT themeChanged();
}

void FluidStyle::resetTheme()
{
    if (!m_explicitTheme)
        return;

    m_explicitTheme = false;

    FluidStyle *style = qobject_cast<FluidStyle *>(attachedParent());
    inheritTheme(style ? style->theme() : globalTheme);
}

int FluidStyle::elevation() const
{
    return m_elevation;
}

void FluidStyle::setElevation(int elevation)
{
    if (m_elevation != elevation) {
        m_elevation = elevation;
        Q_EMIT elevationChanged();
    }
}

void FluidStyle::resetElevation()
{
    setElevation(globalElevation);
}

// Font getters
QString FluidStyle::brandFontFamily() const
{
    return "Roboto"_L1;
}

QString FluidStyle::plainFontFamily() const
{
    return "Roboto"_L1;
}

// Color getters
#define FLUID_STYLE_COLOR(getter, token)                            \
    QColor FluidStyle::getter() const                               \
    {                                                               \
        return m_theme == Dark ? Fluid::ColorDarkTokens().token()   \
                               : Fluid::ColorLightTokens().token(); \
    }

FLUID_STYLE_COLOR(primaryColor, primary)
FLUID_STYLE_COLOR(onPrimaryColor, onPrimary)
FLUID_STYLE_COLOR(primaryContainerColor, primaryContainer)
FLUID_STYLE_COLOR(onPrimaryContainerColor, onPrimaryContainer)
FLUID_STYLE_COLOR(primaryFixedColor, primaryFixed)
FLUID_STYLE_COLOR(primaryFixedDimColor, primaryFixedDim)
FLUID_STYLE_COLOR(onPrimaryFixedColor, onPrimaryFixed)
FLUID_STYLE_COLOR(onPrimaryFixedVariantColor, onPrimaryFixedVariant)
FLUID_STYLE_COLOR(secondaryColor, secondary)
FLUID_STYLE_COLOR(onSecondaryColor, onSecondary)
FLUID_STYLE_COLOR(secondaryContainerColor, secondaryContainer)
FLUID_STYLE_COLOR(onSecondaryContainerColor, onSecondaryContainer)
FLUID_STYLE_COLOR(secondaryFixedColor, secondaryFixed)
FLUID_STYLE_COLOR(secondaryFixedDimColor, secondaryFixedDim)
FLUID_STYLE_COLOR(onSecondaryFixedColor, onSecondaryFixed)
FLUID_STYLE_COLOR(onSecondaryFixedVariantColor, onSecondaryFixedVariant)
FLUID_STYLE_COLOR(tertiaryColor, tertiary)
FLUID_STYLE_COLOR(onTertiaryColor, onTertiary)
FLUID_STYLE_COLOR(tertiaryContainerColor, tertiaryContainer)
FLUID_STYLE_COLOR(onTertiaryContainerColor, onTertiaryContainer)
FLUID_STYLE_COLOR(tertiaryFixedColor, tertiaryFixed)
FLUID_STYLE_COLOR(tertiaryFixedDimColor, tertiaryFixedDim)
FLUID_STYLE_COLOR(onTertiaryFixedColor, onTertiaryFixed)
FLUID_STYLE_COLOR(onTertiaryFixedVariantColor, onTertiaryFixedVariant)
FLUID_STYLE_COLOR(errorColor, error)
FLUID_STYLE_COLOR(onErrorColor, onError)
FLUID_STYLE_COLOR(errorContainerColor, errorContainer)
FLUID_STYLE_COLOR(onErrorContainerColor, onErrorContainer)
FLUID_STYLE_COLOR(backgroundColor, background)
FLUID_STYLE_COLOR(onBackgroundColor, onBackground)
FLUID_STYLE_COLOR(surfaceColor, surface)
FLUID_STYLE_COLOR(onSurfaceColor, onSurface)
FLUID_STYLE_COLOR(surfaceBrightColor, surfaceBright)
FLUID_STYLE_COLOR(surfaceDimColor, surfaceDim)
FLUID_STYLE_COLOR(surfaceVariantColor, surfaceVariant)
FLUID_STYLE_COLOR(onSurfaceVariantColor, onSurfaceVariant)
FLUID_STYLE_COLOR(surfaceTintColor, surfaceTint)
FLUID_STYLE_COLOR(surfaceContainerLowestColor, surfaceContainerLowest)
FLUID_STYLE_COLOR(surfaceContainerLowColor, surfaceContainerLow)
FLUID_STYLE_COLOR(surfaceContainerColor, surfaceContainer)
FLUID_STYLE_COLOR(surfaceContainerHighColor, surfaceContainerHigh)
FLUID_STYLE_COLOR(surfaceContainerHighestColor, surfaceContainerHighest)
FLUID_STYLE_COLOR(outlineColor, outline)
FLUID_STYLE_COLOR(outlineVariantColor, outlineVariant)
FLUID_STYLE_COLOR(inverseSurfaceColor, inverseSurface)
FLUID_STYLE_COLOR(inverseOnSurfaceColor, inverseOnSurface)
FLUID_STYLE_COLOR(inversePrimaryColor, inversePrimary)
FLUID_STYLE_COLOR(scrimColor, scrim)

#undef FLUID_STYLE_COLOR

QColor FluidStyle::shadowColor() const
{
    return Fluid::PaletteTokens().black();
}

FluidStyle *FluidStyle::qmlAttachedProperties(QObject *object)
{
    return new FluidStyle(object);
}

void FluidStyle::attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                                      QQuickAttachedPropertyPropagator *oldParent)
{
    Q_UNUSED(oldParent);

    FluidStyle *parentStyle = qobject_cast<FluidStyle *>(newParent);
    if (parentStyle) {
        inheritTheme(parentStyle->theme());
    }
}

bool FluidStyle::isDarkSystemTheme()
{
    if (const QPlatformTheme *theme = QGuiApplicationPrivate::platformTheme()) {
        if (theme->colorScheme() == Qt::ColorScheme::Unknown)
            return theme->palette()->windowText().color().lightnessF()
                    > theme->palette()->window().color().lightnessF();
        return theme->colorScheme() == Qt::ColorScheme::Dark;
    }
    return false;
}

FluidStyle::Theme FluidStyle::effectiveTheme(FluidStyle::Theme theme)
{
    if (theme == FluidStyle::System)
        theme = FluidStyle::isDarkSystemTheme() ? FluidStyle::Dark : FluidStyle::Light;
    return theme;
}

void FluidStyle::inheritTheme(FluidStyle::Theme theme)
{
    const bool systemThemeChanged = (m_systemTheme != (theme == System));
    const bool hasThemeChanged = systemThemeChanged || (m_theme != effectiveTheme(theme));
    if (m_explicitTheme || !hasThemeChanged)
        return;

    m_theme = effectiveTheme(theme);
    m_systemTheme = (theme == System);

    propagateTheme();
    Q_EMIT themeChanged();
}

void FluidStyle::propagateTheme()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedPropertyPropagator *child : styles) {
        FluidStyle *childStyle = qobject_cast<FluidStyle *>(child);
        if (childStyle)
            childStyle->inheritTheme(m_systemTheme ? System : m_theme);
    }
}
