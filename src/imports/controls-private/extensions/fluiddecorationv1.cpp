// SPDX-FileCopyrightText: 2022 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: MPL-2.0

#include <QGuiApplication>
#include <QPlatformSurfaceEvent>
#include <QtGui/qpa/qplatformnativeinterface.h>

#include "fluiddecorationv1.h"

static inline wl_surface *getWlSurface(QWindow *window)
{
    void *surface = QGuiApplication::platformNativeInterface()->nativeResourceForWindow("surface", window);
    return static_cast<wl_surface *>(surface);
}

FluidDecorationManager::FluidDecorationManager()
    : QWaylandClientExtensionTemplate(1)
{
}

FluidDecorationManager::~FluidDecorationManager()
{
    qDeleteAll(m_decorations);
}

FluidDecoration *FluidDecorationManager::createDecoration(QWindow *window)
{
    auto decoration = new FluidDecoration(this, window, create(getWlSurface(window)));
    registerDecoration(decoration);

    connect(window, &QObject::destroyed, this, [this, decoration](QObject * = nullptr) {
        unregisterDecoration(decoration);
        decoration->deleteLater();
    });

    return decoration;
}

void FluidDecorationManager::registerDecoration(FluidDecoration *decoration)
{
    m_decorations[decoration->window()] = decoration;
}

void FluidDecorationManager::unregisterDecoration(FluidDecoration *decoration)
{
    m_decorations.remove(decoration->window());
}

bool FluidDecorationManager::hasDecoration(QWindow *window) const
{
    return m_decorations.contains(window);
}

FluidDecoration *FluidDecorationManager::decorationForWindow(QWindow *window)
{
    if (hasDecoration(window))
        return m_decorations[window];
    return createDecoration(window);
}

FluidDecoration::FluidDecoration(FluidDecorationManager *parent, QWindow *window, struct ::zfluid_decoration_v1 *object)
    : QWaylandClientExtensionTemplate<FluidDecoration>(1)
    , QtWayland::zfluid_decoration_v1(object)
    , m_manager(parent)
    , m_window(window)
{
}

FluidDecoration::~FluidDecoration()
{
    m_manager->unregisterDecoration(this);
    destroy();
}

void FluidDecoration::setForegroundColor(const QColor &color)
{
    if (m_fgColor == color)
        return;

    m_fgColor = color;
    set_foreground(color.red(), color.green(), color.blue(), color.alpha());
}

void FluidDecoration::setBackgroundColor(const QColor &color)
{
    if (m_bgColor == color)
        return;

    m_bgColor = color;
    set_background(color.red(), color.green(), color.blue(), color.alpha());
}
