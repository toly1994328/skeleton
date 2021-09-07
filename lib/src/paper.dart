import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/src/linker.dart';

class SkeletonPaper extends CustomPainter {
  // List<Linker> linkers = [
  //   Linker(
  //     start: Offset.zero,
  //     end: Offset(0,100)
  //   )
  // ];

  final Linker linker;

  SkeletonPaper({required this.linker}) :super(repaint: linker);


  final Paint pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset.zero, 10, pointPaint);
    print(size);
    drawLinker(canvas, linker);
    linker.nodes.forEach((element) {
      pointPaint.color = Colors.blue;
      drawLinker(canvas, element);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawLinker(Canvas canvas, Linker linker) {
    drawAnchor(canvas, linker.start);
    drawAnchor(canvas, linker.end);
    drawLine(canvas, linker);
  }

  void drawAnchor(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, pointPaint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, pointPaint..style = PaintingStyle.fill);
  }

  void drawLine(Canvas canvas, Linker linker) {
    canvas.drawLine(
        linker.start, linker.end, pointPaint..style = PaintingStyle.stroke);
  }
}
