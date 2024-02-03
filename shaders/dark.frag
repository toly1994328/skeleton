#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform sampler2D uTexture;

out vec4 fragColor;
const float threshold = 0.5;//阈值
void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    vec4 color = texture(uTexture,coo);

    float r = color.r;
    float g = color.g;
    float b = color.b;
    g = r * 0.3 + g * 0.59 + b * 0.11;
    g = g <= threshold ? 0.0 : 1.0;
    fragColor = vec4(g, g, g, 1.0);
}