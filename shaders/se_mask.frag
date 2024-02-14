#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;
uniform sampler2D uTexture;

void main() {
    float rate = uSize.x / uSize.y;
    float cellX = 2.0;
    float cellY = 2.0;
    float rowCount = 100.0;
    vec2 coo = FlutterFragCoord().xy / uSize;

    vec2 sizeFmt = vec2(rowCount, rowCount / rate);
    vec2 sizeMsk = vec2(cellX, cellY / rate);
    vec2 posFmt = vec2(coo.x * sizeFmt.x, coo.y * sizeFmt.y);
    float posMskX = floor(posFmt.x / sizeMsk.x) * sizeMsk.x;
    float posMskY = floor(posFmt.y / sizeMsk.y) * sizeMsk.y;
    vec2 posMsk = vec2(posMskX, posMskY) + 0.5 * sizeMsk;

    bool inCircle = length(posMsk - posFmt)<cellX / 2.0;

    vec4 result;
    if (inCircle) {
        vec2 UVMosaic = vec2(posMsk.x / sizeFmt.x, posMsk.y / sizeFmt.y);
        result = texture(uTexture, UVMosaic);
    } else {
        result = vec4(1.0, 1.0, 1.0, 0.0);
    }
    fragColor = result;
}
