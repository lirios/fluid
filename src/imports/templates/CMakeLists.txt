ecm_add_qml_module(fluidtemplates
    URI
        "Fluid.Templates"
    VERSION
        "2.0"
    GENERATE_PLUGIN_SOURCE
)

target_sources(fluidtemplates
    PRIVATE
        datepicker.cpp datepicker.h
        dateselector.cpp dateselector.h
        datetimepicker.cpp datetimepicker.h
        picker.cpp picker.h
        timepicker.cpp timepicker.h
        timeselector.cpp timeselector.h
        yearmodel.cpp yearmodel.h
        yearselector.cpp yearselector.h
)

ecm_target_qml_sources(fluidtemplates
    SOURCES
        Card.qml
)

target_link_libraries(fluidtemplates
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
)

ecm_finalize_qml_module(fluidtemplates)
