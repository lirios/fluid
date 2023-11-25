ecm_add_qml_module(fluidlayouts
    URI
        "Fluid.Layouts"
    VERSION
        "2.0"
    GENERATE_PLUGIN_SOURCE
)

ecm_target_qml_sources(fluidlayouts
    SOURCES
        AutomaticGrid.qml
        ColumnFlow.qml
)

ecm_finalize_qml_module(fluidlayouts)
