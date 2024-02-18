import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class F2ShaderPainter extends CustomPainter {
  F2ShaderPainter({
    required this.shader,
    required this.time,
  });

  FragmentShader shader;
  double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, time);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);

    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
