// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class SearchAppBar
    \brief A Material 3 Expressive app bar containing an adaptive search field.

    SearchAppBar can act as a launcher that asks the application to open a
    separate search experience, or as an editable query field. Outer
    \c navigationAction and \c actions remain in the app bar, while
    \c searchNavigationAction and \c searchActions are placed inside the
    rounded search capsule.

    The capsule fills narrow layouts. Above the adaptive breakpoint it uses the
    larger of the breakpoint width or half the available width.

    \code
    MD.SearchAppBar {
        mode: MD.SearchAppBar.Editable
        placeholderText: qsTr("Search messages")
        scrollTarget: messageList

        searchActions: [
            MD.AppBarAction {
                text: qsTr("Voice search")
                icon.name: "mic"
            }
        ]

        onAccepted: searchModel.query(text)
    }
    \endcode

    Set \c text on every AppBarAction to provide an accessible name. Safe-area
    insets, keyboard activation, adaptive overflow, and right-to-left layout are
    handled automatically.
*/
MD.BaseAppBar {
    id: control

    /*!
        Selects the search capsule interaction.

        - \c Launcher: Presents a focusable button and emits \c activated when used.
        - \c Editable: Presents an editable text field and emits \c accepted
            when the query is submitted.
    */
    enum Mode {
        Launcher,
        Editable
    }

    /*!
        Controls logical query-text alignment.

        - \c Start: Aligns text to the logical start edge.
        - \c Center: Centers text within the space protected from inner actions.
    */
    enum TextAlignment {
        Start,
        Center
    }

    //! The capsule interaction mode. The default is \c Launcher.
    property int mode: SearchAppBar.Launcher

    /*!
        The current query text.

        Applications may set this property in either mode. In editable mode it
        is updated as the user edits the field.
    */
    property string text

    //! Text shown when \c text is empty.
    property string placeholderText: qsTr("Search")

    //! The logical alignment of query and placeholder text.
    property int textAlignment: SearchAppBar.Start

    /*!
        Input-method hints forwarded to the editable text field.

        This property has no effect in launcher mode.
    */
    property int inputMethodHints: Qt.ImhNone

    /*!
        An optional validator forwarded to the editable text field.

        This property has no effect in launcher mode.
    */
    property var validator: null

    /*!
        The leading action inside the search capsule.

        By default this is a search action that emits \c activated. Set the
        property to \c null to omit the inner leading action.
    */
    property MD.AppBarAction searchNavigationAction: defaultSearchAction

    //! Actions displayed at the logical end of the search capsule.
    property list<MD.AppBarAction> searchActions

    //! Search capsule color before the bar is lifted.
    property color searchContainerColor: MD.Style.surfaceContainerColor

    //! Search capsule color while the bar is lifted by scrolling.
    property color scrolledSearchContainerColor: MD.Style.surfaceContainerHighestColor

    //! Query and placeholder foreground color.
    property color searchTextColor: MD.Style.onSurfaceColor

    //! Foreground color used by actions inside the search capsule.
    property color searchContentColor: MD.Style.onSurfaceVariantColor

    //! Emitted when the launcher capsule or its default search action is activated.
    signal activated

    //! Emitted when the user accepts a query in editable mode.
    signal accepted

    //! \internal
    readonly property bool _centeredText: textAlignment !== 0

    //! \internal
    property var _visibleSearchActions: []

    //! \internal
    property var _searchOverflowActions: []

    //! \internal
    property real _capsuleWidth: 0

    //! \internal
    property var _searchFieldItem: null

    //! \internal
    property var _searchActionRepeater: null

    collapsedHeight: MD.Tokens.appBar.smallContainerHeight
    expandedHeight: collapsedHeight
    scrollBehavior: MD.BaseAppBar.EnterAlways
    minimumCenterWidth: MD.Tokens.appBar.searchContainerHeight + MD.Tokens.appBar.searchOuterFieldMargin * 2
    supplementalOverflowActions: _searchOverflowActions

    //! \internal
    function _searchActionWidth(index) {
        const item = _searchActionRepeater ? _searchActionRepeater.itemAt(index) : null;
        return item ? item.implicitWidth : MD.Tokens.appBar.minimumInteractiveSize;
    }

    //! \internal
    function _reflowSearchActions() {
        const candidates = [];
        const forcedVisible = [];
        let usedWidth = 0;

        for (let index = 0; index < searchActions.length; ++index) {
            const action = searchActions[index];
            if (!action || !action.visible)
                continue;
            const entry = {
                action: action,
                index: index,
                width: _searchActionWidth(index)
            };
            if (action.overflowPolicy === MD.AppBarAction.NeverOverflow) {
                forcedVisible.push(entry);
                usedWidth += entry.width;
            } else if (action.overflowPolicy !== MD.AppBarAction.AlwaysOverflow) {
                candidates.push(entry);
            }
        }

        const leadingWidth = searchNavigationAction && searchNavigationAction.visible ? MD.Tokens.appBar.minimumInteractiveSize + MD.Tokens.appBar.searchContainedLeadingSpace : MD.Tokens.appBar.searchContainedNoActionsLeadingSpace;
        const fixedWidth = leadingWidth + MD.Tokens.appBar.searchContainedTrailingSpace + MD.Tokens.appBar.titleInset * 2;
        const budget = Math.max(0, _capsuleWidth - fixedWidth);

        candidates.sort((left, right) => {
            if (left.action.priority !== right.action.priority)
                return right.action.priority - left.action.priority;
            return left.index - right.index;
        });

        const selected = new Set();
        for (const entry of forcedVisible)
            selected.add(entry.action);
        for (const entry of candidates) {
            if (usedWidth + entry.width <= budget) {
                selected.add(entry.action);
                usedWidth += entry.width;
            }
        }

        const visible = [];
        const overflow = [];
        for (const action of searchActions) {
            if (!action || !action.visible)
                continue;
            if (action.overflowPolicy === MD.AppBarAction.AlwaysOverflow || (action.overflowPolicy === MD.AppBarAction.AutoOverflow && !selected.has(action))) {
                overflow.push(action);
            } else {
                visible.push(action);
            }
        }
        _visibleSearchActions = visible;
        _searchOverflowActions = overflow;
    }

    //! \internal
    function _scheduleSearchReflow() {
        _reflowSearchActions();
        Qt.callLater(() => control._reflowSearchActions());
    }

    /*!
        Gives keyboard focus to the editable query field.

        The function has no effect while \c mode is \c Launcher.
    */
    function forceSearchFocus() {
        if (mode === SearchAppBar.Editable && _searchFieldItem)
            _searchFieldItem.forceActiveFocus();
    }

    //! Clears the current query text.
    function clear() {
        text = "";
    }

    onSearchActionsChanged: _scheduleSearchReflow()
    onSearchNavigationActionChanged: _scheduleSearchReflow()
    on_CapsuleWidthChanged: _scheduleSearchReflow()
    onModeChanged: {
        if (mode === SearchAppBar.Editable && _searchFieldItem)
            Qt.callLater(() => control.forceSearchFocus());
    }

    Component.onCompleted: _scheduleSearchReflow()

    MD.AppBarAction {
        id: defaultSearchAction

        text: qsTr("Search")
        icon.name: MD.SymbolNames.symbolSearch
        overflowPolicy: MD.AppBarAction.NeverOverflow
        onTriggered: control.activated()
    }

    centerContent: Component {
        Item {
            id: searchArea

            readonly property real physicalLeadingWidth: control.layoutMirrored ? control.trailingWidth : control.leadingWidth
            readonly property real physicalTrailingWidth: control.layoutMirrored ? control.leadingWidth : control.trailingWidth
            readonly property real regionLeft: physicalLeadingWidth + MD.Tokens.appBar.searchOuterFieldMargin
            readonly property real regionRight: width - physicalTrailingWidth - MD.Tokens.appBar.searchOuterFieldMargin
            readonly property real availableWidth: Math.max(0, regionRight - regionLeft)
            readonly property real desiredWidth: availableWidth <= MD.Tokens.appBar.searchAdaptiveBreakpoint ? availableWidth : Math.max(MD.Tokens.appBar.searchAdaptiveBreakpoint, availableWidth * MD.Tokens.appBar.searchAdaptiveWidthFraction)
            readonly property real capsuleX: Math.max(regionLeft, Math.min((width - desiredWidth) / 2, regionRight - desiredWidth))

            Binding {
                target: control
                property: "_capsuleWidth"
                value: capsule.width
            }

            Rectangle {
                id: capsule
                objectName: "searchCapsule"

                x: searchArea.capsuleX
                y: (control.collapsedHeight - height) / 2
                width: Math.max(0, Math.min(searchArea.availableWidth, searchArea.desiredWidth))
                height: MD.Tokens.appBar.searchContainerHeight
                radius: MD.Tokens.cornerRadiusFull
                color: control.lifted ? control.scrolledSearchContainerColor : control.searchContainerColor
                clip: true

                Behavior on color {
                    ColorAnimation {
                        duration: MD.Tokens.spring.expressiveFastEffects.duration
                        easing: MD.Tokens.spring.expressiveFastEffects.easing
                    }
                }

                T.AbstractButton {
                    id: launcherButton
                    objectName: "searchLauncher"

                    anchors.fill: parent
                    text: control.text.length > 0 ? control.text : control.placeholderText
                    visible: control.mode === SearchAppBar.Launcher
                    hoverEnabled: true
                    focusPolicy: Qt.StrongFocus
                    background: Item {}

                    onClicked: control.activated()
                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            control.activated();
                            event.accepted = true;
                        }
                    }
                }

                MD.AppBarActionDelegate {
                    id: searchNavigationButton
                    objectName: "searchNavigationActionButton"

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    actionData: control.searchNavigationAction || defaultSearchAction
                    contentColor: control.searchContentColor
                    visible: control.searchNavigationAction !== null && control.searchNavigationAction.visible
                    z: 2
                }

                Row {
                    id: searchTrailingRow
                    objectName: "searchTrailingActions"

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: MD.Tokens.appBar.searchTrailingActionsGap
                    z: 2

                    Repeater {
                        id: searchActionRepeater
                        Component.onCompleted: {
                            control._searchActionRepeater = searchActionRepeater;
                            control._scheduleSearchReflow();
                        }
                        Component.onDestruction: {
                            if (control._searchActionRepeater === searchActionRepeater)
                                control._searchActionRepeater = null;
                        }

                        model: control.searchActions

                        delegate: MD.AppBarActionDelegate {
                            id: searchActionDelegate
                            required property var modelData

                            actionData: modelData
                            contentColor: control.searchContentColor
                            visible: control._visibleSearchActions.indexOf(actionData) >= 0
                            onImplicitWidthChanged: control._scheduleSearchReflow()

                            Connections {
                                target: searchActionDelegate.modelData
                                function onVisibleChanged() {
                                    control._scheduleSearchReflow();
                                }
                                function onPriorityChanged() {
                                    control._scheduleSearchReflow();
                                }
                                function onOverflowPolicyChanged() {
                                    control._scheduleSearchReflow();
                                }
                                function onPresentationChanged() {
                                    control._scheduleSearchReflow();
                                }
                                function onTextChanged() {
                                    control._scheduleSearchReflow();
                                }
                            }
                        }
                    }
                }

                readonly property real physicalStartWidth: control.layoutMirrored ? searchTrailingRow.width : searchNavigationButton.width
                readonly property real physicalEndWidth: control.layoutMirrored ? searchNavigationButton.width : searchTrailingRow.width
                readonly property real textLeft: physicalStartWidth + (searchNavigationButton.visible ? MD.Tokens.appBar.searchContainedLeadingSpace : MD.Tokens.appBar.searchContainedNoActionsLeadingSpace)
                readonly property real textRight: width - physicalEndWidth - (searchTrailingRow.width > 0 ? MD.Tokens.appBar.searchContainedTrailingSpace : MD.Tokens.appBar.searchContainedNoActionsTrailingSpace)

                MD.Label {
                    id: launcherLabel
                    objectName: "searchLauncherLabel"

                    x: capsule.textLeft
                    y: 0
                    width: Math.max(0, capsule.textRight - capsule.textLeft)
                    height: parent.height
                    text: control.text.length > 0 ? control.text : control.placeholderText
                    typescale: MD.Tokens.typescale.bodyLarge
                    color: control.searchTextColor
                    opacity: control.text.length > 0 ? 1 : MD.Tokens.appBar.disabledContentOpacity
                    horizontalAlignment: control._centeredText ? Text.AlignHCenter : control.layoutMirrored ? Text.AlignRight : Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    visible: control.mode === SearchAppBar.Launcher
                }

                T.TextField {
                    id: searchFieldProxy
                    Component.onCompleted: control._searchFieldItem = searchFieldProxy
                    Component.onDestruction: {
                        if (control._searchFieldItem === searchFieldProxy)
                            control._searchFieldItem = null;
                    }
                    objectName: "searchField"

                    x: capsule.textLeft
                    y: 0
                    width: Math.max(0, capsule.textRight - capsule.textLeft)
                    height: parent.height
                    text: control.text
                    placeholderText: control.placeholderText
                    inputMethodHints: control.inputMethodHints
                    validator: control.validator
                    color: control.searchTextColor
                    placeholderTextColor: control.searchContentColor
                    selectionColor: control.MD.Style.primaryColor
                    selectedTextColor: control.MD.Style.onPrimaryColor
                    font.family: control.MD.Style.plainFontFamily
                    font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
                    font.weight: MD.Tokens.typescale.bodyLarge.fontWeight
                    font.letterSpacing: MD.Tokens.typescale.bodyLarge.tracking
                    horizontalAlignment: control._centeredText ? Text.AlignHCenter : control.layoutMirrored ? Text.AlignRight : Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 0
                    rightPadding: 0
                    topPadding: 0
                    bottomPadding: 0
                    focusPolicy: Qt.StrongFocus
                    visible: control.mode === SearchAppBar.Editable
                    background: Item {}

                    onTextEdited: control.text = text
                    onAccepted: control.accepted()
                }

                TapHandler {
                    enabled: control.mode === SearchAppBar.Editable
                    gesturePolicy: TapHandler.ReleaseWithinBounds
                    onTapped: searchFieldProxy.forceActiveFocus()
                }
            }
        }
    }
}
