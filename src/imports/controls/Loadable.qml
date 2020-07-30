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

Item {
    property Component component
    property var showAnimation
    property var hideAnimation
    property alias asynchronous: loader.asynchronous
    property alias item: loader.item

    id: root
    visible: false

    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true
        onStatusChanged: {
            if (status != Loader.Ready)
                return;
            if (item.showAnimation == undefined && root.showAnimation != undefined)
                item.showAnimation = root.showAnimation;
            if (item.hideAnimation == undefined && root.hideAnimation != undefined)
                item.hideAnimation = root.hideAnimation;
            root.visible = true;
            if (item.show != undefined)
                item.show();
        }
    }

    Connections {
        target: loader.item
        onVisibleChanged: {
            // Unload component as soon as it's hidden and hide this item as well
            if (!loader.item.visible) {
                loader.sourceComponent = undefined;
                root.visible = false;
            }
        }
    }

    function show() {
        loader.sourceComponent = root.component;
    }

    function hide() {
        if (loader.item && loader.item.hide != undefined)
            loader.item.hide();
    }
}
