#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float rect(vec2 coo, vec2 size) {
    coo = coo + 0.5;
    size = (1-size)/2;
    float len = length(coo);
    vec2 shaper = vec2(step(size.x, coo.x), step(size.y, coo.y));
    shaper *= vec2(step(size.x, 1 - coo.x), step(size.y, 1 - coo.y));
    return shaper.x * shaper.y;
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = rect(coo, vec2(0.2, 0.2));
    fragColor = vec4(ret, ret, ret, 1);
}

