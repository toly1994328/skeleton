#version 460 core
#include <flutter/runtime_effect.glsl>
precision mediump float;

out vec4 fragColor;
uniform vec2 uSize;

float circle2(vec2 uv, float e, float w, float r)
{
    return 1.0 - smoothstep(w, w + e, abs(length(uv) - r));
}

//float circle(vec2 coo, float r, float t) {
//    float len = length(coo);
//    return 1 - smoothstep(r, r + t, len);
//}

float circle(vec2 coo, float r, float t) {
    float len = length(coo);
    return 1 - smoothstep(0,  t, len-r);
}

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 coo) {
    return smoothstep(0.02, 0, abs(coo.x - coo.y));
}

//// coo  :  像素坐标
//// r    :  圆半径
//// w    :  边线宽度
//// t    :  过渡阈值
//float circle_line(vec2 coo, float r, float w, float t) {
//    float len = length(coo);
//    float c1 = 1 - smoothstep(r + w, r + w + t, len);
//    float c2 = 1 - smoothstep(r, r + t, len);
//    return c1 - c2;
//}

//// coo        :  像素坐标
//// r          :  圆半径
//// w          :  边线宽度
//// t          :  过渡阈值
//// boder_out  :  边线出头百分百 0:内侧 1:外侧 0.5: 增加
//float circle_line(vec2 coo, float r, float w, float t, float boder_out) {
//    float len = length(coo);
//    float outW = w * boder_out;
//    float inW = w - outW;
//    float c1 = 1 - smoothstep(r + outW, r + outW + t, len);
//    float c2 = 1 - smoothstep(r - inW, r -inW + t, len);
//    return c1 - c2;
//}

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

//// coo  :  像素坐标
//// r    :  圆半径
//// w    :  边线宽度
//// t    :  过渡阈值
//float circle_line(vec2 coo, float r, float w, float t) {
//    float len = length(coo);
//    return smoothstep(r, r + t, len) - smoothstep(r + w, r + w + t, len);
//}


//float circle_line(vec2 coo, float r, float w, float t) {
//    float len = length(coo);
////    return smoothstep(0, 0 + t, len-r) - smoothstep(0 + w, 0 + w + t, len-r);
//    return smoothstep(0, 0 + t, len-r) - smoothstep(0 + w, 0 + w + t, len-r);
//}


void main() {
    vec2 coo = FlutterFragCoord() / uSize;
    coo = coo * 2 - 1;
    float ret = circle_line(coo, 0.6, 0.01, 0.01, 0.5);
    //    float    ret = circle2(coo, 0.01,0.2, 0.6);
    //    float ret = plot(coo);

//    float   ret = circle(coo,0.5,0.1);
    fragColor = vec4(ret, ret, ret, 1);
}

