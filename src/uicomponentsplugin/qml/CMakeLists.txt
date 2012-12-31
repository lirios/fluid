# Install QML and JavaScript code
set(MODULE_FILES
    BusyIndicator.qml
    ButtonColumn.qml
    Button.qml
    ButtonRow.qml
    CheckBox.qml
    CommonDialog.qml
    ContextMenu.qml
    Dialog.qml
    Highlight.qml
    Label.qml
    ListItem.qml
    Page.qml
    PageStack.qml
    ProgressBar.qml
    RadioButton.qml
    ScrollBar.qml
    SectionScroller.qml
    SelectionDialog.qml
    Sheet.qml
    Slider.qml
    Switch.qml
    TabBar.qml
    TabButton.qml
    TabGroup.qml
    TextArea.qml
    TextField.qml
    ToolBarLayout.qml
    ToolBar.qml
    ToolButton.qml
)
set(JAVASCRIPT_FILES
    ButtonGroup.js
)
install(FILES ${MODULE_FILES} ${JAVASCRIPT_FILES}
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)

# Install private code
set(PRIVATE_FILES
    private/AppManager.js
    private/ButtonShadow.qml
    private/Config.js
    private/DualStateButton.qml
    private/IconLoader.qml
    private/InlineDialog.qml
    private/PageStack.js
    private/RoundShadow.qml
    private/ScrollBarDelegate.qml
    private/ScrollDecoratorDelegate.qml
    private/SectionScroller.js
    private/TabBarLayout.qml
    private/TabGroup.js
    private/TextFieldFocus.qml
)
install(FILES ${PRIVATE_FILES}
     DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi/private)
