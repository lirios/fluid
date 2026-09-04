add_executable(tst_fluid_controls
    controls.cpp
    tst_accessibility.qml
    tst_action.qml
    tst_adaptivegrid.qml
    tst_automaticgridlayout.qml
    tst_appbar.qml
    tst_buttongroup.qml
    tst_clipboard.qml
    tst_color.qml
    tst_colortokens.qml
    tst_componenttokens.qml
    tst_date.qml
    tst_divider.qml
    tst_exposeddropdownmenu.qml
    tst_extendedfab.qml
    tst_fab.qml
    tst_fabmenu.qml
    tst_gallery.qml
    tst_groupbox.qml
    tst_icon.qml
    tst_iconbutton.qml
    tst_listitem.qml
    tst_menu.qml
    tst_navigationrail.qml
    tst_radiobutton.qml
    tst_ripple.qml
    tst_slider.qml
    tst_switch.qml
    tst_symbols.qml
    tst_textfield.qml
    tst_tooltip.qml
    tst_systemtokens.qml
    tst_typography.qml
    tst_typescale.qml
    tst_utils.qml
)
target_compile_definitions(tst_fluid_controls PRIVATE
    QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)
target_link_libraries(tst_fluid_controls PRIVATE Qt6::Qml Qt6::QuickTest)

if (WIN32)
    set(_extra_args -platform offscreen)
endif()

set(_extra_args ${_extra_args} -import ${QT_QML_OUTPUT_DIRECTORY})

add_test(NAME tst_fluid_controls
         COMMAND tst_fluid_controls ${_extra_args}
         WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
set_tests_properties(tst_fluid_controls PROPERTIES
    ENVIRONMENT "QT_QPA_PLATFORM=offscreen"
)

if (TARGET Qt6::Test)
    add_executable(tst_fluid_accessibility
        accessibility.cpp
    )
    target_compile_definitions(tst_fluid_accessibility PRIVATE
        FLUID_QML_IMPORT_PATH="${QT_QML_OUTPUT_DIRECTORY}"
    )
    target_link_libraries(tst_fluid_accessibility PRIVATE
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::Test
    )
    add_test(NAME tst_fluid_accessibility
             COMMAND tst_fluid_accessibility
             WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
    set_tests_properties(tst_fluid_accessibility PROPERTIES
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen"
    )
endif()
