add_definitions(-DQT_PLUGIN)

set(SOURCES
    corecomponentsplugin.cpp
    qqmlsettings.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidcorecomponentsplugin Qml Quick)

install(TARGETS fluidcorecomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
