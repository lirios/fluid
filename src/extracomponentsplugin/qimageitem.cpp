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

#include "qimageitem.h"

QImageItem::QImageItem(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_smooth(false),
      m_fillMode(QImageItem::Stretch)
{
    setFlag(QQuickItem::ItemHasContents);
}

QImageItem::~QImageItem()
{
}

void QImageItem::setImage(const QImage &image)
{
    bool oldImageNull = m_image.isNull();
    m_image = image;
    update();
    emit nativeWidthChanged();
    emit nativeHeightChanged();
    emit imageChanged();
    if (oldImageNull != m_image.isNull())
        emit nullChanged();
}

QImage QImageItem::image() const
{
    return m_image;
}

void QImageItem::setSmooth(const bool smooth)
{
    if (smooth == m_smooth)
        return;
    m_smooth = smooth;
    update();
}

bool QImageItem::smooth() const
{
    return m_smooth;
}

int QImageItem::nativeWidth() const
{
    return m_image.size().width();
}

int QImageItem::nativeHeight() const
{
    return m_image.size().height();
}

QImageItem::FillMode QImageItem::fillMode() const
{
    return m_fillMode;
}

void QImageItem::setFillMode(QImageItem::FillMode mode)
{
    if (mode == m_fillMode)
        return;

    m_fillMode = mode;
    update();
    emit fillModeChanged();
}

void QImageItem::paint(QPainter *painter)
{
    if (m_image.isNull())
        return;

    painter->save();
    painter->setRenderHint(QPainter::Antialiasing, m_smooth);
    painter->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    QRect destRect;
    switch (m_fillMode) {
        case PreserveAspectFit: {
            QSize scaled = m_image.size();

            scaled.scale(boundingRect().size().toSize(), Qt::KeepAspectRatio);
            destRect = QRect(QPoint(0, 0), scaled);
            break;
        }
        case PreserveAspectCrop: {
            painter->setClipRect(boundingRect(), Qt::IntersectClip);
            QSize scaled = m_image.size();
            scaled.scale(boundingRect().size().toSize(), Qt::KeepAspectRatioByExpanding);
            destRect = QRect(QPoint(0, 0), scaled);
            break;
        }
        case TileVertically: {
            painter->scale(width() / (qreal)m_image.width(), 1);
            destRect = boundingRect().toRect();
            destRect.setWidth(destRect.width() / (width() / (qreal)m_image.width()));
            break;
        }
        case TileHorizontally: {
            painter->scale(1, height() / (qreal)m_image.height());
            destRect = boundingRect().toRect();
            destRect.setHeight(destRect.height() / (height() / (qreal)m_image.height()));
            break;
        }
        case Stretch:
        case Tile:
        default:
            destRect = boundingRect().toRect();
    }

    if (m_fillMode >= Tile) {
        painter->drawTiledPixmap(destRect, QPixmap::fromImage(m_image));
    } else {
        painter->drawImage(destRect, m_image, m_image.rect());
    }

    painter->restore();
}

bool QImageItem::isNull() const
{
    return m_image.isNull();
}

#include "moc_qimageitem.cpp"
