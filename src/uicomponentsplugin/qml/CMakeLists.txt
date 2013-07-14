# Install FluidUi code
set(MODULE_FILES
    qmldir
    Icon.qml
)
install(FILES ${MODULE_FILES}
    DESTINATION ${QT_IMPORTS_DIR}/FluidUi)

# Install FluidUi.ListItems code
set(MODULE_FILES
    ListItems/qmldir
    ListItems/Empty.qml
    ListItems/Base.qml
    ListItems/Standard.qml
)
install(FILES ${MODULE_FILES}
    DESTINATION ${QT_IMPORTS_DIR}/FluidUi/ListItems)
