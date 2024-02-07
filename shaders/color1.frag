#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;

void main() {
    vec2 coo = FlutterFragCoord().xy ;
    if (coo.x < 200) {
        fragColor = vec4(4, 83, 177, 255) / 255;
    } else {
        fragColor = vec4(218, 13, 21, 255) / 255;
    }
}