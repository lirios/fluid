/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2008-2010 Aaron Seigo
 * Copyright (c) 2008-2010 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <notmart@gmail.com>
 *    Aaron Seigo <aseigo@kde.org>
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

#include <QAtomicInt>
#include <QBitmap>
#include <QCryptographicHash>
#include <QDebug>
#include <QPainter>
#include <QRegion>
#include <QSize>
#include <QStringBuilder>
#include <QTimer>

#include "framesvg.h"
#include "framesvg_p.h"
#include "svg_p.h"
#include "theme.h"

namespace Fluid
{
    QHash<QString, FrameData *> FrameSvgPrivate::s_sharedFrames;

    // Any attempt to generate a frame whose width or height is larger than this
    // will be rejected
    static const int MAX_FRAME_SIZE = 100000;

    FrameSvg::FrameSvg(QObject *parent)
        : Svg(parent),
          d(new FrameSvgPrivate(this))
    {
        connect(this, SIGNAL(repaintNeeded()), this, SLOT(updateNeeded()));
        d->frames.insert(QString(), new FrameData(this));
    }

    FrameSvg::~FrameSvg()
    {
        delete d;
    }

    void FrameSvg::setImagePath(const QString &path)
    {
        if (path == imagePath()) {
            return;
        }

        bool updateNeeded = true;
        clearCache();

        FrameData *fd = d->frames[d->prefix];
        if (fd->refcount() == 1) {
            // we're the only user of it, let's remove it from the shared keys
            // we don't want to deref it, however, as we'll still be using it
            const QString oldKey = d->cacheId(fd, d->prefix);
            FrameSvgPrivate::s_sharedFrames.remove(oldKey);
        } else {
            // others are using this frame, so deref it for ourselves
            fd->deref(this);
            fd = 0;
        }

        Svg::d->setImagePath(path);

        if (!fd) {
            // we need to replace our frame, start by looking in the frame cache
            FrameData *oldFd = d->frames[d->prefix];
            const QString key = d->cacheId(oldFd, d->prefix);
            fd = FrameSvgPrivate::s_sharedFrames.value(key);

            if (fd) {
                // we found one, so ref it and use it; we also don't need to (or want to!)
                // trigger a full update of the frame since it is already the one we want
                // and likely already rendered just fine
                fd->ref(this);
                updateNeeded = false;
            } else {
                // nothing exists for us in the cache, so create a new FrameData based
                // on the old one
                fd = new FrameData(*oldFd, this);
            }

            d->frames.insert(d->prefix, fd);
        }

        setContainsMultipleImages(true);
        if (updateNeeded) {
            // ensure our frame is in the cache
            const QString key = d->cacheId(fd, d->prefix);
            FrameSvgPrivate::s_sharedFrames.insert(key, fd);

            // this will emit repaintNeeded() as well when it is done
            d->updateAndSignalSizes();
        } else {
            emit repaintNeeded();
        }
    }

    void FrameSvg::setEnabledBorders(const EnabledBorders borders)
    {
        if (borders == d->frames[d->prefix]->enabledBorders) {
            return;
        }

        FrameData *fd = d->frames[d->prefix];

        const QString oldKey = d->cacheId(fd, d->prefix);
        const EnabledBorders oldBorders = fd->enabledBorders;
        fd->enabledBorders = borders;
        const QString newKey = d->cacheId(fd, d->prefix);
        fd->enabledBorders = oldBorders;

        //qDebug() << "looking for" << newKey;
        FrameData *newFd = FrameSvgPrivate::s_sharedFrames.value(newKey);
        if (newFd) {
            //qDebug() << "FOUND IT!" << newFd->refcount;
            // we've found a math, so insert that new one and ref it ..
            newFd->ref(this);
            d->frames.insert(d->prefix, newFd);

            //.. then deref the old one and if it's no longer used, get rid of it
            if (fd->deref(this)) {
                //const QString oldKey = d->cacheId(fd, d->prefix);
                //qDebug() << "1. Removing it" << oldKey << fd->refcount;
                FrameSvgPrivate::s_sharedFrames.remove(oldKey);
                delete fd;
            }

            return;
        }

        if (fd->refcount() == 1) {
            // we're the only user of it, let's remove it from the shared keys
            // we don't want to deref it, however, as we'll still be using it
            FrameSvgPrivate::s_sharedFrames.remove(oldKey);
        } else {
            // others are using it, but we wish to change its size. so deref it,
            // then create a copy of it (we're automatically ref'd via the ctor),
            // then insert it into our frames.
            fd->deref(this);
            fd = new FrameData(*fd, this);
            d->frames.insert(d->prefix, fd);
        }

        fd->enabledBorders = borders;
        d->updateAndSignalSizes();
    }

