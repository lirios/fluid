// SPDX-FileCopyrightText: 2025-2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Fluid as MD

Item {
    id: page

    component Elevation: MD.Elevation {
        implicitWidth: 160
        implicitHeight: implicitWidth
        radius: radiusSlider.value
        visible: true

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "lightgray"
        }
    }

    GalleryPage {
        id: galleryPage

        anchors.fill: parent
        headline: qsTr("Elevation")
        description: qsTr("Elevation communicates the relative distance between surfaces with tonal shadows ranging from level 0 through level 5.")

        GalleryCard {
            gridColumns: galleryPage.columns
            fullWidth: true
            title: qsTr("Elevation levels")

            ColumnLayout {
                width: parent.width
                spacing: galleryPage.sectionSpacing

                RowLayout {
                    Layout.fillWidth: true
                    spacing: galleryPage.sectionSpacing

                    MD.Label {
                        text: qsTr("Corner radius: %1").arg(radiusSlider.value)
                    }

                    MD.Slider {
                        id: radiusSlider
                        Accessible.name: qsTr("Corner radius")

                        Layout.fillWidth: true
                        from: 0
                        to: 80
                        stepSize: 2
                        value: 8
                    }
                }

                Item {
                    Layout.fillWidth: true
                    implicitHeight: elevationGrid.height

                    MD.AutomaticGrid {
                        id: elevationGrid

                        anchors.horizontalCenter: parent.horizontalCenter
                        cellWidth: Math.min(160, Math.max(1, widthOverride - minColumnSpacing * 2))
                        cellHeight: cellWidth
                        widthOverride: parent.width
                        minColumnSpacing: galleryPage.spaciousSpacing
                        rowSpacing: galleryPage.spaciousSpacing
                        model: [
                            MD.Tokens.elevation.level0,
                            MD.Tokens.elevation.level1,
                            MD.Tokens.elevation.level2,
                            MD.Tokens.elevation.level3,
                            MD.Tokens.elevation.level4,
                            MD.Tokens.elevation.level5
                        ]

                        delegate: Elevation {
                            required property real modelData

                            width: elevationGrid.cellWidth
                            height: elevationGrid.cellHeight
                            elevation: modelData
                        }
                    }
                }
            }
        }
    }
}
