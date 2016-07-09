/*
 * Fluid - QtQuick components for fluid and dynamic applications
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtQuick.Controls 2.0
import Fluid.UI 1.0

/*!
   \qmltype FluidWindow
   \inqmlmodule Fluid.UI 1.0

   \brief A window that provides features commonly used for Material Design apps.

   This is normally what you should use as your root component. It provides a \l Toolbar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.4
   import Fluid.UI 1.0

   ApplicationWindow {
       title: "Application Name"

       initialPage: page

       Page {
           id: page
           title: "Page Title"

           Label {
               anchors.centerIn: parent
               text: "Hello World!"
           }
       }
   }
   \endqml
*/
ApplicationWindow {
    id: window

    property alias appBar: appBar

    /*!
       \qmlproperty Page initialPage

       The initial page shown when the application starts.
     */
    property alias initialPage: pageStack.initialItem

    /*!
       \qmlproperty PageStack pageStack

       The \l PageStack used for controlling pages and transitions between pages.
     */
    property alias pageStack: pageStack

    header: AppToolBar {
        id: appBar
    }

    PageStack {
        id: pageStack

        width: parent.width
        height: parent.height

        onPushed: appBar.push(page)
        onPopped: appBar.pop(page)
        onReplaced: appBar.replace(page)
    }
}
