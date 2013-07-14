QT += qml quick

TARGET = fluidcore
TARGETPATH = FluidCore

SOURCES += \
    corecomponentsplugin.cpp \
    qqmlsettings.cpp

load(qml_plugin)
