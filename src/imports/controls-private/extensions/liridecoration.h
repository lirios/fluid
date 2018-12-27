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

#ifndef LIRIDECORATION_H
#define LIRIDECORATION_H

#include <QMap>
#include <QWindow>
#include <QWaylandClientExtension>

#include <wayland-client.h>

#include "qwayland-liri-decoration.h"

class LiriDecoration;

class LiriDecorationManager : public QWaylandClientExtensionTemplate<LiriDecorationManager>
        , public QtWayland::liri_decoration_manager
{
    Q_OBJECT
public:
    explicit LiriDecorationManager();
    ~LiriDecorationManager();

    LiriDecoration *createDecoration(QWindow *window);

    void registerDecoration(LiriDecoration *decoration);
    void unregisterDecoration(LiriDecoration *decoration);

    bool hasDecoration(QWindow *window) const;

    LiriDecoration *decorationForWindow(QWindow *window);

private:
    QMap<QWindow *, LiriDecoration *> m_decorations;
};

class LiriDecoration : public QWaylandClientExtensionTemplate<LiriDecoration>
        , public QtWayland::liri_decoration
{
    Q_OBJECT
public:
    explicit LiriDecoration(LiriDecorationManager *parent, QWindow *window, struct ::liri_decoration *object);
    ~LiriDecoration();

    inline QWindow *window() const { return m_window; }

    void setForegroundColor(const QColor &color);
    void setBackgroundColor(const QColor &color);

private:
    LiriDecorationManager *m_manager;
    QWindow *m_window;
    QColor m_fgColor = Qt::transparent;
    QColor m_bgColor = Qt::transparent;
};

#endif // LIRIDECORATION_H
