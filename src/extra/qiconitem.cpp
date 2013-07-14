/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <QPainter>

#include "qiconitem.h"

QT_BEGIN_NAMESPACE

QIconItem::QIconItem(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_smooth(false),
      m_state(DefaultState)
{
    setFlag(QQuickItem::ItemHasContents);
}

QIconItem::~QIconItem()
{
}

void QIconItem::setIcon(const QVariant &icon)
{
    if (icon.canConvert<QIcon>())
        m_icon = icon.value<QIcon>();
    else if (icon.canConvert<QString>())
        m_icon = QIcon::fromTheme(icon.toString());
    else
        m_icon = QIcon();
    update();
}

QIcon QIconItem::icon() const
{
    return m_icon;
}

QIconItem::State QIconItem::state() const
{
    return m_state;
}

void QIconItem::setState(QIconItem::State state)
{
    if (m_state == state)
        return;

    m_state = state;
    emit stateChanged(state);
    update();
}

int QIconItem::implicitWidth() const
{
#if 0
    return KIconLoader::global()->currentSize(KIconLoader::Desktop);
#else
    // TODO: use vsettings
    return 48;
#endif
}

int QIconItem::implicitHeight() const
{
#if 0
    return KIconLoader::global()->currentSize(KIconLoader::Desktop);
#else
    // TODO: use vsettings
    return 48;
#endif
}

void QIconItem::setSmooth(const bool smooth)
{
    if (smooth == m_smooth)
        return;
    m_smooth = smooth;
    update();
}

bool QIconItem::smooth() const
{
    return m_smooth;
}

void QIconItem::paint(QPainter *painter)
{
    if (m_icon.isNull())
        return;

    // Do without painter save, faster and the support can be compiled out
    const bool wasAntiAlias = painter->testRenderHint(QPainter::Antialiasing);
    const bool wasSmoothTransform = painter->testRenderHint(QPainter::SmoothPixmapTransform);
    painter->setRenderHint(QPainter::Antialiasing, m_smooth);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

#if 0
    if (m_state == ActiveState) {
        QPixmap result = m_icon.pixmap(boundingRect().size().toSize());
        result = KIconLoader::global()->iconEffect()->apply(result, KIconLoader::Desktop, KIconLoader::ActiveState);
        painter->drawPixmap(0, 0, result);
    } else {
        m_icon.paint(painter, boundingRect().toRect(), Qt::AlignCenter, isEnabled() ? QIcon::Normal : QIcon::Disabled);
    }
#else
    // TODO:
    m_icon.paint(painter, boundingRect().toRect(), Qt::AlignCenter, isEnabled() ? QIcon::Normal : QIcon::Disabled);
#endif

    painter->setRenderHint(QPainter::Antialiasing, wasAntiAlias);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, wasSmoothTransform);
}

QT_END_NAMESPACE
