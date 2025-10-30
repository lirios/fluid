set(LIBNAME fluidcontrols)

set(_sources
    clipboard.cpp clipboard.h
    color.cpp color.h
    controlsplugin.cpp controlsplugin.h
    controlsutils.cpp controlsutils.h
    dateutils.cpp dateutils.h
    datepicker.cpp datepicker.h
    dateselector.cpp dateselector.h
    datetimepicker.cpp datetimepicker.h
    device.cpp device.h
    picker.cpp picker.h
    iconthemeimageprovider.cpp iconthemeimageprovider.h
    inputregion.cpp inputregion.h
    timepicker.cpp timepicker.h
    timeselector.cpp timeselector.h
    yearmodel.cpp yearmodel.h
    yearselector.cpp yearselector.h
    standardpaths.cpp standardpaths.h
    style.cpp style.h
)

#file(GLOB _qml "qml/*.qml")
set(_qml
    qml/AbstractButton.qml
    qml/Action.qml
    qml/ActionGroup.qml
    qml/AlertDialog.qml
    qml/AppBar.qml
    qml/AppToolBar.qml
    qml/ApplicationWindow.qml
    qml/AutomaticGrid.qml
    qml/BodyLabel.qml
    qml/BottomSheet.qml
    qml/BottomSheetGrid.qml
    qml/BottomSheetList.qml
    qml/BoxShadow.qml
    qml/BusyIndicator.qml
    qml/Button.qml
    qml/ButtonGroup.qml
    qml/Calendar.qml
    qml/CalendarModel.qml
    qml/CaptionLabel.qml
    qml/Card.qml
    qml/CheckBox.qml
    qml/Chip.qml
    qml/CircleImage.qml
    qml/CircleMask.qml
    qml/ColumnFlow.qml
    qml/ComboBox.qml
    qml/Container.qml
    qml/Control.qml
    qml/DatePicker.qml
    qml/DatePickerDialog.qml
    qml/DateTimePicker.qml
    qml/DateTimePickerDialog.qml
    qml/DayOfWeekRow.qml
    qml/DelayButton.qml
    qml/Dial.qml
    qml/Dialog.qml
    qml/DialogButtonBox.qml
    qml/DialogLabel.qml
    qml/DisplayLabel.qml
    qml/Elevation.qml
    qml/FloatingActionButton.qml
    qml/Frame.qml
    qml/GroupBox.qml
    qml/HeadlineLabel.qml
    qml/HorizontalHeaderView.qml
    qml/Icon.qml
    qml/InputDialog.qml
    qml/Label.qml
    qml/ListItem.qml
    qml/Loadable.qml
    qml/Menu.qml
    qml/MenuBar.qml
    qml/MenuBarItem.qml
    qml/MenuItem.qml
    qml/MenuSeparator.qml
    qml/MonthGrid.qml
    qml/NavigationDrawer.qml
    qml/NavigationListView.qml
    qml/NoiseBackground.qml
    qml/Object.qml
    qml/Overlay.qml
    qml/OverlayView.qml
    qml/Page.qml
    qml/PageIndicator.qml
    qml/PageSidebar.qml
    qml/PageStack.qml
    qml/Pane.qml
    qml/Placeholder.qml
    qml/Popup.qml
    qml/ProgressBar.qml
    qml/RadioButton.qml
    qml/RangeSlider.qml
    qml/Ripple.qml
    qml/ScrollBar.qml
    qml/ScrollIndicator.qml
    qml/ScrollView.qml
    qml/SearchBar.qml
    qml/SelectionRectangle.qml
    qml/Showable.qml
    qml/Sidebar.qml
    qml/Slider.qml
    qml/SmoothFadeImage.qml
    qml/SmoothFadeLoader.qml
    qml/SnackBar.qml
    qml/SpinBox.qml
    qml/SplitHandle.qml
    qml/SplitView.qml
    qml/StackView.qml
    qml/Subheader.qml
    qml/SubheadingLabel.qml
    qml/SwipeView.qml
    qml/Switch.qml
    qml/Tab.qml
    qml/TabBar.qml
    qml/TabButton.qml
    qml/TabbedPage.qml
    qml/TextArea.qml
    qml/TextField.qml
    qml/ThinDivider.qml
    qml/TimePicker.qml
    qml/TimePickerDialog.qml
    qml/TitleLabel.qml
    qml/ToolBar.qml
    qml/ToolButton.qml
    qml/ToolSeparator.qml
    qml/ToolTip.qml
    qml/TreeViewDelegate.qml
    qml/Tumbler.qml
    qml/Units.qml
    qml/VerticalHeaderView.qml
    qml/Vignette.qml
    qml/Wave.qml
    qml/WeekNumberColumn.qml
)

qt6_add_qml_module(${LIBNAME}
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
    CLASS_NAME FluidPlugin
    NO_GENERATE_PLUGIN_SOURCE
    OUTPUT_TARGETS ${LIBNAME}_targets
)

set_source_files_properties(Units.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

if(FLUID_INSTALL_ICONS)
    target_compile_definitions(${LIBNAME} PRIVATE -DFLUID_INSTALL_ICONS=1)
else()
qt6_add_resource(SOURCES icons.qrc)
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

install(TARGETS ${${LIBNAME}_targets} EXPORT ${LIBNAME}-targets)
install(TARGETS ${LIBNAME} EXPORT ${LIBNAME}-targets)

qt_install_qml_module(${LIBNAME})

if(FLUID_INSTALL_ICONS)
    file(GLOB icons "${CMAKE_CURRENT_SOURCE_DIR}/icons/*/*.svg")
    foreach(source_path IN LISTS icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/icons/" "" icon_basename "${source_path}")
        get_filename_component(_category "${icon_basename}" DIRECTORY)
        install(FILES "${source_path}" DESTINATION "${QML_INSTALL_DIR}/Fluid/icons/${_category}")
    endforeach()
endif()
