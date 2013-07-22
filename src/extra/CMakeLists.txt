add_definitions(-DQT_PLUGIN)

set(SOURCES
    extracomponentsplugin.cpp
    qiconitem.cpp
    qimageitem.cpp
    qpixmapitem.cpp
)

add_library(declarative_fluidextra SHARED ${SOURCES})
qt5_use_modules(declarative_fluidextra Qml Quick)

install(TARGETS declarative_fluidextra LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml/FluidExtra)
install(FILES qmldir
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml/FluidExtra)
