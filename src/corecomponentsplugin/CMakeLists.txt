include_directories(
    ${Qt5Qml_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
)

add_definitions(
    ${Qt5Qml_DEFINITIONS}
    -DQT_PLUGIN
)

set(SOURCES
    corecomponentsplugin.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
target_link_libraries(fluidcorecomponentsplugin
    ${Qt5Qml_LIBRARIES}
    FluidCore
)

# Install plugin
install(TARGETS fluidcorecomponentsplugin LIBRARY DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidCore)
install(FILES qmldir DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidCore)
