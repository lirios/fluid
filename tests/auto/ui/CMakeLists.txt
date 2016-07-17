set(SOURCES ui.cpp)

set(CMAKE_MACOSX_BUNDLE FALSE)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(tst_ui ${SOURCES})
target_link_libraries(tst_ui Qt5::Qml Qt5::Test Qt5::QuickTest)
add_test(tst_ui tst_ui)
add_dependencies(check tst_ui)
