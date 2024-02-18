#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D uTexture;

void main() {
    float rate = uSize.x / uSize.y;
    float countInRow =2.0;
    float countInColumn = countInRow / rate;
    vec2 pos = FlutterFragCoord().xy / uSize;

    float x = floor(pos.x * countInRow)/ countInRow;
    float y = floor(pos.y * countInColumn) / countInColumn;

    fragColor = texture(uTexture, vec2(x, y));
}

