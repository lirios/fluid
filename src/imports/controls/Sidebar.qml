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

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0

/*!
   \qmltype Sidebar
   \inqmlmodule Fluid.Controls
   \ingroup fluidcontrols

   \brief A sidebar component for use in adaptive layouts

   To use, simply add an instance to your code, and anchor other components to it.

   To show or hide, set the expanded property.

   By default, the sidebar has a flickable built in, and whatever contents are added
   will be placed in the flickable. When you want this disabled, or want to fill the
   entire sidebar, set the autoFill property to false.

   Examples:
   \code
   Item {
       property bool wideAspect: width > Units.gu(80)

       Sidebar {
           expanded: wideAspect

           // Anchoring is automatic
       }
   }
   \endcode

    For more information you can read the
    \l{https://material.io/guidelines/patterns/navigation-drawer.html}{Material Design guidelines}.
 */
Pane {
    id: sidebar

    /*!
        \internal
    */
    default property alias contents: contents.data

    /*!
       The text displayed for the action.
     */
    property int edge: Qt.LeftEdge

    /*!
       Show or hide the sidebar.
     */
    property bool expanded: true

    /*!
       Flick automatically.
     */
    property bool autoFlick: true

    /*!
       The text displayed as header.
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
