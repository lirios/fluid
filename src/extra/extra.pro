QT += qml quick

TARGET = fluidextra
TARGETPATH = FluidExtra

SOURCES += \
    extracomponentsplugin.cpp \
    qiconitem.cpp \
    qimageitem.cpp \
    qpixmapitem.cpp

load(qml_plugin)