    FrameSvg::EnabledBorders FrameSvg::enabledBorders() const
    {
        if (d->frames.isEmpty()) {
            return NoBorder;
        }

        QHash<QString, FrameData *>::const_iterator it = d->frames.constFind(d->prefix);

        if (it != d->frames.constEnd()) {
            return it.value()->enabledBorders;
        } else {
            return NoBorder;
        }
    }

    void FrameSvg::setElementPrefix(Fluid::Location location)
    {
        switch (location) {
            case Fluid::TopEdge:
                setElementPrefix("north");
                break;
            case Fluid::BottomEdge:
                setElementPrefix("south");
                break;
            case Fluid::LeftEdge:
                setElementPrefix("west");
                break;
            case Fluid::RightEdge:
                setElementPrefix("east");
                break;
            default:
                setElementPrefix(QString());
                break;
        }

        d->location = location;
    }

    void FrameSvg::setElementPrefix(const QString &prefix)
    {
        const QString oldPrefix(d->prefix);

        if (!hasElement(prefix % "-center")) {
            d->prefix.clear();
        } else {
            d->prefix = prefix;
            if (!d->prefix.isEmpty()) {
                d->prefix += '-';
            }
        }

        FrameData *oldFrameData = d->frames.value(oldPrefix);
        if (oldPrefix == d->prefix && oldFrameData) {
            return;
        }

        if (!d->frames.contains(d->prefix)) {
            if (oldFrameData) {
                FrameData *newFd = 0;
                if (!oldFrameData->frameSize.isEmpty()) {
                    const QString key = d->cacheId(oldFrameData, d->prefix);
                    newFd = FrameSvgPrivate::s_sharedFrames.value(key);
                }

                // we need to put this in the cache if we didn't find it in the shared frames
                // and we have a size; if we don't have a size, we'll catch it later
                const bool cache = !newFd && !oldFrameData->frameSize.isEmpty();
                if (newFd) {
                    newFd->ref(this);
                } else  {
                    newFd = new FrameData(*oldFrameData, this);
                }

                d->frames.insert(d->prefix, newFd);

                if (cache) {
                    // we have to cache after inserting the frame since the cacheId requires the
                    // frame to be in the frames collection already
                    const QString key = d->cacheId(oldFrameData, d->prefix);
                    //qDebug() << this << "     1. inserting as" << key;

                    FrameSvgPrivate::s_sharedFrames.insert(key, newFd);
                }
            } else {
                // couldn't find anything useful, so we just create something here
                // we don't have a size for it yet, so don't bother trying to share it just yet
                FrameData *newFd = new FrameData(this);
                d->frames.insert(d->prefix, newFd);
            }

            d->updateSizes();
        }

        if (!d->cacheAll) {
            d->frames.remove(oldPrefix);
            if (oldFrameData) {
                if (oldFrameData->deref(this)) {
                    const QString oldKey = d->cacheId(oldFrameData, oldPrefix);
                    FrameSvgPrivate::s_sharedFrames.remove(oldKey);
                    delete oldFrameData;
                }
            }
        }

        d->location = Fluid::Floating;
    }

    bool FrameSvg::hasElementPrefix(const QString &prefix) const
    {
        //for now it simply checks if a center element exists,
        //because it could make sense for certain themes to not have all the elements
        if (prefix.isEmpty()) {
            return hasElement("center");
        } else {
            return hasElement(prefix % "-center");
        }
    }

    bool FrameSvg::hasElementPrefix(Fluid::Location location) const
    {
        switch (location) {
            case Fluid::TopEdge:
                return hasElementPrefix("north");
                break;
            case Fluid::BottomEdge:
                return hasElementPrefix("south");
                break;
            case Fluid::LeftEdge:
                return hasElementPrefix("west");
                break;
            case Fluid::RightEdge:
                return hasElementPrefix("east");
                break;
            default:
                return hasElementPrefix(QString());
                break;
        }
    }

    QString FrameSvg::prefix()
    {
        if (d->prefix.isEmpty())
            return d->prefix;

        return d->prefix.left(d->prefix.size() - 1);
    }

