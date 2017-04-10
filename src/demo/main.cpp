/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

#ifdef FLUID_LOCAL
#  include "../imports/core/iconsimageprovider.h"
#  include "../imports/controls/iconthemeimageprovider.h"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    if (QQuickStyle::name().isEmpty())
        QQuickStyle::setStyle(QLatin1String("Material"));

    QQmlApplicationEngine engine;
#ifdef FLUID_LOCAL
    engine.addImportPath(QLatin1String("qrc:/"));
    engine.addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
    engine.addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());
#endif
    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));

    return app.exec();
}
