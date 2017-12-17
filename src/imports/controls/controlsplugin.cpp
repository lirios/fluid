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

#include <QIcon>

#include "controlsplugin.h"
#include "iconthemeimageprovider.h"

void FluidControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Fluid.Controls"));

    // For system icons
    engine->addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());

    // For Material Design icons
    QStringList paths = QIcon::themeSearchPaths();
    paths.append(QLatin1String(":/Fluid/Controls/icons"));
    QIcon::setThemeSearchPaths(paths);
    QIcon::setThemeName(QLatin1String("fluid"));
}

void FluidControlsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Fluid.Controls"));
}