    void FrameSvg::resizeFrame(const QSizeF &size)
    {
        if (imagePath().isEmpty())
            return;

        if (size.isEmpty()) {
#ifdef DEBUG
            qDebug() << "Invalid size" << size;
#endif
            return;
        }

        FrameData *fd = d->frames[d->prefix];
        if (size == fd->frameSize)
            return;

        const QString oldKey = d->cacheId(fd, d->prefix);
        const QSize currentSize = fd->frameSize;
        fd->frameSize = size.toSize();
        const QString newKey = d->cacheId(fd, d->prefix);
        fd->frameSize = currentSize;

        //qDebug() << "looking for" << newKey;
        FrameData *newFd = FrameSvgPrivate::s_sharedFrames.value(newKey);
        if (newFd) {
            //qDebug() << "FOUND IT!" << newFd->refcount;
            // we've found a math, so insert that new one and ref it ..
            newFd->ref(this);
            d->frames.insert(d->prefix, newFd);

            //.. then deref the old one and if it's no longer used, get rid of it
            if (fd->deref(this)) {
                //const QString oldKey = d->cacheId(fd, d->prefix);
                //qDebug() << "1. Removing it" << oldKey << fd->refcount;
                FrameSvgPrivate::s_sharedFrames.remove(oldKey);
                delete fd;
            }

            return;
        }

        if (fd->refcount() == 1) {
            // we're the only user of it, let's remove it from the shared keys
            // we don't want to deref it, however, as we'll still be using it
            FrameSvgPrivate::s_sharedFrames.remove(oldKey);
        } else {
            // others are using it, but we wish to change its size. so deref it,
            // then create a copy of it (we're automatically ref'd via the ctor),
            // then insert it into our frames.
            fd->deref(this);
            fd = new FrameData(*fd, this);
            d->frames.insert(d->prefix, fd);
        }

        d->updateSizes();
        fd->frameSize = size.toSize();
        // we know it isn't in s_sharedFrames due to the check above, so insert it now
        FrameSvgPrivate::s_sharedFrames.insert(newKey, fd);
    }

    QSizeF FrameSvg::frameSize() const
    {
        QHash<QString, FrameData *>::const_iterator it = d->frames.constFind(d->prefix);

        if (it == d->frames.constEnd())
            return QSize(-1, -1);
        else
            return d->frameSize(it.value());
    }

    qreal FrameSvg::marginSize(const Fluid::MarginEdge edge) const
    {
        if (d->frames[d->prefix]->noBorderPadding)
            return .0;

        switch (edge) {
            case Fluid::TopMargin:
                return d->frames[d->prefix]->topMargin;
                break;

            case Fluid::LeftMargin:
                return d->frames[d->prefix]->leftMargin;
                break;

            case Fluid::RightMargin:
                return d->frames[d->prefix]->rightMargin;
                break;

                //Fluid::BottomMargin
            default:
                return d->frames[d->prefix]->bottomMargin;
                break;
        }
    }

    void FrameSvg::getMargins(qreal &left, qreal &top, qreal &right, qreal &bottom) const
    {
        FrameData *frame = d->frames[d->prefix];

        if (frame->noBorderPadding) {
            left = top = right = bottom = 0;
            return;
        }

        top = frame->topMargin;
        left = frame->leftMargin;
        right = frame->rightMargin;
        bottom = frame->bottomMargin;
    }

    QRectF FrameSvg::contentsRect() const
    {
        QSizeF size(frameSize());

        if (size.isValid()) {
            QRectF rect(QPointF(0, 0), size);
            FrameData *frame = d->frames[d->prefix];

            return rect.adjusted(frame->leftMargin, frame->topMargin,
                                 -frame->rightMargin, -frame->bottomMargin);
        } else {
            return QRectF();
        }
    }

    QPixmap FrameSvg::alphaMask() const
    {
        //FIXME: the distinction between overlay and
        return d->alphaMask();
    }

    QRegion FrameSvg::mask() const
    {
        FrameData *frame = d->frames[d->prefix];
        QString id = d->cacheId(frame, QString());
        if (!frame->cachedMasks.contains(id)) {
            //TODO: Implement a better way to cap the number of cached masks
            if (frame->cachedMasks.count() > frame->MAX_CACHED_MASKS)
                frame->cachedMasks.clear();
            frame->cachedMasks.insert(id, QRegion(QBitmap(d->alphaMask().createMaskFromColor(Qt::black))));
        }
        return frame->cachedMasks[id];
    }

    void FrameSvg::setCacheAllRenderedFrames(bool cache)
    {
        if (d->cacheAll && !cache)
            clearCache();

        d->cacheAll = cache;
    }

    bool FrameSvg::cacheAllRenderedFrames() const
    {
        return d->cacheAll;
    }

