set(FLUID_FILES
    qmldir
    Icon.qml
    Loadable.qml
    NoiseBackground.qml
    Showable.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Ui)
