// SPDX-FileCopyrightText: 2022 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: MPL-2.0

#ifndef FLUIDDECORATIONV1_H
#define FLUIDDECORATIONV1_H

#include <QMap>
#include <QWindow>
#include <QWaylandClientExtension>

#include <wayland-client.h>

#include "qwayland-fluid-decoration-unstable-v1.h"

class FluidDecoration;

class FluidDecorationManager : public QWaylandClientExtensionTemplate<FluidDecorationManager>
        , public QtWayland::zfluid_decoration_manager_v1
{
    Q_OBJECT
public:
    explicit FluidDecorationManager();
    ~FluidDecorationManager();

    FluidDecoration *createDecoration(QWindow *window);

    void registerDecoration(FluidDecoration *decoration);
    void unregisterDecoration(FluidDecoration *decoration);

    bool hasDecoration(QWindow *window) const;

    FluidDecoration *decorationForWindow(QWindow *window);

private:
    QMap<QWindow *, FluidDecoration *> m_decorations;
};

class FluidDecoration : public QWaylandClientExtensionTemplate<FluidDecoration>
        , public QtWayland::zfluid_decoration_v1
{
    Q_OBJECT
public:
    explicit FluidDecoration(FluidDecorationManager *parent, QWindow *window, struct ::zfluid_decoration_v1 *object);
    ~FluidDecoration();

    inline QWindow *window() const { return m_window; }

    void setForegroundColor(const QColor &color);
    void setBackgroundColor(const QColor &color);

private:
    FluidDecorationManager *m_manager;
    QWindow *m_window;
    QColor m_fgColor = Qt::transparent;
    QColor m_bgColor = Qt::transparent;
};

#endif // FLUIDDECORATIONV1_H
