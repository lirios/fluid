CONFIG += qmltestcase
TARGET = tst_controls

osx:CONFIG -= app_bundle

QT += testlib

# Use the library from the build directory
QT += Fluid

SOURCES += \
    $$PWD/controls.cpp

IMPORTPATH = $$FLUID_BUILD_DIR/qml
