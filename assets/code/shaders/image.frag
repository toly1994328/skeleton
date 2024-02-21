#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    vec4 color = texture(uTexture, coo);
    fragColor = mix(color,vec4(5, 83, 177, 255) / 255,coo.x);
}