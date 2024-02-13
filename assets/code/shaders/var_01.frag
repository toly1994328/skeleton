#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;

void main() {
    vec2 size = vec2(400.0,200.0);
    vec2 coo = FlutterFragCoord().xy/size;
    fragColor = vec4(coo.x,0.0,0.0,1.0);
}
