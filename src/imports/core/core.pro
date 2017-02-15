TARGET = fluidcoreplugin
TARGETPATH = Fluid/Core
IMPORT_VERSION = 1.0

QT += qml quick Fluid

QML_FILES += \
    Object.qml \
    PlatformExtensions.qml \
    Utils.qml

include(core.pri)

CONFIG += no_cxx_module
load(liri_qml_plugin)
