// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl as TImpl
import Fluid as MD
import "MotionAnimation.js" as MotionAnimation

Item {
    id: content

    required property bool trailing
    required property bool mirrored
    required property bool expanded
    required property string text
    required property string iconName
    required property url iconSource
    required property real iconWidth
    required property real iconHeight
    required property int display
    required property font textFont
    required property real lineHeight
    required property color contentColor
    required property color iconColor
    required property real contentOpacity
    required property real spacing
    required property real startPadding
    required property real endPadding
    required property real opticalOffset

    readonly property bool iconVisible: trailing || (display !== T.AbstractButton.TextOnly
        && (iconName.length > 0 || iconSource.toString().length > 0))
    readonly property bool labelVisible: !trailing && display !== T.AbstractButton.IconOnly && text.length > 0
    readonly property bool stacked: display === T.AbstractButton.TextUnderIcon && !trailing
    readonly property real visibleSpacing: iconVisible && labelVisible ? spacing : 0
    readonly property real naturalWidth: stacked
        ? Math.max(iconVisible ? iconWidth : 0, labelVisible ? label.implicitWidth : 0)
        : (iconVisible ? iconWidth : 0) + visibleSpacing + (labelVisible ? label.implicitWidth : 0)
    readonly property real availableWidth: Math.max(0, width - startPadding - endPadding)
    readonly property real rowWidth: Math.min(availableWidth, naturalWidth)
    readonly property real rowX: (mirrored ? endPadding : startPadding)
        + (availableWidth - rowWidth) / 2 + (mirrored ? -opticalOffset : opticalOffset)

    implicitWidth: naturalWidth
    implicitHeight: stacked
        ? (iconVisible ? iconHeight : 0) + visibleSpacing + (labelVisible ? label.implicitHeight : 0)
        : Math.max(iconVisible ? iconHeight : 0, labelVisible ? label.implicitHeight : 0)
    opacity: contentOpacity
    Accessible.ignored: true
    clip: true

    Item {
        id: iconItem
        width: Math.min(content.iconWidth, content.rowWidth)
        height: content.iconHeight
        x: content.stacked ? content.rowX + (content.rowWidth - width) / 2
            : content.mirrored ? content.rowX + content.rowWidth - width : content.rowX
        y: content.stacked ? (content.height - content.implicitHeight) / 2
                          : (content.height - height) / 2
        visible: content.iconVisible

        TImpl.IconImage {
            objectName: "splitButtonSourceIcon"
            anchors.fill: parent
            source: content.iconSource
            sourceSize: Qt.size(content.iconWidth, content.iconHeight)
            fillMode: Image.PreserveAspectFit
            color: content.iconColor
            visible: !content.trailing && content.iconSource.toString().length > 0
            Accessible.ignored: true
        }

        MD.Symbol {
            objectName: content.trailing ? "splitButtonTrailingSymbol" : "splitButtonSymbol"
            anchors.fill: parent
            name: content.trailing ? MD.Symbols.expandMore : content.iconName
            iconWidth: content.iconWidth
            iconHeight: content.iconHeight
            color: content.iconColor
            visible: content.trailing || content.iconSource.toString().length === 0
            rotation: content.trailing && content.expanded ? (content.mirrored ? -180 : 180) : 0
            Accessible.ignored: true

            Behavior on rotation {
                NumberAnimation {
                    duration: MotionAnimation.standardSpringDuration(MD.Tokens.motion.spring.standardFastSpatial)
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: MotionAnimation.standardSpringCurve(MD.Tokens.motion.spring.standardFastSpatial)
                }
            }
        }
    }

    Text {
        id: label
        objectName: "splitButtonLabel"
        width: Math.max(0, content.rowWidth - (content.stacked ? 0
            : (content.iconVisible ? iconItem.width : 0) + content.visibleSpacing))
        x: content.stacked || content.mirrored ? content.rowX
            : content.rowX + (content.iconVisible ? iconItem.width : 0) + content.visibleSpacing
        y: content.stacked ? iconItem.y + (content.iconVisible ? iconItem.height : 0) + content.visibleSpacing
                          : (content.height - height) / 2
        text: content.text
        font: content.textFont
        lineHeight: content.lineHeight
        lineHeightMode: Text.FixedHeight
        textFormat: Text.PlainText
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        color: content.contentColor
        visible: content.labelVisible
        Accessible.ignored: true
    }
}
