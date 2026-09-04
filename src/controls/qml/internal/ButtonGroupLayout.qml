// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

Item {
    id: layout

    required property var group

    function schedule() {
        updateTimer.restart();
    }

    function updateGeometry() {
        const visibleItems = [];
        let naturalWidth = 0;
        let naturalHeight = 0;
        for (let i = 0; i < group.count; ++i) {
            const item = group.itemAt(i);
            if (!group.__isSupported(item) || !item.visible)
                continue;
            visibleItems.push(item);
            naturalWidth += item.implicitWidth;
            naturalHeight = Math.max(naturalHeight, item.implicitHeight);
        }

        const spacing = group.variant === group.__connectedVariant
                ? MD.Tokens.buttonGroup.connectedSpacing
                : MD.Tokens.buttonGroup.standardSpacing;
        naturalWidth += Math.max(0, visibleItems.length - 1) * spacing;
        layout.implicitWidth = naturalWidth;
        layout.implicitHeight = naturalHeight;

        const widths = [];
        for (let i = 0; i < visibleItems.length; ++i)
            widths.push(visibleItems[i].implicitWidth);

        if (group.variant === group.__standardVariant) {
            let pressedIndex = -1;
            for (let i = 0; i < visibleItems.length; ++i) {
                if (visibleItems[i].pressed) {
                    pressedIndex = i;
                    break;
                }
            }
            if (pressedIndex >= 0) {
                const pressed = visibleItems[pressedIndex];
                const desired = widths[pressedIndex]
                        * MD.Tokens.buttonGroup.standardPressedExpansionRatio;
                const neighbors = [];
                if (pressedIndex > 0)
                    neighbors.push(pressedIndex - 1);
                if (pressedIndex + 1 < visibleItems.length)
                    neighbors.push(pressedIndex + 1);
                let remaining = desired;
                let active = neighbors.slice();
                while (remaining > 0.001 && active.length > 0) {
                    const share = remaining / active.length;
                    const next = [];
                    for (const neighborIndex of active) {
                        const neighbor = visibleItems[neighborIndex];
                        const adjacentPadding = neighborIndex < pressedIndex
                                ? (group.mirrored ? neighbor.leftPadding : neighbor.rightPadding)
                                : (group.mirrored ? neighbor.rightPadding : neighbor.leftPadding);
                        const minimum = Math.max(neighbor.implicitHeight,
                                                 neighbor.implicitWidth - adjacentPadding);
                        const capacity = Math.max(0, widths[neighborIndex] - minimum);
                        const amount = Math.min(share, capacity);
                        widths[neighborIndex] -= amount;
                        remaining -= amount;
                        if (capacity - amount > 0.001)
                            next.push(neighborIndex);
                    }
                    active = next;
                }
                widths[pressedIndex] += desired - remaining;
            }
        }

        let position = 0;
        if (!group.mirrored) {
            for (let i = 0; i < visibleItems.length; ++i) {
                const item = visibleItems[i];
                item.x = position;
                item.width = widths[i];
                item.y = (layout.height - item.height) / 2;
                position += widths[i] + spacing;
            }
        } else {
            position = naturalWidth;
            for (let i = 0; i < visibleItems.length; ++i) {
                const item = visibleItems[i];
                position -= widths[i];
                item.x = position;
                item.width = widths[i];
                item.y = (layout.height - item.height) / 2;
                position -= spacing;
            }
        }

        group.__applyConnectedCorners(visibleItems);
        group.__geometryInitialized = true;
    }

    Timer {
        id: updateTimer
        interval: 0
        onTriggered: layout.updateGeometry()
    }

    Component.onCompleted: updateGeometry()
    onWidthChanged: schedule()
    onHeightChanged: schedule()
}
