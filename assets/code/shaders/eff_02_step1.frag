#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
const float pi = 3.14159;

float circle(vec2 uv, float e, float w, float r) {
    return 1.0 - smoothstep(w, w + e, abs(length(uv) - r));
}

float circle2(vec2 uv,  float r) {
    float d = length(uv);
    return step(r,d);
}

void main() {
    vec2 coo = FlutterFragCoord()/uSize;

    float px1 = 1.0 / uSize.x;


//    vec2 uv = (FlutterFragCoord() - uSize.xy * 0.5) * px1;

//    e = 1.5 * e;
    float c = circle2(coo, 0.5);
//    float c = circle(coo, px1, 0.0005, 0.339375);
//    c += circle(uv, px1, 0.0005, 0.139375);
//    c += circle(uv, px1, 0.0005, 0.1);

    fragColor = vec4(c,c, c, 1.0);
}



