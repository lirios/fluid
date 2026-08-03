// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import QtQuick.Shapes
import Fluid as MD

Item {
    id: indicatorItem

    property Item control
    property color color
    property color backgroundColor
    property color outlineColor
    property real outlineWidth

    implicitWidth: 18 + MD.Tokens.spacingSmall
    implicitHeight: 18 + MD.Tokens.spacingSmall

    Rectangle {
        id: container

        anchors.centerIn: parent
        implicitWidth: 18
        implicitHeight: 18
        color: indicatorItem.backgroundColor
        radius: 2
        border.width: indicatorItem.outlineWidth
        border.color: indicatorItem.outlineColor

        Behavior on color {
            ColorAnimation {
                duration: MD.Tokens.durationShort2
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: MD.Tokens.durationShort2
            }
        }

        Behavior on border.width {
            NumberAnimation {
                duration: MD.Tokens.durationShort2
            }
        }

        MD.Shape {
            id: checkmark

            anchors.fill: parent
            visible: control.checkState !== Qt.Unchecked

            transform: [
                Translate {
                    x: -7
                    y: -7
                }
            ]

            ShapePath {
                objectName: "svg_path:checked"
                strokeColor: "transparent"
                fillRule: ShapePath.WindingFill
                fillColor: control.checkState === Qt.Checked ? indicatorItem.color : "transparent"
                pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles

                PathSvg {
                    path: "M 14 18.2 L 11.4 15.6 L 10 17 L 14 21 L 22 13 L 20.6 11.6 L 14 18.2 "
                }
            }

            ShapePath {
                objectName: "svg_path:partially_checked"
                strokeColor: "transparent"
                fillRule: ShapePath.WindingFill
                fillColor: control.checkState === Qt.PartiallyChecked ? indicatorItem.color : "transparent"
                pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles

                PathSvg {
                    path: "M 13.4 15 L 11 15 L 11 17 L 13.4 17 L 21 17 L 21 15 L 13.4 15 "
                }
            }
        }
    }
}
