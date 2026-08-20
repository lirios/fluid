// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

T.Slider {
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
    property int labelBehavior: Slider.LabelBehavior.Floating

    /*!
        Controls how discrete tick marks are shown.
    */
    property int tickVisibilityMode: Slider.TickVisibilityMode.AutoLimit

    /*!
        Controls the slider's expressive track and handle size.
    */
    property int size: Slider.Size.ExtraSmall

    /*!
        Makes the active track extend from the midpoint to the handle.
    */
    property bool centered: false

    /*!
        Material Symbol names placed at the logical start and end of the active
        and inactive track segments.
    */
    property string trackIconActiveStart
    property string trackIconActiveEnd
    property string trackIconInactiveStart
    property string trackIconInactiveEnd

    /*!
        Colors used by inset icons. They default to the corresponding tick colors.
    */
    property color trackIconActiveColor: control.enabled ? control.MD.Style.onPrimaryColor : control.MD.Style.inverseOnSurfaceColor
    property color trackIconInactiveColor: control.enabled ? control.MD.Style.onSecondaryContainerColor : control.MD.Style.onSurfaceColor

    /*!
        Text displayed in the value indicator. Whole numbers omit decimals;
        other values use two locale-aware decimal places.
    */
    property string valueIndicatorText: control.value.toLocaleString(Qt.locale(), "f", Number.isInteger(control.value) ? 0 : 2)

    value: centered ? (from + to) / 2 : from
    snapMode: T.Slider.SnapAlways
    hoverEnabled: true

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitHandleHeight + topPadding + bottomPadding)

    QtObject {
        id: metrics

        readonly property real handleHeight: {
            switch (control.size) {
            case Slider.Size.ExtraSmall:
                return MD.Tokens.slider.activeHandleHeightExtraSmall;
            case Slider.Size.Small:
                return MD.Tokens.slider.activeHandleHeightSmall;
            case Slider.Size.Medium:
                return MD.Tokens.slider.activeHandleHeightMedium;
            case Slider.Size.Large:
                return MD.Tokens.slider.activeHandleHeightLarge;
            case Slider.Size.ExtraLarge:
                return MD.Tokens.slider.activeHandleHeightExtraLarge;
            }
            return MD.Tokens.slider.activeHandleHeightExtraSmall;
        }

        readonly property real trackHeight: {
            switch (control.size) {
            case Slider.Size.ExtraSmall:
                return MD.Tokens.slider.activeTrackHeightExtraSmall;
            case Slider.Size.Small:
                return MD.Tokens.slider.activeTrackHeightSmall;
            case Slider.Size.Medium:
                return MD.Tokens.slider.activeTrackHeightMedium;
            case Slider.Size.Large:
                return MD.Tokens.slider.activeTrackHeightLarge;
            case Slider.Size.ExtraLarge:
                return MD.Tokens.slider.activeTrackHeightExtraLarge;
            }
            return MD.Tokens.slider.activeTrackHeightExtraSmall;
        }

        readonly property real trackOuterCornerRadius: {
            switch (control.size) {
            case Slider.Size.ExtraSmall:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraSmall;
            case Slider.Size.Small:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusSmall;
            case Slider.Size.Medium:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusMedium;
            case Slider.Size.Large:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusLarge;
            case Slider.Size.ExtraLarge:
                return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraLarge;
            }
            return MD.Tokens.slider.activeTrackLeadingCornerRadiusExtraSmall;
        }

        readonly property real trackIconSize: {
            switch (control.size) {
            case Slider.Size.Medium:
                return MD.Tokens.slider.trackIconSizeMedium;
            case Slider.Size.Large:
                return MD.Tokens.slider.trackIconSizeLarge;
            case Slider.Size.ExtraLarge:
                return MD.Tokens.slider.trackIconSizeExtraLarge;
            }
            return 0;
        }

        readonly property real effectiveHandleWidth: control.pressed ? MD.Tokens.slider.pressedHandleWidth : (control.visualFocus ? MD.Tokens.slider.focusHandleWidth : MD.Tokens.slider.handleWidth)
        readonly property real handleContainerSize: trackOuterCornerRadius * 2
        readonly property bool reservesLabelSpace: control.labelBehavior === Slider.LabelBehavior.WithinBounds || control.labelBehavior === Slider.LabelBehavior.Visible
        readonly property real labelSpace: {
            if (!reservesLabelSpace)
                return 0;
            const indicatorSize = control.horizontal ? sliderHandle.valueIndicatorHeight : sliderHandle.valueIndicatorWidth;
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
        centered: control.centered
        rangeMode: false
        controlEnabled: control.enabled
        visualPosition: control.visualPosition
        secondVisualPosition: control.visualPosition
        rangeFrom: control.from
        rangeTo: control.to
        stepSize: control.stepSize
        tickVisibilityMode: control.tickVisibilityMode
        autoLimitMode: Slider.TickVisibilityMode.AutoLimit
        autoHideMode: Slider.TickVisibilityMode.AutoHide
        hiddenMode: Slider.TickVisibilityMode.Hidden
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
        trackIconActiveStart: control.trackIconActiveStart
        trackIconActiveEnd: control.trackIconActiveEnd
        trackIconInactiveStart: control.trackIconInactiveStart
        trackIconInactiveEnd: control.trackIconInactiveEnd
        trackIconActiveColor: control.trackIconActiveColor
        trackIconInactiveColor: control.trackIconInactiveColor
        trackIconSize: metrics.trackIconSize
    }

    handle: MD.SliderHandle {
        id: sliderHandle

        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.mirrored ? (control.availableWidth - metrics.labelSpace - width) / 2 : metrics.labelSpace + (control.availableWidth - metrics.labelSpace - width) / 2))
        y: control.topPadding + (control.horizontal ? metrics.labelSpace + (control.availableHeight - metrics.labelSpace - height) / 2 : control.visualPosition * (control.availableHeight - height))

        valueIndicatorText: control.valueIndicatorText
        labelBehavior: control.labelBehavior
        handleHasFocus: control.visualFocus
        handlePressed: control.pressed
        handleHovered: control.hovered
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
