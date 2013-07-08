include_directories(
    ${VibeCore_INCLUDE_DIRS}
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    corecomponentsplugin.cpp
    qqmlsettings.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidcorecomponentsplugin Qml Quick)
target_link_libraries(fluidcorecomponentsplugin
    ${VibeCore_LIBRARIES}
)

install(TARGETS fluidcorecomponentsplugin LIBRARY
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
install(FILES qmldir
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidCore)
