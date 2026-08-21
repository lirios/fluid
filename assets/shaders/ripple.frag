// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2026 hypengw <hypengwip@gmail.com>
// SPDX-License-Identifier: MPL-2.0
//
// Originally based on code by hypengw, licensed under the MIT license.

#version 440

#extension GL_GOOGLE_include_directive : enable
#include "common.glsl"
#include "sdf.glsl"

layout(location = 0) out vec4 fragColor;
layout(location = 0) in vec2 qt_TexCoord0;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 in_origin;
    vec2 in_touch;
    float in_progress;
    float in_maxRadius;
    vec2 in_resolutionScale;
    vec2 in_noiseScale;
    float in_hasMask;
    float in_noisePhase;
    float in_turbulencePhase;
    vec2 in_tCircle1;
    vec2 in_tCircle2;
    vec2 in_tCircle3;
    vec2 in_tRotation1;
    vec2 in_tRotation2;
    vec2 in_tRotation3;
    vec4 in_color;
    vec4 in_sparkleColor;
    vec2 in_size;
    vec4 in_corners;
};

// Note: Skia's reference RippleShader.rts uses a `shader in_shader` for the
// mask. We mask via SDF (in_corners + sdf_rounded_rectangle) instead, so no
// external sampler is needed.

float triangleNoise(vec2 n) {
  n  = fract(n * vec2(5.3987, 5.4421));
  n += dot(n.yx, n.xy + vec2(21.5351, 14.3137));
  float xy = n.x * n.y;
  return fract(xy * 95.4307) + fract(xy * 75.04961) - 1.0;
}

const float PI = 3.1415926535897932384626;

float threshold(float v, float l, float h) {
    return step(l, v) * (1.0 - step(h, v));
}

float sparkles(vec2 uv, float t) {
  float n = triangleNoise(uv);
  float s = 0.0;
  for (float i = 0.0; i < 4.0; i += 1.0) {
    float l = i * 0.1;
    float h = l + 0.05;
    float o = sin(PI * (t + 0.35 * i));
    s += threshold(n + o, l, h);
  }
  return clamp(s, 0.0, 1.0) * in_sparkleColor.a;
}

float softCircle(vec2 uv, vec2 xy, float radius, float blur) {
  float blurHalf = blur * 0.5;
  float d = distance(uv, xy);
  return 1.0 - smoothstep(1.0 - blurHalf, 1.0 + blurHalf, d / radius);
}

float softRing(vec2 uv, vec2 xy, float radius, float progress, float blur) {
  float thickness = 0.05 * radius;
  float currentRadius = radius * progress;
  float circle_outer = softCircle(uv, xy, currentRadius + thickness, blur);
  float circle_inner = softCircle(uv, xy, max(currentRadius - thickness, 0.0), blur);
  return clamp(circle_outer - circle_inner, 0.0, 1.0);
}

float subProgress(float start, float end, float progress) {
    float sub = clamp(progress, start, end);
    return (sub - start) / (end - start);
}

mat2 rotate2d(vec2 rad){
  return mat2(rad.x, -rad.y, rad.y, rad.x);
}

float circle_grid(vec2 resolution, vec2 coord, float time, vec2 center,
    vec2 rotation, float cell_diameter) {
  coord = rotate2d(rotation) * (center - coord) + center;
  coord = mod(coord, cell_diameter) / resolution;
  float normal_radius = cell_diameter / resolution.y * 0.5;
  float radius = 0.65 * normal_radius;
  return softCircle(coord, vec2(normal_radius), radius, radius * 50.0);
}

float turbulence(vec2 uv, float t) {
  const vec2 scale = vec2(0.8);
  uv = uv * scale;
  float g1 = circle_grid(scale, uv, t, in_tCircle1, in_tRotation1, 0.17);
  float g2 = circle_grid(scale, uv, t, in_tCircle2, in_tRotation2, 0.2);
  float g3 = circle_grid(scale, uv, t, in_tCircle3, in_tRotation3, 0.275);
  float v = (g1 * g1 + g2 - g3) * 0.5;
  return clamp(0.45 + 0.8 * v, 0.0, 1.0);
}

void main() {
    vec2 p = qt_TexCoord0 * in_size;

    float fadeIn = subProgress(0.0, 0.13, in_progress);
    float scaleIn = subProgress(0.0, 1.0, in_progress);
    float fadeOutNoise = subProgress(0.4, 0.5, in_progress);
    float fadeOutRipple = subProgress(0.4, 1.0, in_progress);

    vec2 center = mix(in_touch, in_origin, clamp(in_progress * 2.0, 0.0, 1.0));
    float ring = softRing(p, center, in_maxRadius, scaleIn, 1.0);

    float alpha = min(fadeIn, 1.0 - fadeOutNoise);
    vec2 uv = p * in_resolutionScale;
    vec2 densityUv = uv - mod(uv, in_noiseScale);
    float turb = turbulence(uv, in_turbulencePhase);

    float sparkleAlpha = sparkles(densityUv, in_noisePhase) * ring * alpha * turb;

    float fade = min(fadeIn, 1.0 - fadeOutRipple);
    float waveAlpha = softCircle(p, center, in_maxRadius * scaleIn, 1.0) * fade * in_color.a;

    vec4 waveColor = vec4(in_color.rgb * waveAlpha, waveAlpha);
    vec4 sparkleColor = vec4(in_sparkleColor.rgb * in_sparkleColor.a, in_sparkleColor.a);

    float mask = 1.0;
    if (in_hasMask == 1.0) {
        vec2 half_size = in_size * 0.5;
        float d = sdf_rounded_rectangle(p - half_size, half_size, in_corners);
        mask = sdf_alpha_uv(d, qt_TexCoord0, 1.0, 0.0);
    }

    fragColor = mix(waveColor, sparkleColor, sparkleAlpha) * mask * qt_Opacity;
}
