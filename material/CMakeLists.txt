set(FLUID_FILES
    qmldir
    ElevationEffect.qml
    Ripple.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Material)
