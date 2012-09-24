/***************************************************************************
 *   Copyright 2010 Marco Martin <mart@kde.org>                            *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/
#ifndef SVGITEM_P
#define SVGITEM_P

#include <QDeclarativeItem>

namespace Plasma {

    class Svg;

class SvgItem : public QDeclarativeItem
{
    Q_OBJECT

    /**
     * The sub element of the svg we want to render. If empty the whole svg document will be painted.
     */
    Q_PROPERTY(QString elementId READ elementId WRITE setElementId NOTIFY elementIdChanged)

    /**
     * Svg class that is the source of the image, use it like that:
     * <code>
     * SvgItem {
     *     svg: Svg {imagePath: "widgets/arrows"}
     *     elementId: "arrow-left"
     * }
     * </code>
     * Instead of a Svg declaration it can also be the id of a Svg declared elsewhere, useful to share Svg instances.
     */
    Q_PROPERTY(Plasma::Svg * svg READ svg WRITE setSvg NOTIFY svgChanged)

    /**
     * The natural, unscaled size of the svg document or the element. useful if a pixel perfect rendering of outlines is needed.
     */
    Q_PROPERTY(QSizeF naturalSize READ naturalSize NOTIFY naturalSizeChanged)

    /**
     * If true enable antialiasing in paint: default off, better quality but less performance.
     */
    Q_PROPERTY(bool smooth READ smooth WRITE setSmooth NOTIFY smoothChanged)

public:
    SvgItem(QDeclarativeItem *parent=0);
    ~SvgItem();

    void setElementId(const QString &elementID);
    QString elementId() const;

    void setSvg(Plasma::Svg *svg);
    Plasma::Svg *svg() const;

    void setSmooth(const bool smooth);
    bool smooth() const;

    QSizeF naturalSize() const;

    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);

Q_SIGNALS:
    void elementIdChanged();
    void svgChanged();
    void naturalSizeChanged();
    void smoothChanged();

protected Q_SLOTS:
    void updateNeeded();

private:
    QWeakPointer<Plasma::Svg> m_svg;
    QString m_elementID;
    bool m_smooth;
};
}

#endif
