TARGET = fluideffectsplugin
TARGETPATH = Fluid/Effects
IMPORT_VERSION = 1.0

QT += qml quick

QML_FILES += \
    BoxShadow.qml \
    CircleMask.qml \
    Vignette.qml

CONFIG += no_cxx_module
load(liri_qml_plugin)
