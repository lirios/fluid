// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes

Item {
    id: background

    required property color containerColor
    required property color outlineColor
    required property color stateLayerColor
    required property real stateLayerOpacity
    required property real outlineWidth
    required property real leftRadius
    required property real rightRadius
    required property bool drawLeftOutline

    Accessible.ignored: true

    Rectangle {
        anchors.fill: parent
        color: background.containerColor
        topLeftRadius: background.leftRadius
        bottomLeftRadius: background.leftRadius
        topRightRadius: background.rightRadius
        bottomRightRadius: background.rightRadius
    }

    Rectangle {
        objectName: "segmentedButtonStateLayer"
        anchors.fill: parent
        color: background.stateLayerColor
        opacity: background.stateLayerOpacity
        topLeftRadius: background.leftRadius
        bottomLeftRadius: background.leftRadius
        topRightRadius: background.rightRadius
        bottomRightRadius: background.rightRadius
    }

    // Each segment owns its right divider. Only the physical left endpoint
    // draws a left edge, so translucent disabled outlines never overlap.
    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            fillColor: "transparent"
            strokeColor: background.outlineColor
            strokeWidth: background.outlineWidth
            capStyle: ShapePath.FlatCap
            joinStyle: ShapePath.MiterJoin
            PathSvg {
                path: {
                    const inset = background.outlineWidth / 2;
                    const left = background.drawLeftOutline ? inset : 0;
                    const right = Math.max(left, background.width - inset);
                    const bottom = Math.max(inset, background.height - inset);
                    const lr = Math.max(0, background.leftRadius - inset);
                    const rr = Math.max(0, background.rightRadius - inset);
                    let result = "M " + (left + lr) + " " + inset
                            + " H " + (right - rr);
                    if (rr > 0)
                        result += " A " + rr + " " + rr + " 0 0 1 " + right + " " + (inset + rr);
                    result += " V " + (bottom - rr);
                    if (rr > 0)
                        result += " A " + rr + " " + rr + " 0 0 1 " + (right - rr) + " " + bottom;
                    result += " H " + (left + lr);
                    if (background.drawLeftOutline) {
                        if (lr > 0)
                            result += " A " + lr + " " + lr + " 0 0 1 " + left + " " + (bottom - lr);
                        result += " V " + (inset + lr);
                        if (lr > 0)
                            result += " A " + lr + " " + lr + " 0 0 1 " + (left + lr) + " " + inset;
                        result += " Z";
                    }
                    return result;
                }
            }
        }
    }
}
