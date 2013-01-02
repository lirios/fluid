include_directories(
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
    ${CMAKE_BINARY_DIR}/src/fluid
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    extracomponentsplugin.cpp
    fallbackcomponent.cpp
    qiconitem.cpp
    qimageitem.cpp
    qpixmapitem.cpp
)

add_library(fluidextracomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidextracomponentsplugin Qml Quick)

install(TARGETS fluidextracomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidExtra)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidExtra)
