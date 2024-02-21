#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D uTexture;

void main() {
    vec2 coo = FlutterFragCoord().xy / uSize;
    float rowCount = 40.0;
    float x = floor(coo.x * rowCount)/ rowCount;
    float y = floor(coo.y * rowCount)/ rowCount;
    fragColor = texture(uTexture, vec2(x,y));
//    fragColor = vec4(x,0,0,1);
}

