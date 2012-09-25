/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
 *
 * $BEGIN_LICENSE:LGPL-ONLY$
 *
 * This file may be used under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation and
 * appearing in the file LICENSE.LGPL included in the packaging of
 * this file, either version 2.1 of the License, or (at your option) any
 * later version.  Please review the following information to ensure the
 * GNU Lesser General Public License version 2.1 requirements
 * will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 *
 * If you have questions regarding the use of this file, please contact
 * us via http://www.maui-project.org/.
 *
 * $END_LICENSE$
 ***************************************************************************/

#include <QPainter>

#include "qiconitem.h"

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
        m_icon = KIcon(icon.toString());
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

    if (m_state == ActiveState) {
        QPixmap result = m_icon.pixmap(boundingRect().size().toSize());
        result = KIconLoader::global()->iconEffect()->apply(result, KIconLoader::Desktop, KIconLoader::ActiveState);
        painter->drawPixmap(0, 0, result);
    } else {
        m_icon.paint(painter, boundingRect().toRect(), Qt::AlignCenter, isEnabled() ? QIcon::Normal : QIcon::Disabled);
    }

    painter->setRenderHint(QPainter::Antialiasing, wasAntiAlias);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, wasSmoothTransform);
}

#include "moc_qitem.cpp"
