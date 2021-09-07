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
    ..style = PaintingStyle.fill..color=Colors.red
    ..strokeWidth = 1;

  void paint(Canvas canvas) {
    canvas.save();
    canvas.translate(start.dx, start.dy);
    canvas.rotate(positiveRad);
    Path arrowPath = Path();
    arrowPath
      ..relativeLineTo(length - 10, 3)
      ..relativeLineTo(0, 2)
      ..lineTo(length, 0)
      ..relativeLineTo(-10, -5)
      ..relativeLineTo(0, 2)..close();
    canvas.drawPath(arrowPath,pointPaint);
    canvas.restore();
  }

  double get rad => (end - start).direction;

  double get positiveRad => rad < 0 ? 2 * pi + rad : rad;

  double get length => (end - start).distance;


  double detaRotate = 0;

  void rotate(double rotate) {
    detaRotate = rotate - detaRotate;
    end = Offset(
          length * cos(rad + detaRotate),
          length * sin(rad + detaRotate),
        ) +
        start;
    detaRotate = rotate;
    notifyListeners();
  }

  void tick() {
    notifyListeners();
  }
}
