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

#include <QtQml/qqml.h>

#include "coreplugin.h"
#include "clipboard.h"
#include "device.h"
#include "dateutils.h"
#include "qqmlsortfilterproxymodel.h"
#include "standardpaths.h"
#include "utils.h"

static QObject *utilsProvider(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(jsEngine);

    return new Utils();
}


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

void FluidCorePlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String("Fluid.Core") == QLatin1String(uri));

    // @uri Fluid.Core

    qmlRegisterType<Clipboard>(uri, 1, 0, "Clipboard");

    qmlRegisterType<QAbstractItemModel>();
    qmlRegisterType<QQmlSortFilterProxyModel>(uri, 1, 0, "SortFilterProxyModel");

    qmlRegisterSingletonType<DateUtils>(uri, 1, 0, "DateUtils", dateUtilsProvider);
    qmlRegisterSingletonType<Device>(uri, 1, 0, "Device", deviceProvider);
    qmlRegisterSingletonType<StandardPaths>(uri, 1, 0, "StandardPaths", standardPathsProvider);
    qmlRegisterSingletonType<Utils>(uri, 1, 0, "Utils", utilsProvider);
}
