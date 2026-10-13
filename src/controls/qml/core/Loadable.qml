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
    Accessible.ignored: true
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
        Item created after \ref Loadable::component is loaded.
    */
    property alias item: loader.item
    // Loaded components may expose optional show/hide methods and animations.
    // Keep this interface dynamic to support custom components as well as Showable.
    readonly property var _loadedItem: loader.item
    visible: false

    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true
        onStatusChanged: {
            if (status != Loader.Ready)
                return;
            if (root._loadedItem.showAnimation == undefined && root.showAnimation != undefined)
                root._loadedItem.showAnimation = root.showAnimation;
            if (root._loadedItem.hideAnimation == undefined && root.hideAnimation != undefined)
                root._loadedItem.hideAnimation = root.hideAnimation;
            root.visible = true;
            if (root._loadedItem.show != undefined)
                root._loadedItem.show();
        }
    }

    Connections {
        target: loader.item

        function onVisibleChanged() {
            // Unload component as soon as it's hidden and hide this item as well
            if (!(loader.item as Item).visible) {
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
        if (root._loadedItem && root._loadedItem.hide !== undefined)
            root._loadedItem.hide();
    }
}
