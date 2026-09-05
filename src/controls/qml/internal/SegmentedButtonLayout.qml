// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

Item {
    id: layout

    required property list<MD.SegmentedButton> segments
    required property bool mirrored

    function updateGeometry() {
        const segmentWidth = segments.length > 0 ? width / segments.length : 0;
        for (let i = 0; i < segments.length; ++i) {
            const segment = segments[i];
            const physicalIndex = mirrored ? segments.length - 1 - i : i;
            segment.x = physicalIndex * segmentWidth;
            segment.y = 0;
            segment.width = segmentWidth;
            segment.height = height;
            segment.__leftEnd = physicalIndex === 0;
            segment.__rightEnd = physicalIndex === segments.length - 1;
        }
    }

    onSegmentsChanged: updateGeometry()
    onMirroredChanged: updateGeometry()
    onWidthChanged: updateGeometry()
    onHeightChanged: updateGeometry()
}
