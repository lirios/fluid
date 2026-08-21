// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

pragma ComponentBehavior: Bound

import Fluid as MD

import QtQuick
import QtQuick.Templates as T
import QtQuick.Window

/*!
    \class Menu
    \brief A Material Design 3 Expressive menu.

    Menu presents a temporary list of actions. Actions declared as children are
    represented by accessible menu-item delegates with Material typography,
    selection, icon, shortcut, disabled, pointer, and keyboard-focus states.

    The surface grows to fit its content between the Material minimum and
    maximum widths. On compact windows it may become narrower than the preferred
    minimum, and tall menus are constrained to the available viewport and become
    scrollable. Logical layout and cascading-menu arrows mirror automatically in
    right-to-left locales.

    Keyboard navigation, focus restoration, menu roles, checked state, and
    accessible names are provided by Qt Quick Templates. Give every action a
    short, localized \c text value so it has a meaningful accessible name.

    \code{.qml}
    MD.Menu {
        id: editMenu

        Action {
            text: qsTr("Copy")
            icon.name: MD.SymbolNames.symbolContentCopy
            onTriggered: copySelection()
        }

        Action {
            text: qsTr("Show formatting")
            checkable: true
        }
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/components/menus/overview">Material Design 3 menu guidelines</a>.
*/
T.Menu {
    id: control

    //! \internal Width available inside the window's popup viewport.
    readonly property real _viewportWidth: parent && parent.Window.window && parent.Window.window.width > 0 ? parent.Window.window.width - margins * 2 : MD.Tokens.menu.maximumWidth

    //! \internal Height available inside the window's popup viewport.
    readonly property real _viewportHeight: parent && parent.Window.window && parent.Window.window.height > 0 ? parent.Window.window.height - margins * 2 : Number.POSITIVE_INFINITY

    //! \internal Effective direction from the popup, locale, or anchor item.
    readonly property bool _layoutMirrored: mirrored || locale.textDirection === Qt.RightToLeft || (parent && parent.LayoutMirroring.enabled)

    //! \internal Widest action delegate before the menu constrains its width.
    readonly property real _itemsImplicitWidth: {
        let itemWidth = 0;
        for (let index = 0; index < count; ++index) {
            const item = itemAt(index);
            if (item)
                itemWidth = Math.max(itemWidth, item.implicitWidth);
        }
        return itemWidth;
    }

    //! \internal Natural width before Material and viewport constraints.
    readonly property real _naturalWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset, _itemsImplicitWidth + leftPadding + rightPadding)

    //! \internal Natural height before the viewport constraint.
    readonly property real _naturalHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset, implicitContentHeight + topPadding + bottomPadding)

    implicitWidth: Math.max(0, Math.min(_viewportWidth, Math.max(MD.Tokens.menu.minimumWidth, Math.min(MD.Tokens.menu.maximumWidth, _naturalWidth))))
    implicitHeight: Math.max(0, Math.min(_viewportHeight, _naturalHeight))

    margins: MD.Tokens.menu.viewportMargin
    topPadding: MD.Tokens.menu.topPadding
    bottomPadding: MD.Tokens.menu.bottomPadding
    leftPadding: 0
    rightPadding: 0
    overlap: 0

    modal: false
    focus: true
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside
    transformOrigin: cascade ? (_layoutMirrored ? Item.TopRight : Item.TopLeft) : Item.Top

    delegate: MD.MenuItem {
        LayoutMirroring.enabled: control._layoutMirrored
        LayoutMirroring.childrenInherit: true
    }

    contentItem: ListView {
        id: menuList
        objectName: "menuListView"

        implicitWidth: control._itemsImplicitWidth
        implicitHeight: contentHeight
        model: control.contentModel
        currentIndex: control.currentIndex
        interactive: contentHeight + control.topPadding + control.bottomPadding > control.height
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        ScrollIndicator.vertical: MD.ScrollIndicator {}
    }

    background: MD.ElevationRectangle {
        objectName: "menuBackground"

        implicitWidth: MD.Tokens.menu.minimumWidth
        implicitHeight: MD.Tokens.menu.itemHeight
        color: control.MD.Style.surfaceContainerColor
        radius: Math.min(MD.Tokens.menu.containerRadius, Math.min(control.width, control.height) / 2)
        elevation: MD.Tokens.menu.containerElevation
    }

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.94
            to: 1
            duration: MD.Tokens.spring.expressiveFastSpatial.duration
            easing: MD.Tokens.spring.expressiveFastSpatial.easing
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: MD.Tokens.spring.expressiveFastEffects.duration
            easing: MD.Tokens.spring.expressiveFastEffects.easing
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1
            to: 0.94
            duration: MD.Tokens.spring.expressiveFastSpatial.duration
            easing: MD.Tokens.spring.expressiveFastSpatial.easing
        }
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: MD.Tokens.spring.expressiveFastEffects.duration
            easing: MD.Tokens.spring.expressiveFastEffects.easing
        }
    }
}
