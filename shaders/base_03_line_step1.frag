#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle2(vec2 uv, float e, float w, float r)
{
    return 1.0 - smoothstep(w, w + e, abs(length(uv) - r));
}

float circle(vec2 coo, float r, float t) {
    float len = length(coo);
    return 1 - smoothstep(r, r + t, len);
}


// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 coo) {
    return smoothstep(0.02, 0, abs(coo.x - coo.y));
}

float circle_line(vec2 coo, float r) {
    float len = length(coo);
    return 1 - smoothstep(0, 0 + 0.1, abs(len - r));
}

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;

    float ret = circle(coo, 0.6, 0.01);
    ret -= circle(coo, 0.5, 0.01);
    fragColor = vec4(ret, ret, ret, 1);
}

