TARGET = Fluid
MODULE = Fluid

QT += core
QT_PRIVATE += core-private

CMAKE_MODULE_NAME = Fluid
CMAKE_MODULE_NAMESPACE = Fluid
CONFIG += liri_create_cmake

HEADERS += \
    fluidglobal.h

include(fluid.pri)

QMAKE_PKGCONFIG_NAME = Fluid
QMAKE_PKGCONFIG_DESCRIPTION = Fluid
QMAKE_PKGCONFIG_VERSION = $$Fluid_VERSION
QMAKE_PKGCONFIG_DESTDIR = pkgconfig

load(liri_qt_module)
