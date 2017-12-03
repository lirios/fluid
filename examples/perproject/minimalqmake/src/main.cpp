#include <QGuiApplication>
#include <QQmlApplicationEngine>


#include "iconsimageprovider.h"
#include "iconthemeimageprovider.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath("../fluid/qml");

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
