import 'package:flutter/material.dart';

import 'coordinate.dart';

class PainterBox extends CustomPainter {

  final Paint _bgPainter = Paint()
    ..color = Colors.grey.withOpacity(0.2);
  final Paint _mainPainter = Paint()
    ..color = Colors.blue;

  final Coordinate coordinate = Coordinate(
    xScaleCount: 10,
    yScaleCount: 10,
  );

  final List<Offset> points = const [
    Offset(0.12, 0.13),
    Offset(0.22, 0.31),
    Offset(0.24, 0.43),
    Offset(0.62, 0.53),
    Offset(0.72, 0.23),
    Offset(0.82, 0.13),
    Offset(0.32, 0.63),
    Offset(0.52, 0.83),
  ];

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(0, size.height);
    coordinate.paint(canvas, size);
    canvas.scale(1,-1);

    canvas.drawRect(Offset.zero & size, _bgPainter);
    // canvas.drawCircle(Offset.zero, 5, _mainPainter);


    for (Offset point in points) {
      canvas.drawCircle(point.scale(size.width, size.height), 5, _mainPainter);
    }

  }

  @override
  bool shouldRepaint(covariant PainterBox oldDelegate) {
    return false;
  }

}
