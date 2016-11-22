/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QtCore/QDir>
#include <QtGui/QIcon>
#include <QtQml/QQmlEngine>

#include "iconsimageprovider.h"

IconsImageProvider::IconsImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
}

QPixmap IconsImageProvider::requestPixmap(const QString &id, QSize *realSize,
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

#ifdef FLUID_LOCAL
    return QPixmap(QLatin1String("qrc:/Fluid/Controls/") + id).scaled(size, Qt::KeepAspectRatio, Qt::SmoothTransformation);
#else
    const QString targetPath = QStringLiteral("Fluid/Controls/icons");
    const QStringList importPaths = QQmlEngine().importPathList();

    for (const QString &importPath: importPaths) {
        QDir dir(importPath);
        if (dir.exists(targetPath)) {
            QDir targetDir(dir.absoluteFilePath(targetPath));
            return QPixmap(targetDir.absoluteFilePath(id)).scaled(size, Qt::KeepAspectRatio, Qt::SmoothTransformation);
        }
    }

    return QPixmap();
#endif
}
