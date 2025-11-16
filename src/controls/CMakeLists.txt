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
    cpp/items/rectangle.cpp cpp/items/rectangle.h
    cpp/scenegraph/elevationmaterial.cpp cpp/scenegraph/elevationmaterial.h
    cpp/scenegraph/geometry.cpp cpp/scenegraph/geometry.h
    cpp/scenegraph/rectanglematerial.cpp cpp/scenegraph/rectanglematerial.h
    cpp/style/color.cpp cpp/style/color.h
    cpp/style/elevation.cpp cpp/style/elevation.h
    cpp/style/style.cpp cpp/style/style.h
    cpp/style/token.cpp cpp/style/token.h
    cpp/utils/cornersgroup.cpp cpp/utils/cornersgroup.h
)

# QML files
file(GLOB_RECURSE _qml CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "qml/*.qml" "qml/**/*.qml"
)

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
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/core"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/datetime"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/items"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/scenegraph"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/style"
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/utils"
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

# ------------------------------------------------------------
# Define the QML module
# ------------------------------------------------------------
set_source_files_properties(qml/core/Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(${LIBNAME}
    URI
        Fluid
    VERSION
        2.0
    SOURCES
        ${_sources}
    QML_FILES
        ${_qml}
    RESOURCES
        ${_resources}
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

# Install library
install(TARGETS ${LIBNAME}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# Install QML module
qt_install_qml_module(${LIBNAME})

# ------------------------------------------------------------
# Shaders
# ------------------------------------------------------------
set(_common_glsl
    "${CMAKE_SOURCE_DIR}/assets/shaders/common.glsl"
    "${CMAKE_SOURCE_DIR}/assets/shaders/sdf.glsl"
)
set(_shaders
    "${CMAKE_SOURCE_DIR}/assets/shaders/default.vert"
    "${CMAKE_SOURCE_DIR}/assets/shaders/round_clip.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/sdf_rectangle.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/shadow_.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/rectangle.vert"
    "${CMAKE_SOURCE_DIR}/assets/shaders/rectangle.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/shadow.vert"
    "${CMAKE_SOURCE_DIR}/assets/shaders/shadow.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/rect_glow.frag"
)
set(_shader_options BATCHABLE OPTIMIZED)
if(CMAKE_BUILD_TYPE MATCHES Debug)
  list(APPEND _shader_options DEBUGINFO)
endif()
if(NOT WIN32)
  list(APPEND _shader_options NOHLSL)
endif()
qt_add_shaders(${LIBNAME} "shaders"
    PREFIX
        /Fluid
    BASE
        "${CMAKE_SOURCE_DIR}"
    GLSL
        "300es,330"
        ${_shader_options}
    FILES
        ${_shaders}
)
foreach(file ${_shaders})
    file(RELATIVE_PATH rel_path "${CMAKE_SOURCE_DIR}" "${file}")
    set(output_file ".qsb/${rel_path}.qsb")
    add_custom_command(
        OUTPUT ${output_file}
        DEPENDS ${_common_glsl}
        APPEND
    )
endforeach()