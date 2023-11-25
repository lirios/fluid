ecm_add_qml_module(fluidcontrolsprivate
    URI
        "Fluid.Controls.Private"
    VERSION
        "2.0"
    GENERATE_PLUGIN_SOURCE
)

target_sources(fluidcontrolsprivate
    PRIVATE
        windowdecoration.cpp windowdecoration.h
)

if(LINUX AND NOT ANDROID)
    find_package(Wayland 1.15 COMPONENTS Client REQUIRED)
    find_package(Qt6WaylandClient REQUIRED)
    qt6_generate_wayland_protocol_client_sources(fluidcontrolsprivate
        FILES
            "${CMAKE_CURRENT_SOURCE_DIR}/extensions/fluid-decoration-unstable-v1.xml"
    )
    target_sources(fluidcontrolsprivate
        PRIVATE
            extensions/fluiddecorationv1.cpp extensions/fluiddecorationv1.h
    )
    target_compile_definitions(fluidcontrolsprivate PRIVATE FLUID_ENABLE_WAYLAND=1)
    target_link_libraries(fluidcontrolsprivate
        PRIVATE
            Qt6::GuiPrivate Qt6::WaylandClient Wayland::Client
    )
endif()

file(GLOB _qml "*.qml")
ecm_target_qml_sources(fluidcontrolsprivate
    SOURCES ${_qml}
)

target_link_libraries(fluidcontrolsprivate
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)

ecm_finalize_qml_module(fluidcontrolsprivate)
