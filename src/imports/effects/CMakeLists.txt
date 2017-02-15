set(FILES
    plugins.qmltypes
    qmldir
    BoxShadow.qml
    CircleMask.qml
    Vignette.qml
)

install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Effects)
