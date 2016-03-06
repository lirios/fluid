set(FILES
    qmldir
    Vignette.qml
)

install(FILES ${FILES}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/hawaii/qml/Fluid/Effects)
