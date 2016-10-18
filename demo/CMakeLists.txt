set(SOURCES main.cpp demo.qrc)
file(GLOB_RECURSE QML_SOURCES
     RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.qml")

add_executable(fluid-demo ${SOURCES} ${QML_SOURCES})
target_link_libraries(fluid-demo Qt5::Gui Qt5::Qml Qt5::QuickControls2)

install(TARGETS fluid-demo
        BUNDLE DESTINATION .
        RUNTIME DESTINATION ${BIN_INSTALL_DIR})
