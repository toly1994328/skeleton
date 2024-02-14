#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
out vec4 fragColor;

void main() {
    vec2 coo = FlutterFragCoord().xy/uSize;
    fragColor = vec4(1,0.0,0.0,1.0);
}
