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

#include "color.h"
#include "controlsplugin.h"
#include "iconthemeimageprovider.h"
#include "utils.h"

static QObject *colorProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new Color();
}

static QObject *utilsProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new Utils();
}

void FluidControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Fluid.Controls"));

    // For system icons
    engine->addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());
}

void FluidControlsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Fluid.Controls"));

    qmlRegisterSingletonType<Color>(uri, 1, 0, "Color", colorProvider);
    qmlRegisterSingletonType<Utils>(uri, 1, 0, "Utils", utilsProvider);
}
