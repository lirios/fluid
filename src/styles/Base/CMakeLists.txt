set(MODULE_FILES
    qmldir
    DialogStyle.qml
    OverlayStyle.qml
    PanelStyle.qml
    PopupStyle.qml
    TooltipStyle.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Styles/Base)

set(MODULE_FILES
    NotificationStyle.qml
    SidePanelStyle.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Controls/Styles/Base)
