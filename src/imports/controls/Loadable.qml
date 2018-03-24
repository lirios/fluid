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

/*!
    \qmltype Loadable
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Loadable component.
*/
Item {
    /*!
        \qmlproperty Component component

        Component to load.
    */
    property Component component

    /*!
        \qmlproperty Animation showAnimation

        Animation to play when the component is shown.
    */
    property var showAnimation

    /*!
        \qmlproperty Animation hideAnimation

        Animation to play when the component is hidden.
    */
    property var hideAnimation

    /*!
        \qmlproperty bool asynchronous

        Whether the component is loaded asynchronously or not.
    */
    property alias asynchronous: loader.asynchronous

    /*!
        \qmlproperty Item item

        Item created after \l Loadable::component is loaded.
    */
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

    /*!
        \qmlmethod void Loadable::show()

        Show the component.
    */
    function show() {
        loader.sourceComponent = root.component;
    }

    /*!
        \qmlmethod void Loadable::hide()

        Hide the component.
    */
    function hide() {
        if (loader.item && loader.item.hide != undefined)
            loader.item.hide();
    }
}
