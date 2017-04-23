TARGET = fluidcontrolsplugin
TARGETPATH = Fluid/Controls
IMPORT_VERSION = 1.0

QT += qml quick

QML_FILES += \
    $$files(*.qml) \
    $$files(+material/*.qml)

include(controls.pri)

CONFIG += no_cxx_module
load(liri_qml_plugin)

icons.path = $$target.path/icons
icons.files += $$FLUID_SOURCE_TREE/icons/action
icons.files += $$FLUID_SOURCE_TREE/icons/av
icons.files += $$FLUID_SOURCE_TREE/icons/communication
icons.files += $$FLUID_SOURCE_TREE/icons/device
icons.files += $$FLUID_SOURCE_TREE/icons/file
icons.files += $$FLUID_SOURCE_TREE/icons/image
icons.files += $$FLUID_SOURCE_TREE/icons/maps
icons.files += $$FLUID_SOURCE_TREE/icons/notification
icons.files += $$FLUID_SOURCE_TREE/icons/social
icons.files += $$FLUID_SOURCE_TREE/icons/toggle
icons.files += $$FLUID_SOURCE_TREE/icons/alert
icons.files += $$FLUID_SOURCE_TREE/icons/content
icons.files += $$FLUID_SOURCE_TREE/icons/editor
icons.files += $$FLUID_SOURCE_TREE/icons/hardware
icons.files += $$FLUID_SOURCE_TREE/icons/navigation
INSTALLS += icons

# Copy all files to the build directory so that QtCreator will recognize
# the QML module and the demo will run without installation
qmlfiles2build.files = $$QML_FILES
qmlfiles2build.path = $$DESTDIR
icons2build.files = $$icons.files
icons2build.path = $$DESTDIR/icons
COPIES += qmlfiles2build icons2build
