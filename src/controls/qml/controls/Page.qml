/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2018 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick
import QtQuick.Controls as C
import QtQuick.Controls.Material
import Fluid as Fluid

/*!
   \brief Represents a page on the navigation page stack.

   Example:

   \code{.qml}
   import QtQuick
   import Fluid as Fluid

   Fluid.Page {
       title: "Application Name"

       actions: [
           Fluid.Action {
               name: "Print"

               // Icon name from the Google Material Design icon pack
               icon.source: Fluid.Utils.iconUrl("action/print")
           }
       ]
   }
   \endcode
*/
C.Page {
    id: page

    default property alias data: content.data

    /*!
        The action bar for this page. Use it as a group property to customize
        this page's action bar. See the \l Page example for details on how to use
        this property.
    */
    property alias appBar: appBar

    /*!
        The page's actions shown in the action bar.
    */
    property alias actions: appBar.actions

    /*!
        The action shown to the left of the title in the action bar. By default,
        this is a back button which shows when there is a page behind the current
        page in the page stack. However, you can replace it with your own action,
        for example, an icon to open a navigation drawer when on your root page.
    */
    property alias leftAction: appBar.leftAction

    /*!
        Set by the page stack to true if there is a page behind this page on the
        page stack.

        The default value is \c false.
    */
    property bool canGoBack: false

    /*!
        Custom content to show instead of the title.
    */
    property alias customContent: appBar.customContent

    /*!
        A sidebar to show on the right of the page. This will have its own
        app bar and title, which will split the toolbar into two app bars.
    */
    property Item rightSidebar: null

    /*!
        This signal is emitted when the back action is triggered or back key is released.

        The \a event is provided with the signal.

        By default, the page will be popped from the page stack. To change the default
        behavior, for example to show a confirmation dialog, listen for this signal using
        \c onGoBack and set \c event.accepted to \c true. To dismiss the page from your
        dialog without triggering this signal and re-showing the dialog, call
        \c page.forcePop().

        \sa Fluid::Page::forcePop()
    */
    signal goBack(var event)

    onRightSidebarChanged: {
        if (rightSidebar)
            rightSidebar.edge = Qt.RightEdge;
    }

    /*!
        Pop this page from the page stack. This does nothing if this page is not
        the current page on the page stack.

        The \a event will be passed to the \l goBack signal.

        Use \a force to avoid calling the \l goBack signal. This is useful if you
        use the \l goBack signal to show a confirmation dialog, and want to close
        the page from your dialog without showing the dialog again. You can also
        use \l Fluid::Page::forcePop() as a shortcut to this behavior.

        \sa Fluid::Page::forcePop()
    */
    function pop(event, force) {
        if (StackView.view.currentItem !== page)
            return false;

        if (!event)
            event = {accepted: false};

        if (!force)
            goBack(event);

        if (event.accepted) {
            return true;
        } else {
            return StackView.view.pop();
        }
    }

    /*!
        Force a pop from the page stack.
    */
    function forcePop() {
        pop(null, true);
    }

    /*!
        Push the specified \a component onto the page stack and set the \a properties.

        \sa StackView::push()
    */
    function push(component, properties) {
        return StackView.view.push(component, properties);
    }

    Keys.onReleased: function (event) {
        // Catches the Android back button event and pops the page, if it isn't the top page
        if (event.key === Qt.Key_Back && StackView.view && StackView.view.depth > 1) {
            pop(event, false);
            event.accepted = true;
        }

        // Toggle overflow menu when the menu button is released
        if (event.key === Qt.Key_Menu) {
            appBar.toggleOverflowMenu();
            event.accepted = true;
        }
    }

    header: null
    footer: null

    contentWidth: content.childrenRect.width
    contentHeight: content.childrenRect.height

    Fluid.AppBar {
        id: appBar

        Material.elevation: 0

        title: page.title

        leftAction: Fluid.Action {
            icon.source: Fluid.Utils.iconUrl("navigation/arrow_back")

            text: qsTr("Back")
            toolTip: qsTr("Go back")
            shortcut: StandardKey.Back
            visible: page.canGoBack

            onTriggered: page.pop()
        }
    }

    Item {
        id: content

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: rightSidebarContent.left
        anchors.bottom: parent.bottom
    }

    Item {
        id: rightSidebarContent

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        children: [rightSidebar]

        width: rightSidebar
               ? rightSidebar.width + rightSidebar.anchors.rightMargin
               : 0
    }
}
