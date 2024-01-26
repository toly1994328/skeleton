#version 460 core
precision mediump float;
out vec4 fragColor;

vec3 blue = vec3(5, 83, 177) / 255;

void main() {
  fragColor = vec4(blue, 1);
}
