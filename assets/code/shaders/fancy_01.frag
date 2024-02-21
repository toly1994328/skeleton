#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;

void main() {
    vec2 size = vec2(300.0, 300.0);
    vec2 coo = FlutterFragCoord().xy / size;
    coo = coo - 0.5; //[-0.5,0.5]
    coo = coo * 2.0; //[-1,1]
    fragColor = vec4(coo, 0.0, 1.0);
}
