add_executable(tst_fluid_core
    core.cpp
    tst_clipboard.qml
    tst_date.qml
    tst_utils.qml
)
target_compile_definitions(tst_fluid_core PRIVATE
    QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)
target_link_libraries(tst_fluid_core PRIVATE Qt6::Qml Qt6::QuickTest)

if (WIN32)
    set(_extra_args -platform offscreen)
endif()

set(_extra_args ${_extra_args} -import ${CMAKE_BINARY_DIR}/bin)

add_test(NAME tst_fluid_core
         COMMAND tst_fluid_core
         WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
