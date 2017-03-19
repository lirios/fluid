CONFIG += console
TARGET = tst_fluid

osx:CONFIG -= app_bundle

QT += testlib Fluid

SOURCES += \
    $$PWD/tst_fluid.cpp
