set(LIBNAME Fluid)

# Source files
set(_sources
    cpp/controlsplugin.cpp cpp/controlsplugin.h
    cpp/core/clipboard.cpp cpp/core/clipboard.h
    cpp/core/controlsutils.cpp cpp/core/controlsutils.h
    cpp/core/device.cpp cpp/core/device.h
    cpp/core/inputregion.cpp cpp/core/inputregion.h
    cpp/core/standardpaths.cpp cpp/core/standardpaths.h
    cpp/datetime/datepicker.cpp cpp/datetime/datepicker.h
    cpp/datetime/dateselector.cpp cpp/datetime/dateselector.h
    cpp/datetime/datetimepicker.cpp cpp/datetime/datetimepicker.h
    cpp/datetime/dateutils.cpp cpp/datetime/dateutils.h
    cpp/datetime/picker.cpp cpp/datetime/picker.h
    cpp/datetime/timepicker.cpp cpp/datetime/timepicker.h
    cpp/datetime/timeselector.cpp cpp/datetime/timeselector.h
    cpp/datetime/yearmodel.cpp cpp/datetime/yearmodel.h
    cpp/datetime/yearselector.cpp cpp/datetime/yearselector.h
    cpp/iconthemeimageprovider.cpp cpp/iconthemeimageprovider.h
    cpp/style/color.cpp cpp/style/color.h
    cpp/style/style.cpp cpp/style/style.h
)

# QML files
file(GLOB_RECURSE _qml CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "qml/**/*.qml"
)

# Resources
set(_resources)
if(NOT FLUID_INSTALL_ICONS)
    file(GLOB_RECURSE _icons CONFIGURE_DEPENDS
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "icons/*/*.svg"
    )
    list(APPEND _resources ${_icons})
endif()

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
target_include_directories(${LIBNAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/cpp/core
        ${CMAKE_CURRENT_SOURCE_DIR}/cpp/datetime
        ${CMAKE_CURRENT_SOURCE_DIR}/cpp/style
)
target_link_libraries(${LIBNAME}
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::GuiPrivate
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
        Qt6::Svg
)
target_compile_definitions(${LIBNAME}
    PRIVATE
        FLUID_INSTALL_ICONS=$<IF:$<BOOL:${FLUID_INSTALL_ICONS}>,1,0>
)

# ------------------------------------------------------------
# Define the QML module
# ------------------------------------------------------------
qt_add_qml_module(${LIBNAME}
    URI Fluid
    VERSION 2.0
    SOURCES ${_sources}
    QML_FILES ${_qml}
    RESOURCES ${_resources}
    IMPORTS
        QtQuick.Layouts
    DEPENDENCIES
        QtQuick
        QtQuick.Templates
        #Fluid.Private
    #CLASS_NAME FluidPlugin
    #NO_GENERATE_PLUGIN_SOURCE
)

set_source_files_properties(qml/Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

install(TARGETS ${LIBNAME}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

qt_install_qml_module(${LIBNAME})

if(FLUID_INSTALL_ICONS)
    file(GLOB icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*.svg")
    foreach(source_path IN LISTS icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(_category "${icon_basename}" DIRECTORY)
        install(FILES "${source_path}" DESTINATION "${QML_INSTALL_DIR}/Fluid/icons/${_category}")
    endforeach()
endif()
