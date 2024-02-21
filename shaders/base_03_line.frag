#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float plot(vec2 st, float pct, float lineWidth) {
//    return smoothstep(pct - lineWidth, pct, st.y) - smoothstep(pct, pct + lineWidth, st.y);
    return smoothstep(pct - lineWidth, pct, st.y) - smoothstep(pct, pct + lineWidth, st.y);
}

float circle(vec2 position, float radius) {
    float d = length(position);
    return step(radius, d);
}

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
//    coo = coo*2 -1;
    float radius = 1;

//    float r = circle(coo, radius);
//    fragColor = vec4(r, r, r, 1);

//        float a = plot(coo, coo.x, 0.005);
//    fragColor = vec4(a, a, a, 1);


}

