CONFIG += console
TARGET = tst_fluid

osx:CONFIG -= app_bundle

QT += testlib

# Use the library from the build directory
QT += Fluid

SOURCES += \
    $$PWD/tst_fluid.cpp
