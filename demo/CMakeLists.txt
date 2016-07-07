set(SOURCES main.cpp demo.qrc)

add_executable(demo ${SOURCES})
target_link_libraries(demo Qt5::Gui Qt5::Qml Qt5::QuickControls2)
