CONFIG += qmltestcase
TARGET = tst_core

osx:CONFIG -= app_bundle

QT += testlib

# Use the library from the build directory
QT += Fluid

SOURCES += \
    $$PWD/core.cpp

IMPORTPATH = $$FLUID_BUILD_DIR/qml
