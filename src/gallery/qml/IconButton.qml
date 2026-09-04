// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    component LargeLabel: MD.Label {
        typescale: MD.Tokens.typescale.labelLarge
    }

    component DemoIconButton: MD.IconButton {
        text: qsTr("Icon action")
    }

    component Sizes: GalleryCard {
        gridColumns: galleryPage.columns
        title: qsTr("Sizes")

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.min(5, Math.floor(width / 72)))
            columnSpacing: page.sectionSpacing
            rowSpacing: page.sectionSpacing

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.ExtraSmall
                icon.name: MD.Symbols.playArrow
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Small
                icon.name: MD.Symbols.playArrow
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Medium
                icon.name: MD.Symbols.playArrow
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Large
                icon.name: MD.Symbols.playArrow
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.ExtraLarge
                icon.name: MD.Symbols.playArrow
            }
        }
    }

    component Shapes: GalleryCard {
        gridColumns: galleryPage.columns
        title: qsTr("Shapes")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                shape: MD.IconButton.Shape.Round
                icon.name: MD.Symbols.share
            }

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                shape: MD.IconButton.Shape.Square
                icon.name: MD.Symbols.share
            }
        }
    }

    component ColorStyles: GalleryCard {
        gridColumns: galleryPage.columns
        title: qsTr("Color Styles")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                icon.name: MD.Symbols.videoCameraFront
            }

            DemoIconButton {
                type: MD.IconButton.Type.Tonal
                icon.name: MD.Symbols.videoCameraFront
            }

            DemoIconButton {
                type: MD.IconButton.Type.Outlined
                icon.name: MD.Symbols.videoCameraFront
            }

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                icon.name: MD.Symbols.videoCameraFront
            }
        }
    }

    component Widths: GalleryCard {
        gridColumns: galleryPage.columns
        title: qsTr("Widths")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Default
                icon.name: MD.Symbols.menu
            }

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Narrow
                icon.name: MD.Symbols.menu
            }

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Wide
                icon.name: MD.Symbols.menu
            }
        }
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Icon buttons")
        description: qsTr("Icon buttons provide compact actions with multiple sizes, shapes, widths, colors, and selection states.")

        Sizes {}
        Shapes {}
        ColorStyles {}
        Widths {}

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Colors")

            ColumnLayout {
                width: parent.width
                spacing: page.contentSpacing

                MD.Switch {
                    id: enabledSwitch

                    text: qsTr("Enabled")
                    checked: true
                }
                GridLayout {
                    Layout.alignment: Qt.AlignHCenter
                    columns: 4
                    rows: 5

                    columnSpacing: MD.Tokens.measurement.space250
                    rowSpacing: MD.Tokens.measurement.space250

                    // Numbers and letters

                    LargeLabel {
                        Layout.row: 0
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Default")
                    }

                    LargeLabel {
                        Layout.row: 0
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Unselected")
                    }

                    LargeLabel {
                        Layout.row: 0
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Selected")
                    }

                    LargeLabel {
                        Layout.row: 1
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Filled")
                    }

                    LargeLabel {
                        Layout.row: 2
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Tonal")
                    }

                    LargeLabel {
                        Layout.row: 3
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Outlined")
                    }

                    LargeLabel {
                        Layout.row: 4
                        Layout.column: 0
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        text: qsTr("Standard")
                    }

                    // Column 1 (default)

                    DemoIconButton {
                        Layout.row: 1
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "filledButton"
                        type: MD.IconButton.Type.Filled
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                    }

                    DemoIconButton {
                        Layout.row: 2
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "tonalButton"
                        type: MD.IconButton.Type.Tonal
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                    }

                    DemoIconButton {
                        Layout.row: 3
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "outlinedButton"
                        type: MD.IconButton.Type.Outlined
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                    }

                    DemoIconButton {
                        Layout.row: 4
                        Layout.column: 1
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "standardButton"
                        type: MD.IconButton.Type.Standard
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                    }

                    // Column 2 (toggle unselected)

                    DemoIconButton {
                        Layout.row: 1
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "filledUnselectedButton"
                        type: MD.IconButton.Type.Filled
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: false
                    }

                    DemoIconButton {
                        Layout.row: 2
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "tonalUnselectedButton"
                        type: MD.IconButton.Type.Tonal
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: false
                    }

                    DemoIconButton {
                        Layout.row: 3
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "outlinedUnselectedButton"
                        type: MD.IconButton.Type.Outlined
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: false
                    }

                    DemoIconButton {
                        Layout.row: 4
                        Layout.column: 2
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "standardUnselectedButton"
                        type: MD.IconButton.Type.Standard
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: false
                    }

                    // Column 3 (toggle selected)

                    DemoIconButton {
                        Layout.row: 1
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "filledSelectedButton"
                        type: MD.IconButton.Type.Filled
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: true
                    }

                    DemoIconButton {
                        Layout.row: 2
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "tonalSelectedButton"
                        type: MD.IconButton.Type.Tonal
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: true
                    }

                    DemoIconButton {
                        Layout.row: 3
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "outlinedSelectedButton"
                        type: MD.IconButton.Type.Outlined
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: true
                    }

                    DemoIconButton {
                        Layout.row: 4
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        objectName: "standardSelectedButton"
                        type: MD.IconButton.Type.Standard
                        icon.name: MD.Symbols.settings
                        enabled: enabledSwitch.checked
                        checkable: true
                        checked: true
                    }
                }
            }
        }
    }
}
