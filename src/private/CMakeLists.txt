set(LIBNAME FluidPrivate)

# Source files
set(_sources
    shortcututils.cpp shortcututils.h
    windowdecoration.cpp windowdecoration.h
)

if(LINUX AND NOT ANDROID)
    set(_sources
        ${_sources}
        extensions/fluiddecorationv1.cpp extensions/fluiddecorationv1.h
    )
endif()

# QML and JavaScript files
file(GLOB_RECURSE _qml_js CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "qml/*.qml" "qml/**/*.qml"
    "qml/*.js" "qml/**/*.js"
)

# ------------------------------------------------------------
# Backing library
# ------------------------------------------------------------
add_library(${LIBNAME} SHARED
    ${_sources}
)
set_target_properties(${LIBNAME} PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    AUTOUIC ON
)
target_link_libraries(${LIBNAME}
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)
if(LINUX AND NOT ANDROID)
    find_package(Wayland 1.15 COMPONENTS Client REQUIRED)
    find_package(Qt6WaylandClient REQUIRED)
    qt_generate_wayland_protocol_client_sources(${LIBNAME}
        FILES
            "${CMAKE_CURRENT_SOURCE_DIR}/extensions/fluid-decoration-unstable-v1.xml"
    )
    target_compile_definitions(${LIBNAME} PRIVATE FLUID_ENABLE_WAYLAND=1)
    target_link_libraries(${LIBNAME}
        PRIVATE
            Qt6::GuiPrivate
            Qt6::WaylandClient
            Wayland::Client
    )
endif()

qt_add_qml_module(${LIBNAME}
    URI
        Fluid.Private
    VERSION
        2.0
    RESOURCE_PREFIX
        /
    SOURCES
        ${_sources}
    QML_FILES
        ${_qml_js}
    IMPORTS
        QtQuick.Layouts
    DEPENDENCIES
        QtQuick
)

# Install library
install(TARGETS ${LIBNAME}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# Install QML module
qt_install_qml_module(${LIBNAME})
