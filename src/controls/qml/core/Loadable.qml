// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class Loadable
    \brief Loads an item and coordinates its show and hide animations.

    Loadable is a Fluid helper rather than a Material 3 component. Applications
    can use Material 3 motion tokens when supplying its animations.
*/
Item {
    id: root
    /*!
        Component to load.
    */
    property Component component

    /*!
        Animation to play when the component is shown.
    */
    property var showAnimation

    /*!
        Animation to play when the component is hidden.
    */
    property var hideAnimation

    /*!
        Whether the component is loaded asynchronously or not.
    */
    property alias asynchronous: loader.asynchronous

    /*!
        Item created after \l Loadable::component is loaded.
    */
    property alias item: loader.item
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

        function onVisibleChanged() {
            // Unload component as soon as it's hidden and hide this item as well
            if (!loader.item.visible) {
                loader.sourceComponent = undefined;
                root.visible = false;
            }
        }
    }

    /*!
        Show the component.
    */
    function show() {
        loader.sourceComponent = root.component;
    }

    /*!
        Hide the component.
    */
    function hide() {
        if (loader.item && loader.item.hide != undefined)
            loader.item.hide();
    }
}
