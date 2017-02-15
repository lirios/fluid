set(QML_FILES
    qmldir
    AutomaticGrid.qml
    ColumnFlow.qml
)

install(FILES ${QML_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Layouts)
