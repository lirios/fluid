qt6_add_executable(FluidDemo
    MANUAL_FINALIZATION
    iconcategorymodel.cpp iconcategorymodel.h
    iconnamemodel.cpp iconnamemodel.h
    main.cpp
    io.liri.Fluid.Demo.appdata.xml
    io.liri.Fluid.Demo.desktop
)

file(GLOB_RECURSE _images RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "images/*")
file(GLOB_RECURSE _qml RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "qml/*")
qt6_add_resources(FluidDemo "resources"
    PREFIX "/"
    FILES
        ${_images}
        ${_qml}
)

set_target_properties(FluidDemo PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.liri.Fluid.Demo"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
)
if(WIN32)
    set_target_properties(FluidDemo PROPERTIES OUTPUT_NAME "FluidDemo")
else()
    set_target_properties(FluidDemo PROPERTIES OUTPUT_NAME "fluid-demo")
endif()
qt6_finalize_target(FluidDemo)

target_compile_definitions(FluidDemo PRIVATE FLUID_VERSION="${PROJECT_VERSION}")

target_link_libraries(FluidDemo
    PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)

install(TARGETS FluidDemo DESTINATION ${KDE_INSTALL_BINDIR})

install(
    FILES io.liri.Fluid.Demo.appdata.xml
    DESTINATION ${KDE_INSTALL_METAINFODIR}
)
install(
    FILES io.liri.Fluid.Demo.desktop
    DESTINATION ${KDE_INSTALL_APPDIR}
)

if(UNIX AND NOT APPLE AND NOT ANDROID)
    file(GLOB png_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.png")
    file(GLOB svg_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.svg")
    foreach(source_path IN LISTS png_icons svg_icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(icon_directory "${icon_basename}" DIRECTORY)
        string(REPLACE "${icon_directory}/" "" icon_filename "${icon_basename}")
        string(REGEX REPLACE "\.(png|svg)" "" icon_filename "${icon_filename}")
        set(dest_path "${KDE_INSTALL_DATADIR}/icons/hicolor/${icon_directory}/")
        install(FILES "${source_path}" DESTINATION "${dest_path}")
    endforeach()
endif()
