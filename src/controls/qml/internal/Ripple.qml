// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2026 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

pragma ComponentBehavior: Bound

import QtQuick
import Fluid as MD

// Material You "realistic" ripple, ported from Skia's RippleShader.rts
// (third_party/skia/resources/sksl/realistic/RippleShader.rts) and the
// driver in third_party/skia/gm/rippleshadergm.cpp.
Item {
    id: root

    // ---- Public Ripple API ----
    property real stateOpacity: 0
    property bool pressed: false
    property real pressX: width / 2
    property real pressY: height / 2

    property alias color: m_back.color
    property alias topLeftRadius: m_back.topLeftRadius
    property alias topRightRadius: m_back.topRightRadius
    property alias bottomLeftRadius: m_back.bottomLeftRadius
    property alias bottomRightRadius: m_back.bottomRightRadius
    property alias radius: m_back.radius

    // ---- Debug interface ----
    // Set debugEnabled = true to drive the shader from fixed values
    // instead of the press/release animation. Useful for visual tests
    // and for poking at the effect interactively.
    property bool debugEnabled: false
    property real debugProgress: 0.5      // 0..1 ripple expansion
    property real debugPhase: 5.0         // noise / turbulence phase
    property real debugTouchX: -1         // <0 → fall back to root.pressX
    property real debugTouchY: -1
    property real debugOpacity: 0.12      // shader visibility while debug
    property real debugBackOpacity: 0.12  // state-layer tint while debug
    // (set < 0 to leave m_back at stateOpacity)

    implicitWidth: 100
    implicitHeight: 100
    clip: false

    // ---- Constants ported from rippleshadergm.cpp ----
    readonly property int _animDuration: 1500
    readonly property int _noiseAnimDuration: 7000
    // MAX_NOISE_PHASE = NOISE_ANIMATION_DURATION / 214
    readonly property real _maxNoisePhase: _noiseAnimDuration / 214.0
    readonly property real _scale: 1.5
    readonly property real _piRotateRight: Math.PI * 0.0078125
    readonly property real _piRotateLeft: Math.PI * -0.0078125

    // ---- Internal animated state ----
    property real _progress: 0
    property real _phase: 0
    property real _runtimeOpacity: 0

    readonly property real _shaderOpacity: debugEnabled ? debugOpacity : _runtimeOpacity
    readonly property real _activeProgress: debugEnabled ? debugProgress : _progress
    readonly property real _activePhase: debugEnabled ? debugPhase : _phase
    readonly property real _activeTouchX: (debugEnabled && debugTouchX >= 0) ? debugTouchX : pressX
    readonly property real _activeTouchY: (debugEnabled && debugTouchY >= 0) ? debugTouchY : pressY
    readonly property real _maxCorner: Math.min(root.width, root.height) * 0.5
    readonly property vector4d _shaderCorners: Qt.vector4d(root._clampCorner(root._effectiveCorner(root.bottomRightRadius)), root._clampCorner(root._effectiveCorner(root.topRightRadius)), root._clampCorner(root._effectiveCorner(root.bottomLeftRadius)), root._clampCorner(root._effectiveCorner(root.topLeftRadius)))

    function _clampCorner(value) {
        return Math.min(Math.max(value, 0), root._maxCorner);
    }

    function _effectiveCorner(value) {
        return value < 0 ? root.radius : value;
    }

    // Distance from the touch point to the furthest corner — this is the
    // radius the wave needs to reach so it just covers the whole shape at
    // progress=1, regardless of where the user clicked.
    readonly property real _maxRadius: {
        const tx = _activeTouchX, ty = _activeTouchY;
        const w = Math.max(width, 1), h = Math.max(height, 1);
        return Math.max(Math.hypot(tx, ty), Math.hypot(w - tx, ty), Math.hypot(tx, h - ty), Math.hypot(w - tx, h - ty));
    }

    // The "state layer": uniform tint covering the whole shape. This is what
    // gives a pressed Material control its shape-conforming look — the
    // sparkle wave on top is just the dynamic accent. Without it, the eye
    // sees only the circular wave (which is genuinely circular by design).
    Rectangle {
        id: m_back
        anchors.fill: parent
        color: "transparent"
        opacity: (root.debugEnabled && root.debugBackOpacity >= 0) ? root.debugBackOpacity : root.stateOpacity
    }

    ShaderEffect {
        id: shader
        anchors.fill: parent
        opacity: root._shaderOpacity
        visible: opacity > 0

        readonly property real _ph: root._activePhase

        property vector2d in_origin: Qt.vector2d(root.width / 2, root.height / 2)
        property vector2d in_touch: Qt.vector2d(root._activeTouchX, root._activeTouchY)
        property real in_progress: root._activeProgress
        property real in_maxRadius: root._maxRadius
        // resolutionScale: pixel-to-uv (uv ∈ [0,1])
        property vector2d in_resolutionScale: Qt.vector2d(1.0 / Math.max(root.width, 1), 1.0 / Math.max(root.height, 1))
        // noiseScale: ~2.1px sparkle grid in uv space (matches rippleshadergm.cpp)
        property vector2d in_noiseScale: Qt.vector2d(2.1 / Math.max(root.width, 1), 2.1 / Math.max(root.height, 1))
        property real in_hasMask: 1.0
        property real in_noisePhase: _ph
        property real in_turbulencePhase: _ph * 1000.0

        property vector2d in_tCircle1: Qt.vector2d(root._scale * 0.5 + (_ph * 0.01 * Math.cos(root._scale * 0.55)), root._scale * 0.5 + (_ph * 0.01 * Math.sin(root._scale * 0.55)))
        property vector2d in_tCircle2: Qt.vector2d(root._scale * 0.2 + (_ph * -0.0066 * Math.cos(root._scale * 0.45)), root._scale * 0.2 + (_ph * -0.0066 * Math.sin(root._scale * 0.45)))
        property vector2d in_tCircle3: Qt.vector2d(root._scale + (_ph * -0.0066 * Math.cos(root._scale * 0.35)), root._scale + (_ph * -0.0066 * Math.sin(root._scale * 0.35)))
        property vector2d in_tRotation1: Qt.vector2d(Math.cos(_ph * root._piRotateRight + 1.7 * Math.PI), Math.sin(_ph * root._piRotateRight + 1.7 * Math.PI))
        property vector2d in_tRotation2: Qt.vector2d(Math.cos(_ph * root._piRotateLeft + 2.0 * Math.PI), Math.sin(_ph * root._piRotateLeft + 2.0 * Math.PI))
        property vector2d in_tRotation3: Qt.vector2d(Math.cos(_ph * root._piRotateRight + 2.75 * Math.PI), Math.sin(_ph * root._piRotateRight + 2.75 * Math.PI))

        property color in_color: root.color
        property color in_sparkleColor: Qt.rgba(1, 1, 1, 0.5)
        property vector2d in_size: Qt.vector2d(root.width, root.height)
        property vector4d in_corners: root._shaderCorners

        vertexShader: "qrc:/Fluid/assets/shaders/default.vert.qsb"
        fragmentShader: "qrc:/Fluid/assets/shaders/ripple.frag.qsb"
    }

    // Sawtooth phase animator → noise + turbulence; only runs while the
    // shader is actually visible and we're not in debug-frozen mode.
    NumberAnimation {
        id: phaseAnim
        target: root
        property: "_phase"
        from: 0
        to: root._maxNoisePhase
        duration: root._noiseAnimDuration
        loops: Animation.Infinite
        running: !root.debugEnabled && root._runtimeOpacity > 0
    }

    SequentialAnimation {
        id: pressAnim
        NumberAnimation {
            target: root
            property: "_progress"
            to: 0.4
            duration: 450
            easing.type: Easing.OutCubic
        }
    }

    SequentialAnimation {
        id: releaseAnim
        NumberAnimation {
            target: root
            property: "_progress"
            to: 1.0
            duration: 350
            easing.type: Easing.OutCubic
        }
        PropertyAction {
            target: root
            property: "_progress"
            value: 0
        }
    }

    SequentialAnimation {
        id: m_fade
        running: false
        onStopped: {
            m_back.opacity = Qt.binding(function () {
                return root.stateOpacity;
            });
        }
        NumberAnimation {
            target: m_back
            to: root.stateOpacity
            duration: 150
            property: "opacity"
        }
        NumberAnimation {
            target: root
            to: 0
            duration: 150
            property: "_runtimeOpacity"
        }
    }

    onPressedChanged: {
        if (root.debugEnabled)
            return;
        if (pressed) {
            releaseAnim.stop();
            m_fade.stop();
            m_back.opacity = 0.12;
            root._runtimeOpacity = 0.12;
            pressAnim.start();
        } else {
            pressAnim.stop();
            releaseAnim.start();
            m_fade.start();
        }
    }
}
