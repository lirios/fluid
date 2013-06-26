include_directories(
    ${VibeCore_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/Fluid
    ${CMAKE_BINARY_DIR}/src/fluid
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    corecomponentsplugin.cpp
    themeproxy.cpp
    settingsitem.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidcorecomponentsplugin Qml Quick)
target_link_libraries(fluidcorecomponentsplugin
    ${VibeCore_LIBRARIES}
    Fluid
)

install(TARGETS fluidcorecomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
