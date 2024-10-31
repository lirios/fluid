/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Fluid


/*!
   \brief A sidebar component for use in adaptive layouts.

   To use, simply add an instance to your code, and anchor other components to it.

   To show or hide, set the expanded property.

   By default, the sidebar has a flickable built in, and whatever contents are added
   will be placed in the flickable. When you want this disabled, or want to fill the
   entire sidebar, set the autoFill property to false.

   Examples:
   \code{.qml}
   Item {
       property bool wideAspect: width > Units.gu(80)

       Sidebar {
           expanded: wideAspect

           // Anchoring is automatic
       }
   }
   \endcode

    For more information you can read the
    <a href="https://material.io/guidelines/patterns/navigation-drawer.html">Material Design guidelines</a>.
*/
Pane {
    id: sidebar

    /*!
        \internal
    */
    default property alias contents: contents.data

    /*!
        This property holds the edge of the window at which the sidebar
        will be attached to. The acceptable values are:

        \value Qt.TopEdge     The top edge of the window.
        \value Qt.LeftEdge    The left edge of the window (default).
        \value Qt.RightEdge   The right edge of the window.
        \value Qt.BottomEdge  The bottom edge of the window.
    */
    property int edge: Qt.LeftEdge

    /*!
        This property holds whether to show or hide the sidebar.
    */
    property bool expanded: true

    /*!
        This property holds whether the sidebar is flickable or not.
    */
    property bool autoFlick: true

    /*!
        This property holds the text displayed as header.
    */
    property alias header: headerItem.text

    Behavior on anchors.leftMargin {
        NumberAnimation { duration: 200 }
    }

    Behavior on anchors.rightMargin {
        NumberAnimation { duration: 200 }
    }

    Material.background: Material.theme === Material.Light ? "white" : "#333"
    Material.elevation: 1

    anchors {
        left: edge === Qt.LeftEdge ? parent.left : undefined
        top: parent.top
        right: edge === Qt.RightEdge ? parent.right : undefined
        bottom: parent.bottom
        leftMargin: expanded ? 0 : -width
        rightMargin: expanded ? 0 : -width
    }

    width: 250

    padding: 0

    Rectangle {
        color: Material.dividerColor
        width: 1

        anchors {
            left: edge === Qt.RightEdge ? parent.left : undefined
            top: parent.top
            right: edge === Qt.LeftEdge ? parent.right : undefined
            bottom: parent.bottom
            //rightMargin: -1
        }
    }

    Item {
        clip: true

        anchors {
            fill: parent
            leftMargin: edge === Qt.RightEdge ? 1 : 0
            rightMargin: edge === Qt.LeftEdge ? 1 : 0
        }

        Subheader {
            id: headerItem

            Material.elevation: flickable.atYBeginning ? 0 : 1

            visible: text !== ""
            z: 2
        }

        Flickable {
            id: flickable

            clip: true

            ScrollBar.vertical: ScrollBar {}

            anchors {
                left: parent.left
                top: headerItem.visible ? headerItem.bottom : parent.top
                right: parent.right
                bottom: parent.bottom
            }

            contentWidth: width
            contentHeight: autoFlick ? contents.height : height
            interactive: contentHeight > height

            Item {
                id: contents

                width: flickable.width
                height: autoFlick ? childrenRect.height : flickable.height
            }

            function getFlickableChild(item) {
                if (item && item.hasOwnProperty("children")) {
                    for (var i = 0; i < item.children.length; i++) {
                        var child = item.children[i]
                        if (internal.isVerticalFlickable(child)) {
                            if (child.anchors.top === page.top || child.anchors.fill === page)
                                return item.children[i]
                        }
                    }
                }
                return null
            }
        }
    }
}
