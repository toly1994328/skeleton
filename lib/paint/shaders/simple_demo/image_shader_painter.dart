import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';




class ImageShaderPainterPainter extends CustomPainter {
  ImageShaderPainterPainter({
    required this.shader,
    required this.image,
  });

  FragmentShader shader;
  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
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




















