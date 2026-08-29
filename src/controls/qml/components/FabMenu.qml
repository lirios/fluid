// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T
import Fluid as MD

/*!
    \class FabMenu
    \brief A Material Design 3 Expressive FAB menu.

    FabMenu presents a floating action button that expands into a vertical list
    of pill-shaped labelled actions while the button itself morphs into a close
    button. Items declared as children are bound to the menu automatically: they
    inherit its color variant and enter and leave with a staggered spring that
    starts at the item nearest the toggle button.

    A FabMenu is meant to cover the page it belongs to, so that its scrim can
    dim the content behind the expanded list and dismiss the menu when tapped.
    Set \c text to a short, localized description of the toggle action; it is
    used as the accessible name of the button.

    The list grows away from the button: with \c Direction.Up the button sits at
    the bottom of the menu and the item nearest to it is the last child, while
    with \c Direction.Down the button sits at the top and the nearest item is the
    first child. The \c alignment property is logical and accepts
    \c Qt.AlignLeft or \c Qt.AlignRight; it flips in right-to-left locales.

    Activating an item or pressing Escape closes an expanded menu. Expanding the menu moves the active
    focus to it unless the toggle button already holds it, so a menu opened
    programmatically with \c open() can be dismissed with Escape as well, while a
    menu toggled by a click leaves the focus ring on its button.

    \code{.qml}
    MD.FabMenu {
        anchors.fill: parent

        text: qsTr("Create")

        MD.FabMenuItem {
            text: qsTr("New document")
            icon.name: MD.SymbolNames.symbolDescription
            onClicked: createDocument()
        }

        MD.FabMenuItem {
            text: qsTr("New folder")
            icon.name: MD.SymbolNames.symbolFolder
            onClicked: createFolder()
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/fab-menu/overview">Material Design 3 FAB menu guidelines</a>.
*/
T.Pane {
    id: control

    //! The supported Material 3 FAB menu color variants.
    enum Variant {
        Primary,
        Secondary,
        Tertiary
    }

    //! The direction the list of items grows towards.
    enum Direction {
        //! The list grows upwards from a button at the bottom of the menu.
        Up,
        //! The list grows downwards from a button at the top of the menu.
        Down
    }

    /*!
        Whether the list of items is shown.

        Expanding raises the scrim, morphs the toggle button into a close
        button, and plays the staggered entrance of the items starting at the
        one nearest the button; collapsing reverses it. Expanding also moves the
        active focus to the menu unless the toggle button already holds it, so
        that Escape closes a menu that was expanded programmatically.
    */
    property bool expanded: false

    //! The semantic color variant of the menu.
    property int variant: FabMenu.Variant.Primary

    //! The direction the list of items grows towards.
    property int direction: FabMenu.Direction.Up

    //! The logical horizontal alignment of the button and the items.
    property int alignment: Qt.AlignRight

    /*!
        Whether an expanded menu dims the content behind it.

        The specification places a scrim behind an expanded FAB menu; tapping it
        closes the menu. Its color and opacity come from the theme and the FAB
        menu tokens, so this property only decides whether it is drawn at all.
    */
    property bool scrim: true

    //! The distance between the menu and the edges of its area.
    property real margins: MD.Tokens.fabMenu.containerMargin

    //! The accessible name of the toggle button.
    property string text

    /*!
        The Material Symbol shown while the menu is collapsed.

        The specification morphs the toggle button into a close button while the
        menu is expanded, so this symbol cross-fades into \c expandedIconName.
    */
    property string collapsedIconName: MD.SymbolNames.symbolAdd

    /*!
        The Material Symbol shown while the menu is expanded.

        This is the close-button symbol of the morph described by
        \c collapsedIconName.
    */
    property string expandedIconName: MD.SymbolNames.symbolClose

    //! The toggle button of the menu.
    readonly property alias button: fabMenuButton

    //! The background color of the items.
    readonly property color itemContainerColor: {
        switch (variant) {
        case FabMenu.Variant.Primary:
            return control.MD.Style.primaryContainerColor;
        case FabMenu.Variant.Secondary:
            return control.MD.Style.secondaryContainerColor;
        case FabMenu.Variant.Tertiary:
            return control.MD.Style.tertiaryContainerColor;
        }
    }

    //! The foreground color of the items.
    readonly property color itemContentColor: {
        switch (variant) {
        case FabMenu.Variant.Primary:
            return control.MD.Style.onPrimaryContainerColor;
        case FabMenu.Variant.Secondary:
            return control.MD.Style.onSecondaryContainerColor;
        case FabMenu.Variant.Tertiary:
            return control.MD.Style.onTertiaryContainerColor;
        }
    }

    //! \internal Whether the menu is laid out against the right edge.
    readonly property bool _alignedRight: (alignment === Qt.AlignRight) !== mirrored

    //! \internal Sign of the collapsed offset of the items, towards the button.
    readonly property real _entranceDirection: direction === FabMenu.Direction.Up ? 1 : -1

    //! \internal Space reserved for the button on its side of the item list.
    readonly property real _buttonMargin: margins + MD.Tokens.fabMenu.closeButtonContainerHeight + MD.Tokens.fabMenu.closeButtonBetweenSpace

    //! Shows the list of items.
    function open() {
        control.expanded = true;
    }

    //! Hides the list of items.
    function close() {
        control.expanded = false;
    }

    //! Shows the list of items if it is hidden, and hides it otherwise.
    function toggle() {
        control.expanded = !control.expanded;
    }

    /*!
        \internal
        Binds every FAB menu item child to this menu.

        A Column positions its children vertically only, so the horizontal
        alignment of every item is driven explicitly. Children that are not FAB
        menu items are left untouched.
    */
    function _bindItems() {
        for (let index = 0; index < control.contentChildren.length; ++index) {
            const item = control.contentChildren[index];
            if (!item || item.menu === undefined || item.staggerIndex === undefined)
                continue;
            // Activating an item dismisses the menu, as the specification
            // requires. The connection is made only when the item is first
            // bound, so re-binding cannot connect it twice, and it lives here
            // rather than in an onClicked handler inside FabMenuItem, which a
            // caller's own onClicked would override.
            if (item.menu !== control) {
                item.menu = control;
                item.clicked.connect(control.close);
            }
            item.staggerIndex = index;
            item.x = Qt.binding(() => {
                return control._alignedRight ? Math.max(0, column.width - item.width) : 0;
            });
        }
    }

    implicitWidth: Math.max(fabMenuButton.implicitWidth + margins * 2, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(fabMenuButton.implicitHeight + margins * 2, implicitContentHeight + topPadding + bottomPadding)

    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0
    leftPadding: margins
    rightPadding: margins
    topPadding: direction === FabMenu.Direction.Up ? margins : _buttonMargin
    bottomPadding: direction === FabMenu.Direction.Up ? _buttonMargin : margins

    onContentChildrenChanged: control._bindItems()

    // Escape is only delivered to a menu that holds the active focus itself or
    // through a descendant. Clicking the toggle button already satisfies that,
    // so focus is only taken when it does not, which keeps the focus ring on a
    // clicked button while making a programmatically opened menu dismissible.
    onExpandedChanged: {
        if (control.expanded && !fabMenuButton.activeFocus)
            control.forceActiveFocus();
    }

    Component.onCompleted: control._bindItems()

    Keys.onEscapePressed: event => {
        if (control.expanded)
            control.close();
        else
            event.accepted = false;
    }

    contentItem: Column {
        id: column

        z: 1
        spacing: MD.Tokens.fabMenu.listItemBetweenSpace

        // The pane stretches its content item over the available area, so the
        // items are pushed down to sit next to a button placed at the bottom.
        transform: Translate {
            y: control.direction === FabMenu.Direction.Up ? Math.max(0, column.height - column.implicitHeight) : 0
        }
    }

    /*
        The scrim and the toggle button are declared as direct children of the
        control rather than inside a background delegate: Qt Quick Controls does
        not deliver mouse presses to items nested in a background, so a button
        placed there would never register a press. Stacking is set explicitly so
        the scrim stays behind the items and the button stays in front of them.
        Every child keeps a non-negative z: a negative z would place it behind
        the control itself, which then consumes the presses meant for it.
    */
    data: [
        Rectangle {
            objectName: "fabMenuScrim"

            anchors.fill: parent
            color: control.MD.Style.scrimColor
            opacity: control.expanded && control.scrim ? MD.Tokens.fabMenu.scrimOpacity : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: MD.Tokens.durationShort4
                }
            }

            TapHandler {
                onTapped: control.close()
            }
        },

        MD.FabMenuButton {
            id: fabMenuButton
            objectName: "fabMenuButton"

            // Positioned explicitly rather than by swapping anchors: resetting an
            // anchor to undefined does not restore the implicit size it overrode,
            // which would stretch the button when the direction or alignment flips.
            x: control._alignedRight ? control.width - width - control.margins : control.margins
            y: control.direction === FabMenu.Direction.Up ? control.height - height - control.margins : control.margins
            z: 2

            expanded: control.expanded
            containerColor: control.itemContainerColor
            contentColor: control.itemContentColor
            text: control.text
            collapsedIconName: control.collapsedIconName
            expandedIconName: control.expandedIconName

            onClicked: control.toggle()
        }
    ]
}
