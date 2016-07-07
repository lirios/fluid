set(QML_FILES
    qmldir
    BaseListItem.qml
    ListItem.qml
    ListItemDelegate.qml
    Subheader.qml
    ThinDivider.qml
)

install(FILES ${QML_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)

install(DIRECTORY +material
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
