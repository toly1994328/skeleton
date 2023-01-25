import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/painter/coordinate.dart';

class PathPainter extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _helpPainter = Paint()
    ..color = Colors.purple;
  final Paint _mainPainter = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke..strokeWidth=2;

  final Coordinate coordinate = Coordinate(strokeWidth: 0.5);

  final Animation<double> animation;


  PathPainter({required this.animation}):super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, _bgPainter);
    coordinate.drawAxisLine(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path()
      ..addRect(
        Rect.fromPoints(
           Offset.zero,
           const Offset(100,60),
        ),
      );
    canvas.drawPath(path, _mainPainter..color=Colors.blue);

    Offset center = const Offset(-50.0, 30.0);
    Matrix4 dest = Matrix4.identity();
    dest.translate(center.dx, center.dy, 0);
    dest.scale(animation.value);
    dest.translate(-center.dx, -center.dy, 0);
    path = path.transform(dest.storage);
    canvas.drawPath(path, _mainPainter..color = Colors.red);

    canvas.drawCircle(center, 4, _helpPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//     Offset center = Offset(80, 80);
//     Matrix4 dest = Matrix4.identity();
//     dest.translate(center.dx, center.dy, 0);
//     dest.rotateZ(animation.value*360*pi/180);
//     dest.translate(-center.dx, -center.dy, 0);
//     canvas.drawPath(path, _mainPainter..color = Colors.blue);
//
//     canvas.drawCircle(center, 4, Paint());
//
//     path = path.transform(dest.storage);

// Matrix4 dest = Matrix4.identity();
// dest.rotateZ(45*pi/180);
// canvas.drawPath(path, _mainPainter..color = Colors.red);