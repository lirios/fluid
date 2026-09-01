// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

import QtQuick
import QtQuick.Templates as T

/*!
    \class RichToolTip
    \brief An actionable Material Design 3 Expressive tooltip.

    RichToolTip presents a body with an optional headline and zero, one, or two
    actions. Set \c headline to an empty string to omit it. The length of
    \c actions selects the button count; actions after the first two are
    ignored with a warning. The second button wraps when both do not fit.

    The inherited \c text property stores the body and is also exposed as
    \c body. Actions use \c QtQuick.Templates.Action so their text, enabled
    state, shortcuts, and triggered signal remain reusable. Fluid renders them
    as Material text buttons, gives the first enabled action focus when the
    popup opens, and closes the tooltip after activation.

    \code{.qml}
    MD.RichToolTip {
        id: formattingTip
        parent: formattingButton
        headline: qsTr("Formatting")
        body: qsTr("Choose how the selected text is emphasized.")
        actions: [
            Action { text: qsTr("Learn more"); onTriggered: openHelp() },
            Action { text: qsTr("Dismiss") }
        ]
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/tooltips/overview">Material Design 3 tooltip guidelines</a>.
*/
T.ToolTip {
    id: control
    objectName: "richToolTip"

    MD.Style.theme: control.parent ? control.parent.MD.Style.theme : MD.Style.System

    //! Optional headline. An empty string removes the headline slot.
    property string headline: ""

    //! Body text. This is an alias of the inherited ToolTip \c text property.
    property alias body: control.text

    /*!
        Ordered actions rendered as zero, one, or two Material text buttons.

        Additional actions are ignored. Use short localized labels so two
        actions can normally fit within the Material maximum width.
    */
    property list<T.Action> actions

    //! \internal Number of actions that can be displayed.
    readonly property int _displayedActionCount: Math.min(actions.length, 2)
    //! \internal Whether the body uses the structured rich-content padding.
    readonly property bool _hasStructuredContent: headline.length > 0
                                                  || _displayedActionCount > 0
    //! \internal Window-relative top coordinate of the anchor.
    readonly property real _anchorWindowY: parent
                                           ? parent.mapToItem(null, 0, 0).y + parent.y * 0 : 0
    //! \internal Whether the tooltip must open below its anchor.
    readonly property bool _opensBelow: parent
                                        ? _anchorWindowY - height
                                          - MD.Tokens.toolTip.anchorSpacing
                                          < MD.Tokens.toolTip.viewportMargin : false
    //! \internal Effective direction inherited from the popup, locale, or anchor.
    readonly property bool _layoutMirrored: mirrored
                                            || locale.textDirection === Qt.RightToLeft
                                            || (parent && parent.LayoutMirroring.enabled)
    //! \internal Natural action-row width before wrapping.
    readonly property real _actionNaturalWidth: (_displayedActionCount > 0
                                                 ? firstActionButton.implicitWidth : 0)
                                                + (_displayedActionCount > 1
                                                   ? secondActionButton.implicitWidth : 0)
    //! \internal Natural content width before the Material maximum is applied.
    readonly property real _naturalContentWidth: Math.max(headlineLabel.implicitWidth,
                                                          bodyLabel.implicitWidth,
                                                          _actionNaturalWidth)
    //! \internal Item that held focus before the tooltip opened.
    property Item _previousFocusItem: null

    function _rememberFocus() {
        const anchorWindow = control.parent ? control.parent.Window.window : null;
        control._previousFocusItem = anchorWindow ? anchorWindow.activeFocusItem : null;
    }

    function _focusFirstAction() {
        if (firstActionButton.visible && firstActionButton.enabled) {
            firstActionButton.forceActiveFocus(Qt.PopupFocusReason);
        } else if (secondActionButton.visible && secondActionButton.enabled) {
            secondActionButton.forceActiveFocus(Qt.PopupFocusReason);
        }
    }

    function _restoreFocus() {
        if (control._previousFocusItem)
            control._previousFocusItem.forceActiveFocus(Qt.PopupFocusReason);
        control._previousFocusItem = null;
    }

    onActionsChanged: {
        if (actions.length > 2)
            console.warn("RichToolTip supports at most two actions; additional actions are ignored");
    }
    onAboutToShow: control._rememberFocus()
    onOpened: Qt.callLater(control._focusFirstAction)
    onClosed: control._restoreFocus()

    x: parent ? (_layoutMirrored ? parent.width - width : 0) : 0
    y: parent ? (_opensBelow
                 ? parent.height + MD.Tokens.toolTip.anchorSpacing
                 : -height - MD.Tokens.toolTip.anchorSpacing) : 0

    implicitWidth: Math.max(MD.Tokens.toolTip.minimumWidth,
                            Math.min(MD.Tokens.toolTip.richMaximumWidth,
                                     _naturalContentWidth + leftPadding + rightPadding))
    implicitHeight: Math.max(MD.Tokens.toolTip.minimumHeight, implicitContentHeight)

    margins: MD.Tokens.toolTip.viewportMargin
    leftPadding: MD.Tokens.toolTip.richHorizontalPadding
    rightPadding: MD.Tokens.toolTip.richHorizontalPadding
    topPadding: 0
    bottomPadding: 0
    focus: _displayedActionCount > 0
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside
    transformOrigin: {
        if (_opensBelow)
            return _layoutMirrored ? Item.TopRight : Item.TopLeft;
        return _layoutMirrored ? Item.BottomRight : Item.BottomLeft;
    }

    contentItem: Column {
        id: contentColumn
        objectName: "richToolTipContent"
        width: control.availableWidth

        Item {
            id: headlineSlot
            objectName: "richToolTipHeadlineSlot"
            width: parent.width
            height: control.headline.length > 0
                    ? MD.Tokens.toolTip.richHeadlineFirstBaseline
                      + Math.max(0, headlineLabel.implicitHeight
                                  - headlineLabel.baselineOffset) : 0
            visible: control.headline.length > 0

            MD.Label {
                id: headlineLabel
                objectName: "richToolTipHeadline"
                y: MD.Tokens.toolTip.richHeadlineFirstBaseline - baselineOffset
                width: parent.width
                text: control.headline
                typescale: MD.Tokens.typescale.titleSmall
                color: control.MD.Style.onSurfaceVariantColor
                horizontalAlignment: control._layoutMirrored ? Text.AlignRight : Text.AlignLeft
                wrapMode: Text.Wrap
                elide: Text.ElideNone
            }
        }

        Item {
            id: bodySlot
            objectName: "richToolTipBodySlot"
            width: parent.width
            readonly property real labelY: control._hasStructuredContent
                                           ? MD.Tokens.toolTip.richBodyFirstBaseline
                                             - bodyLabel.baselineOffset
                                           : MD.Tokens.toolTip.plainVerticalPadding
            height: labelY + bodyLabel.implicitHeight
                    + (control._hasStructuredContent
                       ? MD.Tokens.toolTip.richBodyBottomPadding
                       : MD.Tokens.toolTip.plainVerticalPadding)

            MD.Label {
                id: bodyLabel
                objectName: "richToolTipBody"
                y: bodySlot.labelY
                width: parent.width
                text: control.text
                typescale: MD.Tokens.typescale.bodyMedium
                color: control.MD.Style.onSurfaceVariantColor
                horizontalAlignment: control._layoutMirrored ? Text.AlignRight : Text.AlignLeft
                wrapMode: Text.Wrap
                elide: Text.ElideNone
            }
        }

        Item {
            id: actionSlot
            objectName: "richToolTipActionSlot"
            width: parent.width
            readonly property bool actionsWrap: control._displayedActionCount > 1
                                                && control._actionNaturalWidth > width
            readonly property real actionContentHeight: actionsWrap
                                                        ? firstActionButton.implicitHeight
                                                          + secondActionButton.implicitHeight
                                                        : Math.max(firstActionButton.implicitHeight,
                                                                   secondActionButton.implicitHeight)
            height: control._displayedActionCount > 0
                    ? Math.max(MD.Tokens.toolTip.richActionMinimumHeight, actionContentHeight)
                      + MD.Tokens.toolTip.richActionBottomPadding : 0
            visible: control._displayedActionCount > 0

            Flow {
                id: actionFlow
                objectName: "richToolTipActionFlow"
                width: parent.width
                height: actionSlot.height - MD.Tokens.toolTip.richActionBottomPadding
                spacing: 0
                layoutDirection: control._layoutMirrored ? Qt.RightToLeft : Qt.LeftToRight

                MD.Button {
                    id: firstActionButton
                    objectName: "richToolTipAction0"
                    width: Math.min(implicitWidth, actionFlow.width)
                    action: control.actions.length > 0 ? control.actions[0] : null
                    type: MD.Button.Text
                    size: MD.Button.ExtraSmall
                    display: MD.Button.TextOnly
                    typescale: MD.Tokens.typescale.labelLarge
                    visible: control._displayedActionCount > 0
                    KeyNavigation.tab: secondActionButton.visible ? secondActionButton : null
                    Accessible.role: Accessible.Button
                    Accessible.name: action ? action.text : text

                    onClicked: control.close()
                }

                MD.Button {
                    id: secondActionButton
                    objectName: "richToolTipAction1"
                    width: Math.min(implicitWidth, actionFlow.width)
                    action: control.actions.length > 1 ? control.actions[1] : null
                    type: MD.Button.Text
                    size: MD.Button.ExtraSmall
                    display: MD.Button.TextOnly
                    typescale: MD.Tokens.typescale.labelLarge
                    visible: control._displayedActionCount > 1
                    KeyNavigation.backtab: firstActionButton.visible ? firstActionButton : null
                    Accessible.role: Accessible.Button
                    Accessible.name: action ? action.text : text

                    onClicked: control.close()
                }
            }
        }
    }

    background: MD.ElevationRectangle {
        objectName: "richToolTipBackground"
        readonly property var containerShape: MD.Tokens.toolTip.richContainerShape

        implicitWidth: MD.Tokens.toolTip.minimumWidth
        implicitHeight: MD.Tokens.toolTip.minimumHeight
        color: control.MD.Style.surfaceContainerColor
        topLeftRadius: UiMetrics.resolveShapeRadius(containerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(containerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(containerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(containerShape.bottomRight, width, height)
        elevation: MD.Tokens.toolTip.richContainerElevation
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
