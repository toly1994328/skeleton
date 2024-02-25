#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;
uniform float uThreshold;
uniform vec2 uSize;
out vec4 fragColor;


float circle(vec2 coo, float r) {
    float len = length(coo);
    return 1 - smoothstep(r, r + uThreshold, len);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = circle(coo, 0.5);
    fragColor = vec4(ret, ret, ret, 1);
}

