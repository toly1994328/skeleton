import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line with ChangeNotifier {
  Line({
    this.start = Offset.zero,
    this.end = Offset.zero,
  });

  Offset start;
  Offset end;

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  void paint(Canvas canvas) {
    canvas.drawLine(start, end, pointPaint);
    drawAnchor(canvas, start);
    drawAnchor(canvas, end);
  }

  double get rad => (end - start).direction;

  double get positiveRad => rad < 0 ? 2 * pi + rad : rad;

  double get length => (end - start).distance;

  void drawAnchor(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, pointPaint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, pointPaint..style = PaintingStyle.fill);
  }

  void rotate(double rad) {
    end = Offset(length * cos(rad), length * sin(rad));
    notifyListeners();
  }
}
