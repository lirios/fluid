set(FLUID_FILES
    plugins.qmltypes
    qmldir
    ElevationEffect.qml
    Ripple.qml
    Wave.qml
)

install(FILES ${FLUID_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Material)
