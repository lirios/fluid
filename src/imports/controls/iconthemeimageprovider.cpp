/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QtGui/QIcon>

#include "iconthemeimageprovider.h"

IconThemeImageProvider::IconThemeImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
}

QPixmap IconThemeImageProvider::requestPixmap(const QString &id, QSize *realSize,
                                              const QSize &requestedSize)
{
    // Sanitize requested size
    QSize size(requestedSize);
    if (size.width() < 1)
        size.setWidth(1);
    if (size.height() < 1)
        size.setHeight(1);

    // Return real size
    if (realSize)
        *realSize = size;

    // Is it a path?
    if (id.startsWith(QLatin1Char('/')))
        return QPixmap(id).scaled(size);

    // Return icon from theme or fallback to a generic icon
    QIcon icon = QIcon::fromTheme(id);
    if (icon.isNull())
        icon = QIcon::fromTheme(QLatin1String("application-x-executable"));
    return icon.pixmap(size);
}
