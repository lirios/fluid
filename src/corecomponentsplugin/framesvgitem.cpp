/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2010 Marco Martin <mart@kde.org>
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

#include "framesvgitem.h"

FrameSvgItemMargins::FrameSvgItemMargins(Fluid::FrameSvg *frameSvg, QObject *parent)
    : QObject(parent),
      m_frameSvg(frameSvg)
{
    connect(m_frameSvg, SIGNAL(repaintNeeded()), this, SIGNAL(marginsChanged()));
}

qreal FrameSvgItemMargins::left() const
{
    return m_frameSvg->marginSize(Fluid::LeftMargin);
}

qreal FrameSvgItemMargins::top() const
{
    return m_frameSvg->marginSize(Fluid::TopMargin);
}

qreal FrameSvgItemMargins::right() const
{
    return m_frameSvg->marginSize(Fluid::RightMargin);
}

qreal FrameSvgItemMargins::bottom() const
{
    return m_frameSvg->marginSize(Fluid::BottomMargin);
}

FrameSvgItem::FrameSvgItem(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{
    m_frameSvg = new Fluid::FrameSvg(this);
    m_margins = new FrameSvgItemMargins(m_frameSvg, this);
    setFlag(QQuickItem::ItemHasContents);
    connect(m_frameSvg, SIGNAL(repaintNeeded()), this, SLOT(doUpdate()));
}

FrameSvgItem::~FrameSvgItem()
{
}

void FrameSvgItem::setImagePath(const QString &path)
{
    if (m_frameSvg->imagePath() == path)
        return;

    m_frameSvg->setImagePath(path);
    m_frameSvg->setElementPrefix(m_prefix);

    emit imagePathChanged();
    update();
}

QString FrameSvgItem::imagePath() const
{
    return m_frameSvg->imagePath();
}


void FrameSvgItem::setPrefix(const QString &prefix)
{
    if (m_prefix == prefix)
        return;

    m_frameSvg->setElementPrefix(prefix);
    m_prefix = prefix;

    emit prefixChanged();
    update();
}

QString FrameSvgItem::prefix() const
{
    return m_prefix;
}

FrameSvgItemMargins *FrameSvgItem::margins() const
{
    return m_margins;
}

void FrameSvgItem::setEnabledBorders(const Fluid::FrameSvg::EnabledBorders borders)
{
    if (m_frameSvg->enabledBorders() == borders)
        return;

    m_frameSvg->setEnabledBorders(borders);
    emit enabledBordersChanged();
}

Fluid::FrameSvg::EnabledBorders FrameSvgItem::enabledBorders() const
{
    return m_frameSvg->enabledBorders();
}

void FrameSvgItem::paint(QPainter *painter)
{
    m_frameSvg->paintFrame(painter);
}

void FrameSvgItem::geometryChanged(const QRectF &newGeometry,
                                   const QRectF &oldGeometry)
{
    m_frameSvg->resizeFrame(newGeometry.size());
    QQuickItem::geometryChanged(newGeometry, oldGeometry);
}

void FrameSvgItem::doUpdate()
{
    update();
}

#include "moc_framesvgitem.cpp"
