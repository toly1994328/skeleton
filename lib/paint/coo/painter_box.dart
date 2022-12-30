import 'package:flutter/material.dart';

import 'coordinate.dart';
import 'point_values.dart';

class PainterBox extends CustomPainter {

  final Paint _bgPainter = Paint()
    ..color = Colors.grey.withOpacity(0.2);
  final Paint _mainPainter = Paint()
    ..color = Colors.blue;

  final Coordinate coordinate = Coordinate(
    xScaleCount: 10,
    yScaleCount: 10,
  );

  final PointValues points;

  PainterBox(this.points):super(repaint: points);

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(0, size.height);
    coordinate.paint(canvas, size);
    canvas.scale(1,-1);

    canvas.drawRect(Offset.zero & size, _bgPainter);

    for (Offset point in points.data) {
      canvas.drawCircle(point.scale(size.width, size.height), 5, _mainPainter);
    }

  }

  @override
  bool shouldRepaint(covariant PainterBox oldDelegate) {
    return oldDelegate.points!=points;
  }

}
