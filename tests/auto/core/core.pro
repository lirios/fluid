CONFIG += qmltestcase
TARGET = tst_core

osx:CONFIG -= app_bundle

QT += testlib

SOURCES += \
    $$PWD/core.cpp