    void FrameSvg::clearCache()
    {
        FrameData *frame = d->frames[d->prefix];

        // delete all the frames that aren't this one
        QMutableHashIterator<QString, FrameData *> it(d->frames);
        while (it.hasNext()) {
            FrameData *p = it.next().value();
            if (frame != p) {
                //TODO: should we clear from the Theme pixmap cache as well?
                if (p->deref(this)) {
                    const QString key = d->cacheId(p, it.key());
                    FrameSvgPrivate::s_sharedFrames.remove(key);
                    p->cachedBackground = QPixmap();
                }

                it.remove();
            }
        }
    }

    QPixmap FrameSvg::framePixmap()
    {
        FrameData *frame = d->frames[d->prefix];
        if (frame->cachedBackground.isNull()) {
            d->generateBackground(frame);
            if (frame->cachedBackground.isNull()) {
                return QPixmap();
            }
        }

        return frame->cachedBackground;
    }

    void FrameSvg::paintFrame(QPainter *painter, const QRectF &target, const QRectF &source)
    {
        FrameData *frame = d->frames[d->prefix];
        if (frame->cachedBackground.isNull()) {
            d->generateBackground(frame);
            if (frame->cachedBackground.isNull()) {
                return;
            }
        }

        painter->drawPixmap(target, frame->cachedBackground, source.isValid() ? source : target);
    }

    void FrameSvg::paintFrame(QPainter *painter, const QPointF &pos)
    {
        FrameData *frame = d->frames[d->prefix];
        if (frame->cachedBackground.isNull()) {
            d->generateBackground(frame);
            if (frame->cachedBackground.isNull()) {
                return;
            }
        }

        painter->drawPixmap(pos, frame->cachedBackground);
    }

    //#define DEBUG_FRAMESVG_CACHE
    FrameSvgPrivate::~FrameSvgPrivate()
    {
#ifdef DEBUG_FRAMESVG_CACHE
#ifdef DEBUG
        qDebug() << "*************" << q << q->imagePath() << "****************";
#endif
#endif

        QHashIterator<QString, FrameData *> it(frames);
        while (it.hasNext()) {
            it.next();
            if (it.value()) {
                // we remove all references from this widget to the frame, and delete it if we're the
                // last user
                if (it.value()->removeRefs(q)) {
                    const QString key = cacheId(it.value(), it.key());
#ifdef DEBUG_FRAMESVG_CACHE
#ifdef DEBUG
                    qDebug() << "2. Removing it" << key << it.value() << it.value()->refcount() << s_sharedFrames.contains(key);
#endif
#endif
                    s_sharedFrames.remove(key);
                    delete it.value();
                }
#ifdef DEBUG_FRAMESVG_CACHE
                else {
#ifdef DEBUG
                    qDebug() << "still shared:" << cacheId(it.value(), it.key()) << it.value() << it.value()->refcount() << it.value()->isUsed();
#endif
                }
            } else {
#ifdef DEBUG
                qDebug() << "lost our value for" << it.key();
#endif
#endif
            }
        }

#ifdef DEBUG_FRAMESVG_CACHE
        QHashIterator<QString, FrameData *> it2(s_sharedFrames);
        int shares = 0;
        while (it2.hasNext()) {
            it2.next();
            const int rc = it2.value()->refcount();
            if (rc == 0) {
#ifdef DEBUG
                qDebug() << "     LOST!" << it2.key() << rc << it2.value();// << it2.value()->references;
#endif
            } else {
#ifdef DEBUG
                qDebug() << "          " << it2.key() << rc << it2.value();
#endif
                foreach(FrameSvg * data, it2.value()->references.keys()) {
#ifdef DEBUG
                    qDebug() << "            " << (void *)data << it2.value()->references[data];
#endif
                }
                shares += rc - 1;
            }
        }
#ifdef DEBUG
        qDebug() << "#####################################" << s_sharedFrames.count() << ", pixmaps saved:" << shares;
#endif
#endif

        frames.clear();
    }

