add_definitions(-DQT_PLUGIN)

set(SOURCES
    extracomponentsplugin.cpp
    qiconitem.cpp
    qimageitem.cpp
    qpixmapitem.cpp
)

add_library(fluidextracomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidextracomponentsplugin Qml Quick)

install(TARGETS fluidextracomponentsplugin LIBRARY
    DESTINATION ${QT_IMPORTS_DIR}/FluidExtra)
install(FILES qmldir
    DESTINATION ${QT_IMPORTS_DIR}/FluidExtra)
