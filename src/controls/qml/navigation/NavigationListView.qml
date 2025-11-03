/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Fluid as Fluid

/*!
    \brief The navigation drawer slides in from the left and is a common pattern in apps.

    This is a temporary navigation drawer: it can toggle open or closed.
    Closed by default, this type of navigation drawer opens temporarily above all
    other content until a section is selected or the overlay is tapped.

    NavigationDrawer is recommended on phones and tablets.

    This navigation drawer comes with a built-in ListView.

    \code{.qml}
    import QtQuick
    import QtQuick.Controls
    import QtQuick.Window
    import Fluid as Fluid

    Window {
        id: window
        width: 400
        height: 400
        visible: true

        Fluid.Button {
            text: "Open"
            onClicked: drawer.open()
        }

        Fluid.NavigationListView {
            topContent: Image {
                width: parent.width
                height: 200
                source: "background.png"
            }

            actions: [
                Fluid.Action {
                    text: "Action 1"
                },
                Fluid.Action {
                    text: "Action 2"
                }
            ]
        }
    }
    \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/patterns/navigation-drawer.html">Material Design guidelines</a>.
*/
Fluid.NavigationDrawer {
    id: drawer

    /*!
        The \c currentIndex property holds the index of the current item.
    */
    property alias currentIndex: navDrawerListView.currentIndex

    /*!
        The \c currentItem property holds the current item.
    */
    property alias currentItem: navDrawerListView.currentItem

    /*!
        This property holds whether auto-highlight is enabled.

        If this property is \c true, the current item will be automatically highlighted.

        The default value is \c false.
    */
    property bool autoHighlight: false

    /*!
        List of actions to be displayed by the drawer.
    */
    property list<Fluid.Action> actions

    /*!
        The delegate for item that constitute a menu item.
    */
    property alias delegate : navDrawerListView.delegate

    ScrollView {
        anchors.fill: parent
        clip: true

        ListView {
            id: navDrawerListView
            currentIndex: -1
            spacing: 0

            model: drawer.actions

            delegate: ListItem {
                property int modelIndex: index

                icon.name: modelData.icon.name
                icon.source: modelData.icon.source

                highlighted: drawer.autoHighlight ? ListView.isCurrentItem : false
                text: modelData.text
                showDivider: modelData.hasDividerAfter
                dividerInset: 0
                width: navDrawerListView.width
                enabled: modelData.enabled
                visible: modelData.visible

                onClicked: {
                    navDrawerListView.currentIndex = modelIndex;
                    modelData.triggered(drawer);
                }
            }

            visible: count > 0
        }
    }
}
