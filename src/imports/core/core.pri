QT += svg

HEADERS += \
    $$PWD/clipboard.h \
    $$PWD/device.h \
    $$PWD/iconsimageprovider.h \
    $$PWD/qmldateutils.h \
    $$PWD/qqmlsortfilterproxymodel.h \
    $$PWD/standardpaths.h \
    $$PWD/coreplugin.h

SOURCES += \
    $$PWD/clipboard.cpp \
    $$PWD/device.cpp \
    $$PWD/iconsimageprovider.cpp \
    $$PWD/qmldateutils.cpp \
    $$PWD/qqmlsortfilterproxymodel.cpp \
    $$PWD/standardpaths.cpp \
    $$PWD/coreplugin.cpp

INCLUDEPATH += $$PWD

contains(DEFINES, FLUID_LOCAL) {
    RESOURCES += $$PWD/core.qrc
    SOURCES += \
        $$PWD/registerplugins.cpp
    HEADERS += \
        $$PWD/registerplugins.h
}
