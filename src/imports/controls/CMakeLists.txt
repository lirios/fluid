ecm_add_qml_module(fluidcontrols
    URI
        "Fluid.Controls"
    VERSION
        "2.0"
    CLASS_NAME FluidControlsPlugin
    NO_GENERATE_PLUGIN_SOURCE
)

target_sources(fluidcontrols
    PRIVATE
        color.cpp color.h
        controlsplugin.cpp controlsplugin.h
        controlsutils.cpp controlsutils.h
        iconthemeimageprovider.cpp iconthemeimageprovider.h
        inputregion.cpp inputregion.h
)

if(NOT FLUID_INSTALL_ICONS)
    qt6_add_resource(SOURCES icons.qrc)
    target_sources(fluidcontrols PRIVATE ${SOURCES})
endif()

set_source_files_properties(Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

file(GLOB _qml "*.qml")
ecm_target_qml_sources(fluidcontrols
    SOURCES ${_qml}
)

if(FLUID_INSTALL_ICONS)
    target_compile_definitions(fluidcontrols PRIVATE FLUID_INSTALL_ICONS=1)
else()
    target_compile_definitions(fluidcontrols PRIVATE FLUID_INSTALL_ICONS=0)
endif()

target_link_libraries(fluidcontrols
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Svg
)

ecm_finalize_qml_module(fluidcontrols)

if(FLUID_INSTALL_ICONS)
    file(GLOB icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*.svg")
    foreach(source_path IN LISTS icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(_category "${icon_basename}" DIRECTORY)
        install(FILES "${source_path}" DESTINATION "${KDE_INSTALL_QMLDIR}/Fluid/Controls/icons/${_category}")
    endforeach()
endif()
