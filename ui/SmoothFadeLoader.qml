/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2014-2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0

/*!
    \qmltype SmoothFadeLoader
    \inqmlmodule Fluid.UI 1.0
    \ingroup ui
    \brief Displays an item and smoothly fade when the source is changed.

    This component loads an item with a Loader and smoothly fade to another item when
    the source URL is changed.

    Items are loaded synchronously, also the item being hidden is not unloaded to
    avoid an unpleasant "flash" after the transition.

    Example of usage:
    \code
    import QtQuick 2.0
    import Fluid.UI 1.0

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

    id: root
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
