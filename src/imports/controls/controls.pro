TARGET = fluidcontrolsplugin
TARGETPATH = Fluid/Controls
IMPORT_VERSION = 1.0

QT += qml quick

QML_FILES += \
    Action.qml \
    AlertDialog.qml \
    AppBar.qml \
    ApplicationWindow.qml \
    AppToolBar.qml \
    BaseListItem.qml \
    BodyLabel.qml \
    CaptionLabel.qml \
    Card.qml \
    CircleImage.qml \
    DialogLabel.qml \
    DisplayLabel.qml \
    FluidStyle.qml \
    FluidWindow.qml \
    HeadlineLabel.qml \
    IconButton.qml \
    Icon.qml \
    InfoBar.qml \
    InputDialog.qml \
    ListItemDelegate.qml \
    ListItem.qml \
    Loadable.qml \
    MenuItem.qml \
    NavigationDrawer.qml \
    NoiseBackground.qml \
    Page.qml \
    PageStack.qml \
    Placeholder.qml \
    Showable.qml \
    Sidebar.qml \
    SmoothFadeImage.qml \
    SmoothFadeLoader.qml \
    Subheader.qml \
    SubheadingLabel.qml \
    Tab.qml \
    TabbedPage.qml \
    ThinDivider.qml \
    TitleLabel.qml \
    Units.qml \
    +material/BaseListItem.qml \
    +material/BodyLabel.qml \
    +material/CaptionLabel.qml \
    +material/DialogLabel.qml \
    +material/DisplayLabel.qml

include(controls.pri)

CONFIG += no_cxx_module
load(liri_qml_plugin)

icons.path = $$target.path/icons
icons.files += $$FLUID_SOURCE_TREE/icons/action
icons.files += $$FLUID_SOURCE_TREE/icons/av
icons.files += $$FLUID_SOURCE_TREE/icons/communication
icons.files += $$FLUID_SOURCE_TREE/icons/device
icons.files += $$FLUID_SOURCE_TREE/icons/file
icons.files += $$FLUID_SOURCE_TREE/icons/image
icons.files += $$FLUID_SOURCE_TREE/icons/maps
icons.files += $$FLUID_SOURCE_TREE/icons/notification
icons.files += $$FLUID_SOURCE_TREE/icons/social
icons.files += $$FLUID_SOURCE_TREE/icons/toggle
icons.files += $$FLUID_SOURCE_TREE/icons/alert
icons.files += $$FLUID_SOURCE_TREE/icons/content
icons.files += $$FLUID_SOURCE_TREE/icons/editor
icons.files += $$FLUID_SOURCE_TREE/icons/hardware
icons.files += $$FLUID_SOURCE_TREE/icons/navigation
INSTALLS += icons

android {
    qmlfiles2build.files = $$QML_FILES
    qmlfiles2build.path = $$DESTDIR
    icons2build.files = $$icons.files
    icons2build.path = $$DESTDIR/icons
    COPIES += qmlfiles2build icons2build
}
