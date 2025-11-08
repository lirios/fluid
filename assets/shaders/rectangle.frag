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
layout(location = 0) noperspective in vec4 out_circle_edge;
layout(location = 1) noperspective in vec4 out_color;

layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;
};

void main() {
    // d is zero, if not in round edge
    float d = length(out_circle_edge.xy);
    // this will always keep 1px for circle edge
    // works for (1 - d) <= 1 / out_circle_edge.z
    float distance_to_outer = out_circle_edge.z * (1.0 - d);
    // edge filter at 0-1
    float edge_alpha = clamp(distance_to_outer, 0.0, 1.0);

    // float distance_to_inner = out_circle_edge.z * (d - out_circle_edge.w);
    // // inner edge filter at 0-1
    // float inner_alpha = clamp(distance_to_inner, 0.0, 1.0);
    // edge_alpha *= inner_alpha;
    vec4 final_alpha = vec4(edge_alpha) * qt_Opacity;
    fragColor        = out_color * final_alpha;
}