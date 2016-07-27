set(QML_FILES
    qmldir
    Action.qml
    AppBar.qml
    AppToolBar.qml
    BaseListItem.qml
    BodyLabel.qml
    CaptionLabel.qml
    CircleImage.qml
    DisplayLabel.qml
    FluidStyle.qml
    FluidWindow.qml
    HeadlineLabel.qml
    IconButton.qml
    Icon.qml
    ListItemDelegate.qml
    ListItem.qml
    Loadable.qml
    NoiseBackground.qml
    Page.qml
    PageStack.qml
    Showable.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
    Subheader.qml
    SubheadingLabel.qml
    ThinDivider.qml
    TitleLabel.qml
    Units.qml
    Wave.qml
)

install(FILES ${QML_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)

install(DIRECTORY +material
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
