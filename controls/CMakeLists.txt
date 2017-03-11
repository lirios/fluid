set(SOURCES
    iconthemeimageprovider.cpp
    controlsplugin.cpp
)

set(QML_FILES
    plugins.qmltypes
    qmldir
    Action.qml
    AlertDialog.qml
    AppBar.qml
    ApplicationWindow.qml
    AppToolBar.qml
    BaseListItem.qml
    BodyLabel.qml
    CaptionLabel.qml
    Card.qml
    CircleImage.qml
    DialogLabel.qml
    DisplayLabel.qml
    FluidStyle.qml
    FluidWindow.qml
    HeadlineLabel.qml
    IconButton.qml
    Icon.qml
    InfoBar.qml
    InputDialog.qml
    ListItemDelegate.qml
    ListItem.qml
    Loadable.qml
    MenuItem.qml
    NavigationDrawer.qml
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
    Tab.qml
    TabbedPage.qml
    ThinDivider.qml
    TitleLabel.qml
    Units.qml
)

set(MATERIAL_FILES
    +material/BaseListItem.qml
    +material/BodyLabel.qml
    +material/CaptionLabel.qml
    +material/DialogLabel.qml
    +material/DisplayLabel.qml
    +material/HeadlineLabel.qml
    +material/SubheadingLabel.qml
    +material/ThinDivider.qml
    +material/TitleLabel.qml
)

add_library(fluidcontrols SHARED ${SOURCES} ${QML_FILES} ${MATERIAL_FILES})
target_link_libraries(fluidcontrols Qt5::Gui Qt5::Quick)

install(TARGETS fluidcontrols LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
install(FILES ${QML_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls)
install(FILES ${MATERIAL_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Fluid/Controls/+material)
