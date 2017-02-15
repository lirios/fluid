TARGET = fluidmaterialplugin
TARGETPATH = Fluid/Material
IMPORT_VERSION = 1.0

QT += qml quick

QML_FILES += \
    ActionButton.qml \
    ElevationEffect.qml \
    Ripple.qml \
    Wave.qml

CONFIG += no_cxx_module
load(liri_qml_plugin)
