TARGET = fluidtemplatesplugin
TARGETPATH = Fluid/Templates
IMPORT_VERSION = 1.0

QT += qml quick

HEADERS += \
    $$files($$PWD/*.h)

SOURCES += \
    $$files($$PWD/*.cpp)

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
