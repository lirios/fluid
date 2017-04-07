TARGET = Fluid
MODULE = Fluid

QT += core
QT_PRIVATE += core-private
CONFIG += liri_create_cmake

HEADERS += \
    fluidglobal.h

include(fluid.pri)

load(liri_qt_module)
