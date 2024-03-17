import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';

/// 具有尺寸入参的 painter
class CustomShaderPainter extends CustomPainter {
  CustomShaderPainter({
    required this.shader,
     this.image,
     this.uProgress,
  });

  FragmentShader shader;
  ui.Image? image;
  final double? uProgress;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    if (uProgress != null) {
      shader.setFloat(2, uProgress!);
    }
    if (image != null) {
      shader.setImageSampler(0, image!);
    }

    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomShaderPainter oldDelegate) =>
      oldDelegate.shader != shader ||
          oldDelegate.image != image ||
          oldDelegate.uProgress != uProgress;
}
