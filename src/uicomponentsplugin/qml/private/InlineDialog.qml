/*
 *   Copyright 2012 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import FluidExtra 1.0 as FluidExtra

Item {
    id: root
    property Item visualParent
    z: 9000
    property int status: FluidCore.DialogStatus.Closed
    default property alias data: contentItem.data

    function open()
    {
        if (root.visualParent) {
            internal.parentPos = root.visualParent.mapToItem(dismissArea.parent, 0, 0)
        }
        root.status = FluidCore.DialogStatus.Opening
        appearAnimation.running = true
    }

    function close()
    {
        root.status = FluidCore.DialogStatus.Closing
        appearAnimation.running = true
    }

    SequentialAnimation {
        id: appearAnimation
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
            target: dismissArea
            properties: "opacity"
            to: root.status == FluidCore.DialogStatus.Opening ? 1 : 0
        }
        ScriptAction {
            script: root.status == FluidCore.DialogStatus.Opening ? root.status = FluidCore.DialogStatus.Open : FluidCore.DialogStatus.Closed
        }
    }

    MouseArea {
        id: dismissArea
        z: 9000
        anchors.fill: parent
        opacity: 0
        //to not pass hover events to the background
        hoverEnabled: true

        //FIXME: this is an hack: it's taking the dialog background making sure no opaque or transparent are selected
        //in Plasma2 we need to have the backingstore blur there as well
        FluidExtra.FallbackComponent {
            id: fallbackComponent
            basePath: "desktoptheme"
            candidates: [theme.themeName, ""]
            property string svgPath: fallbackComponent.filePath("/dialogs/background.svgz")
        }
        Connections {
            target: theme
            //fallback if inline-background doesn't work
            onThemeChanged: {
                fallbackComponent.svgPath = fallbackComponent.filePath("/dialogs/background.svgz")
                shadowFrame.visible = backgroundSvg.hasElement("shadow-top")
            }
        }
        FluidCore.FrameSvgItem {
            id: shadowFrame
            imagePath: fallbackComponent.svgPath
            prefix: "shadow"
            anchors {
                fill: internal
                leftMargin: -margins.left
                topMargin: -margins.top
                rightMargin: -margins.right
                bottomMargin: -margins.bottom
            }
            Component.onCompleted: shadowFrame.visible = backgroundSvg.hasElement("shadow-top")
        }
        FluidCore.FrameSvgItem {
            id: internal
            property variant parentPos
            imagePath: fallbackComponent.svgPath
            property bool under: root.visualParent ? internal.parentPos.y + root.visualParent.height + height < dismissArea.height : true
            //bindings won't work inside anchers definition
            onUnderChanged: {
                if (under) {
                    tipSvg.anchors.top = undefined
                    tipSvg.anchors.bottom = tipSvg.parent.top
                } else {
                    tipSvg.anchors.bottom = undefined
                    tipSvg.anchors.top = tipSvg.parent.bottom
                }
            }

            x: {
                if (root.visualParent) {
                    internal.parentPos.x - internal.width/2 + root.visualParent.width/2
                } else {
                    dismissArea.width/2 - internal.width/2
                }
            }
            y: {
                if (root.visualParent) {
                    if (under) {
                        internal.parentPos.y + root.visualParent.height
                    } else {
                        internal.parentPos.y - internal.height
                    }
                } else {
                    dismissArea.height/2 - internal.height/2
                }
            }
            width: contentItem.width + margins.left + margins.right
            height: contentItem.height + margins.top + margins.bottom

            FluidCore.SvgItem {
                id: tipSvg
                visible: root.visualParent != null
                svg: FluidCore.Svg {
                    id: backgroundSvg
                    imagePath: fallbackComponent.svgPath
                }
                elementId: internal.under ? "balloon-tip-top" : "balloon-tip-bottom"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.top
                    top: parent.bottom
                    topMargin: -backgroundSvg.elementSize("hint-bottom-shadow").height - 1
                    bottomMargin: -backgroundSvg.elementSize("hint-top-shadow").height - 1
                }
                width: naturalSize.width
                height: naturalSize.height
            }
            MouseArea {
                id: contentItem
                x: parent.margins.left
                y: parent.margins.top
                width: childrenRect.width
                height: childrenRect.height
                onClicked: mouse.accepted = true
            }
        }
        onClicked: {
            root.close()
        }
        Component.onCompleted: {
            var candidate = root
            while (candidate.parent) {
                candidate = candidate.parent
            }
            if (candidate) {
                dismissArea.parent = candidate
            } else {
                dismissArea.visible = false
            }
            internal.parentPos = root.mapToItem(dismissArea.parent, 0, 0)
        }
    }
}
