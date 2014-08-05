add_definitions(-DQT_PLUGIN)

set(SOURCES
    plugin.cpp
    standardpaths.cpp
)

add_library(declarative_hawaiicore SHARED ${SOURCES})
target_link_libraries(declarative_hawaiicore
    Qt5::Qml
)

set(FILES
    qmldir
)

install(TARGETS declarative_hawaiicore LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Core)
install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Core)
