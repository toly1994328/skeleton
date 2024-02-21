#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform float uTime;
uniform vec2 uSize;



vec3 palette(float t,vec3 a,vec3 b,vec3 c,vec3 d){
    return a+b*cos(6.28318*(c*t+d));
}

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    coo = coo - 0.5; //[-0.5,0.5]
    coo = coo * 2.0; //[-1,1]
    float d = length(coo);

///step1
//    vec3 col = vec3(1.0, 2.0, 3.0);
//    d = sin(d * 8. + uTime) / 8.;
//    d = abs(d);
//    d = 0.02 / d;
//    col *= d;
//    fragColor = vec4(col, 1.0);

    vec3 a1 = vec3(0.5, 0.5, 0.5);
    vec3 b1 = vec3(0.5, 0.5, 0.5);
    vec3 c1= vec3(1.0, 1.0, 1.0);
    vec3 d1 = vec3(0.263,0.416,0.557);
    vec3 col = palette(d,a1,b1,c1,d1);

    d = sin(d * 8. + uTime) / 8.;
    d = abs(d);
    d = 0.02 / d;
    col *= d;



    fragColor = vec4(col, 1.0);
}
