set(FILES
    qmldir
    TextField.qml
    ToolButton.qml
)

install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Controls)
