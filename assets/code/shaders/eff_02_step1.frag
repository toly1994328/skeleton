#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
const float pi = 3.14159;

float circle(vec2 uv, float e, float w, float r) {
    return 1.0 - smoothstep(w, w+e, abs(length(uv) - r));
}

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    float radius = 0.5;
    float d = length(coo-0.5);
    float r = step(radius, d);
    fragColor = vec4(r, r, r, 1);
}



