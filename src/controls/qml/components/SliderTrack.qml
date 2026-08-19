// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

Item {
    id: root
    objectName: "sliderTrack"

    required property bool horizontal
    required property bool mirrored
    required property bool centered
    required property bool rangeMode
    required property bool controlEnabled
    required property real visualPosition
    required property real secondVisualPosition
    required property real rangeFrom
    required property real rangeTo
    required property real stepSize
    required property int tickVisibilityMode
    required property int autoLimitMode
    required property int autoHideMode
    required property int hiddenMode
    required property real trackHeight
    required property real trackOuterCornerRadius
    required property real handleHeight
    required property real effectiveHandleWidth
    required property real labelSpace
    required property color activeTrackColor
    required property color inactiveTrackColor
    required property color activeTickColor
    required property color inactiveTickColor
    required property real activeTrackOpacity
    required property real inactiveTrackOpacity
    required property string trackIconActiveStart
    required property string trackIconActiveEnd
    required property string trackIconInactiveStart
    required property string trackIconInactiveEnd
    required property color trackIconActiveColor
    required property color trackIconInactiveColor
    required property real trackIconSize

    readonly property real baseCrossSize: Math.max(
        MD.Tokens.slider.minimumInteractiveSize, trackHeight, handleHeight)
    implicitWidth: horizontal ? MD.Tokens.slider.defaultLength
                              : baseCrossSize + labelSpace
    implicitHeight: horizontal ? baseCrossSize + labelSpace
                               : MD.Tokens.slider.defaultLength

    readonly property real axisLength: horizontal ? width : height
    readonly property real crossLength: horizontal ? height : width
    readonly property real crossCenter: {
        if (root.horizontal)
            return root.labelSpace + (root.height - root.labelSpace) / 2;
        if (root.mirrored)
            return (root.width - root.labelSpace) / 2;
        return root.labelSpace + (root.width - root.labelSpace) / 2;
    }
    readonly property real handleContainerSize: trackOuterCornerRadius * 2
    readonly property real handleTravel: Math.max(0, axisLength - handleContainerSize)
    readonly property real handleCenter: trackOuterCornerRadius + visualPosition * handleTravel
    readonly property real secondHandleCenter: trackOuterCornerRadius
                                                 + secondVisualPosition * handleTravel
    readonly property real rangeStartHandleCenter: Math.min(handleCenter,
                                                            secondHandleCenter)
    readonly property real rangeEndHandleCenter: Math.max(handleCenter,
                                                          secondHandleCenter)
    readonly property real handleGap: effectiveHandleWidth / 2
                                      + MD.Tokens.slider.activeHandleLeadingSpace
    readonly property real centerPosition: axisLength / 2
    readonly property real centerGap: MD.Tokens.slider.activeHandleLeadingSpace
    readonly property bool handleBeforeCenter: handleCenter < centerPosition
    readonly property bool handleAfterCenter: handleCenter > centerPosition
    readonly property bool mirroredHorizontal: horizontal && mirrored

    readonly property real activeStart: {
        if (root.rangeMode)
            return root.rangeStartHandleCenter + root.handleGap;
        if (!root.centered)
            return root.mirroredHorizontal ? root.handleCenter + root.handleGap : 0;
        if (root.handleBeforeCenter)
            return root.handleCenter + root.handleGap;
        if (root.handleAfterCenter)
            return root.centerPosition + root.centerGap;
        return root.centerPosition;
    }
    readonly property real activeEnd: {
        if (root.rangeMode)
            return root.rangeEndHandleCenter - root.handleGap;
        if (!root.centered)
            return root.mirroredHorizontal ? root.axisLength : root.handleCenter - root.handleGap;
        if (root.handleBeforeCenter)
            return root.centerPosition - root.centerGap;
        if (root.handleAfterCenter)
            return root.handleCenter - root.handleGap;
        return root.centerPosition;
    }
    readonly property real leadingInactiveStart: 0
    readonly property real leadingInactiveEnd: {
        if (root.rangeMode)
            return root.rangeStartHandleCenter - root.handleGap;
        if (!root.centered)
            return root.mirroredHorizontal ? root.handleCenter - root.handleGap : 0;
        if (root.handleBeforeCenter)
            return root.handleCenter - root.handleGap;
        if (!root.handleAfterCenter)
            return root.centerPosition - root.handleGap;
        return root.centerPosition - root.centerGap;
    }
    readonly property real trailingInactiveStart: {
        if (root.rangeMode)
            return root.rangeEndHandleCenter + root.handleGap;
        if (!root.centered)
            return root.mirroredHorizontal ? root.axisLength : root.handleCenter + root.handleGap;
        if (root.handleAfterCenter)
            return root.handleCenter + root.handleGap;
        if (!root.handleBeforeCenter)
            return root.centerPosition + root.handleGap;
        return root.centerPosition + root.centerGap;
    }
    readonly property real trailingInactiveEnd: root.axisLength
    readonly property real inactiveStart: mirroredHorizontal
                                          ? leadingInactiveStart : trailingInactiveStart
    readonly property real inactiveEnd: mirroredHorizontal
                                        ? leadingInactiveEnd : trailingInactiveEnd

    readonly property int desiredTickCount: {
        if (root.stepSize <= 0 || root.rangeTo <= root.rangeFrom)
            return 0;
        return Math.floor((root.rangeTo - root.rangeFrom) / root.stepSize
                          + Number.EPSILON) + 1;
    }
    readonly property real lastTickPosition: {
        if (root.desiredTickCount <= 1)
            return 0;
        return (root.desiredTickCount - 1) * root.stepSize
                / (root.rangeTo - root.rangeFrom);
    }
    readonly property real tickSpanLength: handleTravel * lastTickPosition
    readonly property int maxTickCount: {
        if (root.desiredTickCount <= 0 || root.handleTravel <= 0)
            return 0;
        if (root.desiredTickCount === 1)
            return 1;
        return Math.floor(root.tickSpanLength / MD.Tokens.slider.tickMinSpacing) + 1;
    }
    readonly property int tickCount: {
        if (root.desiredTickCount <= 0 || root.maxTickCount <= 0)
            return 0;
        if (root.tickVisibilityMode === root.autoLimitMode)
            return Math.min(root.desiredTickCount, root.maxTickCount);
        if (root.tickVisibilityMode === root.autoHideMode)
            return root.desiredTickCount <= root.maxTickCount
                    ? root.desiredTickCount : 0;
        if (root.tickVisibilityMode === root.hiddenMode)
            return 0;
        return 0;
    }
    readonly property bool iconsAllowed: stepSize <= 0 && !centered && !rangeMode
                                         && trackIconSize > 0
    readonly property real iconRequiredLength: trackIconSize
                                               + MD.Tokens.slider.trackIconPadding * 2

    function tickStepIndex(displayIndex) {
        if (root.tickCount <= 1)
            return 0;
        return Math.round(displayIndex * (root.desiredTickCount - 1)
                          / (root.tickCount - 1));
    }

    function tickAxisPosition(displayIndex) {
        const logicalPosition = root.tickStepIndex(displayIndex) * root.stepSize
                                / (root.rangeTo - root.rangeFrom);
        const visual = root.mirroredHorizontal ? 1 - logicalPosition : logicalPosition;
        return root.trackOuterCornerRadius + visual * root.handleTravel;
    }

    function pointIsActive(point) {
        return point >= root.activeStart && point <= root.activeEnd;
    }

    function pointOverlapsGap(point) {
        if (Math.abs(point - root.handleCenter) < root.handleGap)
            return true;
        if (root.rangeMode
                && Math.abs(point - root.secondHandleCenter) < root.handleGap)
            return true;
        return root.centered
                && Math.abs(point - root.centerPosition) < root.centerGap;
    }

    component TrackSegment: Rectangle {
        required property real segmentStart
        required property real segmentEnd
        required property real startCornerRadius
        required property real endCornerRadius

        readonly property real segmentLength: Math.max(0, segmentEnd - segmentStart)
        readonly property real boundedStartRadius: Math.min(startCornerRadius,
                                                            segmentLength / 2,
                                                            root.trackHeight / 2)
        readonly property real boundedEndRadius: Math.min(endCornerRadius,
                                                          segmentLength / 2,
                                                          root.trackHeight / 2)

        visible: segmentLength > 0
        x: root.horizontal ? segmentStart : root.crossCenter - root.trackHeight / 2
        y: root.horizontal ? root.crossCenter - root.trackHeight / 2 : segmentStart
        width: root.horizontal ? segmentLength : root.trackHeight
        height: root.horizontal ? root.trackHeight : segmentLength

        topLeftRadius: root.horizontal ? boundedStartRadius : boundedStartRadius
        bottomLeftRadius: root.horizontal ? boundedStartRadius : boundedEndRadius
        topRightRadius: root.horizontal ? boundedEndRadius : boundedStartRadius
        bottomRightRadius: root.horizontal ? boundedEndRadius : boundedEndRadius

        Behavior on color {
            ColorAnimation {
                duration: MD.Tokens.durationShort2
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: MD.Tokens.durationShort2
            }
        }
    }

    TrackSegment {
        id: leadingInactiveTrack
        objectName: "inactiveTrackLeading"
        segmentStart: root.leadingInactiveStart
        segmentEnd: root.leadingInactiveEnd
        startCornerRadius: root.trackOuterCornerRadius
        endCornerRadius: MD.Tokens.slider.trackInsideCornerRadius
        color: root.inactiveTrackColor
        opacity: root.inactiveTrackOpacity
    }

    TrackSegment {
        id: activeTrack
        objectName: "activeTrack"
        segmentStart: root.activeStart
        segmentEnd: root.activeEnd
        startCornerRadius: segmentStart <= 0
                           ? root.trackOuterCornerRadius
                           : MD.Tokens.slider.trackInsideCornerRadius
        endCornerRadius: segmentEnd >= root.axisLength
                         ? root.trackOuterCornerRadius
                         : MD.Tokens.slider.trackInsideCornerRadius
        color: root.activeTrackColor
        opacity: root.activeTrackOpacity
    }

    TrackSegment {
        id: trailingInactiveTrack
        objectName: "inactiveTrackTrailing"
        segmentStart: root.trailingInactiveStart
        segmentEnd: root.trailingInactiveEnd
        startCornerRadius: MD.Tokens.slider.trackInsideCornerRadius
        endCornerRadius: root.trackOuterCornerRadius
        color: root.inactiveTrackColor
        opacity: root.inactiveTrackOpacity
    }

    Repeater {
        id: ticks
        objectName: "tickRepeater"
        model: root.tickCount

        delegate: Rectangle {
            id: tick
            required property int index

            readonly property real axisPosition: root.tickAxisPosition(index)

            objectName: "sliderTick"
            visible: !root.pointOverlapsGap(axisPosition)
            x: root.horizontal
               ? axisPosition - width / 2
               : root.crossCenter - width / 2
            y: root.horizontal
               ? root.crossCenter - height / 2
               : axisPosition - height / 2
            width: MD.Tokens.slider.tickSize
            height: MD.Tokens.slider.tickSize
            radius: width / 2
            color: root.pointIsActive(axisPosition)
                   ? root.activeTickColor : root.inactiveTickColor
            opacity: MD.Tokens.slider.visibleOpacity
        }
    }

    component StopIndicator: Rectangle {
        required property real axisPosition

        width: MD.Tokens.slider.stopIndicatorSize
        height: MD.Tokens.slider.stopIndicatorSize
        radius: width / 2
        x: root.horizontal
           ? axisPosition - width / 2
           : root.crossCenter - width / 2
        y: root.horizontal
           ? root.crossCenter - height / 2
           : axisPosition - height / 2
        color: root.inactiveTickColor
        opacity: MD.Tokens.slider.visibleOpacity
    }

    StopIndicator {
        objectName: "startStopIndicator"
        axisPosition: root.trackOuterCornerRadius
        visible: (root.centered || root.rangeMode)
                 && !root.pointOverlapsGap(axisPosition)
    }

    StopIndicator {
        objectName: "endStopIndicator"
        axisPosition: root.axisLength - root.trackOuterCornerRadius
        visible: (root.centered || root.rangeMode || !root.mirroredHorizontal)
                 && !root.pointOverlapsGap(axisPosition)
    }

    StopIndicator {
        objectName: "mirroredEndStopIndicator"
        axisPosition: root.trackOuterCornerRadius
        visible: !root.centered && !root.rangeMode && root.mirroredHorizontal
                 && !root.pointOverlapsGap(axisPosition)
    }

    component TrackIcon: MD.Symbol {
        required property bool activeSegment
        required property bool logicalStart

        readonly property real segmentStart: activeSegment
                                              ? root.activeStart : root.inactiveStart
        readonly property real segmentEnd: activeSegment
                                            ? root.activeEnd : root.inactiveEnd
        readonly property bool logicalForward: !root.mirroredHorizontal
        readonly property real axisPosition: {
            const fromStart = logicalStart === logicalForward;
            if (fromStart)
                return segmentStart + MD.Tokens.slider.trackIconPadding
                        + root.trackIconSize / 2;
            return segmentEnd - MD.Tokens.slider.trackIconPadding
                    - root.trackIconSize / 2;
        }

        visible: root.iconsAllowed && name.length > 0
                 && segmentEnd - segmentStart >= root.iconRequiredLength
        x: root.horizontal
           ? axisPosition - width / 2
           : root.crossCenter - width / 2
        y: root.horizontal
           ? root.crossCenter - height / 2
           : axisPosition - height / 2
        iconWidth: root.trackIconSize
        iconHeight: root.trackIconSize
    }

    TrackIcon {
        objectName: "activeStartIcon"
        activeSegment: true
        logicalStart: true
        name: root.trackIconActiveStart
        color: root.trackIconActiveColor
    }

    TrackIcon {
        objectName: "activeEndIcon"
        activeSegment: true
        logicalStart: false
        name: root.trackIconActiveEnd
        color: root.trackIconActiveColor
    }

    TrackIcon {
        objectName: "inactiveStartIcon"
        activeSegment: false
        logicalStart: true
        name: root.trackIconInactiveStart
        color: root.trackIconInactiveColor
    }

    TrackIcon {
        objectName: "inactiveEndIcon"
        activeSegment: false
        logicalStart: false
        name: root.trackIconInactiveEnd
        color: root.trackIconInactiveColor
    }
}
