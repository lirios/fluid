add_executable(tst_fluid_controls
    controls.cpp
    tst_color.qml
    tst_fab.qml
    tst_icon.qml
    tst_listitem.qml
    tst_ripple.qml
    tst_typography.qml
)
target_compile_definitions(tst_fluid_controls PRIVATE
    QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)
target_link_libraries(tst_fluid_controls PRIVATE Qt6::Qml Qt6::QuickTest)

if (WIN32)
    set(_extra_args -platform offscreen)
endif()

set(_extra_args ${_extra_args} -import ${CMAKE_BINARY_DIR}/bin)

add_test(NAME tst_fluid_controls
         COMMAND tst_fluid_controls
         WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
