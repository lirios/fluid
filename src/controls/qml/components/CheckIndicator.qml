// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

import QtQuick
import QtQuick.Shapes
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics

/*!
    \class CheckIndicator
    \brief Draws the Material 3 checked, unchecked, or indeterminate checkbox indicator.

    CheckIndicator is the visual delegate used by CheckBox. The \c control must
    expose a Qt checkbox \c checkState; the remaining properties provide the
    resolved colors and outline width for the current interaction state.

    For more information see the
    <a href="https://m3.material.io/components/checkbox/overview">Material Design 3 checkbox guidelines</a>.
*/
Item {
    id: indicatorItem
    Accessible.ignored: true

    //! The checkbox whose \c checkState is rendered.
    property Item control

    //! The checkmark or indeterminate-mark color.
    property color color

    //! The checkbox container color.
    property color backgroundColor

    //! The checkbox outline color.
    property color outlineColor

    //! The checkbox outline width in pixels.
    property real outlineWidth

    implicitWidth: MD.Tokens.checkBox.containerSize + MD.Tokens.checkBox.containerPadding * 2
    implicitHeight: MD.Tokens.checkBox.containerSize + MD.Tokens.checkBox.containerPadding * 2

    Rectangle {
        id: container

        anchors.centerIn: parent
        implicitWidth: MD.Tokens.checkBox.containerSize
        implicitHeight: MD.Tokens.checkBox.containerSize
        color: indicatorItem.backgroundColor
        topLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.checkBox.containerShape.topLeft,
                                                    width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(MD.Tokens.checkBox.containerShape.topRight,
                                                     width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                  MD.Tokens.checkBox.containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(
                                   MD.Tokens.checkBox.containerShape.bottomRight, width, height)
        border.width: indicatorItem.outlineWidth
        border.color: indicatorItem.outlineColor

        Behavior on color {
            ColorAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }

        Behavior on border.width {
            NumberAnimation {
                duration: MD.Tokens.motion.duration.short2
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
