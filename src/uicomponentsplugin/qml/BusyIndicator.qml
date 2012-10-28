/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Artur Duque de Souza
 * Copyright (c) 2011 Daker Fernandes Pinheiro
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Daker Fernandes Pinheiro <dakerfp@gmail.com>
 *    Artur Duque de Souza <asouzakde.org>
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

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0
        FluidCore

Description:
        It is just a simple Busy Indicator, it is used to indicate a task which duration is unknown. If the task duration/number of steps is known, a ProgressBar should be used instead.
        TODO An image has to be added!

Properties:
        bool running:
        This property holds whether the busy animation is running.
        The default value is false.

        bool smoothAnimation:
        Set this property if you don't want to apply a filter to smooth
        the busy icon while animating.
        Smooth filtering gives better visual quality, but is slower.
        The default value is true.
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore

Item {
    id: busy

    // Common API
    property bool running: false

    // Plasma API
    property bool smoothAnimation: true

    implicitWidth: 52
    implicitHeight: 52

    // Should use animation's pause to keep the
    // rotation smooth when running changes but
    // it has lot's of side effects on
    // initialization.
    onRunningChanged: {
        rotationAnimation.from = rotation;
        rotationAnimation.to = rotation + 360;
    }

    RotationAnimation on rotation {
        id: rotationAnimation

        from: 0
        to: 360
        duration: 1500
        running: busy.running
        loops: Animation.Infinite
    }

    FluidCore.SvgItem {
        id: widget
        svg: FluidCore.Svg { imagePath: "widgets/busywidget" }
        elementId: "busywidget"

        anchors.centerIn: parent
        width: busy.width
        height: busy.height
        smooth: !running || smoothAnimation
    }
}
