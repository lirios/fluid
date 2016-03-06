add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    standardpaths.cpp
)

add_library(fluidcore SHARED ${SOURCES})
target_link_libraries(fluidcore Qt5::Qml)

set(FILES
    qmldir
)

install(TARGETS fluidcore LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/hawaii/qml/Fluid/Core)
install(FILES ${FILES}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/hawaii/qml/Fluid/Core)
