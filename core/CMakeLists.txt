add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    clipboard.cpp
    device.cpp
    standardpaths.cpp
)

add_library(fluidcore SHARED ${SOURCES})
target_link_libraries(fluidcore Qt5::Gui Qt5::Qml)

set(FILES
    plugins.qmltypes
    qmldir
    Object.qml
    Utils.qml
)

install(TARGETS fluidcore LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
