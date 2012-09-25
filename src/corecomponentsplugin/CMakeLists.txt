include_directories(
    ${Qt5Qml_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/Fluid
)

add_definitions(
    ${Qt5Qml_DEFINITIONS}
    ${Qt5Quick_DEFINITIONS}
    -DQT_PLUGIN
)

set(SOURCES
    corecomponentsplugin.cpp
    framesvgitem.cpp
    svgitem.cpp
    themeproxy.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
target_link_libraries(fluidcorecomponentsplugin
    ${Qt5Qml_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
    Fluid
)

# Install plugin
install(TARGETS fluidcorecomponentsplugin LIBRARY DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidCore)
install(FILES qmldir DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidCore)
