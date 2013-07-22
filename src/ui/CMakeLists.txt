set(FLUID_FILES
    qmldir
    Icon.qml
    ListItems/Base.qml
    ListItems/Empty.qml
    ListItems/Standard.qml
    ListItems/Highlight.qml
    ListItems/qmldir
)

install(FILES ${FLUID_FILES}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml/FluidUi)

set(LISTITEMS_FILES
    ListItems/Base.qml
    ListItems/Empty.qml
    ListItems/Standard.qml
    ListItems/Highlight.qml
    ListItems/qmldir
)

install(FILES ${LISTITEMS_FILES}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml/FluidUi/ListItems)
