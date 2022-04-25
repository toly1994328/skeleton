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

  Line resultant(Line line) {
    return Line(start: start, end: line.end);
  }

  Line.fromRad({
    required this.start,
    required double rad,
    required double len,
  }) : end = Offset(len * cos(rad), len * sin(rad)) + start;

  Line branch({
    required double rad,
    required double percent,
    required double len,
  }) {
    Offset q0 = this.percent(percent);
    double dx = len * cos(this.rad + rad );
    double dy = len * sin(this.rad + rad );
    Offset q1 = Offset(q0.dx-dx, q0.dy-dy) ;
    return Line(start: q0, end: q1);
  }

  Offset percent(double percent) {
    return Offset(
          length * percent * cos(rad),
          length * percent * sin(rad),
        ) +
        start;
  }

  Line fromAngle(double angle, double len) {
    // double x = end.dx + len * cos(rad + angle  );
    // double y = end.dy + len * sin(rad + angle );

    Offset newEnd = Offset(
          len * cos(rad + angle),
          len * sin(rad + angle),
        ) +
        end;

    return Line(start: end, end: newEnd);
  }

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.fill
    // ..color = Colors.red
    ..strokeWidth = 1;

  void paintArrow(Canvas canvas) {
    canvas.save();
    canvas.translate(start.dx, start.dy);
    canvas.rotate(positiveRad);
    Path arrowPath = Path();
    arrowPath
      ..relativeLineTo(length - 10, 3)
      ..relativeLineTo(0, 2)
      ..lineTo(length, 0)
      ..relativeLineTo(-10, -5)
      ..relativeLineTo(0, 2)
      ..close();
    canvas.drawPath(arrowPath, pointPaint);
    canvas.restore();
  }

  void paint(Canvas canvas,{Color color=Colors.black}) {
    canvas.drawLine(start, end, pointPaint..color=color);
  }

  // void paintHelp(Canvas canvas) {
  //   Paint paint = Paint()..color = pointPaint.color;
  //   canvas.drawCircle(start, 4, paint..style = PaintingStyle.stroke);
  //   canvas.drawCircle(start, 2, paint..style = PaintingStyle.fill);
  //   canvas.drawCircle(end, 4, paint..style = PaintingStyle.stroke);
  //   canvas.drawCircle(end, 2, paint..style = PaintingStyle.fill);
  // }

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
