/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2006-2010 Aaron Seigo <aseigo@kde.org>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Aaron Seigo
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

#ifndef SVG_P_H
#define SVG_P_H

#include <QHash>
#include <QPointer>
#include <QSharedData>
#include <QSvgRenderer>

#include <VibeCore/VSharedPointer>

//
//  W A R N I N G
//  -------------
//
// This file is not part of the Fluid API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.
//

namespace Fluid
{
    class Svg;

    class SharedSvgRenderer : public QSvgRenderer, public QSharedData
    {
    public:
        typedef VSharedPointer<SharedSvgRenderer> Ptr;

        SharedSvgRenderer(QObject *parent = 0);
        SharedSvgRenderer(
            const QString &filename,
            const QString &styleSheet,
            QHash<QString, QRectF> &interestingElements,
            QObject *parent = 0);

        SharedSvgRenderer(
            const QByteArray &contents,
            const QString &styleSheet,
            QHash<QString, QRectF> &interestingElements,
            QObject *parent = 0);

    private:
        bool load(
            const QByteArray &contents,
            const QString &styleSheet,
            QHash<QString, QRectF> &interestingElements);
    };

    class SvgPrivate
    {
    public:
        SvgPrivate(Svg *svg);
        ~SvgPrivate();

        //This function is meant for the rects cache
        QString cacheId(const QString &elementId);

        //This function is meant for the pixmap cache
        QString cachePath(const QString &path, const QSize &size);

        bool setImagePath(const QString &imagePath);

        Theme *actualTheme();
        Theme *cacheAndColorsTheme();

        QPixmap findInCache(const QString &elementId, const QSizeF &s = QSizeF());

        void createRenderer();
        void eraseRenderer();

        QRectF elementRect(const QString &elementId);
        QRectF findAndCacheElementRect(const QString &elementId);
        QMatrix matrixForElement(const QString &elementId);

        void checkColorHints();

        //Following two are utility functions to snap rendered elements to the pixel grid
        //to and from are always 0 <= val <= 1
        qreal closestDistance(qreal to, qreal from);

        QRectF makeUniform(const QRectF &orig, const QRectF &dst);

        //Slots
        void themeChanged();
        void colorsChanged();

        static QHash<QString, SharedSvgRenderer::Ptr> s_renderers;
        static QPointer<Theme> s_systemColorsCache;

        Svg *q;
        QPointer<Theme> theme;
        QHash<QString, QRectF> localRectCache;
        QHash<QString, QSize> elementsWithSizeHints;
        SharedSvgRenderer::Ptr renderer;
        QString themePath;
        QString path;
        QSizeF size;
        QSizeF naturalSize;
        QChar styleCrc;
        unsigned int lastModified;
        bool multipleImages : 1;
        bool themed : 1;
        bool applyColors : 1;
        bool usesColors : 1;
        bool cacheRendering : 1;
        bool themeFailed : 1;
    };
}

#endif // SVG_P_H
