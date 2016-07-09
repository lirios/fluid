set(FLUID_FILES
    qmldir
    Action.qml
    AppBar.qml
    AppToolBar.qml
    FluidStyle.qml
    FluidWindow.qml
    Icon.qml
    IconButton.qml
    Loadable.qml
    NoiseBackground.qml
    Page.qml
    PageStack.qml
    Showable.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
    Units.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/UI)
