import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';

/// 具有尺寸入参的 painter
class SizeImageShaderPainter extends CustomPainter {
  SizeImageShaderPainter({
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
  bool shouldRepaint(covariant SizeImageShaderPainter oldDelegate) =>
      oldDelegate.shader != shader||oldDelegate.image!=image;
}