    QPixmap FrameSvgPrivate::alphaMask()
    {
        FrameData *frame = frames[prefix];
        QString maskPrefix;

        if (q->hasElement("mask-" % prefix % "center"))
            maskPrefix = "mask-";

        if (maskPrefix.isNull()) {
            if (frame->cachedBackground.isNull()) {
                generateBackground(frame);
                if (frame->cachedBackground.isNull())
                    return QPixmap();
            }

            return frame->cachedBackground;
        } else {
            QString oldPrefix = prefix;

            // We are setting the prefix only temporary to generate
            // the needed mask image
            prefix = maskPrefix % oldPrefix;

            if (!frames.contains(prefix)) {
                const QString key = cacheId(frame, prefix);
                // see if we can find a suitable candidate in the shared frames
                // if successful, ref and insert, otherwise create a new one
                // and insert that into both the shared frames and our frames.
                FrameData *maskFrame = s_sharedFrames.value(key);

                if (maskFrame) {
                    maskFrame->ref(q);
                } else {
                    maskFrame = new FrameData(*frame, q);
                    s_sharedFrames.insert(key, maskFrame);
                }

                frames.insert(prefix, maskFrame);
                updateSizes();
            }

            FrameData *maskFrame = frames[prefix];
            if (maskFrame->cachedBackground.isNull() || maskFrame->frameSize != frameSize(frame)) {
                const QString oldKey = cacheId(maskFrame, prefix);
                maskFrame->frameSize = frameSize(frame).toSize();
                const QString newKey = cacheId(maskFrame, prefix);
                if (s_sharedFrames.contains(oldKey)) {
                    s_sharedFrames.remove(oldKey);
                    s_sharedFrames.insert(newKey, maskFrame);
                }

                maskFrame->cachedBackground = QPixmap();

                generateBackground(maskFrame);
                if (maskFrame->cachedBackground.isNull())
                    return QPixmap();
            }

            prefix = oldPrefix;
            return maskFrame->cachedBackground;
        }
    }

    void FrameSvgPrivate::generateBackground(FrameData *frame)
    {
        if (!frame->cachedBackground.isNull() || !q->hasElementPrefix(q->prefix())) {
            return;
        }

        const QString id = cacheId(frame, prefix);

        Theme *theme = Theme::defaultTheme();
        bool frameCached = !frame->cachedBackground.isNull();
        bool overlayCached = false;
        const bool overlayAvailable = !prefix.startsWith(QLatin1String("mask-")) && q->hasElement(prefix % "overlay");
        QPixmap overlay;
        if (q->isUsingRenderingCache()) {
            frameCached = theme->findInCache(id, frame->cachedBackground) && !frame->cachedBackground.isNull();

            if (overlayAvailable)
                overlayCached = theme->findInCache("overlay_" % id, overlay) && !overlay.isNull();
        }

        if (!frameCached) {
            generateFrameBackground(frame);
        }

        // Overlays
        QSize overlaySize;
        QPoint actualOverlayPos = QPoint(0, 0);
        if (overlayAvailable && !overlayCached) {
            QPoint pos = QPoint(0, 0);
            overlaySize = q->elementSize(prefix % "overlay");

            if (q->hasElement(prefix % "hint-overlay-pos-right")) {
                actualOverlayPos.setX(frame->frameSize.width() - overlaySize.width());
            } else if (q->hasElement(prefix % "hint-overlay-pos-bottom")) {
                actualOverlayPos.setY(frame->frameSize.height() - overlaySize.height());
                // Stretched or Tiled?
            } else if (q->hasElement(prefix % "hint-overlay-stretch")) {
                overlaySize = frameSize(frame).toSize();
            } else {
                if (q->hasElement(prefix % "hint-overlay-tile-horizontal")) {
                    overlaySize.setWidth(frameSize(frame).width());
                }
                if (q->hasElement(prefix % "hint-overlay-tile-vertical")) {
                    overlaySize.setHeight(frameSize(frame).height());
                }
            }

            overlay = alphaMask();
            QPainter overlayPainter(&overlay);
            overlayPainter.setCompositionMode(QPainter::CompositionMode_SourceIn);
            // Tiling?
            if (q->hasElement(prefix % "hint-overlay-tile-horizontal") ||
                    q->hasElement(prefix % "hint-overlay-tile-vertical")) {

                QSize s = q->size();
                q->resize(q->elementSize(prefix % "overlay"));

                overlayPainter.drawTiledPixmap(QRect(QPoint(0, 0), overlaySize), q->pixmap(prefix % "overlay"));
                q->resize(s);
            } else {
                q->paint(&overlayPainter, QRect(actualOverlayPos, overlaySize), prefix % "overlay");
            }

            overlayPainter.end();
        }

        if (!frameCached) {
            cacheFrame(prefix, frame->cachedBackground, overlayCached ? overlay : QPixmap());
        }

        if (!overlay.isNull()) {
            QPainter p(&frame->cachedBackground);
            p.setCompositionMode(QPainter::CompositionMode_SourceOver);
            p.drawPixmap(actualOverlayPos, overlay, QRect(actualOverlayPos, overlaySize));
        }
    }

