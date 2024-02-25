#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle(vec2 coo, float r, float t) {
    float len = length(coo);
    return 1 - smoothstep(0, t, len - r);
}

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

void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = 0;
    for (int i = 0;i < 40; i++) {
        float radius = 0.05 * i;
        //ret += circle_line(coo, radius, 0.01, 0.01, 0.5);// 效果1
        ret += circle_line(coo, radius, 0.01 * (i / 8), 0.01, 0.5);// 效果2
        //ret += circle_line(coo, radius, 0.01*(i/8), 0.01*i, 0.5);// 效果3
    }
    fragColor = vec4(ret, ret, ret, 1);
}

