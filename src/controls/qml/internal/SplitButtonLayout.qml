// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick

Item {
    id: layout

    required property bool mirrored
    required property real surfaceHeight
    required property real minimumTarget
    required property real betweenSpace
    required property real leadingContentWidth
    required property real leadingStartPadding
    required property real leadingEndPadding
    required property real trailingIconSize
    required property real trailingStartPadding
    required property real trailingEndPadding

    readonly property real leadingPreferredWidth: Math.max(minimumTarget,
        leadingContentWidth + leadingStartPadding + leadingEndPadding)
    readonly property real trailingPreferredWidth: Math.max(minimumTarget,
        trailingIconSize + trailingStartPadding + trailingEndPadding)
    readonly property real trailingWidth: Math.min(Math.max(0, width), trailingPreferredWidth)
    readonly property real actualGap: Math.min(betweenSpace, Math.max(0, width - trailingWidth))
    readonly property real leadingWidth: Math.max(0, width - trailingWidth - actualGap)
    readonly property real leadingX: mirrored ? trailingWidth + actualGap : 0
    readonly property real trailingX: mirrored ? 0 : leadingWidth + actualGap
    readonly property real surfaceY: (height - surfaceHeight) / 2

    implicitWidth: leadingPreferredWidth + betweenSpace + trailingPreferredWidth
    implicitHeight: Math.max(minimumTarget, surfaceHeight)
}
