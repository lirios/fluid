/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0 as FluidControls

/*!
   \qmltype Page
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief Represents a page on the navigation page stack.

   Example:

   \qml
   import QtQuick 2.4
   import Fluid.Controls 1.0 as FluidControls

   FluidControls.Page {
       title: "Application Name"

       actions: [
           FluidControls.Action {
               name: "Print"

               // Icon name from the Google Material Design icon pack
               iconName: "action/print"
           }
       ]
   }
   \endqml
 */
Page {
    id: page

    /*
      \qmlproperty ActionBar actionBar

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
       \internal
       Set by the page stack to true if there is a page behind this page on the
       page stack.
     */
    property bool canGoBack: false

    /*!
       This signal is emitted when the back action is triggered or back key is released.

       By default, the page will be popped from the page stack. To change the default
       behavior, for example to show a confirmation dialog, listen for this signal using
       \c onGoBack and set \c event.accepted to \c true. To dismiss the page from your
       dialog without triggering this signal and re-showing the dialog, call
       \c page.forcePop().
     */
    signal goBack(var event)

    /*!
       Pop this page from the page stack. This does nothing if this page is not
       the current page on the page stack.

       Use \c force to avoid calling the \l goBack signal. This is useful if you
       use the \l goBack signal to show a confirmation dialog, and want to close
       the page from your dialog without showing the dialog again. You can also
       use \c forcePop() as a shortcut to this behavior.
     */
    function pop(event, force) {
        if (StackView.view.currentItem !== page)
            return false

        if (!event)
            event = {accepted: false}

        if (!force)
            goBack(event)

        if (event.accepted) {
            return true
        } else {
            return StackView.view.pop()
        }
    }

    function forcePop() {
        pop(null, true)
    }

    /*!
       Push the specified component onto the page stack.
     */
    function push(component, properties) {
        return StackView.view.push({item: component, properties: properties});
    }

    header: null
    footer: null

    FluidControls.AppBar {
        id: appBar

        Material.elevation: 0

        title: page.title

        leftAction: Action {
            text: qsTr("Back")
            tooltip: qsTr("Go back")
            iconName: "navigation/arrow_back"
            onTriggered: page.pop()
            visible: page.canGoBack
        }
    }
}
