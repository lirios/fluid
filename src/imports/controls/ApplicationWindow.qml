/*
 * This file is part of Fluid.
 *
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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Controls.Private 1.0 as FluidControlsPrivate

/*!
   \qmltype ApplicationWindow
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief A window that provides features commonly used for Material Design apps.

   This is normally what you should use as your root component. It provides a \l ToolBar and
   \l PageStack to provide access to standard features used by Material Design applications.

   Here is a short working example of an application:

   \qml
   import QtQuick 2.10
   import Fluid.Controls 1.0 as FluidControls

   FluidControls.ApplicationWindow {
       title: "Application Name"
       width: 1024
       height: 800
       visible: true

       initialPage: page

       FluidControls.Page {
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

    /*!
       \qmlproperty color decorationColor

       The color of the status bar or window decorations, if the current
       platform supports it.
     */
    property alias decorationColor: windowDecoration.color

    /*!
        \qmlproperty Theme decorationTheme

        Theme of the status bar or window decoration, if the current
        platform supports it.
    */
    property alias decorationTheme: windowDecoration.theme

    /*!
        \qmlproperty AppToolBar appBar

        The tool bar for this application.
     */
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

    header: FluidControls.AppToolBar {
        id: appBar
    }

    FluidControls.PageStack {
        id: pageStack

        anchors.fill: parent

        onPushed: appBar.push(page)
        onPopped: appBar.pop(page)
        onReplaced: appBar.replace(page)
    }

    FluidControlsPrivate.WindowDecoration {
        id: windowDecoration
        window: window
        color: Material.shade(window.Material.primaryColor, Material.Shade700)
    }
}
