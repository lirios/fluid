TARGET = fluidcoreplugin
TARGETPATH = Fluid/Core
IMPORT_VERSION = 1.0

QT += qml quick svg

HEADERS += \
    $$PWD/clipboard.h \
    $$PWD/device.h \
    $$PWD/iconsimageprovider.h \
    $$PWD/qmldateutils.h \
    $$PWD/qqmlsortfilterproxymodel.h \
    $$PWD/standardpaths.h \
    $$PWD/windowdecoration.h \
    $$PWD/coreplugin.h

SOURCES += \
    $$PWD/clipboard.cpp \
    $$PWD/device.cpp \
    $$PWD/iconsimageprovider.cpp \
    $$PWD/qmldateutils.cpp \
    $$PWD/qqmlsortfilterproxymodel.cpp \
    $$PWD/standardpaths.cpp \
    $$PWD/windowdecoration.cpp \
    $$PWD/coreplugin.cpp

QML_FILES += \
    $$files($$PWD/*.qml)

INCLUDEPATH += $$PWD

CONFIG += no_cxx_module
load(qml_plugin)

# Copy all files to the build directory so that QtCreator will recognize
# the QML module and the demo will run without installation
qmlfiles2build.files = $$QML_FILES
qmlfiles2build.path = $$DESTDIR
COPIES += qmlfiles2build
