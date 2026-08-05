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
static Style::Theme globalTheme = Style::Light;
static int globalElevation = 0;

Style::Style(QObject *parent)
    : QQuickAttachedPropertyPropagator(parent)
    , m_systemTheme(globalTheme == Style::System)
    , m_theme(effectiveTheme(globalTheme))
{
    QQuickAttachedPropertyPropagator::initialize();
}

Style::Theme Style::theme() const
{
    return m_theme;
}

void Style::setTheme(Theme theme)
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

void Style::resetTheme()
{
    if (!m_explicitTheme)
        return;

    m_explicitTheme = false;

    Style *style = qobject_cast<Style *>(attachedParent());
    inheritTheme(style ? style->theme() : globalTheme);
}

int Style::elevation() const
{
    return m_elevation;
}

void Style::setElevation(int elevation)
{
    if (m_elevation != elevation) {
        m_elevation = elevation;
        Q_EMIT elevationChanged();
    }
}

void Style::resetElevation()
{
    setElevation(globalElevation);
}

// Font getters
QString Style::brandFontFamily() const
{
    return "Roboto"_L1;
}

QString Style::plainFontFamily() const
{
    return "Roboto"_L1;
}

// Color getters - Primary
QColor Style::primaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone40]);
}

QColor Style::onPrimaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone20 : Palette::Tone100]);
}

QColor Style::primaryContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone30 : Palette::Tone90]);
}

QColor Style::onPrimaryContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Primary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone10]);
}

QColor Style::primaryFixedColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone90]);
}

QColor Style::primaryFixedDimColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone80]);
}

QColor Style::onPrimaryFixedColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone10]);
}

QColor Style::onPrimaryFixedVariantColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Primary][Palette::Tone30]);
}

// Color getters - Secondary
QColor Style::secondaryColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Secondary]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone40]);
}

QColor Style::onSecondaryColor() const
{
    return m_theme == Dark ? QColor("#332D41") : QColor("#FFFFFF");
}

QColor Style::secondaryContainerColor() const
{
    return m_theme == Dark ? QColor("#4A4458") : QColor("#E8DEF8");
}

QColor Style::onSecondaryContainerColor() const
{
    return m_theme == Dark ? QColor("#E8DEF8") : QColor("#1D192B");
}

// Color getters - Tertiary
QColor Style::tertiaryColor() const
{
    return m_theme == Dark ? QColor("#EFB8C8") : QColor("#7D5260");
}

QColor Style::onTertiaryColor() const
{
    return m_theme == Dark ? QColor("#492532") : QColor("#FFFFFF");
}

QColor Style::tertiaryContainerColor() const
{
    return m_theme == Dark ? QColor("#633B48") : QColor("#FFD8E4");
}

QColor Style::onTertiaryContainerColor() const
{
    return m_theme == Dark ? QColor("#FFD8E4") : QColor("#31111D");
}

// Color getters - Error
QColor Style::errorColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone80
                                                                                : Palette::Tone40]);
}

QColor Style::onErrorColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Error]
                               [m_theme == Dark ? Palette::Tone20 : Palette::Tone100]);
}

QColor Style::errorContainerColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone30
                                                                                : Palette::Tone90]);
}

QColor Style::onErrorContainerColor() const
{
    return QColor::fromRgba(Palette::refPalette[Palette::Error][m_theme == Dark ? Palette::Tone80
                                                                                : Palette::Tone10]);
}

// Color getters - Background
QColor Style::backgroundColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone99]);
}

QColor Style::onBackgroundColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone90 : Palette::Tone10]);
}

// Color getters - Surface
QColor Style::surfaceColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone99]);
}

QColor Style::onSurfaceColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone90 : Palette::Tone10]);
}

QColor Style::surfaceBrightColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone24 : Palette::Tone98]);
}

QColor Style::surfaceDimColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone6 : Palette::Tone87]);
}

QColor Style::surfaceVariantColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone30 : Palette::Tone90]);
}

QColor Style::onSurfaceVariantColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone80 : Palette::Tone30]);
}

QColor Style::surfaceContainerLowestColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone4 : Palette::Tone100]);
}

QColor Style::surfaceContainerLowColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone10 : Palette::Tone96]);
}

QColor Style::surfaceContainerColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone12 : Palette::Tone94]);
}

QColor Style::surfaceContainerHighColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone17 : Palette::Tone92]);
}

QColor Style::surfaceContainerHighestColor() const
{
    return QColor::fromRgba(
            Palette::refPalette[Palette::Neutral]
                               [m_theme == Dark ? Palette::Tone22 : Palette::Tone90]);
}

// Color getters - Outline
QColor Style::outlineColor() const
{
    return m_theme == Dark ? QColor("#938F99") : QColor("#79747E");
}

QColor Style::outlineVariantColor() const
{
    return m_theme == Dark ? QColor("#49454F") : QColor("#CAC4D0");
}

// Color getters - Inverse
QColor Style::inverseSurfaceColor() const
{
    return m_theme == Dark ? QColor("#E6E1E5") : QColor("#313033");
}

QColor Style::inverseOnSurfaceColor() const
{
    return m_theme == Dark ? QColor("#313033") : QColor("#F4EFF4");
}

QColor Style::inversePrimaryColor() const
{
    return m_theme == Dark ? QColor("#6750A4") : QColor("#D0BCFF");
}

// Color getters - Scrim
QColor Style::scrimColor() const
{
    return QColor("#000000");
}

// Color getters - Shadow
QColor Style::shadowColor() const
{
    return QColor("#000000");
}

Style *Style::qmlAttachedProperties(QObject *object)
{
    return new Style(object);
}

void Style::attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                                 QQuickAttachedPropertyPropagator *oldParent)
{
    Q_UNUSED(oldParent);

    Style *parentStyle = qobject_cast<Style *>(newParent);
    if (parentStyle) {
        inheritTheme(parentStyle->theme());
    }
}

bool Style::isDarkSystemTheme()
{
    if (const QPlatformTheme *theme = QGuiApplicationPrivate::platformTheme()) {
        if (theme->colorScheme() == Qt::ColorScheme::Unknown)
            return theme->palette()->windowText().color().lightnessF()
                    > theme->palette()->window().color().lightnessF();
        return theme->colorScheme() == Qt::ColorScheme::Dark;
    }
    return false;
}

Style::Theme Style::effectiveTheme(Style::Theme theme)
{
    if (theme == Style::System)
        theme = Style::isDarkSystemTheme() ? Style::Dark : Style::Light;
    return theme;
}

void Style::inheritTheme(Style::Theme theme)
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

void Style::propagateTheme()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedPropertyPropagator *child : styles) {
        Style *childStyle = qobject_cast<Style *>(child);
        if (childStyle)
            childStyle->inheritTheme(m_systemTheme ? System : m_theme);
    }
}