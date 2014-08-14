add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    abstractstyle.cpp
    padding.cpp
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

add_subdirectory(Base)
