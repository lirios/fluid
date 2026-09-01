// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import QtQuick.Window
import Fluid as MD
import "../internal/MotionAnimation.js" as MotionAnimation

/*!
    \class ModalNavigationRail
    \brief A modal Material Design 3 Expressive navigation rail.

    ModalNavigationRail is a page-sized overlay host. Its expanded rail appears
    above application content, blocks that content with a scrim, and does not
    change the page's layout. Tapping the scrim, pressing Escape, or dragging
    the rail at least halfway toward the logical-start edge collapses it.

    By default the collapsed 96 dp rail remains visible. Set
    \c hideOnCollapse to make the expanded rail enter from and return fully
    off-screen instead. Destination activation changes \c currentIndex but does
    not collapse the rail, leaving the application's navigation lifecycle in
    control.

    \code{.qml}
    MD.ModalNavigationRail {
        anchors.fill: parent
        hideOnCollapse: true
        expanded: navigationButton.checked

        MD.NavigationRailItem {
            text: qsTr("Home")
            icon.name: MD.SymbolNames.symbolHome
        }
        MD.NavigationRailItem {
            text: qsTr("Settings")
            icon.name: MD.SymbolNames.symbolSettings
        }
    }
    \endcode

    This control is intended for medium, expanded, large, and extra-large
    windows. Applications select it explicitly using \l Breakpoints.

    For more information see the
    <a href="https://m3.material.io/components/navigation-rail/overview">Material Design 3 navigation rail guidelines</a>.
*/
T.Control {
    id: control

    //! Destination objects declared inside this modal rail.
    default property alias destinations: rail.contentData

    /*! Whether the modal rail is expanded.

        Expanding shows the scrim and moves focus into the rail. Collapsing
        restores the item that held focus before expansion when it still exists.
    */
    property bool expanded: false

    /*! Whether the rail is fully hidden when collapsed.

        When false, the collapsed persistent rail remains visible. When true,
        the rail keeps expanded item geometry and slides beyond the
        logical-start edge.
    */
    property bool hideOnCollapse: false

    //! Index of the selected destination; \c -1 permits no selection.
    property alias currentIndex: rail.currentIndex

    //! Vertical arrangement of destinations; accepts NavigationRail arrangement values.
    property alias arrangement: rail.arrangement

    //! Optional component shown at the top of the rail.
    property alias header: rail.header

    //! Semantic background color of the modal rail surface.
    property color containerColor: control.MD.Style.surfaceContainerColor

    //! Semantic color of the modal scrim.
    property color scrimColor: control.MD.Style.scrimColor

    //! Number of destinations currently owned by the rail.
    readonly property alias count: rail.count

    //! \internal Item that held focus immediately before expansion.
    property Item _restoreFocusItem: null

    //! \internal Horizontal offset applied by an active or settling drag.
    property real _dragOffset: 0

    //! \internal Drag distance recorded when the current gesture began.
    property real _dragStartOffset: 0

    /*! Returns the destination at \a index, or \c null when it is out of range.

        This forwards NavigationRail::itemAt().
    */
    function itemAt(index) {
        return rail.itemAt(index);
    }

    //! Expands the modal rail.
    function expand() {
        control.expanded = true;
    }

    //! Collapses the modal rail.
    function collapse() {
        control.expanded = false;
    }

    //! Toggles between expanded and collapsed states.
    function toggle() {
        control.expanded = !control.expanded;
    }

    //! \internal Moves focus to the selected or first enabled destination.
    function _focusRail() {
        let index = control.currentIndex;
        if (index >= 0) {
            const selectedItem = rail.itemAt(index);
            if (selectedItem && selectedItem.enabled) {
                selectedItem.forceActiveFocus(Qt.PopupFocusReason);
                return;
            }
        }
        for (index = 0; index < rail.count; ++index) {
            const item = rail.itemAt(index);
            if (item && item.enabled) {
                item.forceActiveFocus(Qt.PopupFocusReason);
                return;
            }
        }
        rail.forceActiveFocus(Qt.PopupFocusReason);
    }

    implicitWidth: rail.implicitWidth
    implicitHeight: rail.implicitHeight
    padding: 0
    focusPolicy: Qt.StrongFocus
    LayoutMirroring.childrenInherit: true

    onExpandedChanged: {
        if (expanded) {
            _restoreFocusItem = Window.window ? Window.window.activeFocusItem : null;
            Qt.callLater(control._focusRail);
        } else {
            _dragOffset = 0;
            if (_restoreFocusItem)
                _restoreFocusItem.forceActiveFocus(Qt.PopupFocusReason);
            _restoreFocusItem = null;
        }
    }

    Keys.onEscapePressed: event => {
        if (control.expanded)
            control.collapse();
        else
            event.accepted = false;
    }

    contentItem: Item {
        clip: false

        Rectangle {
            id: scrim
            objectName: "modalNavigationRailScrim"

            anchors.fill: parent
            z: 0
            color: control.scrimColor
            opacity: control.expanded ? MD.Tokens.navigationRail.modalScrimOpacity : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: MotionAnimation.expressiveFastEffectsDuration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
                }
            }

            TapHandler {
                onTapped: control.collapse()
            }
        }

        NavigationRail {
            id: rail
            objectName: "modalNavigationRailSurface"

            z: 1
            x: {
                const shownX = control.mirrored ? control.width - rail.width : 0;
                const hiddenX = control.mirrored ? control.width : -rail.width;
                return (control.expanded || !control.hideOnCollapse ? shownX : hiddenX)
                       + control._dragOffset;
            }
            y: 0
            width: Math.min(rail.implicitWidth, control.width)
            height: control.height
            expanded: control.hideOnCollapse || control.expanded
            containerColor: control.containerColor
            _modal: true
            LayoutMirroring.enabled: control.mirrored
            LayoutMirroring.childrenInherit: true

            Behavior on x {
                enabled: !dragHandler.active && !dragSettleAnimation.running

                NumberAnimation {
                    duration: MotionAnimation.expressiveFastSpatialDuration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
                }
            }

            DragHandler {
                id: dragHandler
                objectName: "modalNavigationRailDragHandler"

                enabled: control.expanded
                target: null
                dragThreshold: 0
                acceptedDevices: PointerDevice.TouchScreen | PointerDevice.TouchPad | PointerDevice.Mouse

                onActiveChanged: {
                    if (active) {
                        dragSettleAnimation.stop();
                        control._dragStartOffset = control._dragOffset;
                    } else {
                        const dismissalDistance = control.mirrored
                                                  ? control._dragOffset
                                                  : -control._dragOffset;
                        if (dismissalDistance >= rail.width * 0.5) {
                            control._dragOffset = 0;
                            control.collapse();
                        } else {
                            dragSettleAnimation.restart();
                        }
                    }
                }

                onTranslationChanged: {
                    if (!active)
                        return;
                    const logicalDistance = control.mirrored ? translation.x : -translation.x;
                    const clampedDistance = Math.max(0, Math.min(rail.width, logicalDistance));
                    control._dragOffset = control._dragStartOffset
                                          + (control.mirrored ? clampedDistance : -clampedDistance);
                }
            }
        }
    }

    NumberAnimation {
        id: dragSettleAnimation
        target: control
        property: "_dragOffset"
        to: 0
        duration: MotionAnimation.expressiveFastSpatialDuration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
    }
}
