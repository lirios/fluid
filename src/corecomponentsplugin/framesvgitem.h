/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2010 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
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

#ifndef FRAMESVGITEM_H
#define FRAMESVGITEM_H

#include <QQuickPaintedItem>

#include <Fluid/FrameSvg>

namespace Fluid
{
    class FrameSvg;
}

class FrameSvgItemMargins : public QObject
{
    Q_OBJECT

    /**
     * width in pixels of the left margin
     */
    Q_PROPERTY(qreal left READ left NOTIFY marginsChanged)

    /**
     * height in pixels of the top margin
     */
    Q_PROPERTY(qreal top READ top NOTIFY marginsChanged)

    /**
     * width in pixels of the right margin
     */
    Q_PROPERTY(qreal right READ right NOTIFY marginsChanged)

    /**
     * height in pixels of the bottom margin
     */
    Q_PROPERTY(qreal bottom READ bottom NOTIFY marginsChanged)

public:
    FrameSvgItemMargins(Fluid::FrameSvg *frameSvg, QObject *parent = 0);

    qreal left() const;
    qreal top() const;
    qreal right() const;
    qreal bottom() const;

Q_SIGNALS:
    void marginsChanged();

private:
    Fluid::FrameSvg *m_frameSvg;
};

class FrameSvgItem : public QQuickPaintedItem
{
    Q_OBJECT

    /**
     * Theme relative path of the svg, like "widgets/background"
     */
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)

    /**
     * prefix for the 9 piece svg, like "pushed" or "normal" for the button
     * see http://techbase.kde.org/Development/Tutorials/Fluid/ThemeDetails
     * for a list of paths and prefixes
     */
    Q_PROPERTY(QString prefix READ prefix WRITE setPrefix NOTIFY prefixChanged)

    /**
     * The margins of the frame, read only
     * @see FrameSvgItemMargins
     */
    Q_PROPERTY(QObject *margins READ margins CONSTANT)

    Q_FLAGS(Fluid::FrameSvg::EnabledBorders)
    /**
     * The borders that will be rendered, it's a flag combination of:
     *  NoBorder
     *  TopBorder
     *  BottomBorder
     *  LeftBorder
     *  RightBorder
     */
    Q_PROPERTY(Fluid::FrameSvg::EnabledBorders enabledBorders READ enabledBorders WRITE setEnabledBorders NOTIFY enabledBordersChanged)

public:
    FrameSvgItem(QQuickItem *parent = 0);
    ~FrameSvgItem();

    void setImagePath(const QString &path);
    QString imagePath() const;

    void setPrefix(const QString &prefix);
    QString prefix() const;

    void setEnabledBorders(const Fluid::FrameSvg::EnabledBorders borders);
    Fluid::FrameSvg::EnabledBorders enabledBorders() const;

    FrameSvgItemMargins *margins() const;

    void paint(QPainter *painter);

    void geometryChanged(const QRectF &newGeometry,
                         const QRectF &oldGeometry);

signals:
    void imagePathChanged();
    void prefixChanged();
    void enabledBordersChanged();

private Q_SLOTS:
    void doUpdate();

private:
    Fluid::FrameSvg *m_frameSvg;
    FrameSvgItemMargins *m_margins;
    QString m_prefix;
};

#endif // FRAMESVGITEM_H
