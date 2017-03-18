TEMPLATE = app
TARGET = fluid-demo

QT += gui qml quick quickcontrols2

SOURCES += main.cpp
RESOURCES += demo.qrc

OTHER_FILES += \
    $$files(qml/*.qml) \
    $$files(qml/+material/*.qml) \
    $$files(qml/+universal/*.qml) \
    $$files(qml/Pages/Basic/*.qml) \
    $$files(qml/Pages/Compound/*.qml) \
    $$files(qml/Pages/Style/*.qml) \
    $$files(qml/Pages/Layouts/*.qml) \
    $$files(qml/Pages/Material/*.qml) \
    $$files(qml/Pages/Navigation/*.qml)

load(liri_qt_app)

android {
    DISTFILES += \
        android/AndroidManifest.xml \
        android/res/drawable/splash.xml \
        android/res/values/libs.xml \
        android/build.gradle

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    ANDROID_EXTRA_LIBS = $$FLUID_BUILD_DIR/lib/libFluid.so

    QML_IMPORT_PATH = $$FLUID_BUILD_DIR/qml
}
