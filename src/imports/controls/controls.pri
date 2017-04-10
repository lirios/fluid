HEADERS += \
    $$PWD/iconthemeimageprovider.h \
    $$PWD/controlsplugin.h

SOURCES += \
    $$PWD/iconthemeimageprovider.cpp \
    $$PWD/controlsplugin.cpp

INCLUDEPATH += $$PWD

contains(DEFINES, FLUID_LOCAL) {
    RESOURCES += $$PWD/controls.qrc
}
