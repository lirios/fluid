# Install FluidUi code
set(MODULE_FILES
    qmldir
    Icon.qml
)
install(FILES ${MODULE_FILES}
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi)

# Install FluidUi.ListItems code
set(MODULE_FILES
    ListItems/qmldir
    ListItems/Empty.qml
    ListItems/Base.qml
    ListItems/Standard.qml
)
install(FILES ${MODULE_FILES}
    DESTINATION ${CMAKE_INSTALL_QMLDIR}/FluidUi/ListItems)
