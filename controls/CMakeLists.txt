set(FILES
    qmldir
    BaseListItem.qml
    EmptyListItem.qml
    HighlightListItem.qml
    StandardListItem.qml
)

install(FILES ${LISTITEMS_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
