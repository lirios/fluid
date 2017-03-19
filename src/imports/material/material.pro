TARGET = fluidmaterialplugin
TARGETPATH = Fluid/Material
IMPORT_VERSION = 1.0

QT += qml quick

QML_FILES += \
    $$files(*.qml)

CONFIG += no_cxx_module
load(liri_qml_plugin)

android {
    qmlfiles2build.files = $$QML_FILES
    qmlfiles2build.path = $$DESTDIR
    COPIES += qmlfiles2build
}
