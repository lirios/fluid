include_directories(
    ${Qt5Gui_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/FluidCore
)

add_definitions(
    ${Qt5Gui_DEFINITIONS}
)

set(SOURCES
    fluid.cpp
)

set(HEADERS
    fluid.h
)

add_library(FluidCore SHARED ${SOURCES})
target_link_libraries(FluidCore
    ${Qt5Gui_LIBRARIES}
)

# Install library and headers
install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/FluidCore)
install(TARGETS FluidCore LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
