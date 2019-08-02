if(WIN32)
    set(FluidDemo_OUTPUT_NAME "FluidDemo")
else()
    set(FluidDemo_OUTPUT_NAME "fluid-demo")
endif()

liri_add_executable(FluidDemo
    OUTPUT_NAME
        "${FluidDemo_OUTPUT_NAME}"
    SOURCES
        iconcategorymodel.cpp
        iconcategorymodel.h
        iconnamemodel.cpp
        iconnamemodel.h
        main.cpp
        qml/icons.txt
        qml/main.qml
        qml/Pages/Layouts/ColumnFlowPage.qml
        qml/Pages/Layouts/AutomaticGridPage.qml
        qml/Pages/Controls/ListItemPage.qml
        qml/Pages/Controls/WavePage.qml
        qml/Pages/Controls/DialogsPage.qml
        qml/Pages/Controls/ActionButtonPage.qml
        qml/Pages/Controls/NavigationListViewPage.qml
        qml/Pages/Controls/NavDrawerPage.qml
        qml/Pages/Controls/ChipPage.qml
        qml/Pages/Controls/DatePickerPage.qml
        qml/Pages/Controls/DateTimePickerPage.qml
        qml/Pages/Controls/SearchPage.qml
        qml/Pages/Controls/OverlayPage.qml
        qml/Pages/Controls/SubPage.qml
        qml/Pages/Controls/SnackBarPage.qml
        qml/Pages/Controls/CardPage.qml
        qml/Pages/Controls/TimePickerPage.qml
        qml/Pages/Controls/PlaceholderPage.qml
        qml/Pages/Controls/BottomSheetPage.qml
        qml/Pages/Basic/BusyIndicatorPage.qml
        qml/Pages/Basic/SliderPage.qml
        qml/Pages/Basic/SwitchPage.qml
        qml/Pages/Basic/CheckBoxPage.qml
        qml/Pages/Basic/RadioButtonPage.qml
        qml/Pages/Basic/ButtonPage.qml
        qml/Pages/Basic/ProgressBarPage.qml
        qml/Pages/Style/IconsPage.qml
        qml/Pages/Style/PalettePage.qml
        qml/Pages/Style/PaletteSwatch.qml
        qml/Pages/Style/TypographyPage.qml
        qml/Pages/Style/SystemIconsPage.qml
        qml/StyledPage.qml
        qml/StyledPageTwoColumns.qml
        qml/StyledRectangle.qml
    RESOURCES
        fluid-demo.qrc
    QTQUICK_COMPILER
        ${FLUID_ENABLE_QTQUICK_COMPILER}
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
        -DFLUID_VERSION="${PROJECT_VERSION}"
    APPDATA
        io.liri.Fluid.Demo.appdata.xml
    DESKTOP
        io.liri.Fluid.Demo.desktop
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    GUI
)
set_target_properties(FluidDemo PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.liri.Fluid.Demo"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
)

if(UNIX AND NOT APPLE AND NOT ANDROID)
    file(GLOB png_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.png")
    file(GLOB svg_icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*/*.svg")
    foreach(source_path IN LISTS png_icons svg_icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(icon_directory "${icon_basename}" DIRECTORY)
        string(REPLACE "${icon_directory}/" "" icon_filename "${icon_basename}")
        string(REGEX REPLACE "\.(png|svg)" "" icon_filename "${icon_filename}")
        set(dest_path "${INSTALL_DATADIR}/icons/hicolor/${icon_directory}/")
        install(FILES "${source_path}" DESTINATION "${dest_path}")
    endforeach()
endif()
