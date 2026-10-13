// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

/*!
    \class BadgeOverlay
    \brief Places a badge at an icon's logical upper trailing corner.

    The target must be an explicit sibling Item representing actual icon bounds
    in the same untransformed coordinate space. The badge grows toward logical
    trailing, without moving its leading anchor, and honors ancestor clipping.
    Null, destroyed, invisible, or empty targets hide the overlay.
*/
MD.Badge {
    id: control

    //! Sibling icon bounds; assign null when the icon is absent.
    required property Item target

    //! Logical layout direction. Hosts pass their mirrored state explicitly.
    property bool layoutMirrored: mirrored

    //! Whether the target currently supplies visible, nonempty icon bounds.
    readonly property bool targetAvailable: target !== null && target.visible
        && target.width > 0 && target.height > 0

    readonly property real _horizontalOffset: effectiveVariant === MD.Badge.Small
        ? MD.Tokens.badge.horizontalOffset : MD.Tokens.badge.largeHorizontalOffset
    readonly property real _verticalOffset: effectiveVariant === MD.Badge.Small
        ? MD.Tokens.badge.verticalOffset : MD.Tokens.badge.largeVerticalOffset

    x: target ? (layoutMirrored ? target.x + _horizontalOffset - width
                               : target.x + target.width - _horizontalOffset) : 0
    y: target ? target.y + _verticalOffset - height : 0
    visible: targetAvailable
}
