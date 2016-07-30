set(SOURCES main.cpp demo.qrc)

add_executable(fluid-demo ${SOURCES})
target_link_libraries(fluid-demo Qt5::Gui Qt5::Qml Qt5::QuickControls2)

install(TARGETS fluid-demo RUNTIME
        DESTINATION ${BIN_INSTALL_DIR})
