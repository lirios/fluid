set(FLUID_FILES
    qmldir
    FluidStyle.qml
    Icon.qml
    Loadable.qml
    NoiseBackground.qml
    Showable.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
    Units.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/UI)
