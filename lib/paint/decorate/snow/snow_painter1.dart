import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowPainter1 extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()
    ..color = const Color(0xff292869)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, _bgPainter);
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset.zero, 4, _mainPainter);
    //158 - 120
    double rate = 1 / 158 * size.width / 2;
    double storkWidth = 7.5 * rate;

    Path p1 = Path()
      ..addRect(Rect.fromCenter(
          center: Offset(80 * rate / 2, 0),
          width: 80 * rate,
          height: storkWidth));

    double h = 26 * rate;
    Path p2 = Path()
      ..relativeLineTo(h, -h)
      ..relativeLineTo(storkWidth / sqrt(2), storkWidth / sqrt(2))
      ..lineTo(sqrt(2) * storkWidth, 0)
      ..relativeLineTo(h - storkWidth / sqrt(2), h - storkWidth / sqrt(2))
      ..relativeLineTo(-storkWidth / sqrt(2), storkWidth / sqrt(2))
      ..lineTo(0, 0);

    Path result = combineAll([
      p1,
      p2,
      p2.shift(Offset(37 * rate, 0)),
      p2.shift(Offset(76 * rate, 0))
    ]);


    List<Path> paths = [];
    Matrix4 tranM4 = Matrix4.translationValues(18 * rate, 0, 0);
    for (int i = 0; i < 8; i++) {
      double rotate = 2 * pi / 8 * i + 23 / 180 * pi;
      Matrix4 matrix4 = Matrix4.rotationZ(rotate)..multiply(tranM4);
      paths.add(result.transform(matrix4.storage));
    }
    canvas.drawPath(combineAll(paths), _mainPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path combineAll(List<Path> paths,
      {PathOperation operation = PathOperation.union}) {
    if (paths.isEmpty) return Path();
    if (paths.length <= 1) return paths.first;
    Path result = paths.first;
    for (int i = 1; i < paths.length; i++) {
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }
}
