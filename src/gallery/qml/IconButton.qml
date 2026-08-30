// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property int contentSpacing: 16
    readonly property int sectionSpacing: 24

    component Headline: MD.Label {
        typescale: MD.Tokens.typescale.headlineMedium
    }

    component Headline2: MD.Label {
        typescale: MD.Tokens.typescale.headlineSmall
    }

    component LargeLabel: MD.Label {
        typescale: MD.Tokens.typescale.labelLarge
    }

    component DemoIconButton: MD.IconButton {
        text: icon.name.length > 0 ? icon.name.replace(/_/g, " ") : qsTr("Icon action")
    }

    component Sizes: MD.GroupBox {
        title: qsTr("Sizes")

        RowLayout {
            anchors.centerIn: parent
            spacing: page.sectionSpacing

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.ExtraSmall
                icon.name: "play_arrow"
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Small
                icon.name: "play_arrow"
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Medium
                icon.name: "play_arrow"
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.Large
                icon.name: "play_arrow"
            }

            DemoIconButton {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                type: MD.IconButton.Type.Filled
                size: MD.IconButton.Size.ExtraLarge
                icon.name: "play_arrow"
            }
        }
    }

    component Shapes: MD.GroupBox {
        title: qsTr("Shapes")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                shape: MD.IconButton.Shape.Round
                icon.name: "share"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                shape: MD.IconButton.Shape.Square
                icon.name: "share"
            }
        }
    }

    component ColorStyles: MD.GroupBox {
        title: qsTr("Color Styles")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                icon.name: "video_camera_front"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Tonal
                icon.name: "video_camera_front"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Outlined
                icon.name: "video_camera_front"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Standard
                icon.name: "video_camera_front"
            }
        }
    }

    component Widths: MD.GroupBox {
        title: qsTr("Widths")

        ColumnLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: page.sectionSpacing

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Default
                icon.name: "menu"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Narrow
                icon.name: "menu"
            }

            DemoIconButton {
                type: MD.IconButton.Type.Filled
                widthVariant: MD.IconButton.Width.Wide
                icon.name: "menu"
            }
        }
    }

    MD.ScrollView {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: page.sectionSpacing

            ColumnLayout {
                spacing: page.contentSpacing

                Headline {
                    text: qsTr("Configurations")
                }

                RowLayout {
                    spacing: page.contentSpacing

                    Sizes {
                        Layout.fillHeight: true
                    }
                    Shapes {
                        Layout.fillHeight: true
                    }
                    ColorStyles {
                        Layout.fillHeight: true
                    }
                    Widths {
                        Layout.fillHeight: true
                    }
                }
            }

            RowLayout {
                spacing: page.contentSpacing

                Headline {
                    text: qsTr("Colors")
                }

                MD.Switch {
                    id: enabledSwitch

                    text: qsTr("Enabled")
                    checked: true
                }
            }

            GridLayout {
                columns: 4
                rows: 5

                columnSpacing: 20
                rowSpacing: 20

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
                    icon.name: "settings"
                    enabled: enabledSwitch.checked
                }

                DemoIconButton {
                    Layout.row: 2
                    Layout.column: 1
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    objectName: "tonalButton"
                    type: MD.IconButton.Type.Tonal
                    icon.name: "settings"
                    enabled: enabledSwitch.checked
                }

                DemoIconButton {
                    Layout.row: 3
                    Layout.column: 1
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    objectName: "outlinedButton"
                    type: MD.IconButton.Type.Outlined
                    icon.name: "settings"
                    enabled: enabledSwitch.checked
                }

                DemoIconButton {
                    Layout.row: 4
                    Layout.column: 1
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    objectName: "standardButton"
                    type: MD.IconButton.Type.Standard
                    icon.name: "settings"
                    enabled: enabledSwitch.checked
                }

                // Column 2 (toggle unselected)

                DemoIconButton {
                    Layout.row: 1
                    Layout.column: 2
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    objectName: "filledUnselectedButton"
                    type: MD.IconButton.Type.Filled
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
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
                    icon.name: "settings"
                    enabled: enabledSwitch.checked
                    checkable: true
                    checked: true
                }
            }
        }
    }
}
