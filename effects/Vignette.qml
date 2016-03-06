/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2013-2014 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

Item {
    id: root

    /*!
        This property defines the source item that is going to be used as source
        for the generated effect.
    */
    property variant source

    /*!
        This property defines the vignette radius.
    */
    property alias radius: effect.radius

    /*!
        This property defines how much brightness will be used.
    */
    property alias brightness: effect.brightness

    ShaderEffect {
        id: effect
        anchors.fill: parent

        property variant source: ShaderEffectSource {
            sourceItem: root.source
            sourceRect: Qt.rect(0, 0, 0, 0)
            hideSource: false
            smooth: true
            visible: false
        }

        property real radius: 16
        property real brightness: 0.1

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float radius;
            uniform highp float brightness;
            uniform lowp sampler2D source;

            void main() {
                highp vec2 uv = qt_TexCoord0.xy;
                highp vec2 coord = qt_TexCoord0 - 0.5;
                lowp vec4 orig = texture2D(source, uv);

                highp float vignette = 1.0 - dot(coord, coord);

                lowp vec3 col = orig.rgb * clamp(pow(vignette, radius) + brightness, 0.0, 1.0);

                gl_FragColor = vec4(col, 1.0);
            }"
    }
}
