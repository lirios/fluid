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

#ifndef STANDARDPATHS_H
#define STANDARDPATHS_H

#include <QObject>

class StandardPaths : public QObject
{
    Q_OBJECT
public:
    enum StandardLocation {
        DesktopLocation,
        DocumentsLocation,
        FontsLocation,
        ApplicationsLocation,
        MusicLocation,
        MoviesLocation,
        PicturesLocation,
        TempLocation,
        HomeLocation,
        DataLocation,
        CacheLocation,
        GenericDataLocation,
        RuntimeLocation,
        ConfigLocation,
        DownloadLocation,
        GenericCacheLocation,
        GenericConfigLocation
    };
    Q_ENUM(StandardLocation)

    explicit StandardPaths(QObject *parent = nullptr);

    Q_INVOKABLE QString locateFile(StandardLocation type, const QString &fileName);
    Q_INVOKABLE QString locateDirectory(StandardLocation type, const QString &dirName);
};

#endif // STANDARDPATHS_H
