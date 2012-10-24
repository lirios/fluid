/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2011-2012 Pier Luigi Fiorini
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

#include <QDebug>
#include <QIcon>

#include "iconimageprovider.h"

IconImageProvider::IconImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage IconImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    // Special case for images whose full path was specified,
    // we just need to resize to the requested size
    if (id.startsWith("/") && id.length() > 1) {
        QImage icon(id);
        if (icon.isNull()) {
            qWarning() << "Failed to load icon from" << id;
            return QImage();
        }

        if (requestedSize.isValid())
            icon = icon.scaled(requestedSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);

        if (size)
            *size = icon.size();
        return icon;
    }

    // Perform icon lookup in the default theme
    QIcon icon(QIcon::fromTheme(id, QIcon::fromTheme("unknown")));
    if (size)
        *size = icon.actualSize(requestedSize);
    return QImage(icon.pixmap(requestedSize).toImage());
}
