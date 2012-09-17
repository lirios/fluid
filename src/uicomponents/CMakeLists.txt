include_directories(
    ${Qt5Gui_INCLUDE_DIRS}
    ${Qt5Svg_INCLUDE_DIRS}
    ${VibeCore_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidUi
)

add_definitions(
    ${Qt5Gui_DEFINITIONS}
    ${Qt5Svg_DEFINITIONS}
)

set(SOURCES
    framesvg.cpp
    rangemodel.cpp
    svg.cpp
)

set(HEADERS
    framesvg.h
    rangemodel.h
    svg.h
)

add_library(FluidUi SHARED ${SOURCES})
target_link_libraries(FluidUi
    ${Qt5Gui_LIBRARIES}
    ${Qt5Svg_LIBRARIES}
)

# Install library and headers
install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/FluidUi)
install(TARGETS FluidUi LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# Install QML and JavaScript code
file(GLOB MODULE_FILES "qml/*.*")
install(FILES ${MODULE_FILES}
    DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi)

# Install styles
file(GLOB STYLE_FILES "qml/style/*.*")
install(FILES ${STYLE_FILES}
    DESTINATION ${CMAKE_INSTALL_IMPORTSDIR}/FluidUi)
