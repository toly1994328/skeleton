#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;
uniform vec2 uSize;
uniform float uThreshold;
uniform sampler2D uTexture;
out vec4 fragColor;


float circle(vec2 coo, float r) {
    float len = length(coo);
    return 1 - smoothstep(r, r + 0.2, len);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = circle(coo, 0.5);
    vec2 picCoo = (coo + 1) / 2;
    vec4 color = texture(uTexture, picCoo);

    fragColor = color*ret;
}

