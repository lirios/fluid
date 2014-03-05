add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    standardpaths.cpp
)

add_library(declarative_fluidcore SHARED ${SOURCES})
qt5_use_modules(declarative_fluidcore Qml)

set(FILES
    qmldir
)

install(TARGETS declarative_fluidcore LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/hawaii/qml/Fluid/Core)
install(FILES ${FILES}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/hawaii/qml/Fluid/Core)
