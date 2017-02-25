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

#include <QtQml>

#include "iconthemeimageprovider.h"

class FluidControlsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
    void initializeEngine(QQmlEngine *engine, const char *uri);
    void registerTypes(const char *uri);
};

void FluidControlsPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QByteArray(uri) == QByteArrayLiteral("Fluid.Controls"));

    engine->addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());
}

void FluidControlsPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QByteArray(uri) == QByteArrayLiteral("Fluid.Controls"));

    // @uri Fluid.Controls
}

#include "controlsplugin.moc"
