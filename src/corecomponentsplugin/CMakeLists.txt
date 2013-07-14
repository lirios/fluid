add_definitions(-DQT_PLUGIN)

set(SOURCES
    corecomponentsplugin.cpp
    qqmlsettings.cpp
)

add_library(fluidcorecomponentsplugin SHARED ${SOURCES})
qt5_use_modules(fluidcorecomponentsplugin Qml Quick)

install(TARGETS fluidcorecomponentsplugin LIBRARY
    DESTINATION ${QT_IMPORTS_DIR}/FluidCore)
install(FILES qmldir
    DESTINATION ${QT_IMPORTS_DIR}/FluidCore)
