// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD
import "../core/UiMetrics.js" as UiMetrics
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class FabMenuItem
    \brief A pill-shaped action inside a Material Design 3 Expressive FAB menu.

    FabMenuItem lays out an optional leading icon and a text label inside an
    elevated pill container. Its colors default to the colors of the FAB menu
    that owns it, so a menu renders as a single coherent group.

    Items declared as children of a FabMenu are bound to it automatically and
    enter and leave with a staggered spring, so the item nearest the toggle
    button moves first, as the staggered list entrance of the specification
    requires. A fully collapsed item is hidden and accepts no input. Leading and
    trailing content and the text alignment mirror automatically for
    right-to-left locales.

    An item can be driven by an existing action:

    \code{.qml}
    MD.FabMenuItem {
        action: newDocumentAction
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/fab-menu/overview">Material Design 3 FAB menu guidelines</a>.
*/
T.AbstractButton {
    id: control

    //! \internal The FAB menu that owns this item, assigned by FabMenu.
    property MD.FabMenu menu: null

    /*!
        \internal
        The position of this item among the children of its FAB menu, assigned
        by FabMenu in declaration order. The entrance sequence is derived from
        it by \c _entranceOrder rather than read from it directly.
    */
    property int staggerIndex: 0

    //! The background color used in normal interactive states.
    property color containerColor: control.menu ? control.menu.itemContainerColor : control.MD.Style.primaryContainerColor

    //! The foreground color used in normal interactive states.
    property color contentColor: control.menu ? control.menu.itemContentColor : control.MD.Style.onPrimaryContainerColor

    //! The resolved background color.
    readonly property color effectiveContainerColor: control.containerColor

    //! The resolved foreground color.
    readonly property color effectiveContentColor: control.contentColor

    //! \internal Whether the action supplies a Material symbol name.
    readonly property bool _hasNamedIcon: icon.name.length > 0

    //! \internal Whether the action supplies an image source.
    readonly property bool _hasSourceIcon: icon.source.toString().length > 0

    //! \internal Whether the action supplies either supported icon type.
    readonly property bool _hasIcon: _hasNamedIcon || _hasSourceIcon

    //! \internal Effective opacity for enabled and disabled content.
    readonly property real _contentOpacity: enabled ? 1 : MD.Tokens.fabMenu.disabledContentOpacity

    //! \internal Whether this item takes part in the menu entrance motion.
    readonly property bool _animated: menu !== null

    /*!
        \internal
        The position of this item in the entrance sequence counted from the
        toggle button, so the nearest item always moves first, as the staggered
        list entrance of the specification requires. Items grow away from the
        button, so this reverses \c staggerIndex when the list grows upwards and
        the nearest item is the last child. Multiplied by the stagger delay
        token, it is the delay before this item enters or leaves.
    */
    readonly property int _entranceOrder: control._animated && control.menu._entranceDirection > 0 ? Math.max(0, control.menu.contentChildren.length - 1 - control.staggerIndex) : control.staggerIndex

    //! \internal Normalized scale of a fully collapsed item.
    readonly property real _collapsedScale: 0.8

    //! \internal Collapsed vertical offset as a fraction of the item height.
    readonly property real _collapsedOffsetFactor: 0.5

    //! \internal Collapsed vertical offset, directed towards the toggle button.
    readonly property real _collapsedOffset: _animated ? control.height * control._collapsedOffsetFactor * control.menu._entranceDirection : 0

    //! \internal Vertical offset applied while entering or leaving.
    property real _entranceOffset: 0

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0
    leftPadding: mirrored ? MD.Tokens.fabMenu.listItemTrailingSpace : MD.Tokens.fabMenu.listItemLeadingSpace
    rightPadding: mirrored ? MD.Tokens.fabMenu.listItemLeadingSpace : MD.Tokens.fabMenu.listItemTrailingSpace
    topPadding: 0
    bottomPadding: 0
    spacing: MD.Tokens.fabMenu.listItemIconLabelSpace

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    LayoutMirroring.childrenInherit: true

    transform: Translate {
        y: control._entranceOffset
    }

    states: [
        State {
            name: "collapsed"
            when: control._animated && !control.menu.expanded

            PropertyChanges {
                control.opacity: 0
                control.scale: control._collapsedScale
                control._entranceOffset: control._collapsedOffset
                control.visible: false
            }
        }
    ]

    transitions: [
        Transition {
            to: "collapsed"

            SequentialAnimation {
                PauseAnimation {
                    duration: control._entranceOrder * MD.Tokens.fabMenu.listItemStaggerDelay
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: control
                        properties: "scale,_entranceOffset"
                        // qmllint disable unresolved-type
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                        duration: MotionAnimation.expressiveFastSpatialDuration
                        // qmllint enable unresolved-type
                    }
                    NumberAnimation {
                        target: control
                        property: "opacity"
                        // qmllint disable unresolved-type
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
                        duration: MotionAnimation.expressiveFastEffectsDuration
                        // qmllint enable unresolved-type
                    }
                }
                PropertyAction {
                    target: control
                    property: "visible"
                }
            }
        },
        Transition {
            from: "collapsed"

            SequentialAnimation {
                PropertyAction {
                    target: control
                    property: "visible"
                }
                PauseAnimation {
                    duration: control._entranceOrder * MD.Tokens.fabMenu.listItemStaggerDelay
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: control
                        properties: "scale,_entranceOffset"
                        // qmllint disable unresolved-type
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                        duration: MotionAnimation.expressiveFastSpatialDuration
                        // qmllint enable unresolved-type
                    }
                    NumberAnimation {
                        target: control
                        property: "opacity"
                        // qmllint disable unresolved-type
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
                        duration: MotionAnimation.expressiveFastEffectsDuration
                        // qmllint enable unresolved-type
                    }
                }
            }
        }
    ]

    contentItem: Item {
        id: itemContent

        readonly property real leadingWidth: iconSlot.visible ? iconSlot.width + control.spacing : 0

        implicitWidth: leadingWidth + label.implicitWidth
        implicitHeight: Math.max(MD.Tokens.fabMenu.listItemIconSize, label.implicitHeight)

        Row {
            anchors.fill: parent
            spacing: control.spacing
            LayoutMirroring.enabled: control.mirrored
            LayoutMirroring.childrenInherit: true

            Item {
                id: iconSlot
                objectName: "fabMenuItemIcon"

                anchors.verticalCenter: parent.verticalCenter
                width: MD.Tokens.fabMenu.listItemIconSize
                height: MD.Tokens.fabMenu.listItemIconSize
                visible: control._hasIcon

                Image {
                    anchors.fill: parent
                    source: control.icon.source
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: control._contentOpacity
                    visible: control._hasSourceIcon
                }

                MD.Symbol {
                    anchors.centerIn: parent
                    name: control.icon.name
                    iconWidth: MD.Tokens.fabMenu.listItemIconSize
                    iconHeight: MD.Tokens.fabMenu.listItemIconSize
                    color: control.effectiveContentColor
                    opacity: control._contentOpacity
                    visible: !control._hasSourceIcon && control._hasNamedIcon
                }
            }

            MD.Label {
                id: label
                objectName: "fabMenuItemLabel"

                width: Math.max(0, itemContent.width - itemContent.leadingWidth)
                anchors.verticalCenter: parent.verticalCenter
                text: control.text
                // qmllint disable unresolved-type
                typescale: MD.Tokens.typescale.titleMedium
                // qmllint enable unresolved-type
                color: control.effectiveContentColor
                opacity: control._contentOpacity
                horizontalAlignment: control.mirrored ? Text.AlignRight : Text.AlignLeft
                elide: Text.ElideRight
            }
        }
    }

    background: MD.ElevationRectangle {
        implicitHeight: MD.Tokens.fabMenu.listItemContainerHeight
        topLeftRadius: UiMetrics.resolveShapeRadius(
                               MD.Tokens.fabMenu.listItemContainerShape.topLeft, width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(
                                MD.Tokens.fabMenu.listItemContainerShape.topRight, width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(
                                  MD.Tokens.fabMenu.listItemContainerShape.bottomLeft, width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(
                                   MD.Tokens.fabMenu.listItemContainerShape.bottomRight, width,
                                   height)
        color: control.effectiveContainerColor
        elevation: MD.Tokens.fabMenu.listItemContainerElevation

        MD.Ripple {
            objectName: "fabMenuItemRipple"

            anchors.fill: parent
            topLeftRadius: parent.topLeftRadius
            topRightRadius: parent.topRightRadius
            bottomLeftRadius: parent.bottomLeftRadius
            bottomRightRadius: parent.bottomRightRadius
            pressed: control.pressed
            pressX: control.pressX
            pressY: control.pressY
            color: control.effectiveContentColor
            stateOpacity: {
                if (!control.enabled)
                    return 0;
                if (control.pressed)
                    return MD.Tokens.fabMenu.pressedStateLayerOpacity;
                if (control.visualFocus)
                    return MD.Tokens.fabMenu.focusStateLayerOpacity;
                if (control.hovered)
                    return MD.Tokens.fabMenu.hoverStateLayerOpacity;
                return 0;
            }
        }
    }
}
