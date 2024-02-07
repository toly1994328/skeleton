#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;

vec4 blue = vec4(4, 83, 177, 255) / 255;
vec4 red = vec4(218, 13, 21, 255) / 255;
vec4 yellow = vec4(250, 193, 21, 255) / 255;
vec4 green = vec4(38, 152, 70, 255) / 255;

void main() {
    vec2 coo = FlutterFragCoord().xy;
    if(coo.x<200){
        if(coo.y<100){
            fragColor = blue;
        }else{
            fragColor = red;
        }
    }else {
        if(coo.y<100){
            fragColor = yellow;
        }else{
            fragColor = green;
        }
    }
}
