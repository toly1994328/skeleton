#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;


float rect(vec2 coo, vec2 pos, vec2 size) {
    vec2 br_pos = vec2(pos.x + size.x, pos.y + size.y);
    vec2 lt = step(pos, coo);
    vec2 br = step(coo, br_pos);
    return lt.x * lt.y * br.x * br.y;
}


void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    float rect1 = rect(coo, vec2(0.2, 0.24), vec2(0.6, 0.1));
    float rect2 = rect(coo, vec2(0.2, 0.44), vec2(0.25, 0.1));
    float rect3 = rect(coo, vec2(0.2, 0.64), vec2(0.6, 0.1));
    float rect4 = rect(coo, vec2(0.55, 0.44), vec2(0.25, 0.1));
    vec3 color = vec3(rect1 + rect2 + rect3 + rect4);
    fragColor = vec4(color, 1.0);
}