ecm_add_qml_module(fluideffects
    URI
        "Fluid.Effects"
    VERSION
        "2.0"
    GENERATE_PLUGIN_SOURCE
)

ecm_target_qml_sources(fluideffects
    SOURCES
        BoxShadow.qml
        CircleMask.qml
        Elevation.qml
        Vignette.qml
)

ecm_finalize_qml_module(fluideffects)
