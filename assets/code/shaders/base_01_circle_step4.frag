#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle(vec2 coo, float r) {
    float len = length(coo);
    return 1 - step(r, len);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float c0 = circle(coo, 0.5);

    vec2 offset = vec2(-0.8, -0.8);
    float c1 = circle(coo + offset, 0.2);
    c0 += c1;
    fragColor = vec4(c0, c0, c0, 1);
}

