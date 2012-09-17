/*
 *   Copyright 2006-2010 Aaron Seigo <aseigo@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef SVG_P_H
#define SVG_P_H

#include <QHash>
#include <QSharedData>
#include <QSvgRenderer>

#include <VibeCore/VSharedPointer>

namespace FluidUi
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
        static QWeakPointer<Theme> s_systemColorsCache;

        Svg *q;
        QWeakPointer<Theme> theme;
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
