TARGETPATH = Fluid/Effects
IMPORT_VERSION = 1.0

QML_FILES += \
    plugins.qmltypes \
    $$files(*.qml)

load(qml_module)

# Copy all files to the build directory so that QtCreator will recognize
# the QML module and the demo will run without installation
qmlfiles2build.files = $$QML_FILES
qmlfiles2build.path = $$DESTDIR
COPIES += qmlfiles2build
