#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle(vec2 coo, float r) {
    float len = length(coo);
//    if (len <= r) {
//        return 0;
//    } else {
//        return 1;
//    }
    return step(r, len);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    float radius = 0.5;
    float ret = circle(coo, radius);
    fragColor = vec4(ret, ret, ret, 1);
}

