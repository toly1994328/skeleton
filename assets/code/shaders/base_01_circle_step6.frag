#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D uTexture;

float circle(vec2 coo, float r) {
    float len = length(coo);
    return step(len, r);
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = 0;
    float c0 = circle(coo, 0.5);
    vec2 offset = vec2(-0.6, -0.6);
    float c1 = circle(coo + offset, 0.2);
    float c2 = circle(coo - offset * .7, 0.2);
    ret = c0 + c1 + c2;
    ret = min(ret, 1.0);


    vec2 picCoo = (coo + 1) / 2;
    vec4 color = texture(uTexture, picCoo);


    color = ret == 1 ? color : vec4(0, 1, 1, 1);

    fragColor = color;
}

