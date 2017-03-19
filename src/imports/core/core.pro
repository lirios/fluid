TARGET = fluidcoreplugin
TARGETPATH = Fluid/Core
IMPORT_VERSION = 1.0

QT += qml quick Fluid

QML_FILES += \
    $$files(*.qml)

include(core.pri)

CONFIG += no_cxx_module
load(liri_qml_plugin)

android {
    qmlfiles2build.files = $$QML_FILES
    qmlfiles2build.path = $$DESTDIR
    COPIES += qmlfiles2build
}
