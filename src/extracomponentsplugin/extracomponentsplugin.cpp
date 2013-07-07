/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

#include "extracomponentsplugin.h"
#include "qpixmapitem.h"
#include "qimageitem.h"
#include "qiconitem.h"

void ExtraComponentsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidExtra"));

    qmlRegisterType<QPixmapItem>(uri, 0, 2, "PixmapItem");
    qmlRegisterType<QImageItem>(uri, 0, 2, "ImageItem");
    qmlRegisterType<QIconItem>(uri, 0, 2, "IconItem");
}

#include "moc_extracomponentsplugin.cpp"
