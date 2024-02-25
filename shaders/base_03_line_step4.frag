#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform sampler2D uTexture;
uniform vec2 uSize;

//// coo        :  像素坐标
//// r          :  圆半径
//// w          :  边线宽度
//// t          :  过渡阈值
//// boder_out  :  边线出头百分百 0:内侧 1:外侧 0.5: 增加
float circle_line(vec2 coo, float r, float w, float t, float boder_out) {
    float len = length(coo);
    float outW = w * boder_out;
    float inW = w - outW;
    return smoothstep(-inW, -inW + t, len - r)
    - smoothstep(outW, outW + t, len - r);
}

float circle_line_inner(vec2 coo, float r, float w, float t) {
    float len = length(coo);
    float c1 = 1 - smoothstep(r, r + t, len);
    float c2 = 1 - smoothstep(r - w, r - w + t, len);
    return c1 - c2;
}


void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = 0;
    int count = 40;
    for(int i=0;i<40;i++){
        float radius = 0.025*i;
        float t = 0.01;
        float w = 0.05;
        ret += circle_line(coo, radius, w, t, 0.5);
    }
    vec2 picCoo = (coo + 1) / 2;
    vec4 color = texture(uTexture, picCoo);
    fragColor = color*ret;
}

