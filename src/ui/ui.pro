QT += qml quick

TARGETPATH = FluidUi

QML_FILES = \
    Icon.qml \
    ListItems/Base.qml \
    ListItems/Empty.qml \
    ListItems/Standard.qml \
    ListItems/Highlight.qml \
    ListItems/qmldir

load(qml_module)
