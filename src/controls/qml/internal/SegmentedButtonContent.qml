// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.impl as TImpl
import Fluid as MD

Item {
    id: content

    required property string text
    required property string iconName
    required property url iconSource
    required property real iconWidth
    required property real iconHeight
    required property bool checked
    required property bool showCheckmark
    required property bool mirrored
    required property font textFont
    required property real lineHeight
    required property color contentColor
    required property color iconColor
    required property real spacing
    required property real indicatorSize

    readonly property bool hasIcon: iconName.length > 0 || iconSource.toString().length > 0
    readonly property bool hasText: text.length > 0
    readonly property bool labelVisible: hasText
    readonly property bool checkVisible: checked && showCheckmark
    readonly property bool iconVisible: hasIcon && !(hasText && checkVisible)
    readonly property real leadingWidth: hasText
                                        ? Math.max(hasIcon ? iconWidth : 0, showCheckmark ? indicatorSize : 0)
                                        : (showCheckmark ? indicatorSize : 0)
    readonly property real trailingWidth: hasText ? label.implicitWidth : (hasIcon ? iconWidth : 0)
    readonly property real effectiveSpacing: leadingWidth > 0 && trailingWidth > 0 ? spacing : 0
    // Reserve the indicator in natural sizing, but center only visible content.
    readonly property real visibleLeadingWidth: hasText && iconVisible ? iconWidth
                                               : checkVisible ? indicatorSize : 0
    readonly property real visibleSpacing: visibleLeadingWidth > 0 && trailingWidth > 0 ? spacing : 0
    readonly property real rowWidth: Math.min(width, visibleLeadingWidth + visibleSpacing + trailingWidth)
    readonly property real rowX: (width - rowWidth) / 2
    readonly property real slotHeight: Math.max(hasIcon ? iconHeight : 0, showCheckmark ? indicatorSize : 0)

    implicitWidth: leadingWidth + effectiveSpacing + trailingWidth
    implicitHeight: Math.max(slotHeight, hasText ? label.implicitHeight : 0)
    Accessible.ignored: true
    clip: true

    Item {
        id: leading
        width: content.visibleLeadingWidth
        height: content.slotHeight
        x: content.mirrored ? content.rowX + content.rowWidth - width : content.rowX
        y: (content.height - height) / 2

        MD.Symbol {
            objectName: "segmentedButtonCheckmark"
            anchors.centerIn: parent
            name: MD.Symbols.check
            iconWidth: content.indicatorSize
            iconHeight: content.indicatorSize
            color: content.contentColor
            visible: content.checkVisible
            Accessible.ignored: true
        }
    }

    Item {
        id: optionIcon
        width: content.iconWidth
        height: content.iconHeight
        x: content.hasText ? leading.x + (leading.width - width) / 2
                           : (content.mirrored ? content.rowX : content.rowX + content.rowWidth - width)
        y: content.hasText ? leading.y + (leading.height - height) / 2
                           : (content.height - height) / 2
        visible: content.iconVisible

        TImpl.IconImage {
            objectName: "segmentedButtonSourceIcon"
            anchors.fill: parent
            source: content.iconSource
            sourceSize: Qt.size(content.iconWidth, content.iconHeight)
            fillMode: Image.PreserveAspectFit
            color: content.iconColor
            visible: content.iconSource.toString().length > 0
            Accessible.ignored: true
        }

        MD.Symbol {
            objectName: "segmentedButtonSymbol"
            anchors.fill: parent
            name: content.iconName
            iconWidth: content.iconWidth
            iconHeight: content.iconHeight
            color: content.iconColor
            visible: content.iconSource.toString().length === 0
            Accessible.ignored: true
        }
    }

    Text {
        id: label
        objectName: "segmentedButtonLabel"
        width: Math.max(0, content.rowWidth - content.visibleLeadingWidth - content.visibleSpacing)
        x: content.mirrored ? content.rowX : content.rowX + content.visibleLeadingWidth + content.visibleSpacing
        y: (content.height - height) / 2
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
