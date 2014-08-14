set(MODULE_FILES
    qmldir
    AppChooserButtonStyle.qml
    DialogStyle.qml
    NotificationBubbleStyle.qml
    OverlayStyle.qml
    PanelIndicatorStyle.qml
    PanelStyle.qml
    PopupStyle.qml
    TooltipStyle.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Hawaii/Shell/Styles/Base)
