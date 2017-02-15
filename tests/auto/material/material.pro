CONFIG += qmltestcase
TARGET = tst_material

osx:CONFIG -= app_bundle

QT += testlib quickcontrols2

SOURCES += \
    $$PWD/material.cpp
