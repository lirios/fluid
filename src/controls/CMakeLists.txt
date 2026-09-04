set(LIBNAME Fluid)

# Source files
set(_sources
    cpp/core/clipboard.cpp cpp/core/clipboard.h
    cpp/core/inputregion.cpp cpp/core/inputregion.h
    cpp/core/tooltipattached.cpp cpp/core/tooltipattached.h
    cpp/scenegraph/elevationmaterial.cpp cpp/scenegraph/elevationmaterial.h
    cpp/scenegraph/geometry.cpp cpp/scenegraph/geometry.h
    cpp/style/color.cpp cpp/style/color.h
    cpp/style/elevation.cpp cpp/style/elevation.h
    cpp/style/style.cpp cpp/style/style.h
    cpp/style/theme.cpp cpp/style/theme.h
    cpp/tokens/appbar.cpp cpp/tokens/appbar.h
    cpp/tokens/button.cpp cpp/tokens/button.h
    cpp/tokens/buttongroup.cpp cpp/tokens/buttongroup.h
    cpp/tokens/checkbox.cpp cpp/tokens/checkbox.h
    cpp/tokens/colordark.cpp cpp/tokens/colordark.h
    cpp/tokens/colorlight.cpp cpp/tokens/colorlight.h
    cpp/tokens/dialog.cpp cpp/tokens/dialog.h
    cpp/tokens/divider.cpp cpp/tokens/divider.h
    cpp/tokens/elevationtokens.cpp cpp/tokens/elevationtokens.h
    cpp/tokens/exposeddropdownmenu.cpp cpp/tokens/exposeddropdownmenu.h
    cpp/tokens/fab.cpp cpp/tokens/fab.h
    cpp/tokens/fabmenu.cpp cpp/tokens/fabmenu.h
    cpp/tokens/iconbutton.cpp cpp/tokens/iconbutton.h
    cpp/tokens/listitem.cpp cpp/tokens/listitem.h
    cpp/tokens/measurementtokens.cpp cpp/tokens/measurementtokens.h
    cpp/tokens/menu.cpp cpp/tokens/menu.h
    cpp/tokens/motiontokens.cpp cpp/tokens/motiontokens.h
    cpp/tokens/navigationrail.cpp cpp/tokens/navigationrail.h
    cpp/tokens/palette.cpp cpp/tokens/palette.h
    cpp/tokens/radiobutton.cpp cpp/tokens/radiobutton.h
    cpp/tokens/shapetokens.cpp cpp/tokens/shapetokens.h
    cpp/tokens/slider.cpp cpp/tokens/slider.h
    cpp/tokens/statetokens.cpp cpp/tokens/statetokens.h
    cpp/tokens/switch.cpp cpp/tokens/switch.h
    cpp/tokens/symbol.cpp cpp/tokens/symbol.h
    cpp/tokens/textfield.cpp cpp/tokens/textfield.h
    cpp/tokens/tooltip.cpp cpp/tokens/tooltip.h
    cpp/tokens/tokens.cpp cpp/tokens/tokens.h
    cpp/tokens/typescale.cpp cpp/tokens/typescale.h
)

# QML and JavaScript files
file(GLOB_RECURSE _qml_js CONFIGURE_DEPENDS
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "qml/*.qml" "qml/**/*.qml"
    "qml/*.js" "qml/**/*.js"
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
        "${CMAKE_CURRENT_SOURCE_DIR}/cpp/tokens"
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
set_source_files_properties(qml/components/Symbols.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/core/Breakpoints.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/core/Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/core/Utils.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/internal/MotionAnimation.js PROPERTIES
    QT_QML_SKIP_QMLDIR_ENTRY TRUE
)

qt_add_qml_module(${LIBNAME}
    URI
        Fluid
    VERSION
        2.0
    SOURCES
        ${_sources}
    QML_FILES
        ${_qml_js}
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
    "${CMAKE_SOURCE_DIR}/assets/shaders/ripple.frag"
    "${CMAKE_SOURCE_DIR}/assets/shaders/shadow.vert"
    "${CMAKE_SOURCE_DIR}/assets/shaders/shadow.frag"
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

# ------------------------------------------------------------
# Fonts
# ------------------------------------------------------------
function(download_material_symbols_font name)
    message(STATUS "Downloading Material Symbols font: ${name}")
    file(DOWNLOAD
        "https://raw.githubusercontent.com/google/material-design-icons/refs/heads/master/variablefont/${name}"
        "${CMAKE_CURRENT_BINARY_DIR}/assets/fonts/${name}"
        SHOW_PROGRESS
        STATUS download_status
    )

    # Check download status and bail out on failure
    list(GET download_status 0 download_result)
    list(GET download_status 1 download_reason)
    if(NOT download_result EQUAL 0)
        message(FATAL_ERROR "Failed to download Material Symbols font: ${download_reason} (code ${download_result})")
    endif()
endfunction()

download_material_symbols_font("MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].ttf")
download_material_symbols_font("MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf")
download_material_symbols_font("MaterialSymbolsSharp[FILL,GRAD,opsz,wght].ttf")

qt_add_resources(${LIBNAME} "assets/fonts"
    PREFIX
        /Fluid/assets/fonts
    BASE
        "${CMAKE_CURRENT_BINARY_DIR}/assets/fonts"
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/assets/fonts/MaterialSymbolsOutlined[FILL,GRAD,opsz,wght].ttf"
        "${CMAKE_CURRENT_BINARY_DIR}/assets/fonts/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf"
        "${CMAKE_CURRENT_BINARY_DIR}/assets/fonts/MaterialSymbolsSharp[FILL,GRAD,opsz,wght].ttf"
)
