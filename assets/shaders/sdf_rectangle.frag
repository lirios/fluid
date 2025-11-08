/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2024-2025 hypengw <hypengwip@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

#version 440

#extension GL_GOOGLE_include_directive : enable

#include "sdf.glsl"

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;
    // tl,tr,bl,br
    vec4 radius;
    // item_size, rect_size
    vec4 size;
    vec4 color;

    float smoothing;
    float offset;
};

void main() {
    vec2 p = qt_TexCoord0 - vec2(0.5);
    p *= size.xy;
    // br,tr,bl,tl
    float sdf = sdf_rounded_rectangle(p, size.zw / 2.0, vec4(radius.w, radius.y, radius.z, radius.x));

    fragColor   = color;
    fragColor.a = sdf_alpha_uv(sdf, p, smoothing, offset) * qt_Opacity;
    // premultiplied
    fragColor.xyz *= fragColor.a;
}