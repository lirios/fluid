set(FLUID_FILES
    qmldir
    Action.qml
    AppBar.qml
    AppToolBar.qml
    BodyLabel.qml
    CircleImage.qml
    CaptionLabel.qml
    DisplayLabel.qml
    FluidStyle.qml
    FluidWindow.qml
    HeadlineLabel.qml
    Icon.qml
    IconButton.qml
    Loadable.qml
    NoiseBackground.qml
    Page.qml
    PageStack.qml
    Showable.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
    SubheadingLabel.qml
    TitleLabel.qml
    Units.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/UI)

install(DIRECTORY +material
        DESTINATION ${QML_INSTALL_DIR}/Fluid/UI)
