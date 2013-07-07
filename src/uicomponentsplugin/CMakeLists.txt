add_definitions(-DQT_PLUGIN)

set(SOURCES
    uicomponentsplugin.cpp
)

add_library(fluiduicomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluiduicomponentsplugin Qml)

# Install plugin
install(TARGETS fluiduicomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)

# QML code
add_subdirectory(qml)
