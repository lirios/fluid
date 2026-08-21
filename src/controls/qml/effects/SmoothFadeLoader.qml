// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class SmoothFadeLoader
    \brief Displays an item and smoothly fades when its source changes.

    SmoothFadeLoader is a Fluid transition utility rather than a standalone
    Material 3 component. Its fade duration can be selected from the application's
    Material 3 motion tokens.

    This component loads an item with a Loader and smoothly fade to another item when
    the source URL is changed.

    Items are loaded synchronously, also the item being hidden is not unloaded to
    avoid an unpleasant "flash" after the transition.

    Example of usage:
    \code{.qml}
    import QtQuick 2.10
    import Fluid.Controls 1.0

    Item {
        width: 640
        height: 480

        SmoothFadeLoader {
            anchors.fill: parent
            source: "MyComponent.qml"
            fadeDuration: 400

            MouseArea {
                anchors.fill: parent
                onClicked: parent.source = "AnotherComponent.qml"
            }
        }
    }
    \endcode
*/
Item {
    id: root
    /*!
        The item being displayed.

        \sa Loader::source
    */
    property url source

    /*!
        Set this to change the fade animation time (in milliseconds).
        Default value is 250 ms.
    */
    property int fadeDuration: 250

    /*!
        This property holds whether the fade animation is running or not.
    */
    readonly property bool running: animation.running
    onSourceChanged: {
        animation.running = false;

        if (__priv.currentLoader == loader1) {
            __priv.currentLoader = loader2;
            __priv.nextLoader = loader1;
        } else {
            __priv.currentLoader = loader1;
            __priv.nextLoader = loader2;
        }

        __priv.currentLoader.source = sourceUrl;
        __priv.currentLoader.opacity = 0;
        __priv.currentLoader.z = 1;
        __priv.nextLoader.z = 0;

        if (__priv.firstTime) {
            __priv.currentLoader.opacity = 1.0;
            __priv.nextLoader.opacity = 0.0;
            __priv.firstTime = false;
        } else {
            animation.running = true;
        }
    }

    QtObject {
        id: __priv

        property bool firstTime: true
        property Loader currentLoader: loader1
        property Loader nextLoader: loader2
    }

    SequentialAnimation {
        id: animation
        running: false

        NumberAnimation {
            target: __priv.currentLoader
            properties: "opacity"
            from: 0.0
            to: 1.0
            duration: root.fadeDuration
            easing.type: Easing.OutQuad
        }

        ScriptAction {
            script: {
                __priv.nextLoader.opacity = 0;
                //__priv.nextLoader.source = "";
            }
        }
    }

    Loader {
        id: loader1
        anchors.fill: parent
        z: 1
    }

    Loader {
        id: loader2
        anchors.fill: parent
        z: 0
    }
}
