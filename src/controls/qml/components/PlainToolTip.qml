// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

import QtQuick
import QtQuick.Templates as T

/*!
    \class PlainToolTip
    \brief A concise Material Design 3 Expressive tooltip.

    PlainToolTip describes an anchor with a short text label. It can be created
    as a standalone \c QtQuick.Templates.ToolTip. The popup prefers to appear
    above its anchor, moves below when space is insufficient, and remains
    inside the window viewport. Use the \c ToolTip attached API for concise
    tooltips that do not require a standalone object.

    The inherited ToolTip API provides \c text, \c visible, \c delay,
    \c timeout, \c show(), and \c hide(). Qt Quick Templates supplies the
    accessible tooltip role and announcement behavior; use localized text that
    adds information not already present in the anchor's accessible name.

    \code{.qml}
    MD.IconButton {
        text: qsTr("Search")
        icon.name: MD.SymbolNames.symbolSearch

        MD.ToolTip.text: qsTr("Search")
        MD.ToolTip.visible: hovered || visualFocus
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/tooltips/overview">Material Design 3 tooltip guidelines</a>.
*/
T.ToolTip {
    id: control
    objectName: "plainToolTip"

    MD.Style.theme: control.parent ? control.parent.MD.Style.theme : MD.Style.System

    //! \internal Window-relative top coordinate of the anchor.
    readonly property real _anchorWindowY: control.parent
                                           ? control.parent.mapToItem(null, 0, 0).y
                                             + control.parent.y * 0 : 0
    //! \internal Whether the tooltip must open below its anchor.
    readonly property bool _opensBelow: control.parent
                                        ? control._anchorWindowY - control.height
                                          - MD.Tokens.toolTip.anchorSpacing
                                          < MD.Tokens.toolTip.viewportMargin : false
    //! \internal Effective direction inherited from the popup, locale, or anchor.
    readonly property bool _layoutMirrored: control.mirrored
                                            || control.locale.textDirection === Qt.RightToLeft
                                            || (control.parent
                                                && control.parent.LayoutMirroring.enabled)
    //! \internal Natural width before the Material maximum is applied.
    readonly property real _naturalWidth: control.implicitContentWidth
                                          + control.leftPadding + control.rightPadding

    x: control.parent ? (control.parent.width - control.width) / 2 : 0
    y: control.parent ? (control._opensBelow
                         ? control.parent.height + MD.Tokens.toolTip.anchorSpacing
                         : -control.height - MD.Tokens.toolTip.anchorSpacing) : 0

    implicitWidth: Math.max(MD.Tokens.toolTip.minimumWidth,
                            Math.min(MD.Tokens.toolTip.plainMaximumWidth, _naturalWidth))
    implicitHeight: Math.max(MD.Tokens.toolTip.minimumHeight,
                             control.implicitContentHeight
                             + control.topPadding + control.bottomPadding)

    margins: MD.Tokens.toolTip.viewportMargin
    leftPadding: MD.Tokens.toolTip.plainHorizontalPadding
    rightPadding: MD.Tokens.toolTip.plainHorizontalPadding
    topPadding: MD.Tokens.toolTip.plainVerticalPadding
    bottomPadding: MD.Tokens.toolTip.plainVerticalPadding
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent
                 | T.Popup.CloseOnReleaseOutsideParent
    transformOrigin: control._opensBelow ? Item.Top : Item.Bottom

    contentItem: MD.Label {
        objectName: "plainToolTipLabel"
        width: control.availableWidth
        text: control.text
        typescale: MD.Tokens.typescale.bodySmall
        color: control.MD.Style.inverseOnSurfaceColor
        horizontalAlignment: control._layoutMirrored ? Text.AlignRight : Text.AlignLeft
        wrapMode: Text.Wrap
        elide: Text.ElideNone
    }

    background: Rectangle {
        objectName: "plainToolTipBackground"
        readonly property var containerShape: MD.Tokens.toolTip.plainContainerShape

        implicitWidth: MD.Tokens.toolTip.minimumWidth
        implicitHeight: MD.Tokens.toolTip.minimumHeight
        color: control.MD.Style.inverseSurfaceColor
        topLeftRadius: UiMetrics.resolveShapeRadius(containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(containerShape.bottomRight, width, height)
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: MD.Tokens.toolTip.closedScale
            to: 1
            duration: MotionAnimation.expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: MotionAnimation.expressiveFastEffectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1
            to: MD.Tokens.toolTip.closedScale
            duration: MotionAnimation.expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
        }
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: MotionAnimation.expressiveFastEffectsDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
        }
    }
}
