include_directories(
    ${Qt5Qml_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
)

add_definitions(
    ${Qt5Qml_DEFINITIONS}
    ${Qt5Quick_DEFINITIONS}
    -DQT_PLUGIN
)

set(SOURCES
    extracomponentsplugin.cpp
    qiconitem.cpp
    qimageitem.cpp
    qpixmapitem.cpp
)

add_library(fluidextracomponentsplugin SHARED ${SOURCES})
target_link_libraries(fluidextracomponentsplugin
    ${Qt5Qml_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
)

# Install plugin
install(TARGETS fluidextracomponentsplugin LIBRARY DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidExtra)
install(FILES qmldir DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidExtra)
