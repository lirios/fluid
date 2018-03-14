TARGET = fluidcontrolsplugin
TARGETPATH = Fluid/Controls
IMPORT_VERSION = 1.0

QT += qml quick quickcontrols2 svg

HEADERS += \
    $$files($$PWD/*.h)

SOURCES += \
    $$files($$PWD/*.cpp)

QML_FILES += \
    $$files(*.qml)

INCLUDEPATH += $$PWD

CONFIG += no_cxx_module
load(qml_plugin)

contains(CONFIG, fluid_resource_icons) {
    DEFINES += FLUID_INSTALL_ICONS=0
    RESOURCES += icons.qrc
} else {
    DEFINES += FLUID_INSTALL_ICONS=1

    icons.path = $$target.path/icons
    icons.files += $$PWD/icons/action
    icons.files += $$PWD/icons/alert
    icons.files += $$PWD/icons/av
    icons.files += $$PWD/icons/communication
    icons.files += $$PWD/icons/content
    icons.files += $$PWD/icons/device
    icons.files += $$PWD/icons/editor
    icons.files += $$PWD/icons/file
    icons.files += $$PWD/icons/hardware
    icons.files += $$PWD/icons/image
    icons.files += $$PWD/icons/maps
    icons.files += $$PWD/icons/navigation
    icons.files += $$PWD/icons/notification
    icons.files += $$PWD/icons/places
    icons.files += $$PWD/icons/social
    icons.files += $$PWD/icons/toggle
    INSTALLS += icons

    icons2build.files = $$icons.files
    icons2build.path = $$DESTDIR/icons
    COPIES += icons2build
}

# Copy all files to the build directory so that QtCreator will recognize
# the QML module and the demo will run without installation
qmlfiles2build.files = $$QML_FILES
qmlfiles2build.path = $$DESTDIR
COPIES += qmlfiles2build
