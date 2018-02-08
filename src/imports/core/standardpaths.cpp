/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QtCore/QStandardPaths>

#include "standardpaths.h"

StandardPaths::StandardPaths(QObject *parent)
    : QObject(parent)
{
}

QString StandardPaths::locateFile(StandardLocation type, const QString &fileName)
{
    QStandardPaths::StandardLocation qtype = static_cast<QStandardPaths::StandardLocation>(type);
    return QStandardPaths::locate(qtype, fileName);
}

QString StandardPaths::locateDirectory(StandardLocation type, const QString &dirName)
{
    QStandardPaths::StandardLocation qtype = static_cast<QStandardPaths::StandardLocation>(type);
    return QStandardPaths::locate(qtype, dirName, QStandardPaths::LocateDirectory);
}

#include "moc_standardpaths.cpp"
