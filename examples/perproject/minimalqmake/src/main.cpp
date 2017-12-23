#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


#ifndef Q_OS_ANDROID
    qputenv("QML2_IMPORT_PATH", "../fluid/qml");
#endif

    QQmlApplicationEngine engine;

    engine.addImportPath(QLatin1String("../fluid/qml")) ;

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
