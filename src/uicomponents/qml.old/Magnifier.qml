/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import "Utils.js" as Utils

Item {
    id: root

    property alias sourceItem: effectSource.sourceItem
    property real xCenter: 0 // in source item coordinates
    property real yCenter: 0 // in source item coordinates
    
    // Source rect is not as small as it can be as there is drawing problems
    // with small source rect/texture size.
    property real __realScaleFactor: 1.25
    property real __sourceRectMultiplier: 2

    property variant __rootElement

    property bool active: false

    visible: active
    width: 182
    height: 211
    z: Number.MAX_VALUE

    Component.onCompleted: {
        var isWindowContent = parent.objectName == "windowContent"
        if (isWindowContent) {
            sourceItem = parent;
        }
        declarativeView.setFullViewportMode(root);
    }

    ShaderEffectSource {
        id: effectSource
        sourceRect: Qt.rect(root.xCenter - textureSize.width / 2,
                            root.yCenter - textureSize.height / 2,
                            textureSize.width,
                            textureSize.height);
        textureSize: Qt.size(root.__sourceRectMultiplier * root.width,
                             root.__sourceRectMultiplier * root.height);

        hideSource: false
        smooth: true

        property real scaleFactor: root.__sourceRectMultiplier * root.__realScaleFactor
    }

    Image {
        id: magnifierFrameImage
        source: "/usr/share/themes/blanco/meegotouch/images/theme/basement/meegotouch-virtual-keyboard/meegotouch-seattle-magnifier-frame.png"
    }

    ShaderEffectSource {
        id: magnifierFrame
        sourceItem: magnifierFrameImage
        hideSource: true
        live: false
    }

    Image {
        id: magnifierMaskImage
        source: "/usr/share/themes/blanco/meegotouch/images/theme/basement/meegotouch-virtual-keyboard/meegotouch-seattle-magnifier-frame-mask.png"
    }

    ShaderEffectSource {
        id: magnifierMask
        sourceItem: magnifierMaskImage
        hideSource: true
        live: false
    }

    ShaderEffectItem {
        id: magnifier
        anchors.fill:parent
        visible: root.visible

        vertexShader: "
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            uniform highp mat4 qt_ModelViewProjectionMatrix;
            uniform highp float scaleFactor;
            varying highp vec2 qt_TexCoord0;
            varying highp vec2 qt_TexCoord1;
            void main() {
                qt_TexCoord0.x = 0.5 - 1. / (2. * scaleFactor) + qt_MultiTexCoord0.x / scaleFactor;
                qt_TexCoord0.y = 0.5 - 1. / (2. * scaleFactor) + qt_MultiTexCoord0.y / scaleFactor;
                qt_TexCoord1 = qt_MultiTexCoord0;
                gl_Position = qt_ModelViewProjectionMatrix * qt_Vertex;
            }";

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            varying highp vec2 qt_TexCoord1;
            uniform lowp sampler2D source;
            uniform lowp sampler2D frame;
            uniform lowp sampler2D mask;
            void main() {
                lowp vec4 frame_c = texture2D(frame, qt_TexCoord1);
                lowp vec4 mask_c = texture2D(mask, qt_TexCoord1);
                lowp vec4 color_c = texture2D(source, qt_TexCoord0);
                bool outsideElement=(qt_TexCoord0.s<0. || qt_TexCoord0.s>1. || qt_TexCoord0.t<0. || qt_TexCoord0.t>1.);
                bool onGlass=(mask_c.a==1.);

                if (outsideElement) {
                    // make white outside the element
                    color_c=vec4(1.,1.,1.,1.);
                } else if (onGlass) {
                    // blend premultiplied texture with pure white (background)
                    color_c = color_c + vec4(1.,1.,1.,1.) * (1.-color_c.a);
                }

                if ( qt_TexCoord1.y >= 0.98 ) {
                    // Top part of item above visible magnifier frame is made
                    // transparent explicitly to prevent showing of wrongly
                    // colored pixels, which would otherwise appear sometimes
                    // when using sourceRect functionality.
                    gl_FragColor = vec4(0.,0.,0.,0.);
                } else {
                    gl_FragColor = onGlass ? color_c : frame_c;
                }
       }";

        property variant source: effectSource
        property variant frame: magnifierFrame
        property variant mask: magnifierMask
        property real scaleFactor: effectSource.scaleFactor;
    }
}
