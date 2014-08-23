set(FILES
    qmldir
    TextField.qml
    ToolButton.qml
    ScrollView.qml
    SidePanel.qml
)

install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Controls)
