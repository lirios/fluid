// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD
import "../core/BadgeContent.js" as BadgeContent

// Explicit inputs keep measurement, badges, and the indicator's anchor in one model.
Item {
    id: root
    required property string text
    required property string iconName
    required property url iconSource
    required property real iconWidth
    required property real iconHeight
    required property color iconColor
    required property color contentColor
    required property font textFont
    required property real textLineHeight
    required property bool showIcon
    required property bool showText
    required property bool stacked
    required property bool layoutMirrored
    required property bool tintSourceIcon
    required property int maximumLineCount
    required property bool showBadge
    required property var badgeContent
    required property bool badgeNotification
    required property int badgeVariant
    required property string badgeAccessibleDescription
    required property var locale

    readonly property bool inlineBadge: showBadge && showText && !stacked
    readonly property bool overlayBadge: showBadge && showIcon && !inlineBadge
    // Symmetric paint extents retain the icon/label center and indicator anchor.
    readonly property real overlayPaintWidth: overlayBadge
        ? iconWidth + 2 * Math.max(0, badge.width - MD.Tokens.tab.badgeOverlap) : 0
    readonly property real overlayVerticalExtent: overlayBadge
        ? Math.max(0, badge.height - MD.Tokens.tab.badgeOverlap
                     - (stacked ? 0 : (contentHeight - iconHeight) / 2)) : 0
    readonly property real badgeSpace: inlineBadge ? badge.width + MD.Tokens.tab.labelBadgeGap : 0
    readonly property real iconSpace: showIcon && !stacked
        ? iconWidth + (showText ? MD.Tokens.tab.inlineIconLabelGap : 0) : 0
    readonly property real labelAvailableWidth: Math.max(0, width - iconSpace - badgeSpace)
    readonly property real labelWidth: showText ? Math.min(labelAvailableWidth, measure.implicitWidth) : 0
    readonly property real displayedLabelWidth: showText ? Math.min(labelWidth, label.contentWidth) : 0
    readonly property real displayedContentWidth: stacked
        ? (showText ? displayedLabelWidth : iconWidth)
        : (showIcon ? iconWidth : 0)
          + (showIcon && showText ? MD.Tokens.tab.inlineIconLabelGap : 0)
          + displayedLabelWidth + badgeSpace
    readonly property string accessibleBadgeDescription: badge.visible ? badge.accessibleDescription : ""
    readonly property real contentHeight: stacked
        ? iconHeight + MD.Tokens.tab.stackedIconLabelGap + label.contentHeight
        : Math.max(showIcon ? iconHeight : 0, showText ? label.contentHeight : 0,
                   inlineBadge ? badge.height : 0)

    implicitWidth: Math.max(overlayPaintWidth, stacked ? Math.max(iconWidth, measure.implicitWidth)
        : (showIcon ? iconWidth : 0)
          + (showIcon && showText ? MD.Tokens.tab.inlineIconLabelGap : 0)
          + (showText ? measure.implicitWidth : 0) + badgeSpace)
    implicitHeight: contentHeight + 2 * overlayVerticalExtent
    Accessible.ignored: true

    Text {
        id: measure
        text: root.showText ? root.text : ""
        font: root.textFont
        textFormat: Text.PlainText
        visible: false
        Accessible.ignored: true
    }

    Item {
        id: group
        objectName: "tabContentGroup"
        width: root.stacked ? Math.max(root.showIcon ? root.iconWidth : 0,
                                      root.displayedLabelWidth) : root.displayedContentWidth
        height: root.contentHeight
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        Accessible.ignored: true

        Item {
            id: iconSlot
            objectName: "tabIconSlot"
            width: root.iconWidth
            height: root.iconHeight
            visible: root.showIcon
            x: root.stacked ? (group.width - width) / 2
                : root.layoutMirrored ? group.width - width : 0
            y: root.stacked ? 0 : (group.height - height) / 2
            Accessible.ignored: true

            MD.IconImage {
                objectName: "tabSourceImage"
                anchors.fill: parent
                source: root.iconSource
                sourceSize: Qt.size(root.iconWidth, root.iconHeight)
                fillMode: Image.PreserveAspectFit
                color: root.tintSourceIcon ? root.iconColor : "transparent"
                visible: root.iconSource.toString().length > 0
                Accessible.ignored: true
            }
            MD.Symbol {
                objectName: "tabSymbol"
                anchors.fill: parent
                name: root.iconName
                iconWidth: root.iconWidth
                iconHeight: root.iconHeight
                color: root.iconColor
                visible: root.iconSource.toString().length === 0 && name.length > 0
                Accessible.ignored: true
            }
        }

        Text {
            id: label
            objectName: "tabLabel"
            text: root.text
            font: root.textFont
            color: root.contentColor
            textFormat: Text.PlainText
            visible: root.showText
            width: root.labelWidth
            x: root.stacked ? (group.width - width) / 2
                : (root.layoutMirrored ? root.badgeSpace : root.iconSpace)
                  - (width - root.displayedLabelWidth) / 2
            y: root.stacked ? root.iconHeight + MD.Tokens.tab.stackedIconLabelGap
                           : (group.height - height) / 2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: root.maximumLineCount > 1 ? Text.Wrap : Text.NoWrap
            maximumLineCount: Math.max(1, Math.min(2, root.maximumLineCount))
            elide: Text.ElideRight
            lineHeight: root.textLineHeight
            lineHeightMode: Text.FixedHeight
            Accessible.ignored: true
        }

        MD.Badge {
            id: badge
            objectName: "tabBadge"
            count: BadgeContent.count(root.badgeContent)
            text: BadgeContent.text(root.badgeContent)
            locale: root.locale
            variant: root.badgeNotification ? MD.Badge.Small : root.badgeVariant
            accessibleDescription: root.badgeAccessibleDescription.length > 0
                ? root.badgeAccessibleDescription : _defaultAccessibleDescription
            visible: root.showBadge && (root.showText || root.showIcon)
            x: root.inlineBadge
                ? (root.layoutMirrored ? 0 : group.width - width)
                : (root.layoutMirrored ? iconSlot.x + MD.Tokens.tab.badgeOverlap - width
                                      : iconSlot.x + iconSlot.width - MD.Tokens.tab.badgeOverlap)
            y: root.inlineBadge ? (group.height - height) / 2
                                : iconSlot.y + MD.Tokens.tab.badgeOverlap - height
        }
    }
}
