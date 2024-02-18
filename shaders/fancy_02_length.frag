#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;
uniform float uTime;
uniform vec2 uSize;

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    vec3 col = vec3(1.0,0.0,0.0);

    coo = coo - 0.5; //[-0.5,0.5]
    coo = coo * 2.0; //[-1,1]
    float d = length(coo);

//    d -=0.5;
    d = sin(d*8. + uTime)/8.;

    d = abs(d);
//    d = step(0.1,d);
//    d = smoothstep(0,0.1,d);

    d = 0.02/d;
    col*=d;
    fragColor = vec4(d, d, d, 1.0);
}
