include_directories(
    ${Qt5Qml_INCLUDE_DIRS}
    ${Qt5Quick_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
)

add_definitions(
    ${Qt5Qml_DEFINITIONS}
    ${Qt5Quick_DEFINITIONS}
    -DQT_PLUGIN
)

set(SOURCES
    uicomponentsplugin.cpp
    iconimageprovider.cpp
    themeimageprovider.cpp
    enums.cpp
)

add_library(fluiduicomponentsplugin SHARED ${SOURCES})
target_link_libraries(fluiduicomponentsplugin
    ${Qt5Qml_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
    Fluid
)

# Install plugin
install(TARGETS fluiduicomponentsplugin LIBRARY DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi)
install(FILES qmldir DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi)

# QML and JavaScript code
add_subdirectory(qml)
