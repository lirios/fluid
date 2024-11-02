ecm_add_qml_module(fluidcontrols
    URI
        "Fluid"
    VERSION
        "2.0"
    RESOURCE_PREFIX /liri.io/imports
    CLASS_NAME FluidPlugin
    NO_GENERATE_PLUGIN_SOURCE
)

target_sources(fluidcontrols
    PRIVATE
        clipboard.cpp clipboard.h
        color.cpp color.h
        controlsplugin.cpp controlsplugin.h
        controlsutils.cpp controlsutils.h
        dateutils.cpp dateutils.h
        device.cpp device.h
        iconthemeimageprovider.cpp iconthemeimageprovider.h
        inputregion.cpp inputregion.h
        standardpaths.cpp standardpaths.h
)

if(NOT FLUID_INSTALL_ICONS)
    qt6_add_resource(SOURCES icons.qrc)
    target_sources(fluidcontrols PRIVATE ${SOURCES})
endif()

set_source_files_properties(Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

file(GLOB _qml "qml/*.qml")

set_source_files_properties("${CMAKE_CURRENT_SOURCE_DIR}/qml/Units.qml"
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

ecm_target_qml_sources(fluidcontrols
    SOURCES ${_qml}
)

if(FLUID_INSTALL_ICONS)
    target_compile_definitions(fluidcontrols PRIVATE -DFLUID_INSTALL_ICONS=1)
else()
    target_compile_definitions(fluidcontrols PRIVATE -DFLUID_INSTALL_ICONS=0)
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
        install(FILES "${source_path}" DESTINATION "${KDE_INSTALL_QMLDIR}/Fluid/icons/${_category}")
    endforeach()
endif()
