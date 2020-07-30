/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QGuiApplication>
#include <QPlatformSurfaceEvent>
#include <QTimer>

#include "windowdecoration.h"

#ifdef FLUID_ENABLE_WAYLAND
#  include "extensions/liridecoration.h"

Q_GLOBAL_STATIC(LiriDecorationManager, s_decorationManager)
#endif

WindowDecoration::WindowDecoration(QObject *parent)
    : QObject(parent)
    , m_window(nullptr)
    , m_theme(WindowDecoration::Light)
    , m_color(Qt::transparent)
{
#ifdef FLUID_ENABLE_WAYLAND
    if (QGuiApplication::platformName().startsWith(QStringLiteral("wayland")))
        connect(s_decorationManager, &LiriDecorationManager::activeChanged,
                this, &WindowDecoration::setServerSideDecorationColor);
#endif
}

QWindow *WindowDecoration::window() const
{
    return m_window;
}

void WindowDecoration::setWindow(QWindow *window)
{
    if (window == m_window)
        return;

    m_window = window;
    Q_EMIT windowChanged();
}

WindowDecoration::Theme WindowDecoration::theme() const
{
    return m_theme;
}

void WindowDecoration::setTheme(WindowDecoration::Theme theme)
{
    if (theme == m_theme)
        return;

    m_theme = theme;
    Q_EMIT themeChanged();

    updateDecorationColor();
}

QColor WindowDecoration::color() const
{
    return m_color;
}

void WindowDecoration::setColor(const QColor &color)
{
    if (color == m_color)
        return;

    m_color = color;
    Q_EMIT colorChanged();

    updateDecorationColor();
}

void WindowDecoration::classBegin()
{
}

void WindowDecoration::componentComplete()
{
    if (m_window) {
        // Update decoration color immediately if the platform window is ready, otherwise
        // install an event filter to know when it is created and update the color only then
        if (m_window->handle())
            updateDecorationColor();
        else
            m_window->installEventFilter(this);
    }
}

bool WindowDecoration::eventFilter(QObject *object, QEvent *event)
{
    if (object != m_window)
        return QObject::eventFilter(object, event);

    if (event->type() == QEvent::PlatformSurface) {
        auto pe = static_cast<QPlatformSurfaceEvent *>(event);
        if (pe->surfaceEventType() == QPlatformSurfaceEvent::SurfaceCreated) {
            updateDecorationColor();
            return true;
        }
    }

    return false;
}

void WindowDecoration::updateDecorationColor()
{
    if (!m_window)
        return;
    if (m_color == Qt::transparent)
        return;

#ifdef FLUID_ENABLE_WAYLAND
    if (QGuiApplication::platformName().startsWith(QStringLiteral("wayland"))) {
        // Calculate text color automatically based on the decoration color
        const qreal alpha = 1.0 - (0.299 * m_color.redF() + 0.587 * m_color.greenF() + 0.114 * m_color.blueF());
        const bool isDark = m_color.alphaF() > 0.0 && alpha >= 0.3;
        const QColor textColor = isDark ? QColor(255, 255, 255, 255) : QColor(0, 0, 0, 221);

        // Set properties
        m_window->setProperty("__material_decoration_backgroundColor", m_color);
        m_window->setProperty("__material_decoration_foregroundColor", textColor);

        // Trigger a QtWayland client-side decoration update
        m_window->resize(m_window->size());

        // Register a server-side decoration object if needed
        setServerSideDecorationColor();
    }
#endif
}

#ifdef FLUID_ENABLE_WAYLAND
void WindowDecoration::setServerSideDecorationColor()
{
    if (!m_window)
        return;

    if (QGuiApplication::platformName().startsWith(QStringLiteral("wayland"))) {
        const QVariant fgColor = m_window->property("__material_decoration_foregroundColor");
        const QVariant bgColor = m_window->property("__material_decoration_backgroundColor");

        if (s_decorationManager->isActive() && fgColor.isValid() && bgColor.isValid()) {
            LiriDecoration *decoration = s_decorationManager->decorationForWindow(m_window);
            decoration->setForegroundColor(fgColor.value<QColor>());
            decoration->setBackgroundColor(bgColor.value<QColor>());
        }
    }
}
#endif
