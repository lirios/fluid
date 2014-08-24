include_directories(
    ${CMAKE_BINARY_DIR}/headers
)

add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    stylesettings.cpp
)

add_library(declarative_hawaiistyles SHARED ${SOURCES})
target_link_libraries(declarative_hawaiistyles
    Qt5::Qml
)

install(TARGETS declarative_hawaiistyles LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Styles)

set(MODULE_FILES
    qmldir
    Style.qml
    StyledItem.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Styles)

install(FILES qmldir2
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Controls/Styles
        RENAME qmldir)

add_subdirectory(Base)
