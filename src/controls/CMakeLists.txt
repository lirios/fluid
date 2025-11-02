set(LIBNAME Controls)

set(_sources
    clipboard.cpp clipboard.h
    color.cpp color.h
    controlsplugin.cpp controlsplugin.h
    controlsutils.cpp controlsutils.h
    datetime/datepicker.cpp datetime/datepicker.h
    datetime/dateselector.cpp datetime/dateselector.h
    datetime/datetimepicker.cpp datetime/datetimepicker.h
    datetime/dateutils.cpp datetime/dateutils.h
    datetime/picker.cpp datetime/picker.h
    datetime/timepicker.cpp datetime/timepicker.h
    datetime/timeselector.cpp datetime/timeselector.h
    datetime/yearmodel.cpp datetime/yearmodel.h
    datetime/yearselector.cpp datetime/yearselector.h
    device.cpp device.h
    iconthemeimageprovider.cpp iconthemeimageprovider.h
    inputregion.cpp inputregion.h
    standardpaths.cpp standardpaths.h
    style.cpp style.h
)

# Glob all QML files under qml/ recursively
file(GLOB_RECURSE _qml CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "qml/**/*.qml"
)

qt_add_qml_module(${LIBNAME}
    URI Fluid
    VERSION 2.0
    RESOURCE_PREFIX /
    SOURCES ${_sources}
    QML_FILES ${_qml}
    IMPORTS
        QtQuick.Layouts
    DEPENDENCIES
        QtQuick
        QtQuick.Templates
        #Fluid.Private
    PLUGIN_TARGET ${LIBNAME}
    CLASS_NAME FluidPlugin
    NO_PLUGIN_OPTIONAL
    NO_GENERATE_PLUGIN_SOURCE
)

set_source_files_properties(qml/Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

if(FLUID_INSTALL_ICONS)
    target_compile_definitions(${LIBNAME} PRIVATE -DFLUID_INSTALL_ICONS=1)
else()
qt_add_resource(SOURCES icons.qrc)
    target_sources(${LIBNAME} PRIVATE ${_sources})
    target_compile_definitions(${LIBNAME} PRIVATE -DFLUID_INSTALL_ICONS=0)
endif()

target_link_libraries(${LIBNAME}
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Svg
    PRIVATE
        Qt6::GuiPrivate
)

qt_install_qml_module(${LIBNAME})

if(FLUID_INSTALL_ICONS)
    file(GLOB icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*.svg")
    foreach(source_path IN LISTS icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(_category "${icon_basename}" DIRECTORY)
        install(FILES "${source_path}" DESTINATION "${QML_INSTALL_DIR}/Fluid/icons/${_category}")
    endforeach()
endif()
