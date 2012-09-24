include_directories(
    ${Qt5Gui_PRIVATE_INCLUDE_DIRS}
    ${Qt5Gui_INCLUDE_DIRS}
    ${Qt5Svg_INCLUDE_DIRS}
    ${VibeCore_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
)

add_definitions(
    ${Qt5Gui_DEFINITIONS}
    ${Qt5Svg_DEFINITIONS}
    ${VibeCore_DEFINITIONS}
)

set(SOURCES
    fluid.cpp
    framesvg.cpp
    svg.cpp
    theme.cpp
)

set(HEADERS
    fluid.h
    framesvg.h
    svg.h
    theme.h
)

add_library(FluidCore SHARED ${SOURCES})
target_link_libraries(FluidCore
    ${Qt5Gui_LIBRARIES}
    ${Qt5Svg_LIBRARIES}
    ${VibeCore_LIBRARIES}
)

# Install library and headers
install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/FluidCore)
install(TARGETS FluidCore LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