    void FrameSvgPrivate::generateFrameBackground(FrameData *frame)
    {
        //qDebug() << "generating background";
        const QSizeF size = frameSize(frame);
        const int topWidth = q->elementSize(prefix % "top").width();
        const int leftHeight = q->elementSize(prefix % "left").height();
        const int topOffset = 0;
        const int leftOffset = 0;


        if (!size.isValid()) {
#ifdef DEBUG
            qDebug() << "Invalid frame size" << size;
#endif
            return;
        }
        if (size.width() >= MAX_FRAME_SIZE || size.height() >= MAX_FRAME_SIZE) {
            qWarning() << "Not generating frame background for a size whose width or height is more than" << MAX_FRAME_SIZE << size;
            return;
        }

        const int contentWidth = size.width() - frame->leftWidth  - frame->rightWidth;
        const int contentHeight = size.height() - frame->topHeight  - frame->bottomHeight;
        int contentTop = 0;
        int contentLeft = 0;
        int rightOffset = contentWidth;
        int bottomOffset = contentHeight;

        frame->cachedBackground = QPixmap(frame->leftWidth + contentWidth + frame->rightWidth,
                                          frame->topHeight + contentHeight + frame->bottomHeight);
        frame->cachedBackground.fill(Qt::transparent);
        QPainter p(&frame->cachedBackground);
        p.setCompositionMode(QPainter::CompositionMode_Source);
        p.setRenderHint(QPainter::SmoothPixmapTransform);

        //CENTER
        if (frame->tileCenter) {
            if (contentHeight > 0 && contentWidth > 0) {
                const int centerTileHeight = q->elementSize(prefix % "center").height();
                const int centerTileWidth = q->elementSize(prefix % "center").width();
                QPixmap center(centerTileWidth, centerTileHeight);
                center.fill(Qt::transparent);

                {
                    QPainter centerPainter(&center);
                    centerPainter.setCompositionMode(QPainter::CompositionMode_Source);
                    q->paint(&centerPainter, QRect(QPoint(0, 0), q->elementSize(prefix % "center")), prefix % "center");
                }

                if (frame->composeOverBorder) {
                    p.drawTiledPixmap(QRect(QPoint(0, 0), size.toSize()), center);
                } else {
                    p.drawTiledPixmap(QRect(frame->leftWidth, frame->topHeight,
                                            contentWidth, contentHeight), center);
                }
            }
        } else {
            if (contentHeight > 0 && contentWidth > 0) {
                if (frame->composeOverBorder) {
                    q->paint(&p, QRect(QPoint(0, 0), size.toSize()),
                             prefix % "center");
                } else {
                    q->paint(&p, QRect(frame->leftWidth, frame->topHeight,
                                       contentWidth, contentHeight),
                             prefix % "center");
                }
            }
        }

        if (frame->composeOverBorder) {
            p.setCompositionMode(QPainter::CompositionMode_DestinationIn);
            p.drawPixmap(QRect(QPoint(0, 0), size.toSize()), alphaMask());
            p.setCompositionMode(QPainter::CompositionMode_SourceOver);
        }

        if (frame->enabledBorders & FrameSvg::LeftBorder && q->hasElement(prefix % "left"))
            rightOffset += frame->leftWidth;

        // Corners
        if (frame->enabledBorders & FrameSvg::TopBorder && q->hasElement(prefix % "top")) {
            contentTop = frame->topHeight;
            bottomOffset += frame->topHeight;

            if (q->hasElement(prefix % "topleft") && frame->enabledBorders & FrameSvg::LeftBorder) {
                q->paint(&p, QRect(leftOffset, topOffset, frame->leftWidth, frame->topHeight), prefix % "topleft");

                contentLeft = frame->leftWidth;
            }

            if (q->hasElement(prefix % "topright") && frame->enabledBorders & FrameSvg::RightBorder)
                q->paint(&p, QRect(rightOffset, topOffset, frame->rightWidth, frame->topHeight), prefix % "topright");
        }

        if (frame->enabledBorders & FrameSvg::BottomBorder && q->hasElement(prefix % "bottom")) {
            if (q->hasElement(prefix % "bottomleft") && frame->enabledBorders & FrameSvg::LeftBorder) {
                q->paint(&p, QRect(leftOffset, bottomOffset, frame->leftWidth, frame->bottomHeight), prefix % "bottomleft");

                contentLeft = frame->leftWidth;
            }

            if (frame->enabledBorders & FrameSvg::RightBorder && q->hasElement(prefix % "bottomright")) {
                q->paint(&p, QRect(rightOffset, bottomOffset, frame->rightWidth, frame->bottomHeight), prefix % "bottomright");
            }
        }

        // Sides
        if (frame->stretchBorders) {
            if (frame->enabledBorders & FrameSvg::LeftBorder || frame->enabledBorders & FrameSvg::RightBorder) {
                if (q->hasElement(prefix % "left") &&
                        frame->enabledBorders & FrameSvg::LeftBorder) {
                    q->paint(&p, QRect(leftOffset, contentTop, frame->leftWidth, contentHeight), prefix % "left");
                }

                if (q->hasElement(prefix % "right") &&
                        frame->enabledBorders & FrameSvg::RightBorder) {
                    q->paint(&p, QRect(rightOffset, contentTop, frame->rightWidth, contentHeight), prefix % "right");
                }
            }

            if (frame->enabledBorders & FrameSvg::TopBorder || frame->enabledBorders & FrameSvg::BottomBorder) {
                if (frame->enabledBorders & FrameSvg::TopBorder && q->hasElement(prefix % "top")) {
                    q->paint(&p, QRect(contentLeft, topOffset, contentWidth, frame->topHeight), prefix % "top");
                }

                if (frame->enabledBorders & FrameSvg::BottomBorder && q->hasElement(prefix % "bottom")) {
                    q->paint(&p, QRect(contentLeft, bottomOffset, contentWidth, frame->bottomHeight), prefix % "bottom");
                }
            }
        } else {
            if (frame->enabledBorders & FrameSvg::LeftBorder && q->hasElement(prefix % "left")
                    && leftHeight > 0 && frame->leftWidth > 0) {
                QPixmap left(frame->leftWidth, leftHeight);
                left.fill(Qt::transparent);

                QPainter sidePainter(&left);
                sidePainter.setCompositionMode(QPainter::CompositionMode_Source);
                q->paint(&sidePainter, QRect(QPoint(0, 0), left.size()), prefix % "left");

                p.drawTiledPixmap(QRect(leftOffset, contentTop, frame->leftWidth, contentHeight), left);
            }

            if (frame->enabledBorders & FrameSvg::RightBorder && q->hasElement(prefix % "right") &&
                    leftHeight > 0 && frame->rightWidth > 0) {
                QPixmap right(frame->rightWidth, leftHeight);
                right.fill(Qt::transparent);

                QPainter sidePainter(&right);
                sidePainter.setCompositionMode(QPainter::CompositionMode_Source);
                q->paint(&sidePainter, QRect(QPoint(0, 0), right.size()), prefix % "right");

                p.drawTiledPixmap(QRect(rightOffset, contentTop, frame->rightWidth, contentHeight), right);
            }

            if (frame->enabledBorders & FrameSvg::TopBorder && q->hasElement(prefix % "top")
                    && topWidth > 0 && frame->topHeight > 0) {
                QPixmap top(topWidth, frame->topHeight);
                top.fill(Qt::transparent);

                QPainter sidePainter(&top);
                sidePainter.setCompositionMode(QPainter::CompositionMode_Source);
                q->paint(&sidePainter, QRect(QPoint(0, 0), top.size()), prefix % "top");

                p.drawTiledPixmap(QRect(contentLeft, topOffset, contentWidth, frame->topHeight), top);
            }

            if (frame->enabledBorders & FrameSvg::BottomBorder && q->hasElement(prefix % "bottom")
                    && topWidth > 0 && frame->bottomHeight > 0) {
                QPixmap bottom(topWidth, frame->bottomHeight);
                bottom.fill(Qt::transparent);

                QPainter sidePainter(&bottom);
                sidePainter.setCompositionMode(QPainter::CompositionMode_Source);
                q->paint(&sidePainter, QRect(QPoint(0, 0), bottom.size()), prefix % "bottom");

                p.drawTiledPixmap(QRect(contentLeft, bottomOffset, contentWidth, frame->bottomHeight), bottom);
            }
        }
    }

