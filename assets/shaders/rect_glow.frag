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

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float relativeSizeX;
    float relativeSizeY;
    float spread;
    vec4 color;
} ubuf;

float linearstep(float e0, float e1, float x)
{
    return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
}

void main()
{
    float alpha =
        smoothstep(0.0, ubuf.relativeSizeX, 0.5 - abs(0.5 - qt_TexCoord0.x)) * 
        smoothstep(0.0, ubuf.relativeSizeY, 0.5 - abs(0.5 - qt_TexCoord0.y));

    float spreadMultiplier = linearstep(ubuf.spread, 1.0 - ubuf.spread, alpha);
    fragColor = ubuf.color * ubuf.qt_Opacity * spreadMultiplier * spreadMultiplier;
}