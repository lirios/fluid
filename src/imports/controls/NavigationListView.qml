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

import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype NavigationListView
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief The navigation drawer slides in from the left and is a common pattern in apps.

    This is a temporary navigation drawer: it can toggle open or closed.
    Closed by default, this type of navigation drawer opens temporarily above all
    other content until a section is selected or the overlay is tapped.

    NavigationDrawer is recommended on phones and tablets.

    This navigation drawer comes with a built-in ListView.

    \code
    import QtQuick.Window 2.2
    import Fluid.Controls 2.0 as FluidControls

    Window {
        id: window
        width: 400
        height: 400
        visible: true

        Button {
            text: "Open"
            onClicked: drawer.open()
        }

        FluidControls.NavigationListView {
            topContent: Image {
                source: "background.png"

                Layout.fillWidth: true
                Layout.preferredHeight: 200
            }

            actions: [
                FluidControls.Action {
                    text: "Action 1"
                },
                FluidControls.Action {
                    text: "Action 2"
                }
            ]
        }
    }
    \endcode

    For more information you can read the
    \l{https://material.io/guidelines/patterns/navigation-drawer.html}{Material Design guidelines}.
*/
FluidControls.NavigationDrawer {
    id: drawer

    /*!
        \qmlproperty int currentIndex

        The \c currentIndex property holds the index of the current item.
    */
    property alias currentIndex: navDrawerListView.currentIndex

    /*!
        \qmlproperty Item currentItem

        The \c currentItem property holds the current item.
    */
    property alias currentItem: navDrawerListView.currentItem

    /*!
        \qmlproperty bool autoHighlight

        This property holds whether auto-highlight is enabled.

        If this property is \c true, the current item will be automatically highlighted.

        The default value is \c false.
    */
    property bool autoHighlight: false

    /*!
        \qmlproperty list<Action> actions

        List of actions to be displayed by the drawer.
    */
    property list<FluidControls.Action> actions

    /*!
        \qmlproperty Component delegate

        The delegate for item that constitute a menu item.
    */
    property alias delegate : navDrawerListView.delegate

    ScrollView {
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
                enabled: modelData.enabled
                visible: modelData.visible

                onClicked: {
                    navDrawerListView.currentIndex = modelIndex;
                    modelData.triggered(drawer);
                }
            }

            visible: count > 0
        }

        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
