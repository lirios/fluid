// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Fluid as MD

MD.ApplicationWindow {
    id: window

    visible: true

    width: MD.Breakpoints.largeLowerBound
    height: MD.Breakpoints.expandedLowerBound

    minimumWidth: MD.Breakpoints.mediumLowerBound
    minimumHeight: MD.Breakpoints.mediumLowerBound

    title: qsTr("Fluid Gallery")

    readonly property var navigationCategories: [
        {
            "name": qsTr("Foundations"),
            "icon": MD.SymbolNames.symbolFoundation,
            "items": [
                {
                    "name": qsTr("Elevation"),
                    "source": "Elevation.qml"
                },
                {
                    "name": qsTr("Grids"),
                    "source": "Grids.qml"
                },
                {
                    "name": qsTr("Symbols"),
                    "source": "Symbols.qml"
                },
                {
                    "name": qsTr("Colors"),
                    "source": "Colors.qml"
                },
                {
                    "name": qsTr("Typography"),
                    "source": "Typography.qml"
                }
            ]
        },
        {
            "name": qsTr("Components"),
            "icon": MD.SymbolNames.symbolWidgets,
            "items": [
                {
                    "name": qsTr("Components overview"),
                    "source": "Components.qml"
                },
                {
                    "name": qsTr("Divider"),
                    "source": "Divider.qml"
                },
                {
                    "name": qsTr("Exposed Dropdown Menus"),
                    "source": "ExposedDropdownMenus.qml"
                },
                {
                    "name": qsTr("Menus"),
                    "source": "Menus.qml"
                },
                {
                    "name": qsTr("Navigation Rails"),
                    "source": "NavigationRails.qml"
                },
                {
                    "name": qsTr("Icon Button"),
                    "source": "IconButton.qml"
                },
                {
                    "name": qsTr("FAB"),
                    "source": "FAB.qml"
                },
                {
                    "name": qsTr("Extended FAB"),
                    "source": "ExtendedFAB.qml"
                },
                {
                    "name": qsTr("FAB Menu"),
                    "source": "FabMenu.qml"
                },
                {
                    "name": qsTr("App Bars"),
                    "source": "AppBars.qml"
                },
                {
                    "name": qsTr("Indicators"),
                    "source": "Indicators.qml"
                },
                {
                    "name": qsTr("Slider"),
                    "source": "Slider.qml"
                },
                {
                    "name": qsTr("Text Fields"),
                    "source": "TextFields.qml"
                },
                {
                    "name": qsTr("Lists"),
                    "source": "Lists.qml"
                },
                {
                    "name": qsTr("Tooltips"),
                    "source": "ToolTips.qml"
                }
            ]
        }
    ]

    property int previewCategoryIndex: 0
    property int selectedCategoryIndex: 0
    property string selectedSource: "Elevation.qml"

    Item {
        anchors.fill: parent

        Loader {
            id: loader
            objectName: "galleryDetailPane"

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: categoryRail.width

            source: window.selectedSource
        }

        Item {
            id: navigationContainer
            objectName: "galleryNavigation"

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: categoryRail.width + (categoryPane.visible ? categoryPane.width : 0)
            z: 1

            property bool paneOpen: false
            property int openCategoryIndex: -1

            function toggleCategory(index) {
                const closeCurrent = paneOpen && openCategoryIndex === index;
                window.previewCategoryIndex = index;
                if (closeCurrent) {
                    paneOpen = false;
                    return;
                }
                openCategoryIndex = index;
                paneOpen = true;
            }

            MD.NavigationRail {
                id: categoryRail
                objectName: "galleryCategoryRail"
                Accessible.name: qsTr("Gallery categories")

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                expanded: false

                MD.NavigationRailItem {
                    text: window.navigationCategories[0].name
                    icon.name: window.navigationCategories[0].icon

                    onClicked: navigationContainer.toggleCategory(0)
                }

                MD.NavigationRailItem {
                    text: window.navigationCategories[1].name
                    icon.name: window.navigationCategories[1].icon

                    onClicked: navigationContainer.toggleCategory(1)
                }
            }

            Rectangle {
                id: categoryPane
                objectName: "galleryCategoryPane"

                anchors.left: categoryRail.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 280

                visible: navigationContainer.paneOpen
                clip: true
                color: window.MD.Style.surfaceContainerLowColor

                MD.Divider {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    orientation: Qt.Vertical
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: MD.Tokens.measurement.space200
                    spacing: MD.Tokens.measurement.space100

                    MD.Label {
                        Layout.fillWidth: true
                        Layout.leftMargin: MD.Tokens.measurement.space100
                        Layout.rightMargin: MD.Tokens.measurement.space100

                        text: window.navigationCategories[window.previewCategoryIndex].name
                        typescale: MD.Tokens.typescale.titleLarge
                        color: window.MD.Style.onSurfaceColor
                    }

                    MD.ScrollView {
                        id: categoryScrollView

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        ListView {
                            id: categoryList
                            objectName: "galleryCategoryList"

                            width: categoryScrollView.availableWidth
                            height: categoryScrollView.availableHeight
                            spacing: MD.Tokens.measurement.space50
                            boundsBehavior: Flickable.StopAtBounds
                            model: window.navigationCategories[window.previewCategoryIndex].items

                            delegate: MD.ListItem {
                                id: destinationItem

                                required property int index
                                required property var modelData

                                readonly property bool selected: destinationItem.modelData.source === window.selectedSource

                                width: ListView.view.width
                                text: destinationItem.modelData.name

                                onClicked: {
                                    window.selectedCategoryIndex = window.previewCategoryIndex;
                                    window.selectedSource = destinationItem.modelData.source;
                                    categoryRail.currentIndex = window.selectedCategoryIndex;
                                    navigationContainer.paneOpen = false;
                                }

                                background: Rectangle {
                                    implicitWidth: 64
                                    implicitHeight: MD.Tokens.listItem.oneLineContainerHeight
                                    radius: MD.Tokens.shape.cornerLarge.topLeft
                                    color: {
                                        if (destinationItem.selected)
                                            return window.MD.Style.secondaryContainerColor;
                                        if (destinationItem.down)
                                            return window.MD.Style.surfaceContainerHighestColor;
                                        if (destinationItem.hovered || destinationItem.visualFocus)
                                            return window.MD.Style.surfaceContainerHighColor;
                                        return "transparent";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
