/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype TimeSelector
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Clock to select time

    The TimeSelector is used to select a time
    It's part of the TimePicker but can be used also standalone.

    \code
    import QtQuick 2.0
    import Fluid.Controls 1.0 as FluidControls

    Item {
        width: 600
        height: 600

        FluidControls.TimeSelector {
            anchors.fill: parent

            onSelectedDateChanged: {
                console.log(selectedDate)
            }
        }
    }

    \endcode
*/
Item {
    id: timeSelector

    property alias currentSelector: circle.mode
    property bool prefer24hView: true
    property string timeMode: "AM"
    property var selectedDate: new Date()

    function selectMode(mode) {
        switch(mode) {
        case "HOUR":
            innerPathView.visible = prefer24hView;
            setModeValues(0, prefer24hView ? 23 : 11, 12, mode, 1, 1)
            var model=[12];
            for(var i=1; i<12; i++)
                model.push(i);
            outerPathView.model = model;

            if(prefer24hView) {
                model=[0];
                for(var i=13; i<24; i++)
                    model.push(i);
                innerPathView.model = model;
            }
            circle.selectedValue = selectedDate.getHours();
            break;

        case "MINUTE":
            innerPathView.visible = false;
            setModeValues(0, 59, 60, mode, 1, 5)
            var model=[];
            for(var i=0; i<60; i++)
                model.push(i);
            outerPathView.model = model;
            circle.selectedValue = selectedDate.getMinutes();
            break;

        case "SECOND":
            innerPathView.visible = false;
            setModeValues(0, 59, 60, mode, 1, 5)
            var model=[];
            for(var i=0; i<60; i++)
                model.push(i);
            outerPathView.model = model;
            circle.selectedValue = selectedDate.getSeconds();
            break;
        }
    }

    function setModeValues(min, max, valuesAtRing, mode, steps, labelStep) {
        circle.minValue = min;
        circle.maxValue = max;
        circle.valuesAtRing = valuesAtRing;
        circle.mode = mode;
        circle.steps = steps;
        circle.labelSteps = labelStep;
    }

    onSelectedDateChanged: selectMode(circle.mode)
    Component.onCompleted: selectMode("HOUR")


    Rectangle {
        id: circle
        property int minValue: 0
        property int maxValue: 0
        property int steps: 1
        property int labelSteps: 1
        property int valuesAtRing: 12

        property string mode: "HOUR"

        function getValue(x, y) {
            var distance = Math.sqrt((x * x) + (y * y));
            if(distance === 0)
                return minValue;

            var rad = Math.acos(x / distance);
            if(y > 0)
                rad = (2 * Math.PI) - rad;

            var deg = (450 - ((rad * 180) / Math.PI)) % 360;

            var ring = distance < 100 ? 1 : 0
            var value = Math.round((deg * valuesAtRing) / 360 / steps) * steps;
            if(value === 0) {
                value = valuesAtRing;
            }
            value += valuesAtRing * ring;
            return minValue + (value % ((maxValue - minValue) + 1));
        }

        property int selectedValue: 0

        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height)
        height: width
        radius: width / 2
        color: Qt.darker(Material.background, 1.05)

        Rectangle {
            id: centerPoint
            anchors.centerIn: parent
            color: Material.accent
            width: 8
            height: 8
            radius: width / 2
        }

        Rectangle {
            id: pointer
            color: Material.accent
            width: 2
            height: circle.height / 2 - y
            rotation: (360 / circle.valuesAtRing) * circle.selectedValue
            x: circle.width / 2 - width / 2
            y: {
                var selValue = circle.selectedValue === 0 && !prefer24hView ? 12 : circle.selectedValue
                if(outerPathView.model.indexOf(selValue) > -1)
                    return outerPathView.pathPadding
                else
                    return innerPathView.pathPadding
            }

            antialiasing: true
            transformOrigin: Item.Bottom
        }

        PathView {
            id: outerPathView
            property real pathPadding: 21

            anchors.fill: parent
            anchors.margins: 0
            interactive: false
            delegate: pathDelegate
            path: Path {
                startX: circle.width / 2
                startY: outerPathView.pathPadding
                PathArc {
                    x: circle.width / 2
                    y: circle.height - outerPathView.pathPadding
                    radiusX: circle.width / 2 - outerPathView.pathPadding
                    radiusY: circle.width / 2 - outerPathView.pathPadding
                    useLargeArc: false
                }
                PathArc {
                    x: circle.width / 2
                    y: outerPathView.pathPadding
                    radiusX: circle.width / 2 - outerPathView.pathPadding
                    radiusY: circle.width / 2 - outerPathView.pathPadding
                    useLargeArc: false
                }
            }
        }


        PathView {
            id: innerPathView
            property real pathPadding: 65
            visible: false
            anchors.fill: parent
            anchors.margins: 0
            interactive: false
            delegate: pathDelegate
            path: Path {
                startX: circle.width / 2
                startY: innerPathView.pathPadding
                PathArc {
                    x: circle.width / 2
                    y: circle.height - innerPathView.pathPadding
                    radiusX: circle.width / 2 - innerPathView.pathPadding
                    radiusY: circle.width / 2 - innerPathView.pathPadding
                    useLargeArc: false
                }
                PathArc {
                    x: circle.width / 2
                    y: innerPathView.pathPadding
                    radiusX: circle.width / 2 - innerPathView.pathPadding
                    radiusY: circle.width / 2 - innerPathView.pathPadding
                    useLargeArc: false
                }
            }
        }

        Component {
            id: pathDelegate
            Rectangle {
                function isSelected(value) {
                    if(currentSelector === "HOUR") {
                        if(circle.selectedValue === 0 && !prefer24hView) {
                            return value === 12
                        }
                    }
                    return circle.selectedValue === value
                }

                width: (Math.max(label.implicitHeight, label.implicitWidth) * 2) / (index % circle.labelSteps === 0 ? 1 : 2)
                height: width
                radius: width / 2
                color: isSelected(modelData) ? Material.accent : "transparent"
                Label {
                    id: label
                    text: modelData
                    font.weight: Font.DemiBold
                    font.pixelSize: 13
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: isSelected(modelData) ? "white" : Material.foreground
                    visible: index % circle.labelSteps === 0
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.margins: 0
            hoverEnabled: true
            onPositionChanged: {
                circle.selectedValue = circle.getValue(mouse.x - circle.width/2, mouse.y - circle.width/2)
            }
            onClicked: {
                var newDate = new Date(selectedDate.getTime());
                switch(circle.mode) {
                case "HOUR":
                    newDate.setHours(circle.getValue(mouse.x - circle.width/2, mouse.y - circle.width/2) + (timeMode === "PM" ? 12 : 0));
                    selectMode("MINUTE");
                    break;
                case "MINUTE":
                    newDate.setMinutes(circle.getValue(mouse.x - circle.width/2, mouse.y - circle.width/2));
                    selectMode("SECOND");
                    break;
                case "SECOND":
                    newDate.setSeconds(circle.getValue(mouse.x - circle.width/2, mouse.y - circle.width/2));
                    selectMode("HOUR");
                    break;
                }
                selectedDate = newDate;
            }
        }
    }
}
