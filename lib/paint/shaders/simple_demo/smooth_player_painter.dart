import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class SmoothPlayerPainter extends CustomPainter {
  SmoothPlayerPainter({
    required this.shader,
    required this.threshold,
  });

  FragmentShader shader;
  final double threshold;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, threshold);
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


class SmoothWithImagePainter extends CustomPainter {
  SmoothWithImagePainter({
    required this.shader,
    required this.image,
    required this.uThreshold,
  });

  FragmentShader shader;
  ui.Image image;
  final double uThreshold;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, uThreshold);
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




















