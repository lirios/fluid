// SPDX-FileCopyrightText: 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick

/*!
    \class Vignette
    \brief Applies a vignette shader effect to an item.

    Vignette is a Fluid visual utility and is not specified as a standalone
    Material 3 component.
*/
Item {
    id: root
    Accessible.ignored: true

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
