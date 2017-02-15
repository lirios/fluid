HEADERS += \
    $$PWD/clipboard.h \
    $$PWD/device.h \
    $$PWD/iconsimageprovider.h \
    $$PWD/qmldateutils.h \
    $$PWD/qqmlsortfilterproxymodel.h \
    $$PWD/standardpaths.h

SOURCES += \
    $$PWD/clipboard.cpp \
    $$PWD/device.cpp \
    $$PWD/iconsimageprovider.cpp \
    $$PWD/plugin.cpp \
    $$PWD/qmldateutils.cpp \
    $$PWD/qqmlsortfilterproxymodel.cpp \
    $$PWD/standardpaths.cpp

RESOURCES += \
    $$PWD/core.qrc

INCLUDEPATH += $$PWD

QT += svg
