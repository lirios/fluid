include_directories(
    ${Qt5Gui_INCLUDE_DIRS}
    ${VibeCore_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
    ${CMAKE_SOURCE_DIR}/headers/FluidUi
)

add_definitions(
    ${Qt5Gui_DEFINITIONS}
    ${Qt5Svg_DEFINITIONS}
)

set(SOURCES
    rangemodel.cpp
)

set(HEADERS
    fluiduicomponentsglobal.h
    rangemodel.h
)

add_library(FluidUi SHARED ${SOURCES})
target_link_libraries(FluidUi
    ${Qt5Gui_LIBRARIES}
)

# Install library and headers
install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/FluidUi)
install(TARGETS FluidUi LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# QML and JavaScript code
add_subdirectory(qml)
