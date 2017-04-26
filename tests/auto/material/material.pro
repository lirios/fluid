CONFIG += qmltestcase
TARGET = tst_material

osx:CONFIG -= app_bundle

QT += testlib quickcontrols2

# Use the library from the build directory
QT += Fluid

SOURCES += \
    $$PWD/material.cpp

IMPORTPATH = $$FLUID_BUILD_DIR/qml
