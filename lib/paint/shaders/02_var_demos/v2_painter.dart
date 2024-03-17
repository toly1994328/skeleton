import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class V2ShaderPainter extends CustomPainter {
  V2ShaderPainter({required this.shader, required this.color});

  FragmentShader shader;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, color.red / 255);
    shader.setFloat(3, color.green / 255);
    shader.setFloat(4, color.blue / 255);
    shader.setFloat(5, color.alpha / 255);
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}