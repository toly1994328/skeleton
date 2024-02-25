#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle(vec2 coo, float r) {
    float len = length(coo);
    return step(r, len);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = circle(coo, 0.5);
    fragColor = vec4(ret, ret, ret, 1);
}

