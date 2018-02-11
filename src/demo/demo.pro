TEMPLATE = app

QT += qml quick quickcontrols2

TARGET = demo

HEADERS += \
    $$PWD/iconcategorymodel.h \
    $$PWD/iconnamemodel.h

SOURCES += \
    $$PWD/iconcategorymodel.cpp \
    $$PWD/iconnamemodel.cpp \
    $$PWD/main.cpp

RESOURCES += demo.qrc

INCLUDEPATH += $$PWD


