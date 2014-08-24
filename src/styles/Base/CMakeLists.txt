set(MODULE_FILES
    DialogStyle.qml
    NotificationStyle.qml
    OverlayStyle.qml
    PanelStyle.qml
    PopupStyle.qml
    SidePanelStyle.qml
    TooltipStyle.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Controls/Styles/Base)
