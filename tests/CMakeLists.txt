# NOTE: We're not using CTest here as just adds an extra layer around QuickTest

set(SOURCES tests.cpp)

set(CMAKE_MACOSX_BUNDLE FALSE)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(fluidtests ${SOURCES})
target_link_libraries(fluidtests Qt5::Qml Qt5::Test Qt5::QuickTest)

add_custom_target(check COMMAND fluidtests DEPENDS fluidtests)
