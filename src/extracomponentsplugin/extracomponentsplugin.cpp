/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include "extracomponentsplugin.h"
#include "qpixmapitem.h"
#include "qimageitem.h"
#include "qiconitem.h"

void ExtraComponentsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("FluidExtra"));

    qmlRegisterType<QPixmapItem>(uri, 1, 0, "PixmapItem");
    qmlRegisterType<QImageItem>(uri, 1, 0, "ImageItem");
    qmlRegisterType<QIconItem>(uri, 1, 0, "IconItem");
}

#include "moc_extracomponentsplugin.cpp"
