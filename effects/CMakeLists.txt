set(FILES
    plugins.qmltypes
    qmldir
    Vignette.qml
)

install(FILES ${FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Effects)
