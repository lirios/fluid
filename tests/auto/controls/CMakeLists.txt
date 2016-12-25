set(SOURCES controls.cpp)

set(CMAKE_MACOSX_BUNDLE FALSE)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(tst_controls ${SOURCES})
target_link_libraries(tst_controls Qt5::Qml Qt5::Test Qt5::QuickTest)
add_test(tst_controls tst_controls)
add_dependencies(check tst_controls)
