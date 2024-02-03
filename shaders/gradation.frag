#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
out vec4 fragColor;

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    vec4 color = vec4(1, 1, 1, 1.0);
    if (coo.x > 0.2 && coo.x < 0.4) {
        color = vec4(0, 1, 1, 1.0);
    }else if (coo.x > 0.6 && coo.x < 0.7) {
        color = vec4(1, 1, 1, 1.0);
    } else {
        color = vec4(coo.x, 0, 0, 1.0);
    }

    fragColor = color;
}