    QString FrameSvgPrivate::cacheId(FrameData *frame, const QString &prefixToSave) const
    {
        const QSize size = frameSize(frame).toSize();
        const QLatin1Char s('_');
        return QString::number(frame->enabledBorders) % s % QString::number(size.width()) % s % QString::number(size.height()) % s % prefixToSave % s % q->imagePath();
    }

    void FrameSvgPrivate::cacheFrame(const QString &prefixToSave, const QPixmap &background, const QPixmap &overlay)
    {
        if (!q->isUsingRenderingCache())
            return;

        //insert background
        FrameData *frame = frames.value(prefixToSave);

        if (!frame)
            return;

        const QString id = cacheId(frame, prefixToSave);

        //qDebug()<<"Saving to cache frame"<<id;

        Theme::defaultTheme()->insertIntoCache(id, background, QString::number((qint64)q, 16) % prefixToSave);

        if (!overlay.isNull()) {
            // Insert overlay into cache
            Theme::defaultTheme()->insertIntoCache("overlay_" % id, overlay,
                                                   QString::number((qint64)q, 16) % prefixToSave % "overlay");
        }
    }

    void FrameSvgPrivate::updateSizes() const
    {
        //qDebug() << "!!!!!!!!!!!!!!!!!!!!!! updating sizes" << prefix;
        FrameData *frame = frames[prefix];
        Q_ASSERT(frame);

        QSize s = q->size();
        q->resize();
        frame->cachedBackground = QPixmap();

        if (frame->enabledBorders & FrameSvg::TopBorder) {
            frame->topHeight = q->elementSize(prefix % "top").height();

            if (q->hasElement(prefix % "hint-top-margin")) {
                frame->topMargin = q->elementSize(prefix % "hint-top-margin").height();
            } else {
                frame->topMargin = frame->topHeight;
            }
        } else {
            frame->topMargin = frame->topHeight = 0;
        }

        if (frame->enabledBorders & FrameSvg::LeftBorder) {
            frame->leftWidth = q->elementSize(prefix % "left").width();

            if (q->hasElement(prefix % "hint-left-margin")) {
                frame->leftMargin = q->elementSize(prefix % "hint-left-margin").width();
            } else {
                frame->leftMargin = frame->leftWidth;
            }
        } else {
            frame->leftMargin = frame->leftWidth = 0;
        }

        if (frame->enabledBorders & FrameSvg::RightBorder) {
            frame->rightWidth = q->elementSize(prefix % "right").width();

            if (q->hasElement(prefix % "hint-right-margin")) {
                frame->rightMargin = q->elementSize(prefix % "hint-right-margin").width();
            } else {
                frame->rightMargin = frame->rightWidth;
            }
        } else {
            frame->rightMargin = frame->rightWidth = 0;
        }

        if (frame->enabledBorders & FrameSvg::BottomBorder) {
            frame->bottomHeight = q->elementSize(prefix % "bottom").height();

            if (q->hasElement(prefix % "hint-bottom-margin")) {
                frame->bottomMargin = q->elementSize(prefix % "hint-bottom-margin").height();
            } else {
                frame->bottomMargin = frame->bottomHeight;
            }
        } else {
            frame->bottomMargin = frame->bottomHeight = 0;
        }

        frame->composeOverBorder = (q->hasElement(prefix % "hint-compose-over-border") &&
                                    q->hasElement("mask-" % prefix % "center"));

        //since it's rectangular, topWidth and bottomWidth must be the same
        //the ones that don't have a prefix is for retrocompatibility
        frame->tileCenter = (q->hasElement("hint-tile-center") || q->hasElement(prefix % "hint-tile-center"));
        frame->noBorderPadding = (q->hasElement("hint-no-border-padding") || q->hasElement(prefix % "hint-no-border-padding"));
        frame->stretchBorders = (q->hasElement("hint-stretch-borders") || q->hasElement(prefix % "hint-stretch-borders"));
        q->resize(s);
    }

    void FrameSvgPrivate::updateNeeded()
    {
        q->clearCache();
        updateSizes();
    }

    void FrameSvgPrivate::updateAndSignalSizes()
    {
        updateSizes();
        emit q->repaintNeeded();
    }

    QSizeF FrameSvgPrivate::frameSize(FrameData *frame) const
    {
        if (!frame->frameSize.isValid()) {
            updateSizes();
            frame->frameSize = q->size();
        }

        return frame->frameSize;
    }

    void FrameData::ref(FrameSvg *svg)
    {
        references[svg] = references[svg] + 1;
        //qDebug() << this << svg << references[svg];
    }

    bool FrameData::deref(FrameSvg *svg)
    {
        references[svg] = references[svg] - 1;
        //qDebug() << this << svg << references[svg];
        if (references[svg] < 1) {
            references.remove(svg);
        }

        return references.isEmpty();
    }

    bool FrameData::removeRefs(FrameSvg *svg)
    {
        references.remove(svg);
        return references.isEmpty();
    }

    bool FrameData::isUsed() const
    {
        return !references.isEmpty();
    }

    int FrameData::refcount() const
    {
        return references.count();
    }
}

#include "moc_framesvg.cpp"
