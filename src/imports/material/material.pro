TARGET = fluidmaterialplugin
TARGETPATH = Fluid/Material
IMPORT_VERSION = 1.0

QT += qml quick

HEADERS += \
    $$PWD/materialplugin.h

SOURCES += \
    $$PWD/materialplugin.cpp

QML_FILES += \
    $$files(*.qml)

CONFIG += no_cxx_module
load(liri_qml_plugin)

# Copy all files to the build directory so that QtCreator will recognize
# the QML module and the demo will run without installation
qmlfiles2build.files = $$QML_FILES
qmlfiles2build.path = $$DESTDIR
COPIES += qmlfiles2build
