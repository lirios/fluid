// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QPalette>

#include <QtGui/private/qguiapplication_p.h>
#include <QtGui/qpa/qplatformtheme.h>

#include "palette.h"
#include "style.h"

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

// Color getters - Primary
QColor FluidStyle::primaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone40]);
}

QColor FluidStyle::onPrimaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone20 : Palette::Tone100]);
}

QColor FluidStyle::primaryContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone30 : Palette::Tone90]);
}

QColor FluidStyle::onPrimaryContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone10]);
}

QColor FluidStyle::primaryFixedColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone90]);
}

QColor FluidStyle::primaryFixedDimColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone80]);
}

QColor FluidStyle::onPrimaryFixedColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone10]);
}

QColor FluidStyle::onPrimaryFixedVariantColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone30]);
}

// Color getters - Secondary
QColor FluidStyle::secondaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Secondary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone40]);
}

QColor FluidStyle::onSecondaryColor() const
{
    return m_theme == Dark ? QColor("#332D41") : QColor("#FFFFFF");
}

QColor FluidStyle::secondaryContainerColor() const
{
    return m_theme == Dark ? QColor("#4A4458") : QColor("#E8DEF8");
}

QColor FluidStyle::onSecondaryContainerColor() const
{
    return m_theme == Dark ? QColor("#E8DEF8") : QColor("#1D192B");
}

// Color getters - Tertiary
QColor FluidStyle::tertiaryColor() const
{
    return m_theme == Dark ? QColor("#EFB8C8") : QColor("#7D5260");
}

QColor FluidStyle::onTertiaryColor() const
{
    return m_theme == Dark ? QColor("#492532") : QColor("#FFFFFF");
}

QColor FluidStyle::tertiaryContainerColor() const
{
    return m_theme == Dark ? QColor("#633B48") : QColor("#FFD8E4");
}

QColor FluidStyle::onTertiaryContainerColor() const
{
    return m_theme == Dark ? QColor("#FFD8E4") : QColor("#31111D");
}

// Color getters - Error
QColor FluidStyle::errorColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone80
                                                                                : Palette::Tone40]);
}

QColor FluidStyle::onErrorColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Error]
                               [m_theme == Dark ? Palette::Tone20 : Palette::Tone100]);
}

QColor FluidStyle::errorContainerColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone30
                                                                                : Palette::Tone90]);
}

QColor FluidStyle::onErrorContainerColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone80
                                                                                : Palette::Tone10]);
}

// Color getters - Background
QColor FluidStyle::backgroundColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone99]);
}

QColor FluidStyle::onBackgroundColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone90 : Palette::Tone10]);
}

// Color getters - Surface
QColor FluidStyle::surfaceColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone99]);
}

QColor FluidStyle::onSurfaceColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone90 : Palette::Tone10]);
}

QColor FluidStyle::surfaceBrightColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone24 : Palette::Tone98]);
}

QColor FluidStyle::surfaceDimColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone6 : Palette::Tone87]);
}

QColor FluidStyle::surfaceVariantColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone30 : Palette::Tone90]);
}

QColor FluidStyle::onSurfaceVariantColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone30]);
}

QColor FluidStyle::surfaceContainerLowestColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone4 : Palette::Tone100]);
}

QColor FluidStyle::surfaceContainerLowColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone96]);
}

QColor FluidStyle::surfaceContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone12 : Palette::Tone94]);
}

QColor FluidStyle::surfaceContainerHighColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone17 : Palette::Tone92]);
}

QColor FluidStyle::surfaceContainerHighestColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone22 : Palette::Tone90]);
}

// Color getters - Outline
QColor FluidStyle::outlineColor() const
{
    return m_theme == Dark ? QColor("#938F99") : QColor("#79747E");
}

QColor FluidStyle::outlineVariantColor() const
{
    return m_theme == Dark ? QColor("#49454F") : QColor("#CAC4D0");
}

// Color getters - Inverse
QColor FluidStyle::inverseSurfaceColor() const
{
    return m_theme == Dark ? QColor("#E6E1E5") : QColor("#313033");
}

QColor FluidStyle::inverseOnSurfaceColor() const
{
    return m_theme == Dark ? QColor("#313033") : QColor("#F4EFF4");
}

QColor FluidStyle::inversePrimaryColor() const
{
    return m_theme == Dark ? QColor("#6750A4") : QColor("#D0BCFF");
}

// Color getters - Scrim
QColor FluidStyle::scrimColor() const
{
    return QColor("#000000");
}

// Color getters - Shadow
QColor FluidStyle::shadowColor() const
{
    return QColor("#000000");
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