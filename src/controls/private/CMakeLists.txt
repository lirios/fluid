set(LIBNAME fluidcontrolsprivate)

set(_sources
    windowdecoration.cpp windowdecoration.h
)

set(_qml
    DateSelector.qml
    TimeSelector.qml
    YearSelector.qml
)

qt6_add_qml_module(${LIBNAME}
    URI Fluid.Private
    VERSION 2.0
    RESOURCE_PREFIX /
    SOURCES ${_sources}
    QML_FILES ${_qml}
    DEPENDENCIES
        QtQuick
    OUTPUT_TARGETS ${LIBNAME}_targets
)

if(LINUX AND NOT ANDROID)
    find_package(Wayland 1.15 COMPONENTS Client REQUIRED)
    find_package(Qt6WaylandClient REQUIRED)
    qt6_generate_wayland_protocol_client_sources(${LIBNAME}
        FILES
            "${CMAKE_CURRENT_SOURCE_DIR}/extensions/fluid-decoration-unstable-v1.xml"
    )
    set(_sources
        ${_sources}
        extensions/fluiddecorationv1.cpp extensions/fluiddecorationv1.h
    )
    target_compile_definitions(${LIBNAME} PRIVATE FLUID_ENABLE_WAYLAND=1)
    target_link_libraries(${LIBNAME}
        PRIVATE
            Qt6::GuiPrivate
            Qt6::WaylandClient
            Wayland::Client
    )
endif()

target_link_libraries(${LIBNAME}
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)

install(TARGETS ${${LIBNAME}_targets} EXPORT ${LIBNAME}-targets)
install(TARGETS ${LIBNAME} EXPORT ${LIBNAME}-targets)

qt_install_qml_module(${LIBNAME})
