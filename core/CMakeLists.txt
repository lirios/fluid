include_directories(
    "${CMAKE_CURRENT_BINARY_DIR}/../src"
    "${CMAKE_CURRENT_BINARY_DIR}/../src/Fluid"
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    coreplugin.cpp
    clipboard.cpp
    qmldateutils.cpp
    device.cpp
    iconsimageprovider.cpp
    qqmlsortfilterproxymodel.cpp
    standardpaths.cpp
)

add_library(fluidcore SHARED ${SOURCES})
target_link_libraries(fluidcore Qt5::Svg Qt5::Gui Qt5::Quick Fluid)

set(FILES
    plugins.qmltypes
    qmldir
    Object.qml
    PlatformExtensions.qml
    Utils.qml
)

install(TARGETS fluidcore LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Core)
