#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    float ret1 = step(0.1, coo.x);
    float ret2 = step(0.1, coo.y);
    vec3 color = vec3(ret1 * ret2);
    fragColor = vec4(color, 1.0);
}