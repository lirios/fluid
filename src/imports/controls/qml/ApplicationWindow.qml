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
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid as Fluid
import Fluid.Private as P

/*!
   \brief A window that provides features commonly used for Material Design apps.

   This is normally what you should use as your root component. It provides a \l ToolBar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \code{.qml}
   import QtQuick
   import Fluid as Fluid

   Fluid.ApplicationWindow {
       title: "Application Name"
       width: 1024
       height: 800
       visible: true

       initialPage: page

       Fluid.Page {
           id: page
           title: "Page Title"

           Label {
               anchors.centerIn: parent
               text: "Hello World!"
           }
       }
   }
   \endcode
*/
ApplicationWindow {
    id: window

    /*!
        The color of the status bar or window decorations, if the current
        platform supports it.
    */
    property alias decorationColor: windowDecoration.color
    
    /*!
        Theme of the status bar or window decoration, if the current
        platform supports it.
    */
    property alias decorationTheme: windowDecoration.theme

    /*!
        The tool bar for this application.
    */
    property alias appBar: appBar

    /*!
        The initial page shown when the application starts.
    */
    property alias initialPage: pageStack.initialItem

    /*!
        The \l PageStack used for controlling pages and transitions between pages.
    */
    property alias pageStack: pageStack

    header: Fluid.AppToolBar {
        id: appBar
    }

    Fluid.PageStack {
        id: pageStack

        anchors.fill: parent

        onPushed: (page) => appBar.push(page)
        onPopped: (page) => appBar.pop(page)
        onReplaced: (page) => appBar.replace(page)
    }

    P.WindowDecoration {
        id: windowDecoration
        window: window
        color: Material.shade(appBar ? appBar.Material.background : window.Material.primaryColor, Material.Shade700)
    }
}
