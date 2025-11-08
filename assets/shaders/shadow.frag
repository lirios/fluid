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
#include "common.glsl"

layout(location = 0) out vec4 fragColor;

layout(location = 0) noperspective in vec3 out_shadow_params;
layout(location = 1) noperspective in vec4 out_color;
layout(binding = 1) uniform sampler2D strength_tex;

layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;
};

void main() {
    float d      = length(out_shadow_params.xy);
    vec2  uv     = vec2(out_shadow_params.z * (1.0 - d), 0.5);
    float factor = texture(strength_tex, uv, -0.475).x;
    vec4  alpha  = vec4(factor) * qt_Opacity;
    fragColor    = out_color * alpha;
}
