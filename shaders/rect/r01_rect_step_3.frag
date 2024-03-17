#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    float left = step(0.1, coo.x);
    float top = step(0.1, coo.y);
    float right = step(0.1, 1 - coo.x);
    float bottom = step(0.1, 1 - coo.y);
    vec3 color = vec3(right * top * left * bottom);
    fragColor = vec4(color, 1.0);
}