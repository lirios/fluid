// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

T.RangeSlider {
    id: control

    enum LabelBehavior {
        Floating,
        WithinBounds,
        Visible,
        Gone
    }

    enum TickVisibilityMode {
        AutoLimit,
        AutoHide,
        Hidden
    }

    enum Size {
        ExtraSmall,
        Small,
        Medium,
        Large,
        ExtraLarge
    }

    /*!
        Controls when the value indicator is shown.
    */
    property int labelBehavior: RangeSlider.LabelBehavior.Floating

    /*!
        Controls how discrete tick marks are shown.
    */
    property int tickVisibilityMode: RangeSlider.TickVisibilityMode.AutoLimit

    /*!
        Controls the slider's expressive track and handle size.
    */
    property int size: RangeSlider.Size.ExtraSmall

    /*!
        Text displayed in the first handle value indicator.
    */
    property string firstValueIndicatorText: control.first.value.toLocaleString(Qt.locale(), "f", Number.isInteger(control.first.value) ? 0 : 2)
    /*!
        Text displayed in the second handle value indicator.
    */
    property string secondValueIndicatorText: control.second.value.toLocaleString(Qt.locale(), "f", Number.isInteger(control.second.value) ? 0 : 2)

    first.value: from
    second.value: to
    snapMode: T.RangeSlider.SnapAlways
    hoverEnabled: true

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, first.implicitHandleWidth + leftPadding + rightPadding, second.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, first.implicitHandleHeight + topPadding + bottomPadding, second.implicitHandleHeight + topPadding + bottomPadding)

    QtObject {
        id: metrics

        readonly property real handleHeight: {
            switch (control.size) {
            case RangeSlider.Size.ExtraSmall:
                return MD.Tokens.slider.activeHandleHeightExtraSmall;
            case RangeSlider.Size.Small:
                return MD.Tokens.slider.activeHandleHeightSmall;
            case RangeSlider.Size.Medium:
                return MD.Tokens.slider.activeHandleHeightMedium;
            case RangeSlider.Size.Large:
                return MD.Tokens.slider.activeHandleHeightLarge;
            case RangeSlider.Size.ExtraLarge:
                return MD.Tokens.slider.activeHandleHeightExtraLarge;
            }
            return MD.Tokens.slider.activeHandleHeightExtraSmall;
        }

        readonly property real trackHeight: {
            switch (control.size) {
            case RangeSlider.Size.ExtraSmall:
                return MD.Tokens.slider.activeTrackHeightExtraSmall;
            case RangeSlider.Size.Small:
                return MD.Tokens.slider.activeTrackHeightSmall;
            case RangeSlider.Size.Medium:
                return MD.Tokens.slider.activeTrackHeightMedium;
            case RangeSlider.Size.Large:
                return MD.Tokens.slider.activeTrackHeightLarge;
            case RangeSlider.Size.ExtraLarge:
                return MD.Tokens.slider.activeTrackHeightExtraLarge;
            }
            return MD.Tokens.slider.activeTrackHeightExtraSmall;
        }

        readonly property real trackOuterCornerRadius: {
            switch (control.size) {
            case RangeSlider.Size.ExtraSmall:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraSmall;
            case RangeSlider.Size.Small:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusSmall;
            case RangeSlider.Size.Medium:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusMedium;
            case RangeSlider.Size.Large:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusLarge;
            case RangeSlider.Size.ExtraLarge:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraLarge;
            }
            return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraSmall;
        }

        readonly property real effectiveHandleWidth: (control.first.pressed || control.second.pressed) ? MD.Tokens.slider.pressedHandleWidth : (control.visualFocus ? MD.Tokens.slider.focusHandleWidth : MD.Tokens.slider.handleWidth)
        readonly property real handleContainerSize: trackOuterCornerRadius * 2
        readonly property bool reservesLabelSpace: control.labelBehavior === RangeSlider.LabelBehavior.WithinBounds || control.labelBehavior === RangeSlider.LabelBehavior.Visible
        readonly property real labelSpace: {
            if (!reservesLabelSpace)
                return 0;
            const indicatorSize = control.horizontal ? Math.max(firstSliderHandle.valueIndicatorHeight, secondSliderHandle.valueIndicatorHeight) : Math.max(firstSliderHandle.valueIndicatorWidth, secondSliderHandle.valueIndicatorWidth);
            return indicatorSize + MD.Tokens.slider.valueIndicatorActiveBottomSpace;
        }

        readonly property color activeTrackColor: control.enabled ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
        readonly property color inactiveTrackColor: control.enabled ? control.MD.Style.secondaryContainerColor : control.MD.Style.onSurfaceColor
        readonly property color activeTickColor: control.enabled ? control.MD.Style.onPrimaryColor : control.MD.Style.inverseOnSurfaceColor
        readonly property color inactiveTickColor: control.enabled ? control.MD.Style.onSecondaryContainerColor : control.MD.Style.onSurfaceColor
        readonly property color handleColor: control.enabled ? control.MD.Style.primaryColor : control.MD.Style.onSurfaceColor
        readonly property real activeTrackOpacity: control.enabled ? MD.Tokens.slider.visibleOpacity : MD.Tokens.slider.disabledActiveTrackOpacity
        readonly property real inactiveTrackOpacity: control.enabled ? MD.Tokens.slider.visibleOpacity : MD.Tokens.slider.disabledInactiveTrackOpacity
        readonly property real handleOpacity: control.enabled ? MD.Tokens.slider.visibleOpacity : MD.Tokens.slider.disabledHandleOpacity
    }

    background: MD.SliderTrack {
        horizontal: control.horizontal
        mirrored: control.mirrored
        centered: false
        rangeMode: true
        controlEnabled: control.enabled
        visualPosition: control.first.visualPosition
        secondVisualPosition: control.second.visualPosition
        rangeFrom: control.from
        rangeTo: control.to
        stepSize: control.stepSize
        tickVisibilityMode: control.tickVisibilityMode
        autoLimitMode: RangeSlider.TickVisibilityMode.AutoLimit
        autoHideMode: RangeSlider.TickVisibilityMode.AutoHide
        hiddenMode: RangeSlider.TickVisibilityMode.Hidden
        trackHeight: metrics.trackHeight
        trackOuterCornerRadius: metrics.trackOuterCornerRadius
        handleHeight: metrics.handleHeight
        effectiveHandleWidth: metrics.effectiveHandleWidth
        labelSpace: metrics.labelSpace
        activeTrackColor: metrics.activeTrackColor
        inactiveTrackColor: metrics.inactiveTrackColor
        activeTickColor: metrics.activeTickColor
        inactiveTickColor: metrics.inactiveTickColor
        activeTrackOpacity: metrics.activeTrackOpacity
        inactiveTrackOpacity: metrics.inactiveTrackOpacity
        trackIconActiveStart: ""
        trackIconActiveEnd: ""
        trackIconInactiveStart: ""
        trackIconInactiveEnd: ""
        trackIconActiveColor: metrics.activeTickColor
        trackIconInactiveColor: metrics.inactiveTickColor
        trackIconSize: 0
        trackIconPadding: 0
    }

    first.handle: MD.SliderHandle {
        id: firstSliderHandle

        x: control.leftPadding + (control.horizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.mirrored ? (control.availableWidth - metrics.labelSpace - width) / 2 : metrics.labelSpace + (control.availableWidth - metrics.labelSpace - width) / 2))
        y: control.topPadding + (control.horizontal ? metrics.labelSpace + (control.availableHeight - metrics.labelSpace - height) / 2 : control.first.visualPosition * (control.availableHeight - height))

        valueIndicatorText: control.firstValueIndicatorText
        labelBehavior: control.labelBehavior
        handleHasFocus: control.visualFocus
        handlePressed: control.first.pressed
        handleHovered: control.first.hovered
        controlEnabled: control.enabled
        horizontal: control.horizontal
        mirrored: control.mirrored
        controlWidth: control.width
        controlHeight: control.height
        activeHandleWidth: metrics.effectiveHandleWidth
        handleHeight: metrics.handleHeight
        handleContainerSize: metrics.handleContainerSize
        handleColor: metrics.handleColor
        handleOpacity: metrics.handleOpacity
        valueIndicatorContainerColor: control.MD.Style.inverseSurfaceColor
        valueIndicatorLabelColor: control.MD.Style.inverseOnSurfaceColor
    }

    second.handle: MD.SliderHandle {
        id: secondSliderHandle

        x: control.leftPadding + (control.horizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.mirrored ? (control.availableWidth - metrics.labelSpace - width) / 2 : metrics.labelSpace + (control.availableWidth - metrics.labelSpace - width) / 2))
        y: control.topPadding + (control.horizontal ? metrics.labelSpace + (control.availableHeight - metrics.labelSpace - height) / 2 : control.second.visualPosition * (control.availableHeight - height))

        valueIndicatorText: control.secondValueIndicatorText
        labelBehavior: control.labelBehavior
        handleHasFocus: control.visualFocus
        handlePressed: control.second.pressed
        handleHovered: control.second.hovered
        controlEnabled: control.enabled
        horizontal: control.horizontal
        mirrored: control.mirrored
        controlWidth: control.width
        controlHeight: control.height
        activeHandleWidth: metrics.effectiveHandleWidth
        handleHeight: metrics.handleHeight
        handleContainerSize: metrics.handleContainerSize
        handleColor: metrics.handleColor
        handleOpacity: metrics.handleOpacity
        valueIndicatorContainerColor: control.MD.Style.inverseSurfaceColor
        valueIndicatorLabelColor: control.MD.Style.inverseOnSurfaceColor
    }
}
