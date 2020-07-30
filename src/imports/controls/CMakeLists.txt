if(FLUID_INSTALL_ICONS)
    set(FluidControls_RESOURCES)
else()
    set(FluidControls_RESOURCES "${CMAKE_CURRENT_SOURCE_DIR}/icons.qrc")
endif()

if(FLUID_INSTALL_ICONS)
    set(FluidControls_DEFINES FLUID_INSTALL_ICONS=1)
else()
    set(FluidControls_DEFINES FLUID_INSTALL_ICONS=0)
endif()

liri_add_qml_plugin(fluidcontrols
    MODULE_PATH
        "Fluid/Controls"
    VERSION
        "1.1"
    SOURCES
        color.cpp
        color.h
        controlsplugin.cpp
        controlsplugin.h
        controlsutils.cpp
        controlsutils.h
        iconthemeimageprovider.cpp
        iconthemeimageprovider.h
    QML_FILES
        Action.qml
        AlertDialog.qml
        AppBar11.qml
        AppBar.qml
        ApplicationWindow11.qml
        ApplicationWindow.qml
        AppToolBar11.qml
        AppToolBar.qml
        BodyLabel.qml
        BottomSheetGrid.qml
        BottomSheetList.qml
        BottomSheet.qml
        CaptionLabel.qml
        Card.qml
        Chip.qml
        CircleImage.qml
        DatePickerDialog.qml
        DatePicker.qml
        DateTimePickerDialog.qml
        DateTimePicker.qml
        DialogLabel.qml
        DisplayLabel.qml
        FloatingActionButton.qml
        HeadlineLabel.qml
        Icon.qml
        InputDialog.qml
        ListItem.qml
        Loadable.qml
        NavigationDrawer.qml
        NavigationListView.qml
        NoiseBackground.qml
        OverlayView.qml
        Page11.qml
        Page.qml
        PageSidebar.qml
        PageStack.qml
        Placeholder.qml
        Ripple.qml
        SearchBar11.qml
        SearchBar.qml
        Showable.qml
        Sidebar.qml
        SmoothFadeImage.qml
        SmoothFadeLoader.qml
        SnackBar.qml
        Subheader.qml
        SubheadingLabel.qml
        TabbedPage.qml
        Tab.qml
        ThinDivider.qml
        TimePickerDialog.qml
        TimePicker.qml
        TitleLabel.qml
        ToolButton.qml
        Units.qml
        Wave.qml
        qmldir
    RESOURCES
        ${FluidControls_RESOURCES}
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
        ${FluidControls_DEFINES}
    PUBLIC_LIBRARIES
        Qt5::QuickControls2
        Qt5::Svg
)

if(FLUID_INSTALL_ICONS)
    file(GLOB icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*.svg")
    foreach(source_path IN LISTS icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(_category "${icon_basename}" DIRECTORY)
        install(FILES "${source_path}" DESTINATION "${INSTALL_QMLDIR}/Fluid/Controls/icons/${_category}")
    endforeach()
endif()
