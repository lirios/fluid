// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import Fluid.Private as Private
import "../core/BadgeContent.js" as BadgeContent
import "../core/UiMetrics.js" as UiMetrics

/*!
    \class Badge
    \brief A passive Material Design 3 notification dot or short label.

    Auto chooses Small without valid content and Large otherwise. Nonempty text
    takes precedence over count. Counts are valid only when finite, nonnegative,
    integral, and within the safe-integer range; zero displays as 0 and invalid
    values behave as unset. Counts above Tokens.badge.maximumCount display the
    maximum followed by +. Both visible and accessible counts use the control locale.
    Status text longer than four grapheme clusters displays its first three clusters
    and U+2026. Small suppresses the visible label while retaining the full value in
    accessibleDescription. Large without content displays an empty large container.

    The inherited visible property defaults to true. The default typescale is
    LabelSmall. Set typescale to another Tokens.typescale value to select its
    font family, size, weight, tracking, and line height, as with Label.
    Explicit local font overrides are honored.
    Large grows to fit the measured label and font instead of capping width.
    Container and content colors default to the active error/on-error semantic pair.
    Input is disabled by default so pointer and touch events reach the host beneath
    the badge. Reenabling Badge is unsupported for passive use; its appearance is
    independent of enabled and no focus, hover, or wheel interaction is added.

    Badges create no accessible or interactive node. Hosts include the full
    accessibleDescription after the destination name, separated by a comma, while
    the badge is rendered. Hidden badges contribute no stale information. If an
    application overrides the host's complete Accessible.name, it must compose
    badge information itself. There are no automatic live announcements.
    Supply translated descriptions with correct plural forms and context when a raw
    value or the generic New notification description is insufficient.

    Host badgeContent maps strings to text and numbers to count. badgeNotification
    requests Small even with content; badgeVisible controls rendering and the default
    accessible name. These properties default from a Fluid Action when supplied.
    Hosts own activation and clearing. Change application-owned content/notification
    bindings when unread state is cleared; Badge never clears caller state.

    \code{.qml}
    MD.IconButton {
        text: qsTr("Inbox")
        icon.name: MD.Symbols.mail
        badgeContent: unreadCount
        badgeVisible: unreadCount > 0
        badgeAccessibleDescription: qsTr("%n unread message(s)", "", unreadCount)
        onClicked: unreadCount = 0
    }
    \endcode

    BadgeOverlay accepts an explicit sibling Item around the actual icon bounds
    in a shared untransformed coordinate space. Growth keeps the logical leading
    anchor fixed, layoutMirrored supplies RTL placement, and ancestor clipping applies
    without automatic repositioning. NavigationRailItem uses an icon overlay when
    collapsed or icon-only, and a trailing Large badge beside an expanded label.
    App-bar icon actions always present Small while retaining the full accessible value.
    For template-based tabs, compose BadgeOverlay around the icon or Badge beside
    the label; tab-specific placement metrics are deferred to issue #393.

    \code{.qml}
    Item {
        id: composition
        Item {
            id: iconBounds
            // Set x/y/width/height to the actual icon bounds.
        }
        MD.BadgeOverlay {
            target: iconBounds
            layoutMirrored: host.mirrored
            count: unreadCount
        }
    }
    \endcode

    \sa BadgeOverlay, IconButton, NavigationRailItem
    <a href="https://m3.material.io/components/badges/overview">Material badge guidelines</a>.
*/
T.Control {
    id: control

    //! Auto chooses Small without content and Large with content.
    enum Variant { Auto, Small, Large }

    //! Requested badge presentation. Large can display an empty large container.
    property int variant: MD.Badge.Auto

    //! Numeric content; negative, nonfinite, fractional and unsafe values are unset.
    property real count: -1

    //! Status text taking precedence over numeric content. The default is empty.
    property string text: ""

    //! The Material type scale used for the label. Defaults to LabelSmall.
    property MD.typescale typescale: MD.Tokens.typescale.labelSmall

    //! Semantic container color, resolved through the active theme.
    property color containerColor: control.MD.Style.errorColor

    //! Semantic label color, resolved through the active theme.
    property color contentColor: control.MD.Style.onErrorColor

    //! Full value for the host's accessible name; callers may localize/pluralize it.
    property string accessibleDescription: _defaultAccessibleDescription

    //! \internal Default full description, before a host override.
    readonly property string _defaultAccessibleDescription: text.length > 0 ? text
        : BadgeContent.isValidCount(count) ? count.toLocaleString(locale, "f", 0)
        : qsTr("New notification")

    //! The actual Small or Large presentation after resolving Auto.
    readonly property int effectiveVariant: variant === MD.Badge.Auto
        ? (text.length > 0 || BadgeContent.isValidCount(count) ? MD.Badge.Large : MD.Badge.Small)
        : variant

    //! The shortened visible value. Small always displays an empty string.
    readonly property string displayText: {
        if (effectiveVariant === MD.Badge.Small)
            return "";
        if (text.length > 0)
            return Private.BadgeText.elide(text, MD.Tokens.badge.maximumCharacters);
        if (!BadgeContent.isValidCount(count))
            return "";
        const maximum = MD.Tokens.badge.maximumCount;
        return Math.min(count, maximum).toLocaleString(locale, "f", 0)
               + (count > maximum ? "+" : "");
    }

    readonly property MD.shapeValue _containerShape: effectiveVariant === MD.Badge.Small
        ? MD.Tokens.badge.shape : MD.Tokens.badge.largeShape

    font.family: typescale.face === MD.Style.TypeFace.Brand
        ? control.MD.Style.brandFontFamily : control.MD.Style.plainFontFamily
    font.pixelSize: typescale.fontSize
    font.weight: typescale.fontWeight
    font.letterSpacing: typescale.tracking

    implicitWidth: Math.max(implicitHeight,
        implicitBackgroundWidth + leftInset + rightInset,
        (effectiveVariant === MD.Badge.Small ? 0 : implicitContentWidth)
            + leftPadding + rightPadding)
    implicitHeight: Math.max(effectiveVariant === MD.Badge.Small
            ? MD.Tokens.badge.size : MD.Tokens.badge.largeSize,
        implicitBackgroundHeight + topInset + bottomInset,
        (effectiveVariant === MD.Badge.Small ? 0 : implicitContentHeight)
            + topPadding + bottomPadding)
    leftPadding: effectiveVariant === MD.Badge.Small ? 0 : MD.Tokens.badge.horizontalPadding
    rightPadding: leftPadding
    topPadding: 0
    bottomPadding: 0
    // Control otherwise consumes pointer/touch events above its host. Badge has
    // no disabled visual state, so disabling input preserves the passive visual.
    enabled: false
    hoverEnabled: false
    wheelEnabled: false
    focusPolicy: Qt.NoFocus
    Accessible.ignored: true

    FontMetrics {
        id: fontMetrics
        font: control.font
    }

    contentItem: Text {
        objectName: "badgeLabel"
        text: control.displayText
        font: control.font
        color: control.contentColor
        textFormat: Text.PlainText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        lineHeight: Math.max(control.typescale.lineHeight, fontMetrics.height)
        lineHeightMode: Text.FixedHeight
        Accessible.ignored: true
    }

    background: Rectangle {
        objectName: "badgeBackground"
        color: control.containerColor
        topLeftRadius: UiMetrics.resolveShapeRadius(control._containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(control._containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(control._containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(control._containerShape.bottomRight, width, height)
        Accessible.ignored: true
    }
}
