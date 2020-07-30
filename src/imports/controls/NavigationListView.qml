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
import QtQuick.Controls 2.3
import Fluid.Core 1.0 as FluidCore
import Fluid.Controls 1.0 as FluidControls

FluidControls.NavigationDrawer {
    id: drawer

    property alias currentIndex: navDrawerListView.currentIndex
    property alias currentItem: navDrawerListView.currentItem
    property bool autoHighlight: false
    property list<FluidControls.Action> actions
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
