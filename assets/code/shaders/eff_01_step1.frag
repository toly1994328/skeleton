#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D uTexture;

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    float count = 10.0;
    float x = floor(coo.x * count)/ count;
    fragColor = vec4(x,0,0,1);
}

