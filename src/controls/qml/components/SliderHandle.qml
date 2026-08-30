// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class SliderHandle
    \internal
    \brief Renders a Slider or RangeSlider handle and its value indicator.

    For the public control behavior see the
    <a href="https://m3.material.io/components/sliders/overview">Material Design 3 slider guidelines</a>.
*/
Item {
    id: root

    required property string valueIndicatorText
    required property int labelBehavior
    required property bool handleHasFocus
    required property bool handlePressed
    required property bool handleHovered
    required property bool controlEnabled
    required property bool horizontal
    required property bool mirrored
    required property real controlWidth
    required property real controlHeight
    required property real activeHandleWidth
    required property real handleHeight
    required property real handleContainerSize
    required property color handleColor
    required property real handleOpacity
    required property color valueIndicatorContainerColor
    required property color valueIndicatorLabelColor

    readonly property bool valueIndicatorActive: {
        if (root.labelBehavior === MD.Slider.LabelBehavior.Gone)
            return false;
        if (root.labelBehavior === MD.Slider.LabelBehavior.Visible)
            return root.controlEnabled;
        return root.controlEnabled && (root.handlePressed || root.handleHasFocus || root.handleHovered);
    }
    readonly property real valueIndicatorWidth: valueIndicator.implicitWidth
    readonly property real valueIndicatorHeight: valueIndicator.implicitHeight

    implicitWidth: horizontal ? handleContainerSize : handleHeight
    implicitHeight: horizontal ? handleHeight : handleContainerSize

    function __valueIndicatorOffset(preferred, alternative, handleOffset, indicatorSize, controlSize) {
        if (root.labelBehavior !== MD.Slider.LabelBehavior.WithinBounds)
            return preferred;

        const firstAllowed = -handleOffset;
        const lastAllowed = controlSize - handleOffset - indicatorSize;
        if (lastAllowed < firstAllowed)
            return firstAllowed;
        if (preferred >= firstAllowed && preferred <= lastAllowed)
            return preferred;
        if (alternative >= firstAllowed && alternative <= lastAllowed)
            return alternative;
        return Math.max(firstAllowed, Math.min(preferred, lastAllowed));
    }

    MD.Control {
        id: valueIndicator
        objectName: "valueIndicator"

        readonly property real indicatorWidth: Math.max(MD.Tokens.slider.valueIndicatorMinWidth, contentItem.implicitWidth + leftPadding + rightPadding)
        readonly property real indicatorHeight: Math.max(MD.Tokens.slider.valueIndicatorMinHeight, contentItem.implicitHeight + topPadding + bottomPadding)

        x: {
            if (root.horizontal) {
                const centered = (root.width - width) / 2;
                return root.__valueIndicatorOffset(centered, centered, root.x, width, root.controlWidth);
            }

            const gap = MD.Tokens.slider.valueIndicatorActiveBottomSpace;
            const beforeHandle = -width - gap;
            const afterHandle = root.width + gap;
            const preferred = root.mirrored ? afterHandle : beforeHandle;
            const alternative = root.mirrored ? beforeHandle : afterHandle;
            return root.__valueIndicatorOffset(preferred, alternative, root.x, width, root.controlWidth);
        }
        y: {
            if (!root.horizontal) {
                const centered = (root.height - height) / 2;
                return root.__valueIndicatorOffset(centered, centered, root.y, height, root.controlHeight);
            }

            const gap = MD.Tokens.slider.valueIndicatorActiveBottomSpace;
            const aboveHandle = -height - gap;
            const belowHandle = root.height + gap;
            return root.__valueIndicatorOffset(aboveHandle, belowHandle, root.y, height, root.controlHeight);
        }

        horizontalPadding: MD.Tokens.slider.valueIndicatorHorizontalPadding
        verticalPadding: MD.Tokens.slider.valueIndicatorVerticalPadding

        implicitWidth: indicatorWidth
        implicitHeight: indicatorHeight

        opacity: visible ? 1 : 0
        scale: visible ? 1 : 0
        visible: root.valueIndicatorActive

        background: Rectangle {
            implicitWidth: valueIndicator.indicatorWidth
            implicitHeight: valueIndicator.indicatorHeight
            radius: height / 2
            color: root.valueIndicatorContainerColor
        }

        contentItem: Item {
            implicitWidth: valueIndicatorLabel.implicitWidth
            implicitHeight: valueIndicatorLabel.implicitHeight

            MD.Label {
                id: valueIndicatorLabel
                objectName: "valueIndicatorLabel"

                anchors.centerIn: parent
                text: Math.round(root.valueIndicatorText)
                typescale: MD.Tokens.typescale.labelLarge
                font.weight: MD.Tokens.typescale.bodyLarge.fontWeight
                font.letterSpacing: MD.Tokens.typescale.bodyLarge.tracking
                color: root.valueIndicatorLabelColor
            }
        }

        Behavior on scale {
            NumberAnimation {
                // qmllint disable unresolved-type
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                // qmllint enable unresolved-type
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }
    }

    Rectangle {
        id: handle
        objectName: "sliderHandle"

        anchors.centerIn: parent
        width: root.horizontal ? root.activeHandleWidth : root.handleHeight
        height: root.horizontal ? root.handleHeight : root.activeHandleWidth
        radius: Math.min(width, height) / 2
        color: root.handleColor
        opacity: root.handleOpacity

        Behavior on width {
            NumberAnimation {
                // qmllint disable unresolved-type
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                // qmllint enable unresolved-type
            }
        }

        Behavior on height {
            NumberAnimation {
                // qmllint disable unresolved-type
                duration: MotionAnimation.expressiveFastSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                // qmllint enable unresolved-type
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: MD.Tokens.motion.duration.short2
            }
        }
    }
}
