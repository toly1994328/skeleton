#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    vec3 color = vec3(0.0);

    float ret = step(0.1,coo.x);
    color = vec3(ret);

    fragColor = vec4(color,1.0);
}