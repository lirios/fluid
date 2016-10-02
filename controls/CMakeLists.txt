set(SOURCES
    iconthemeimageprovider.cpp
    plugin.cpp
)

set(QML_FILES
    plugins.qmltypes
    qmldir
    Action.qml
    AppBar.qml
    AppToolBar.qml
    BaseListItem.qml
    BodyLabel.qml
    CaptionLabel.qml
    Card.qml
    CircleImage.qml
    Dialog.qml
    DisplayLabel.qml
    FluidStyle.qml
    FluidWindow.qml
    HeadlineLabel.qml
    IconButton.qml
    Icon.qml
    InfoBar.qml
    ListItemDelegate.qml
    ListItem.qml
    Loadable.qml
    NoiseBackground.qml
    Page.qml
    PageStack.qml
    Placeholder.qml
    Showable.qml
    Sidebar.qml
    SmoothFadeImage.qml
    SmoothFadeLoader.qml
    Subheader.qml
    SubheadingLabel.qml
    ThinDivider.qml
    TitleLabel.qml
    Units.qml
)

add_library(fluidcontrols SHARED ${SOURCES} ${QML_FILES})
target_link_libraries(fluidcontrols Qt5::Gui Qt5::Quick)

install(TARGETS fluidcontrols LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
install(FILES ${QML_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
install(DIRECTORY +material
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
