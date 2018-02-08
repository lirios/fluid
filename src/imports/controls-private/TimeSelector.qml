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
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0 as FluidControls
import Fluid.Templates 1.0 as FluidTemplates

FluidTemplates.TimeSelector {
    id: timeSelector

    property int currentSelector: mode

    onModeChanged: {
        switch (mode) {
        case FluidTemplates.TimeSelector.Hour:
            circle.selectedValue = selectedTime.getHours();
            break;
        case FluidTemplates.TimeSelector.Minute:
            circle.selectedValue = selectedTime.getMinutes();
            break;
        case FluidTemplates.TimeSelector.Second:
            circle.selectedValue = selectedTime.getSeconds();
            break;
        }
    }

    circle: Rectangle {
        id: circle

        property int minValue: 0
        property int maxValue: {
            if (timeSelector.mode === FluidTemplates.TimeSelector.Hour)
                return prefer24Hour ? 23 : 11;
            return 59;
        }
        property int steps: 1
        property int labelSteps: timeSelector.mode === FluidTemplates.TimeSelector.Hour ? 1 : 5
        property int valuesAtRing: timeSelector.mode === FluidTemplates.TimeSelector.Hour ? 12 : 60
        property int selectedValue: 0

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

        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height)
        height: width
        radius: width / 2
        color: timeSelector.Material.theme === Material.Dark ? timeSelector.Material.dialogColor : Qt.darker(timeSelector.Material.background, 1.05)

        Rectangle {
            id: centerPoint
            anchors.centerIn: parent
            color: timeSelector.Material.accent
            width: 8
            height: 8
            radius: width / 2
        }

        Rectangle {
            id: pointer
            color: timeSelector.Material.accent
            width: 2
            height: circle.height / 2 - y
            rotation: (360 / circle.valuesAtRing) * circle.selectedValue
            x: circle.width / 2 - width / 2
            y: {
                var selValue = circle.selectedValue === 0 && !prefer24Hour ? 12 : circle.selectedValue
                if (outerPathView.model.indexOf(selValue) > -1)
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
            property var twelveModel: [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            property var sixtyModel: []

            anchors.fill: parent
            anchors.margins: 0
            interactive: false
            model: timeSelector.mode === FluidTemplates.TimeSelector.Hour ? twelveModel : sixtyModel
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

            Component.onCompleted: {
                for (var i = 0; i < 60; i++)
                    sixtyModel.push(i);
            }
        }


        PathView {
            id: innerPathView

            property real pathPadding: 65

            visible: timeSelector.mode === FluidTemplates.TimeSelector.Hour ? prefer24Hour : false
            anchors.fill: parent
            anchors.margins: 0
            interactive: false
            model: timeSelector.mode === FluidTemplates.TimeSelector.Hour && prefer24Hour ? [0, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23] : []
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
                    if(currentSelector === FluidTemplates.TimeSelector.HourMode) {
                        if(circle.selectedValue === 0 && !prefer24Hour) {
                            return value === 12
                        }
                    }
                    return circle.selectedValue === value
                }

                width: (Math.max(label.implicitHeight, label.implicitWidth) * 2) / (index % circle.labelSteps === 0 ? 1 : 2)
                height: width
                radius: width / 2
                color: isSelected(modelData) ? timeSelector.Material.accent : "transparent"

                Label {
                    id: label
                    text: modelData
                    font.weight: Font.DemiBold
                    font.pixelSize: 13
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: isSelected(modelData) ? "white" : timeSelector.Material.foreground
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
                circle.selectedValue = circle.getValue(mouse.x - circle.width / 2, mouse.y - circle.width / 2);
            }
            onClicked: {
                var newTime = new Date(selectedTime.getTime());
                switch (timeSelector.mode) {
                case FluidTemplates.TimeSelector.Hour:
                    newTime.setHours(circle.getValue(mouse.x - circle.width / 2, mouse.y - circle.width / 2) + (timeMode === FluidTemplates.TimeSelector.PM ? 12 : 0));
                    timeSelector.mode = FluidTemplates.TimeSelector.Minute;
                    break;
                case FluidTemplates.TimeSelector.Minute:
                    newTime.setMinutes(circle.getValue(mouse.x - circle.width / 2, mouse.y - circle.width / 2));
                    timeSelector.mode = FluidTemplates.TimeSelector.Second;
                    break;
                case FluidTemplates.TimeSelector.Second:
                    newTime.setSeconds(circle.getValue(mouse.x - circle.width / 2, mouse.y - circle.width / 2));
                    timeSelector.mode = FluidTemplates.TimeSelector.Hour;
                    break;
                }
                selectedTime = newTime;
            }
        }
    }
}
