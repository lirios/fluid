include_directories(
    ${Qt5Gui_PRIVATE_INCLUDE_DIRS}
    ${VibeCore_INCLUDE_DIRS}
    ${CMAKE_SOURCE_DIR}/headers
    ${CMAKE_SOURCE_DIR}/headers/Fluid
)

set(SOURCES
    fluid.cpp
    framesvg.cpp
    svg.cpp
    theme.cpp
    rangemodel.cpp
)

set(HEADERS
    fluid.h
    framesvg.h
    svg.h
    theme.h
    rangemodel.h
)

add_compiler_export_flags()
add_library(Fluid SHARED ${SOURCES})
generate_export_header(Fluid
    BASE_NAME fluid
    DEPRECATED_MACRO_NAME FLUID_DEPRECATED
)
qt5_use_modules(Fluid Gui Svg)
target_link_libraries(Fluid
    ${VibeCore_LIBRARIES}
)
set_target_properties(Fluid PROPERTIES
    VERSION ${FLUID_VERSION_STRING}
    SOVERSION ${FLUID_VERSION_MAJOR}.${FLUID_VERSION_MINOR}.${FLUID_VERSION_PATCH})

install(FILES ${HEADERS} ${CMAKE_CURRENT_BINARY_DIR}/fluid_export.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/Fluid)
install(TARGETS Fluid LIBRARY
    DESTINATION ${CMAKE_INSTALL_LIBDIR})
