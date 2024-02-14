#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uColor;
out vec4 fragColor;

void main() {
    vec2 coo = FlutterFragCoord().xy/uSize;
    vec4 black = vec4(0,0.0,0.0,1.0);
    fragColor = mix(black,uColor,coo.x);
}
