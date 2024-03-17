import 'dart:ui';
import 'package:flutter/material.dart';

/// 具有尺寸入参的 painter
class SizeShaderPainter extends CustomPainter {
  SizeShaderPainter({required this.shader});

  FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant SizeShaderPainter oldDelegate) =>
      oldDelegate.shader != shader;
}
