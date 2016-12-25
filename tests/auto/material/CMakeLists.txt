set(SOURCES material.cpp)

set(CMAKE_MACOSX_BUNDLE FALSE)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

qt5_add_resources(RESOURCES material.qrc)

add_executable(tst_material ${SOURCES} ${RESOURCES})
target_link_libraries(tst_material Qt5::Qml Qt5::QuickControls2 Qt5::Test Qt5::QuickTest)
add_test(tst_material tst_material)
add_dependencies(check tst_material)
