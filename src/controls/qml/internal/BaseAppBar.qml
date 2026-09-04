// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound
import Fluid as MD
import "MotionAnimation.js" as MotionAnimation
import "../core/UiMetrics.js" as UiMetrics

import QtQuick
import QtQuick.Templates as T

/*!
    \class BaseAppBar
    \internal
    \brief Shared foundation for Material 3 Expressive app bars.

    BaseAppBar owns safe-area-aware geometry, logical start/end placement,
    adaptive action overflow, scrolling and dragging behavior, lifted container
    treatment, and overflow-menu interaction. AppBar and SearchAppBar provide
    their center content while exposing the relevant properties below as part
    of their inherited public API.

    The implementation follows the
    <a href="https://m3.material.io/components/app-bars/overview">Material Design 3 app bar guidelines</a>
    and is not part of the public QML API.
*/
T.ToolBar {
    id: control

    /*!
        Controls how an app bar responds to vertical scrolling.

        - \c Pinned: Keeps the bar fixed and applies lifted styling after content
            scrolls away from its origin.
        - \c EnterAlways: Retracts on upward scrolling, re-enters immediately on
            downward scrolling, and settles to the nearest endpoint.
        - \c ExitUntilCollapsed: Collapses flexible height on upward scrolling
            and expands again when content returns to its beginning.
    */
    enum ScrollBehavior {
        Pinned,
        EnterAlways,
        ExitUntilCollapsed
    }

    /*!
        The optional action displayed at the logical start edge.

        Set the property to \c null to reserve no navigation-action space.
    */
    property MD.AppBarAction navigationAction: null

    /*!
        Actions displayed at the logical end edge.

        Actions are kept in their source order. Automatic overflow selection
        uses each action's priority and overflow policy.
    */
    property list<MD.AppBarAction> actions

    //! \internal Additional actions contributed directly to the overflow menu.
    property var supplementalOverflowActions: []

    /*!
        The Flickable observed for scrolling behavior.

        Origin changes, overshoot, runtime target replacement, and movement
        completion are handled automatically.
    */
    property Flickable scrollTarget: null

    //! The scrolling behavior applied to \c scrollTarget.
    property int scrollBehavior: BaseAppBar.Pinned

    //! Height of the fully collapsed container, excluding the top safe area.
    property real collapsedHeight: MD.Tokens.appBar.smallContainerHeight

    /*!
        Minimum height of the fully expanded container, excluding the top safe
        area. Flexible content may increase its effective height when needed.
    */
    property real expandedHeight: collapsedHeight

    //! \internal Minimum width protected for center content during action reflow.
    property real minimumCenterWidth: MD.Tokens.appBar.titleInset

    //! \internal Component instantiated as the app bar's center content.
    property Component centerContent: null

    /*!
        Optional background or media shown behind expanded app-bar content.

        The component extends edge-to-edge, including behind safe-area insets,
        and fades as the bar collapses.
    */
    property Component expandedBackground: null

    //! Container color used before content has scrolled.
    property color containerColor: MD.Style.surfaceColor

    //! Container color used while the app bar is lifted.
    property color scrolledContainerColor: MD.Style.surfaceContainerColor

    //! Foreground color used by title content.
    property color titleColor: MD.Style.onSurfaceColor

    //! Foreground color used by subtitle content.
    property color subtitleColor: MD.Style.onSurfaceVariantColor

    //! Foreground color used by the logical-start navigation action.
    property color navigationContentColor: MD.Style.onSurfaceColor

    //! Foreground color used by trailing and overflow actions.
    property color actionContentColor: MD.Style.onSurfaceVariantColor

    /*!
        Current collapse or retraction offset in device-independent pixels.

        The value ranges from zero to the active behavior's maximum offset.
    */
    readonly property real heightOffset: _heightOffset

    /*!
        Current collapse progress.

        Zero represents fully expanded and one represents fully collapsed or
        fully retracted. A non-flexible pinned bar reports one.
    */
    readonly property real collapsedFraction: {
        if (_collapseRange > 0)
            return _heightOffset / _collapseRange;
        if (scrollBehavior === BaseAppBar.EnterAlways && _maximumHeightOffset > 0)
            return _heightOffset / _maximumHeightOffset;
        return 1;
    }

    //! Whether scrolled container color and elevation are currently applied.
    readonly property bool lifted: _heightOffset > 0 || (scrollTarget !== null && scrollTarget.contentY > scrollTarget.originY)

    //! Whether the adaptive overflow menu is currently open.
    readonly property bool overflowVisible: overflowMenu.visible

    //! \internal Whether geometry is currently mirrored.
    readonly property bool layoutMirrored: mirrored || LayoutMirroring.enabled

    //! Actions currently presented directly in the app bar.
    readonly property var visibleActions: _visibleActions

    //! Actions currently presented in the overflow menu.
    readonly property var overflowActions: _overflowActions

    //! \internal Physical left edge of safe-area-adjusted bar content.
    readonly property real contentLeft: SafeArea.margins.left + MD.Tokens.appBar.horizontalPadding

    //! \internal Physical right edge of safe-area-adjusted bar content.
    readonly property real contentRight: width - SafeArea.margins.right - MD.Tokens.appBar.horizontalPadding

    //! \internal Available safe-area-adjusted content width.
    readonly property real barContentWidth: Math.max(0, contentRight - contentLeft)

    //! \internal Width occupied by the logical-start action.
    readonly property real leadingWidth: navigationButton.visible ? navigationButton.width : 0

    //! \internal Width occupied by directly visible logical-end actions.
    readonly property real trailingWidth: trailingRow.width

    //! \internal Logical-start occupied width exposed to center-content geometry.
    readonly property real logicalStartOccupiedWidth: leadingWidth

    //! \internal Logical-end occupied width exposed to center-content geometry.
    readonly property real logicalEndOccupiedWidth: trailingWidth

    //! \internal Current container height after flexible collapse.
    readonly property real currentContainerHeight: scrollBehavior === BaseAppBar.ExitUntilCollapsed ? expandedHeight - _heightOffset : expandedHeight

    //! \internal
    property real _heightOffset: 0

    //! \internal
    property real _lastScrollPosition: 0

    //! \internal
    property real _dragStartOffset: 0

    //! \internal
    property var _visibleActions: []

    //! \internal
    property var _overflowActions: []

    //! \internal
    readonly property real _collapseRange: Math.max(0, expandedHeight - collapsedHeight)

    //! \internal
    readonly property real _maximumHeightOffset: {
        switch (scrollBehavior) {
        case BaseAppBar.EnterAlways:
            return expandedHeight + SafeArea.margins.top;
        case BaseAppBar.ExitUntilCollapsed:
            return _collapseRange;
        default:
            return 0;
        }
    }

    implicitWidth: MD.Tokens.appBar.searchAdaptiveBreakpoint
    implicitHeight: currentContainerHeight + SafeArea.margins.top
    padding: 0
    spacing: 0
    clip: false

    transform: Translate {
        y: control.scrollBehavior === BaseAppBar.EnterAlways ? -control._heightOffset : 0
    }

    //! \internal
    function _clampOffset(value) {
        return Math.max(0, Math.min(_maximumHeightOffset, value));
    }

    //! \internal
    function _actionWidth(index) {
        const item = actionRepeater.itemAt(index);
        return item ? item.implicitWidth : MD.Tokens.appBar.minimumInteractiveSize;
    }

    //! \internal
    function _reflowActions() {
        const candidates = [];
        const forcedVisible = [];
        const forcedOverflow = [];
        let visibleWidth = 0;

        for (let index = 0; index < actions.length; ++index) {
            const action = actions[index];
            if (!action || !action.visible)
                continue;

            const entry = {
                action: action,
                index: index,
                width: _actionWidth(index)
            };
            if (action.overflowPolicy === MD.AppBarAction.AlwaysOverflow) {
                forcedOverflow.push(entry);
            } else if (action.overflowPolicy === MD.AppBarAction.NeverOverflow) {
                forcedVisible.push(entry);
                visibleWidth += entry.width;
            } else {
                candidates.push(entry);
            }
        }

        const totalAutoWidth = candidates.reduce((sum, entry) => sum + entry.width, 0);
        const reservedLeading = navigationAction && navigationAction.visible ? MD.Tokens.appBar.minimumInteractiveSize : 0;
        const baseBudget = Math.max(0, barContentWidth - reservedLeading - minimumCenterWidth);
        const needsOverflow = forcedOverflow.length > 0 || supplementalOverflowActions.length > 0 || visibleWidth + totalAutoWidth > baseBudget;
        const actionBudget = Math.max(0, baseBudget - (needsOverflow ? MD.Tokens.appBar.minimumInteractiveSize : 0));

        candidates.sort((left, right) => {
            if (left.action.priority !== right.action.priority)
                return right.action.priority - left.action.priority;
            return left.index - right.index;
        });

        const selected = new Set();
        for (const entry of forcedVisible)
            selected.add(entry.action);

        let usedWidth = visibleWidth;
        for (const entry of candidates) {
            if (usedWidth + entry.width <= actionBudget) {
                selected.add(entry.action);
                usedWidth += entry.width;
            }
        }

        const visible = [];
        const overflow = [];
        for (let index = 0; index < actions.length; ++index) {
            const action = actions[index];
            if (!action || !action.visible)
                continue;
            if (action.overflowPolicy === MD.AppBarAction.AlwaysOverflow || (action.overflowPolicy === MD.AppBarAction.AutoOverflow && !selected.has(action))) {
                overflow.push(action);
            } else {
                visible.push(action);
            }
        }

        for (const action of supplementalOverflowActions) {
            if (action && action.visible && overflow.indexOf(action) < 0)
                overflow.push(action);
        }

        _visibleActions = visible;
        _overflowActions = overflow;
        _syncOverflowMenu();
    }

    //! \internal Keeps the Menu's action model in adaptive overflow order.
    function _syncOverflowMenu() {
        for (let index = overflowMenu.count - 1; index >= 0; --index) {
            const action = overflowMenu.actionAt(index);
            if (action)
                overflowMenu.removeAction(action);
        }

        for (const action of _overflowActions)
            overflowMenu.addAction(action);
    }

    //! \internal
    function _scheduleReflow() {
        _reflowActions();
        Qt.callLater(() => control._reflowActions());
    }

    //! \internal
    function _observeScroll() {
        if (!scrollTarget)
            return;

        const origin = scrollTarget.originY;
        const position = Math.max(origin, scrollTarget.contentY);
        const delta = position - _lastScrollPosition;
        _lastScrollPosition = position;

        if (scrollBehavior === BaseAppBar.Pinned) {
            _heightOffset = 0;
        } else if (scrollBehavior === BaseAppBar.EnterAlways) {
            settleAnimation.stop();
            _heightOffset = _clampOffset(_heightOffset + delta);
        } else if (scrollBehavior === BaseAppBar.ExitUntilCollapsed) {
            settleAnimation.stop();
            if (position <= origin)
                _heightOffset = 0;
            else if (delta > 0)
                _heightOffset = _clampOffset(_heightOffset + delta);
        }
    }

    //! \internal
    function _settle() {
        if (scrollBehavior === BaseAppBar.Pinned || _maximumHeightOffset <= 0)
            return;

        let destination = _heightOffset >= _maximumHeightOffset / 2 ? _maximumHeightOffset : 0;
        if (scrollBehavior === BaseAppBar.ExitUntilCollapsed && scrollTarget && !scrollTarget.atYBeginning) {
            destination = _maximumHeightOffset;
        }
        settleAnimation.to = destination;
        settleAnimation.restart();
    }

    //! Opens the overflow menu when at least one overflow action is available.
    function openOverflow() {
        if (_overflowActions.length === 0)
            return;

        const point = overflowButton.mapToItem(control, 0, overflowButton.height);
        overflowMenu.x = layoutMirrored ? point.x : point.x + overflowButton.width - overflowMenu.implicitWidth;
        overflowMenu.y = point.y;
        overflowMenu.open();
    }

    //! Closes the overflow menu.
    function closeOverflow() {
        overflowMenu.close();
    }

    onWidthChanged: _scheduleReflow()
    onMinimumCenterWidthChanged: _scheduleReflow()
    onActionsChanged: _scheduleReflow()
    onNavigationActionChanged: _scheduleReflow()
    onSupplementalOverflowActionsChanged: _scheduleReflow()
    onScrollBehaviorChanged: {
        settleAnimation.stop();
        _heightOffset = 0;
        _observeScroll();
    }
    onScrollTargetChanged: {
        settleAnimation.stop();
        _heightOffset = 0;
        _lastScrollPosition = scrollTarget ? Math.max(scrollTarget.originY, scrollTarget.contentY) : 0;
        _observeScroll();
    }

    Component.onCompleted: {
        _scheduleReflow();
        if (scrollTarget)
            _lastScrollPosition = Math.max(scrollTarget.originY, scrollTarget.contentY);
        _observeScroll();
    }

    background: MD.ElevationRectangle {
        objectName: "appBarBackground"

        color: control.lifted ? control.scrolledContainerColor : control.containerColor
        elevation: control.lifted ? MD.Tokens.appBar.onScrollContainerElevation : MD.Tokens.appBar.containerElevation
        topLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.appBar.containerShape.topLeft,
                                                    width, height)
        topRightRadius: UiMetrics.resolveShapeRadius(MD.Tokens.appBar.containerShape.topRight,
                                                     width, height)
        bottomLeftRadius: UiMetrics.resolveShapeRadius(MD.Tokens.appBar.containerShape.bottomLeft,
                                                       width, height)
        bottomRightRadius: UiMetrics.resolveShapeRadius(MD.Tokens.appBar.containerShape.bottomRight,
                                                        width, height)

        Behavior on color {
            ColorAnimation {
                duration: MotionAnimation.expressiveFastEffectsDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: MotionAnimation.expressiveFastEffectsCurve
            }
        }
    }

    contentItem: Item {
        id: contentLayer
    }

    Loader {
        id: mediaLoader

        anchors.fill: parent
        z: -1
        sourceComponent: control.expandedBackground
        opacity: 1 - control.collapsedFraction
        visible: status === Loader.Ready && opacity > 0
    }

    Item {
        id: barContent
        objectName: "appBarContent"

        x: control.contentLeft
        y: SafeArea.margins.top
        width: control.barContentWidth
        height: control.currentContainerHeight

        Loader {
            id: centerLoader
            anchors.fill: parent
            sourceComponent: control.centerContent
        }

        AppBarActionDelegate {
            id: navigationButton
            objectName: "navigationActionButton"

            anchors.left: parent.left
            y: (control.collapsedHeight - height) / 2
            actionData: control.navigationAction || emptyAction
            contentColor: control.navigationContentColor
            visible: control.navigationAction !== null && control.navigationAction.visible
        }

        Row {
            id: trailingRow
            objectName: "trailingActions"

            anchors.right: parent.right
            y: (control.collapsedHeight - height) / 2
            spacing: MD.Tokens.appBar.searchTrailingActionsGap

            Repeater {
                id: actionRepeater

                model: control.actions

                delegate: AppBarActionDelegate {
                    id: trailingActionDelegate
                    required property var modelData
                    required property int index

                    actionData: modelData
                    contentColor: control.actionContentColor
                    visible: control._visibleActions.indexOf(actionData) >= 0
                    onImplicitWidthChanged: control._scheduleReflow()

                    Connections {
                        target: trailingActionDelegate.modelData
                        function onVisibleChanged() {
                            control._scheduleReflow();
                        }
                        function onPriorityChanged() {
                            control._scheduleReflow();
                        }
                        function onOverflowPolicyChanged() {
                            control._scheduleReflow();
                        }
                        function onPresentationChanged() {
                            control._scheduleReflow();
                        }
                        function onTextChanged() {
                            control._scheduleReflow();
                        }
                    }
                }
            }

            AppBarActionDelegate {
                id: overflowButton
                objectName: "overflowButton"

                actionData: overflowAction
                contentColor: control.actionContentColor
                visible: control._overflowActions.length > 0
                onClicked: control.openOverflow()
            }
        }
    }

    MD.AppBarAction {
        id: emptyAction
        visible: false
    }

    MD.AppBarAction {
        id: overflowAction
        text: qsTr("More options")
        icon.name: MD.Symbols.moreVert
    }

    MD.Menu {
        id: overflowMenu
        objectName: "overflowMenu"

        parent: control
        modal: true
    }

    Connections {
        target: control.scrollTarget
        ignoreUnknownSignals: true

        function onContentYChanged() {
            control._observeScroll();
        }
        function onOriginYChanged() {
            control._lastScrollPosition = Math.max(control.scrollTarget.originY, control.scrollTarget.contentY);
            control._observeScroll();
        }
        function onMovementEnded() {
            control._settle();
        }
    }

    DragHandler {
        id: dragHandler

        enabled: control.scrollBehavior !== BaseAppBar.Pinned
        target: null
        acceptedDevices: PointerDevice.TouchScreen | PointerDevice.TouchPad | PointerDevice.Mouse

        onActiveChanged: {
            if (active) {
                settleAnimation.stop();
                control._dragStartOffset = control._heightOffset;
            } else {
                control._settle();
            }
        }
        onTranslationChanged: {
            if (active)
                control._heightOffset = control._clampOffset(control._dragStartOffset - translation.y);
        }
    }

    NumberAnimation {
        id: settleAnimation

        target: control
        property: "_heightOffset"
        duration: MotionAnimation.expressiveFastSpatialDuration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: MotionAnimation.expressiveFastSpatialCurve
    }
}
