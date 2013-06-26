include_directories(
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
    ${CMAKE_BINARY_DIR}/src/fluid
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    uicomponentsplugin.cpp
)

add_library(fluiduicomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluiduicomponentsplugin Qml)
target_link_libraries(fluiduicomponentsplugin Fluid)

# Install plugin
install(TARGETS fluiduicomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)

# QML and JavaScript code
#add_subdirectory(qml)
