/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2011 Marco Martin <mart@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Marco Martin
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#ifndef QICONITEM_H
#define QICONITEM_H

#include <QQuickPaintedItem>
#include <QIcon>
#include <QVariant>

class QIconItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QVariant icon READ icon WRITE setIcon)
    Q_PROPERTY(bool smooth READ smooth WRITE setSmooth)
    Q_PROPERTY(int implicitWidth READ implicitWidth CONSTANT)
    Q_PROPERTY(int implicitHeight READ implicitHeight CONSTANT)
    Q_PROPERTY(State state READ state WRITE setState NOTIFY stateChanged)
    Q_ENUMS(State)
public:
    enum State {
        DefaultState,   //! The default state
        ActiveState,    //! Icon is active
        DisabledState   //! Icon is disabled
    };

    QIconItem(QQuickItem *parent = 0);
    ~QIconItem();

    void setIcon(const QVariant &icon);
    QIcon icon() const;

    QIconItem::State state() const;
    void setState(State state);

    int implicitWidth() const;
    int implicitHeight() const;

    void setSmooth(const bool smooth);
    bool smooth() const;

    void paint(QPainter *painter);

Q_SIGNALS:
    void stateChanged(State state);

private:
    QIcon m_icon;
    bool m_smooth;
    State m_state;
};

#endif // QICONITEM_H
