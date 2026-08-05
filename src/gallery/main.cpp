// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setDesktopFileName("io.liri.Fluid.Gallery"_L1);
    app.setQuitOnLastWindowClosed(true);

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"_L1));

    return app.exec();
}
