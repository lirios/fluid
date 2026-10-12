// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls as T
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    readonly property real contentSpacing: MD.Tokens.measurement.space200
    readonly property real sectionSpacing: MD.Tokens.measurement.space300

    readonly property var appearances: [
        { "name": "Filled", "type": MD.SplitButton.Type.Filled },
        { "name": "Tonal", "type": MD.SplitButton.Type.Tonal },
        { "name": "Elevated", "type": MD.SplitButton.Type.Elevated },
        { "name": "Outlined", "type": MD.SplitButton.Type.Outlined }
    ]
    readonly property var sizes: [
        { "name": "ExtraSmall", "shortName": "XS", "size": MD.SplitButton.Size.ExtraSmall },
        { "name": "Small", "shortName": "S", "size": MD.SplitButton.Size.Small },
        { "name": "Medium", "shortName": "M", "size": MD.SplitButton.Size.Medium },
        { "name": "Large", "shortName": "L", "size": MD.SplitButton.Size.Large },
        { "name": "ExtraLarge", "shortName": "XL", "size": MD.SplitButton.Size.ExtraLarge }
    ]

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Split buttons")
        description: qsTr("Split buttons pair a primary action with a separate menu action. Each side has its own focus and activation target.")

        GalleryCard {
            objectName: "splitButton-appearancesCard"
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Appearances and sizes")

            contentItem: ColumnLayout {
                objectName: "splitButton-appearancesLayout"
                spacing: page.contentSpacing

                Repeater {
                    model: page.appearances

                    delegate: ColumnLayout {
                        id: appearanceRow
                        required property var modelData
                        required property int index
                        objectName: "splitButton-appearance-" + modelData.name.toLowerCase()
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        spacing: page.contentSpacing

                        MD.Label {
                            text: qsTr(modelData.name)
                            typescale: MD.Tokens.typescale.labelLarge
                        }

                        Flow {
                            id: appearanceFlow
                            objectName: "splitButton-appearanceFlow-" + appearanceRow.modelData.name.toLowerCase()
                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            Layout.preferredWidth: 0
                            spacing: page.contentSpacing

                            Repeater {
                                model: page.sizes

                                delegate: ColumnLayout {
                                    required property var modelData
                                    required property int index
                                    objectName: "splitButton-example-" + appearanceRow.modelData.name.toLowerCase()
                                                + "-" + modelData.name.toLowerCase()
                                    // Only a single example wider than the viewport is constrained.
                                    width: Math.min(implicitWidth, appearanceFlow.width)
                                    height: implicitHeight
                                    spacing: MD.Tokens.measurement.space100

                                    MD.SplitButton {
                                        objectName: "splitButton-" + page.appearances[appearanceRow.index].name.toLowerCase()
                                                    + "-" + modelData.name.toLowerCase()
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.fillWidth: true
                                        Layout.minimumWidth: 0
                                        // Avoid rounding a fractional natural width down and eliding its label.
                                        Layout.preferredWidth: Math.ceil(implicitWidth)
                                        Layout.maximumWidth: Layout.preferredWidth
                                        type: page.appearances[appearanceRow.index].type
                                        size: modelData.size
                                        text: qsTr("Save")
                                        icon.name: MD.Symbols.save
                                        secondaryText: qsTr("More save options")
                                    }

                                    MD.Label {
                                        objectName: "splitButton-caption-" + appearanceRow.modelData.name.toLowerCase()
                                                    + "-" + modelData.name.toLowerCase()
                                        Layout.alignment: Qt.AlignHCenter
                                        text: modelData.shortName
                                        typescale: MD.Tokens.typescale.labelMedium
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Primary content")

            Flow {
                width: parent.width
                spacing: page.contentSpacing

                MD.SplitButton {
                    objectName: "splitButton-labelOnly"
                    text: qsTr("Continue")
                    secondaryText: qsTr("More continue options")
                }
                MD.SplitButton {
                    objectName: "splitButton-iconOnly"
                    icon.name: MD.Symbols.add
                    Component.onCompleted: leadingButton.Accessible.name = Qt.binding(() => qsTr("Create"))
                    secondaryText: qsTr("More create options")
                }
                MD.SplitButton {
                    objectName: "splitButton-combined"
                    text: qsTr("Create")
                    icon.name: MD.Symbols.add
                    secondaryText: qsTr("More create options")
                }
                MD.SplitButton {
                    objectName: "splitButton-sourceIcon"
                    text: qsTr("Gallery")
                    icon.source: Qt.resolvedUrl("../icons/32x32/apps/io.liri.Fluid.Gallery.png")
                    secondaryText: qsTr("More gallery options")
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Menu, custom popup, and disabled actions")

            Flow {
                width: parent.width
                spacing: page.contentSpacing

                MD.SplitButton {
                    id: managedButton
                    objectName: "splitButton-managedMenu"
                    text: qsTr("Save")
                    icon.name: MD.Symbols.save

                    menu: MD.Menu {
                        MD.Action { text: qsTr("Save as…") }
                        MD.Action { text: qsTr("Export") }
                    }
                }

                MD.SplitButton {
                    id: customButton
                    objectName: "splitButton-customPopup"
                    text: qsTr("Filter")
                    icon.name: MD.Symbols.filterList
                    expanded: customPopup.visible
                    onSecondaryClicked: customPopup.visible ? customPopup.close() : customPopup.open()
                }

                MD.SplitButton {
                    objectName: "splitButton-disabled"
                    text: qsTr("Unavailable")
                    icon.name: MD.Symbols.block
                    primaryEnabled: false
                    secondaryEnabled: false
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Right to left")

            Item {
                objectName: "splitButton-rtl"
                width: Math.min(parent.width, rtlButton.implicitWidth)
                implicitHeight: rtlButton.implicitHeight
                LayoutMirroring.enabled: true
                LayoutMirroring.childrenInherit: true

                MD.SplitButton {
                    id: rtlButton
                    anchors.left: parent.left
                    objectName: "splitButton-rtl-control"
                    text: qsTr("Move to folder")
                    icon.name: MD.Symbols.folder
                    secondaryText: qsTr("More folder actions")
                }
            }
        }

        GalleryCard {
            gridColumns: galleryPage.columns
            title: qsTr("Light and dark themes")

            Flow {
                width: parent.width
                spacing: page.contentSpacing

                MD.SplitButton {
                    objectName: "splitButton-lightTheme"
                    MD.Style.theme: MD.Style.Light
                    text: qsTr("Light theme")
                    icon.name: MD.Symbols.lightMode
                }
                MD.SplitButton {
                    objectName: "splitButton-darkTheme"
                    MD.Style.theme: MD.Style.Dark
                    text: qsTr("Dark theme")
                    icon.name: MD.Symbols.darkMode
                }
            }
        }

        GalleryCard {
            id: constrainedCard
            objectName: "splitButton-constrainedCard"
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Constrained width")

            contentItem: ColumnLayout {
                objectName: "splitButton-constrainedLayout"
                spacing: page.contentSpacing

                MD.Label {
                    objectName: "splitButton-constrainedDescription"
                    Layout.fillWidth: true
                    text: qsTr("When space is limited, the primary label is elided while the trailing target keeps its preferred width. An allocation narrower than both 48 dp targets plus the gap cannot meet the minimum target sizes.")
                    wrapMode: Text.WordWrap
                    elide: Text.ElideNone
                    color: constrainedCard.MD.Style.onSurfaceVariantColor
                }

                MD.SplitButton {
                    objectName: "splitButton-constrained"
                    Layout.fillWidth: true
                    Layout.preferredWidth: implicitWidth * 0.65
                    Layout.maximumWidth: Layout.preferredWidth
                    text: qsTr("Move to a very long destination folder")
                    icon.name: MD.Symbols.folder
                }
            }
        }
    }

    T.Popup {
        id: customPopup
        objectName: "splitButton-customPopup-menu"
        parent: customButton.trailingButton
        focus: true
        closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent
        padding: MD.Tokens.measurement.space200
        onAboutToShow: {
            const mirrored = customButton.mirrored || customButton.locale.textDirection === Qt.RightToLeft;
            x = mirrored ? customButton.trailingButton.width - width : 0;
            y = customButton.trailingButton.background.y + customButton.trailingButton.background.height
                + MD.Tokens.splitButton.menuAnchorGap;
        }

        background: Rectangle {
            color: customButton.MD.Style.surfaceContainerColor
            radius: MD.Tokens.shape.cornerValueMedium
        }

        contentItem: MD.Label {
            text: qsTr("Caller-managed popup content")
            color: customButton.MD.Style.onSurfaceColor
        }
    }
}
