qt_add_executable(FluidGallery
    MANUAL_FINALIZATION
    main.cpp
    io.liri.Fluid.Gallery.appdata.xml
    io.liri.Fluid.Gallery.desktop
)

qt_add_resources(FluidGallery "gallery"
    PREFIX /
    BASE qml
    FILES
        qml/main.qml
        qml/AppBars.qml
        qml/Colors.qml
        qml/Components.qml
        qml/Divider.qml
        qml/Elevation.qml
        qml/FAB.qml
        qml/FabMenu.qml
        qml/IconButton.qml
        qml/Indicators.qml
        qml/Slider.qml
        qml/Lists.qml
        qml/Symbols.qml
        qml/SymbolsModel.qml
        qml/Typography.qml
        qml/ValueCircle.qml
)

qt_add_resources(FluidGallery "gallery-icons"
    PREFIX /
    BASE "${CMAKE_CURRENT_SOURCE_DIR}"
    FILES
        icons/32x32/apps/io.liri.Fluid.Gallery.png
)

set_target_properties(FluidGallery PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.liri.Fluid.Gallery"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
    AUTOMOC ON
)
if(WIN32)
    set_target_properties(FluidGallery PROPERTIES OUTPUT_NAME "FluidGallery")
else()
    set_target_properties(FluidGallery PROPERTIES OUTPUT_NAME "fluid-gallery")
endif()
qt_finalize_target(FluidGallery)

target_compile_definitions(FluidGallery PRIVATE FLUID_VERSION="${PROJECT_VERSION}")

target_link_libraries(FluidGallery
    PRIVATE
        Qt6::Qml
        Qt6::Quick
)

if(UNIX AND NOT APPLE AND NOT ANDROID)
    install(
        TARGETS FluidGallery
        DESTINATION ${CMAKE_INSTALL_BINDIR}
    )
    install(
        FILES io.liri.Fluid.Gallery.appdata.xml
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/metainfo
    )
    install(
        FILES io.liri.Fluid.Gallery.desktop
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications
    )
endif()

if(UNIX AND NOT APPLE AND NOT ANDROID)
    file(GLOB png_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.png")
    file(GLOB svg_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.svg")
    foreach(source_path IN LISTS png_icons svg_icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(icon_directory "${icon_basename}" DIRECTORY)
        string(REPLACE "${icon_directory}/" "" icon_filename "${icon_basename}")
        string(REGEX REPLACE "\.(png|svg)" "" icon_filename "${icon_filename}")
        set(dest_path "${CMAKE_INSTALL_DATADIR}/icons/hicolor/${icon_directory}/")
        install(FILES "${source_path}" DESTINATION "${dest_path}")
    endforeach()
endif()
