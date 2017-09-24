CONFIG += qmltestcase
TARGET = tst_controls

osx:CONFIG -= app_bundle

QT += testlib

SOURCES += \
    $$PWD/controls.cpp

IMPORTPATH = $$FLUID_BUILD_DIR/qml
