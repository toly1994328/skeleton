import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class V4ShaderPainter extends CustomPainter {
  V4ShaderPainter({
    required this.shader,
    required this.image,
    required this.color,
    required this.progress,
  });

  FragmentShader shader;
  ui.Image image;
  Color color;
  double progress;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, progress);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);
    shader.setFloat(3, color.red / 255);
    shader.setFloat(4, color.green / 255);
    shader.setFloat(5, color.blue / 255);
    shader.setFloat(6, color.alpha / 255);

    shader.setImageSampler(0, image);
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
