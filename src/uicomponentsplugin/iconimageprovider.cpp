/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2011-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

#include <QDebug>
#include <QIcon>

#include "iconimageprovider.h"

IconImageProvider::IconImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
}

QPixmap IconImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    // Special case for images whose full path was specified,
    // we just need to resize to the requested size
    if (id.startsWith("/") && id.length() > 1) {
        QPixmap icon(id);
        if (icon.isNull()) {
            qWarning() << "Failed to load icon from" << id;
            return QPixmap();
        }

        if (size)
            *size = icon.size();
        if (requestedSize.isValid())
            icon = icon.scaled(requestedSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);

        return icon;
    }

    QString iconName = id;

    // Fallback to normal icons when the symbolic version doesn't exist
    if (!QIcon::hasThemeIcon(iconName) && iconName.endsWith(QLatin1String("-symbolic"))) {
        iconName = iconName.replace(QLatin1String("-symbolic"), QLatin1String(""));
        qDebug() << "No" << id << "icon found, fallback to" << iconName;
    }

    // Perform icon lookup in the default theme
    QIcon icon = QIcon::fromTheme(iconName, QIcon::fromTheme(QLatin1String("unknown")));
    if (icon.isNull()) {
        qWarning() << "No valid icon for" << id;
        return QPixmap();
    }

    // Assume a default size if the requested size is not valid
    QSize iconSize = requestedSize;
    if (!iconSize.isValid())
        iconSize = QSize(256, 256);
    iconSize = icon.actualSize(iconSize);

    if (size)
        *size = iconSize;

    return icon.pixmap(iconSize);
}
