ecm_add_qml_module(fluidcore
    URI
        "Fluid.Core"
    VERSION
        "2.0"
    GENERATE_PLUGIN_SOURCE
)

target_sources(fluidcore
    PRIVATE
        clipboard.cpp clipboard.h
        coreutils.cpp coreutils.h
        dateutils.cpp dateutils.h
        device.cpp device.h
        standardpaths.cpp standardpaths.h
)

ecm_target_qml_sources(fluidcore
    SOURCES
        Object.qml
)

target_link_libraries(fluidcore
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
)

ecm_finalize_qml_module(fluidcore)
