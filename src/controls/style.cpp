/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QPalette>

#include <QtGui/private/qguiapplication_p.h>
#include <QtGui/qpa/qplatformtheme.h>

#include "style.h"

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