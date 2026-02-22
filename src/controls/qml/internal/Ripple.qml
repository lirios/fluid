// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2024-2025 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Fluid as MD

Item {
    id: root

    property real stateOpacity: 0
    property bool pressed: false
    property real pressX: width / 2
    property real pressY: height / 2

    property real _circle_radius: 0

    property alias color: m_back.color
    property alias radius: m_back.radius

    clip: false

    Rectangle {
        id: m_back
        anchors.fill: parent
        color: "transparent"
        opacity: root.stateOpacity
    }

    MD.Shape {
        id: m_circle

        anchors.fill: parent
        opacity: 0.12

        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            fillColor: m_back.color
            fillGradient: RadialGradient {
                centerX: root.pressX
                centerY: root.pressY
                centerRadius: root._circle_radius
                focalX: centerX
                focalY: centerY

                GradientStop {
                    position: 0
                    color: MD.Utils.transparent(root.color, 1.0)
                }
                GradientStop {
                    position: 0.77
                    color: MD.Utils.transparent(root.color, 1.0)
                }
                GradientStop {
                    position: 0.771
                    color: MD.Utils.transparent(root.color, 0.0)
                }
                GradientStop {
                    position: 1
                    color: MD.Utils.transparent(root.color, 0.0)
                }
            }

            startX: m_back.topLeftRadius
            startY: 0

            PathLine {
                x: root.width - m_back.topRightRadius
                y: 0
            }
            PathArc {
                relativeX: m_back.topRightRadius
                relativeY: m_back.topRightRadius
                radiusX: m_back.topRightRadius
                radiusY: m_back.topRightRadius
            }
            PathLine {
                x: root.width
                y: root.height - m_back.bottomRightRadius
            }
            PathArc {
                relativeX: -m_back.bottomRightRadius
                relativeY: m_back.bottomRightRadius
                radiusX: m_back.bottomRightRadius
                radiusY: m_back.bottomRightRadius
            }
            PathLine {
                x: m_back.bottomLeftRadius
                y: root.height
            }
            PathArc {
                relativeX: -m_back.bottomLeftRadius
                relativeY: -m_back.bottomLeftRadius
                radiusX: m_back.bottomLeftRadius
                radiusY: m_back.bottomLeftRadius
            }
            PathLine {
                x: 0
                y: m_back.topLeftRadius
            }
            PathArc {
                x: m_back.topLeftRadius
                y: 0
                radiusX: m_back.topLeftRadius
                radiusY: m_back.topLeftRadius
            }
        }
    }

    state: "normal"

    readonly property real endRadius: Math.sqrt(root.height * root.height + root.width * root.width) * 1.3

    states: [
        State {
            name: "active"
            when: root.pressed
            PropertyChanges {
                restoreEntryValues: false
                root._circle_radius: endRadius
            }
        },
        State {
            name: "normal"
            when: true
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "active"

            SequentialAnimation {
                ScriptAction {
                    script: {
                        m_fade.stop();
                        m_back.opacity = root.stateOpacity;
                        root._circle_radius = root.endRadius / 1.3 / 4;
                        m_circle.opacity = 0.12;
                    }
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: m_back
                        property: 'opacity'
                        to: 0.12
                        duration: 500
                    }
                    NumberAnimation {
                        target: root
                        property: '_circle_radius'
                        duration: 500
                    }
                }
            }
        },
        Transition {
            from: "active"
            to: "normal"

            ParallelAnimation {
                alwaysRunToEnd: true
                NumberAnimation {
                    target: m_back
                    to: root.stateOpacity
                    property: "opacity"
                    duration: 200
                }
                SequentialAnimation {
                    NumberAnimation {
                        target: root
                        property: "_circle_radius"
                        to: root.endRadius
                        duration: 200
                    }

                    ScriptAction {
                        script: {
                            m_fade.start();
                        }
                    }
                }
            }
        }
    ]

    // for tracking root.stateOpacity, need to be top-level
    SequentialAnimation {
        id: m_fade
        running: false
        onStopped: {
            m_back.opacity = Qt.binding(function () {
                return root.stateOpacity;
            });
            m_circle.opacity = 0;
        }

        NumberAnimation {
            target: m_back
            to: root.stateOpacity
            duration: 100
            property: "opacity"
        }
        NumberAnimation {
            target: m_circle
            to: 0
            duration: 100
            property: "opacity"
        }
    }
}
