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

#include <QtQml/QQmlExtensionPlugin>
#include <QtQml/qqml.h>

#include "clipboard.h"
#include "device.h"
#include "iconsimageprovider.h"
#include "qmldateutils.h"
#include "qqmlsortfilterproxymodel.h"
#include "standardpaths.h"

static QObject *dateUtilsProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new DateUtils();
}

static QObject *deviceProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new Device();
}

static QObject *standardPathsProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new StandardPaths();
}

class FluidCorePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
    void initializeEngine(QQmlEngine *engine, const char *uri);
    void registerTypes(const char *uri);
};

void FluidCorePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QByteArray(uri) == QByteArrayLiteral("Fluid.Core"));

    engine->addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
}

void FluidCorePlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QByteArray("Fluid.Core") == QByteArray(uri));

    // @uri Fluid.Core

    qmlRegisterType<Clipboard>(uri, 1, 0, "Clipboard");

    qmlRegisterType<QAbstractItemModel>();
    qmlRegisterType<QQmlSortFilterProxyModel>(uri, 1, 0, "SortFilterProxyModel");

    qmlRegisterSingletonType<DateUtils>(uri, 1, 0, "DateUtils", dateUtilsProvider);
    qmlRegisterSingletonType<Device>(uri, 1, 0, "Device", deviceProvider);
    qmlRegisterSingletonType<StandardPaths>(uri, 1, 0, "StandardPaths", standardPathsProvider);
}

#ifdef FLUID_LOCAL
static void registerFluidCoreTypes() {
    FluidCorePlugin fluidCore;
    fluidCore.registerTypes("Fluid.Core");
}

Q_COREAPP_STARTUP_FUNCTION(registerFluidCoreTypes)
#endif

#include "coreplugin.moc"
