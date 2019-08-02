/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QGuiApplication>
#include <QPlatformSurfaceEvent>
#include <QtGui/qpa/qplatformnativeinterface.h>

#include "liridecoration.h"

static inline wl_surface *getWlSurface(QWindow *window)
{
    void *surface = QGuiApplication::platformNativeInterface()->nativeResourceForWindow("surface", window);
    return static_cast<wl_surface *>(surface);
}

LiriDecorationManager::LiriDecorationManager()
    : QWaylandClientExtensionTemplate(1)
{
}

LiriDecorationManager::~LiriDecorationManager()
{
    qDeleteAll(m_decorations);
}

LiriDecoration *LiriDecorationManager::createDecoration(QWindow *window)
{
    auto decoration = new LiriDecoration(this, window, create(getWlSurface(window)));
    registerDecoration(decoration);

    connect(window, &QObject::destroyed, this, [this, decoration](QObject * = nullptr) {
        unregisterDecoration(decoration);
        decoration->deleteLater();
    });

    return decoration;
}

void LiriDecorationManager::registerDecoration(LiriDecoration *decoration)
{
    m_decorations[decoration->window()] = decoration;
}

void LiriDecorationManager::unregisterDecoration(LiriDecoration *decoration)
{
    m_decorations.remove(decoration->window());
}

bool LiriDecorationManager::hasDecoration(QWindow *window) const
{
    return m_decorations.contains(window);
}

LiriDecoration *LiriDecorationManager::decorationForWindow(QWindow *window)
{
    if (hasDecoration(window))
        return m_decorations[window];
    return createDecoration(window);
}

LiriDecoration::LiriDecoration(LiriDecorationManager *parent, QWindow *window, struct ::liri_decoration *object)
    : QWaylandClientExtensionTemplate<LiriDecoration>(1)
    , QtWayland::liri_decoration(object)
    , m_manager(parent)
    , m_window(window)
{
}

LiriDecoration::~LiriDecoration()
{
    m_manager->unregisterDecoration(this);
    destroy();
}

void LiriDecoration::setForegroundColor(const QColor &color)
{
    if (m_fgColor == color)
        return;

    m_fgColor = color;
    set_foreground(color.name(QColor::HexRgb));
}

void LiriDecoration::setBackgroundColor(const QColor &color)
{
    if (m_bgColor == color)
        return;

    m_bgColor = color;
    set_background(color.name());
}
